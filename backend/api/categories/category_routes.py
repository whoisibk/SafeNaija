from fastapi import APIRouter, Depends, HTTPException


from queries.category_queries import get_categories_
from queries.user_queries import get_db, Session

router = APIRouter()


@router.get("/all", response_model=list[str])
def get_categories(db_session: Session = Depends(get_db)):
    """Endpoint to retrieve all category names."""

    categories = get_categories_(db_session)
    return [category.name for category in categories]
