from fastapi import Depends

from db.database import SessionLocal, Session
from db.models import User
from schemas.schemas_ import UserCreate
from utils.hashing import hash_password


def get_db():
    """Dependency to get DB session."""
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


def create_user(user: UserCreate, db_session: Session = Depends(get_db)) -> User:
    """Adds a new user to the database."""

    if get_user_by_email(user.email, db_session) or get_user_by_username(
        user.username, db_session
    ):
        raise ValueError("User with this email or username already exists.")

    new_user = User(
        first_name=user.first_name.title(),
        last_name=user.last_name.title(),
        username=user.username,
        email=user.email.lower(),
        password_hash=hash_password(user.password),
    )

    db_session.add(new_user)

    db_session.commit()
    db_session.refresh(new_user)
    return new_user


def get_user_by_id(user_id: int, db_session: Session) -> User:
    """Retrieve a user by their ID."""

    user = db_session.query(User).filter(User.id == user_id).first()
    if user is None:
        return None
    return user


def get_user_by_email(email: str, db_session: Session) -> User:

    user = db_session.query(User).filter(User.email == email).first()
    if user is None:
        return None
    return user


def get_user_by_username(username: str, db_session: Session) -> User:

    user = db_session.query(User).filter(User.username == username).first()
    if user is None:
        return None
    return user
