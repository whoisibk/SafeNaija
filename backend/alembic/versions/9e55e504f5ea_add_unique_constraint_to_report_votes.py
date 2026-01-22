"""add unique constraint to report_votes

Revision ID: 9e55e504f5ea
Revises: c8dedd743aae
Create Date: 2026-01-22 16:11:57.721790

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = '9e55e504f5ea'
down_revision: Union[str, Sequence[str], None] = 'c8dedd743aae'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade():
    op.create_unique_constraint(
        "unique_report_user_vote",
        "report_votes",
        ["report_id", "user_id"]
    )


def downgrade():
    op.drop_constraint(
        "unique_report_user_vote",
        "report_votes",
        type_="unique"
    )