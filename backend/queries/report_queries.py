import os
from dotenv import load_dotenv
from supabase.client import Client, create_client

from fastapi import Depends, UploadFile

from db.models import Category, Report
from queries.user_queries import Session
from queries.category_queries import get_category_id


load_dotenv()

SUPABASE_URL: str = os.getenv("SUPABASE_URL")
SUPABASE_KEY: str = os.getenv("SUPABASE_KEY")
BUCKET_NAME: str = "reports-media"

supabase_client: Client = create_client(SUPABASE_URL, SUPABASE_KEY)


def create_report(report: Report, db_session: Session):
    """Create a new report in the database."""

    severity_mapping = {"low": 1, "mid": 2, "high": 3}

    new_report = Report(
        title=report.title,
        description=report.description,
        category_id=report.category_id,
        user_id=report.user_id,
        severity=severity_mapping.get(report.severity, 1),
        latitude=report.latitude,
        longitude=report.longitude,
        media_url=report.media_url,
    )
    try:
        db_session.add(new_report)
        db_session.commit()
    except Exception as e:
        db_session.rollback()
        raise e


async def upload_image(file: UploadFile) -> str:
    """Upload an image to Supabase Storage and return the public URL."""

    if file.content_type not in ["image/jpeg", "image/png", "image/jpg"]:
        raise ValueError("Invalid file type. Only JPEG and PNG are allowed.")

    # Define the file path in the storage bucket
    file_path = f"reports/{file.filename}"

    # Read the file content
    file_ = file.file.read()

    # Upload the file to Supabase Storage
    supabase_client.storage.from_(BUCKET_NAME).upload(
        path=file_path,
        file=file_,
        file_options={"content_type": file.content_type, "upsert": False},
    )

    # Generate the public URL for the uploaded file
    public_url = supabase_client.storage.from_(BUCKET_NAME).get_public_url(file_path)

    return public_url
