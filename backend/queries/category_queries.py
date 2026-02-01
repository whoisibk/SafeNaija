from fastapi import Depends
from typing import Optional

from sqlalchemy import Uuid

from queries.user_queries import Session
from db.models import Category


def get_categories_(db_session: Session) -> list[Category]:
    """Retrieve all categories from the database."""
    categories = db_session.query(Category).all()
    return categories


def get_category_id(category_name: str, db_session: Session) -> Optional[Uuid]:
    """Retrieve the category ID based on the category name."""
    category_record = (
        db_session.query(Category).filter(Category.name == category_name).first()
    )
    if category_record:
        return category_record.id
    return None
