from fastapi import APIRouter, Depends

from queries.report_queries import create_report
from queries.category_queries import get_category_id
from queries.user_queries import get_db, Session

from api.auth.dependencies import get_current_user
from schemas.report_schemas import ReportCreate, ReportUpdate, Severity
from db.models import User, Report, ReportVote
from uuid import UUID as Uuid
from datetime import datetime


router = APIRouter()


"""""" "-----------------------------------REPORT CREATION----------------------------------------------" """""" ""


@router.post("/create")
def report_create(
    report: ReportCreate,
    user: User = Depends(get_current_user),
    db_session: Session = Depends(get_db),
):
    """Endpoint to create a report.
    Args:
        user (User): The current authenticated user.
        report(ReportCreate): The report details from the user.

    Returns:

    """
    user_id = user.id
    # Convert Pydantic model to dictionary
    report = report.model_dump()

    category_id = get_category_id(report["category"], db_session)

    new_report = Report(
        title=report["title"],
        description=report["description"],
        category_id=category_id,
        severity=report.get("severity").lower().strip(),
        user_id=user_id,
        latitude=report.get("latitude"),
        longitude=report.get("longitude"),
        media_url=report.get("media_url"),
    )

    try:
        create_report(new_report, db_session)
        return {"message": "Report created successfully", "report": report}
    except Exception as e:
        return {"An error occurred while creating the report": str(e)}




"""""" "-----------------------------------REPORT FETCHING----------------------------------------------" """""" ""
@router.get("/my")
def view_my_reports(
    user: User = Depends(get_current_user), db_session: Session = Depends(get_db)
):
    """Endpoint to view all reports made by the current user"""

    user_id = user.id
    user_reports = db_session.query(Report).filter(Report.user_id == user_id).all()

    return {"reports": user_reports}


@router.get("/my/{report_id}")
def view_my_report(
    report_id: Uuid,
    user: User = Depends(get_current_user),
    db_session: Session = Depends(get_db),
):
    """Endpoint to view a specific report made by the current user"""

    user_id = user.id
    report = (
        db_session.query(Report)
        .filter(Report.id == report_id, Report.user_id == user_id)
        .first()
    )
    if not report:
        return {"message": "Report not found."}
    return {"report": report}


@router.patch("/my/{report_id}")
def update_my_report(
    report_id: Uuid,
    updatedreport: ReportUpdate,
    user: User = Depends(get_current_user),
    db_session: Session = Depends(get_db),
):
    """Endpoint to update a specific report made by the current user"""

    user_id = user.id
    report = (
        db_session.query(Report)
        .filter(Report.id == report_id, Report.user_id == user_id)
        .first()
    )
    if not report:
        return {"message": "Report not found."}

    # Get the update data as a dictionary, excluding unset fields
    update_data = updatedreport.model_dump(exclude_unset=True)

    # Update the report fields
    for key, value in update_data.items():
        if key == "severity":
            severity_mapping = {"low": 1, "mid": 2, "high": 3}
            value = severity_mapping[value]
        setattr(report, key, value)

    try:
        db_session.commit()
        db_session.refresh(report)
        return {"message": "Report updated successfully", "report": report}
    except Exception as e:
        db_session.rollback()
        return {"An error occurred while updating the report": str(e)}
    


"""""" "-----------------------------------REPORT DELETION----------------------------------------------" """""" ""

@router.delete("/my/{report_id}")
def delete_my_report(
    report_id: Uuid,
    user: User = Depends(get_current_user),
    db_session: Session = Depends(get_db),
):
    """Endpoint to delete a specific report made by the current user"""

    user_id = user.id
    report = (
        db_session.query(Report)
        .filter(Report.id == report_id, Report.user_id == user_id)
        .first()
    )
    if not report:
        return {"message": "Report not found."}

    try:
        db_session.delete(report)
        db_session.commit()
        return {"message": "Report deleted successfully"}
    except Exception as e:
        db_session.rollback()
        return {"An error occurred while deleting the report": str(e)}
    


"""""" "-----------------------------------NOT USER-SPECIFIC ENDPOINTS----------------------------------------------" """""" ""

