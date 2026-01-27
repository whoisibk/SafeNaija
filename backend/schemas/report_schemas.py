"""Pydantic models for report-related data validation and serialization."""

from pydantic import BaseModel, Field
from enum import Enum
from sqlalchemy import Integer
from typing import Optional


class ReportBase(BaseModel):
    """Base schema for report data."""

    title: str = Field(..., max_length=100, description="Title of the report")
    description: str = Field(
        ..., max_length=500, description="Detailed description of the report"
    )
    category: str = Field(..., description="Category of the report")


class Severity(str, Enum):
    """Enumeration for report severity levels."""

    low = "low"
    mid = "mid"
    high = "high"


class ReportCreate(ReportBase):
    """Schema for creating a new report."""

    severity: Severity = Field(
        default=Severity.low, description="Severity level of the report"
    )

    latitude: float = Field(None, description="Latitude for geolocation")
    longitude: float = Field(None, description="Longitude for geolocation")

    media_url: str = Field(
        None, description="URL of the image associated with the report"
    )


class ReportUpdate(BaseModel):
    """Schema for updating an existing report."""

    title: Optional[str] = Field(
        None, max_length=100, description="Title of the report"
    )
    description: Optional[str] = Field(
        None, max_length=500, description="Detailed description of the report"
    )
    category: Optional[str] = Field(None, description="Category of the report")

    severity: Optional[Severity] = Field(
        None, description="Severity level of the report"
    )

    latitude: Optional[float] = Field(None, description="Latitude for geolocation")
    longitude: Optional[float] = Field(None, description="Longitude for geolocation")
    media_url: Optional[str] = Field(
        None, description="URL of the image associated with the report"
    )
