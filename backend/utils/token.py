from os import getenv
from dotenv import load_dotenv
from datetime import timedelta, datetime

from jose import JWTError, jwt


load_dotenv()


def create_jwt_token(
    data: dict, expires_delta: timedelta = timedelta(minutes=30)
) -> str:
    """
    Create a JWT token with the given data and expiration delta.
    Args:
        data (dict): The payload data to encode in the JWT token.
        expires_delta (timedelta): The time duration for which the token remains valid.
    Returns:
        str: The encoded JWT token.
    """

    ALGORITHM = getenv("ALGORITHM")
    SECRET_KEY = getenv("SECRET_KEY")

    to_encode = data.copy()
    expire = datetime.now() + expires_delta
    to_encode["exp"] = expire

    try:
        encoded_jwt = jwt.encode(claims=to_encode, key=SECRET_KEY, algorithm=ALGORITHM)
        return encoded_jwt

    except JWTError:
        raise JWTError("Could not create token")


def decode_token(token: str):
    """
    Decode a JWT token and return the payload data.
    Args:
        token (str): The JWT token to decode.
    Returns:
        dict: The decoded payload data.
    """

    ALGORITHM = getenv("ALGORITHM")
    SECRET_KEY = getenv("SECRET_KEY")

    try:
        data = jwt.decode(token, SECRET_KEY, algorithms=ALGORITHM)
        return data

    except JWTError:
        raise JWTError("Could not validate credentials")