@router.get("/view")
def view_reports(
    category: str = None,
    severity: Severity = None,
    created_at: datetime = None,
    verification_status: str = None,
    limit=25,
    db_session: Session = Depends(get_db),
):
    """Endpoint to view all reports with optional filters.
    Args:
        category (str|None): Filter by category name.
        severity (Severity|None): Filter by severity level.
        created_at (datetime|None): Filter by creation date.
        limit (int): Maximum number of reports to return.

    Returns:
        dict: A dictionary containing a list of reports.
    """

    query = db_session.query(Report)

    if category:
        category_id = get_category_id(category, db_session)

        # Filter reports by category ID
        query = query.filter(Report.category_id == category_id)

    if severity:
        severity_mapping = {Severity.low: 1, Severity.mid: 2, Severity.high: 3}
        severity_value = severity_mapping[severity]

        # Filter reports by severity value
        query = query.filter(Report.severity == severity_value)

    if created_at:
        # Filter reports by creation date
        query = query.filter(Report.created_at >= created_at)
    
    if verification_status:
        # Filter reports by verification status
        query = query.filter(Report.verification_status == verification_status)

    # Limit the number of reports returned
    reports = query.limit(limit).all()

    return {"reports": reports}


@router.get("/view/{report_id}")
def view_report(report_id: Uuid, db_session: Session = Depends(get_db)):
    """Endpoint to view a specific report by its ID."""

    report = db_session.query(Report).filter(Report.id == report_id).first()
    if not report:
        return {"message": "Report not found."}
    return {"report": report}


@router.get("/map")
def map_view(
    north: float,
    south: float,
    east: float,
    west: float,
    db_session: Session = Depends(get_db),
):
    """Endpoint to get reports within specified map bounds.
    Args:
        north (float): Northern latitude bound.
        south (float): Southern latitude bound.
        east (float): Eastern longitude bound.
        west (float): Western longitude bound.
    Returns:
        dict: A dictionary containing a list of reports within the specified bounds.
    """

    reports_ = (
        db_session.query(Report)
        .filter(
            Report.latitude <= north,
            Report.latitude >= south,
            Report.longitude <= east,
            Report.longitude >= west,
        )
        .all()
    )

    reports = []

    # Build a list of main report details for map plotting
    for report in reports_:
        reports.append(
            {
                "id": report.id,
                "title": report.title,
                "category_id": report.category_id,
                "severity": report.severity,
                "latitude": report.latitude,
                "longitude": report.longitude,
            }
        )

    return {"reports": reports}


"""""" "-----------------------------------REPORT INTERACTION----------------------------------------------" """""" ""


@router.post("/{report_id}/upvote")
def upvote_report(
    report_id: Uuid,
    user: User = Depends(get_current_user),
    db_session: Session = Depends(get_db),
):
    """Endpoint to upvote a report."""
    user_id = user.id

    # Check if the user has already voted on this report
    existing_vote = (
        db_session.query(ReportVote)
        .filter(ReportVote.report_id == report_id, ReportVote.user_id == user_id)
        .first()
    )

    reportmodel = db_session.query(Report).filter(Report.id == report_id).first()
    

    if existing_vote:
        current_upvotes = reportmodel.upvote_count or 0
        if existing_vote.vote == "upvote":
            return {"message": "You have already upvoted this report."}
        else:
            existing_vote.vote = "upvote"
            current_upvotes += 1

            if current_upvotes > 2:
                reportmodel.verification_status = "verified"
                
    else:
        new_vote = ReportVote(report_id=report_id, user_id=user_id, vote="upvote")
        current_upvotes = reportmodel.upvote_count or 0
        db_session.add(new_vote)
        current_upvotes += 1


    try:
        db_session.commit()
        reportmodel.upvote_count = current_upvotes
        return {"message": "Report upvoted successfully."}
    except Exception as e:
        db_session.rollback()
        return {"An error occurred while upvoting the report": str(e)}


@router.delete("/{report_id}/upvote")
def remove_upvote_report(
    report_id: Uuid,
    user: User = Depends(get_current_user),
    db_session: Session = Depends(get_db),
):
    """Endpoint to remove an upvote from a report."""
    user_id = user.id

    # Check if the user has voted on this report
    existing_vote = (
        db_session.query(ReportVote)
        .filter(ReportVote.report_id == report_id, ReportVote.user_id == user_id)
        .first()
    )

    if not existing_vote or existing_vote.vote != "upvote":
        return {"message": "You have not upvoted this report."}
    
    reportmodel = db_session.query(Report).filter(Report.id == report_id).first()
    current_upvotes = reportmodel.upvote_count or 0
    reportmodel.upvote_count = max(0, current_upvotes - 1)

    try:
        db_session.delete(existing_vote)
        db_session.commit()
        return {"message": "Upvote removed successfully."}
    except Exception as e:
        db_session.rollback()
        return {"An error occurred while removing the upvote": str(e)}

