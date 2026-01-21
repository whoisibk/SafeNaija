from db.database import session
from db.models import User
from schemas.schemas_ import UserCreate
from utils.hashing import hash_password


def create_user(user: UserCreate) -> User:
    """Adds a new user to the database."""
    db_session = session

    new_user = User(
        firstName=user.firstName.title(),
        lastName=user.lastName.title(),
        username=user.username,
        email=user.email.lower(),
        password_hash=hash_password(user.password),
        )

    db_session.add(new_user)
    db_session.commit()
    db_session.refresh(new_user)
    return new_user

def get_user_by_id(user_id: int) -> User:
    """Retrieve a user by their ID."""
    db_session = session

    user = db_session.query(User).filter(User.id==user_id).first()
    if user is None:
        raise ValueError("User not found")
    return user

def get_user_by_email(email: str):
    db_session = session

    user = db_session.query(User).filter(User.email==email).first()
    if user is None:
        raise ValueError("User not found")
    return user
