"""remove unique constraint from category

Revision ID: 1ffdf63bbc66
Revises: cf00c8e44051
Create Date: 2026-01-22 16:22:21.429125

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = '1ffdf63bbc66'
down_revision: Union[str, Sequence[str], None] = 'cf00c8e44051'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade():
    # 1️⃣ Drop the UNIQUE constraint
    op.drop_constraint(
        "categories_name_key",  # this is usually the default name Postgres gave the UNIQUE
        "categories",
        type_="unique"
    )

    # 2️⃣ Alter the column length
    op.alter_column(
        "categories",
        "name",
        type_=sa.String(20),  # new max length
        existing_type=sa.String(50),  # old max length
        existing_nullable=False
    )

def downgrade():
    # 1️⃣ Restore the old column length
    op.alter_column(
        "categories",
        "name",
        type_=sa.String(50),
        existing_type=sa.String(20),
        existing_nullable=False
    )

    # 2️⃣ Restore the UNIQUE constraint
    op.create_unique_constraint(
        "categories_name_key",
        "categories",
        ["name"]
    )
