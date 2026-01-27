from fastapi import APIRouter, status, HTTPException, Depends
from fastapi.security import OAuth2PasswordRequestForm

from db.database import Session
from schemas.schemas_ import UserCreate, UserLogin
from queries.user_queries import create_user, get_user_by_email, get_db
from utils.hashing import verify_password
from utils.token import create_jwt_token

# from ..schemas.schemas_ import UserCreate, UserLogin
# from ..queries.user_queries import create_user, get_user_by_email
# from ..utils.hashing import hash_password, verify_password
# from ..utils.token import create_jwt_token


router = APIRouter()


@router.post("/signup")
def sign_up(user: UserCreate, db_session: Session = Depends(get_db)):
    """Register a new user.
    Args:
        user (UserCreate): The user registration details.
    Returns:
        dict: A dictionary containing the access token and token type.
    """
    try:
        new_user = create_user(user, db_session)
    except Exception as e:
        db_session.rollback()  # rollback any failed transaction
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Database operation failed: {e}",
        )

    try:
        jwt_token = create_jwt_token(data={"user_id": str(new_user.id)})
    except Exception as e:
        return {"An Error occurred": str(e)}

    return {"status": 200, "access_token": jwt_token, "token_type": "Bearer"}


@router.post("/login")
def login(
    user: OAuth2PasswordRequestForm = Depends(), db_session: Session = Depends(get_db)
):
    """Authenticate user and return JWT token.
    Args:
        user (OAuth2PasswordRequestForm): The user login details.
    Returns:
        dict: A dictionary containing the access token and token type.
    """
    # user = UserLogin(username=user.username, password=user.password)
    useremail = (
        user.username
    )  # OAuth2PasswordRequestForm uses 'username' field for email
    userpassword = user.password

    db_user = get_user_by_email(useremail, db_session)

    # check if user exists or password is correct
    if not db_user or verify_password(userpassword, db_user.password_hash) is False:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid credentials"
        )

    jwt_token = create_jwt_token(data={"user_id": str(db_user.id)})

    return {"access_token": jwt_token, "token_type": "Bearer"}


@router.post("/logout")
def logout():
    """Logout endpoint (placeholder).
    Returns:
        dict: A message indicating successful logout.
    Note:
        Since JWTs are stateless, logout is typically handled on the client side
        by deleting the token. This endpoint serves as a placeholder.
    """
    return {"message": "Successfully logged out"}
