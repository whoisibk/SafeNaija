from fastapi.security import OAuth2PasswordBearer
from fastapi import Depends, HTTPException, status

from db.database import Session
from queries.user_queries import get_user_by_id
from schemas.schemas_ import UserDisplay
from utils.token import decode_token


# OAuth2 security scheme - tells FastAPI how to extract the token
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="login")


def get_current_user(token: str = Depends(oauth2_scheme)) -> UserDisplay:
    """Get the current authenticated user from the JWT token.

    Args:
        token (str): The JWT token extracted from Authorization header by oauth2_scheme.

    Returns:
        UserDisplay: The currently authenticated user.

    Raises:
        HTTPException: If token is invalid or user not found.
    """

    try:
        # Decode the token to get payload
        payload = decode_token(token)
        user_id = payload.get("user_id")

        if not user_id:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Invalid token: missing user_id",
            )
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid token or user not found",
            headers={"WWW-Authenticate": "Bearer"},
        ) from e

    # Fetch user from database
    user = get_user_by_id(user_id, Session())

    # Convert ORM model to Pydantic schema
    return UserDisplay(
        id=user.id,
        firstName=user.firstName,
        lastName=user.lastName,
        username=user.username,
        email=user.email,
        is_active=user.is_active,
        role=user.role,
    )
