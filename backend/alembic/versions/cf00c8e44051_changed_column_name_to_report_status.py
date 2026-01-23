"""changed column name to report_status

Revision ID: cf00c8e44051
Revises: 4a7fbf7d06a2
Create Date: 2026-01-22 16:16:20.046628

"""

from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = "cf00c8e44051"
down_revision: Union[str, Sequence[str], None] = "4a7fbf7d06a2"
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade():
    op.alter_column("reports", "status", new_column_name="report_status")


def downgrade():
    op.alter_column("reports", "report_status", new_column_name="status")
