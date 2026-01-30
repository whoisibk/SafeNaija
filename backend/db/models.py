from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import (
    Column,
    Float,
    Uuid,
    Integer,
    String,
    Boolean,
    DateTime,
    ForeignKey,
    Text,
    UniqueConstraint,
)

from uuid import uuid4

from datetime import datetime

Base = declarative_base()


class User(Base):
    """SQLAlchemy model for a user in the authentication system."""

    __tablename__ = "users"

    id = Column(Uuid, primary_key=True, index=True, default=uuid4)

    first_name = Column(String(50), nullable=False)
    last_name = Column(String(50), nullable=False)

    username = Column(String(30), unique=True, index=True, nullable=False)
    email = Column(String, unique=True, index=True, nullable=False)
    password_hash = Column(String, nullable=False)
    is_active = Column(Boolean, default=True)

    created_at = Column(DateTime, default=datetime.now)
    last_login = Column(DateTime, nullable=True, default=None)

    role = Column(String, default="user")

    def __repr__(self):
        """String representation of the User model."""
        return f"<User(username={self.username}, email={self.email})>"


class Report(Base):
    """Model for user incident reports."""

    __tablename__ = "reports"

    id = Column(Uuid, primary_key=True, index=True, default=uuid4)
    user_id = Column(Uuid, ForeignKey("users.id"), nullable=False)
    title = Column(String(50), nullable=False)
    description = Column(Text, nullable=False)
    category_id = Column(Uuid, ForeignKey("categories.id"), nullable=False)

    severity = Column(Integer, nullable=False)  # e.g., scale of 1-3 for severity level

    # for map plotting / geolocation
    latitude = Column(Float, nullable=True)
    longitude = Column(Float, nullable=True)

    media_url = Column(String, nullable=True)

    # pending, verified, dismissed
    verification_status = Column(String, default="pending", nullable=False)

    upvote_count = Column(Integer, default=0)

    created_at = Column(DateTime, default=datetime.now)
    updated_at = Column(DateTime, default=datetime.now, onupdate=datetime.now)


class Category(Base):
    """Model for report categories: theft, accident, roadblock, etc."""

    __tablename__ = "categories"

    id = Column(Uuid, primary_key=True, index=True, default=uuid4)
    name = Column(String(30), nullable=False)


class ReportVote(Base):
    """Model for votes on reports."""

    __tablename__ = "report_votes"

    id = Column(Uuid, primary_key=True, index=True, default=uuid4)
    report_id = Column(Uuid, ForeignKey("reports.id"), nullable=False)
    user_id = Column(Uuid, ForeignKey("users.id"), nullable=False)
    vote = Column(String, nullable=False)  # upvote or none

    created_at = Column(DateTime, default=datetime.now)

    # Ensure a user can only vote once per report
    # catch the error this generate when user tries to vote again, and handle it
    __table_args__ = (
        UniqueConstraint("report_id", "user_id", name="unique_report_user_vote"),
    )
