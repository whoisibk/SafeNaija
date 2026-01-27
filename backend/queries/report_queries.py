from fastapi import Depends

from db.models import Category, Report
from queries.user_queries import Session
from queries.category_queries import get_category_id


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
