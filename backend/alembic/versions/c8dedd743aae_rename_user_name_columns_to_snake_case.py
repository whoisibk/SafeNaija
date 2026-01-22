"""rename user name columns to snake_case

Revision ID: c8dedd743aae
Revises: 2f945310b1b5
Create Date: 2026-01-22 16:10:39.002390

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = 'c8dedd743aae'
down_revision: Union[str, Sequence[str], None] = '2f945310b1b5'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


from alembic import op

def upgrade():
    op.alter_column(
        "users",
        "firstName",
        new_column_name="first_name"
    )
    op.alter_column(
        "users",
        "lastName",
        new_column_name="last_name"
    )


def downgrade():
    op.alter_column(
        "users",
        "first_name",
        new_column_name="firstName"
    )
    op.alter_column(
        "users",
        "last_name",
        new_column_name="lastName"
    )
