"""use database defaults for timestamps

Revision ID: 4a7fbf7d06a2
Revises: 9e55e504f5ea
Create Date: 2026-01-22 16:13:13.137356

"""

from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = "4a7fbf7d06a2"
down_revision: Union[str, Sequence[str], None] = "9e55e504f5ea"
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade():
    op.alter_column("users", "created_at", server_default=sa.text("NOW()"))

    op.alter_column("reports", "created_at", server_default=sa.text("NOW()"))

    op.alter_column("reports", "updated_at", server_default=sa.text("NOW()"))


def downgrade():
    op.alter_column("users", "created_at", server_default=None)
    op.alter_column("reports", "created_at", server_default=None)
    op.alter_column("reports", "updated_at", server_default=None)
