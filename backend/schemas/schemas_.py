"""Pydantic models for validation"""

from pydantic import BaseModel, ConfigDict, EmailStr, Field
from uuid import UUID as uuid




class UserCreate(BaseModel):
    """Pydantic model for user creation (signup)"""

    model_config = ConfigDict(arbitrary_types_allowed=True)


    firstName: str = Field(min_length=1, max_length=50, description="First name of the user")
    lastName: str = Field(min_length=1, max_length=50, description="Last name of the user")

    username: str = Field(min_length=1, max_length=50, description="Username of the user")
    email: EmailStr = Field(description="Email address of the user")

    password: str = Field(min_length=8, max_length=128, description="Password for the user account")


class UserLogin(BaseModel):
    model_config = ConfigDict(arbitrary_types_allowed=True)


    # username: str = Field(description="Username of the user")
    email: EmailStr = Field(description="Email address of the user")    
    password: str = Field(description="Password of the user")


class UserDisplay(BaseModel):
    model_config = ConfigDict(arbitrary_types_allowed=True)


    id: uuid = Field(description="Unique identifier for the user")
    firstName: str = Field(description="First name of the user")
    lastName: str = Field(description="Last name of the user")
    username: str = Field(description="Username of the user")
    email: EmailStr = Field(description="Email address of the user")
    is_active: bool = Field(description="Indicates if the user is active")
    role: str = Field(description="Role of the user")

