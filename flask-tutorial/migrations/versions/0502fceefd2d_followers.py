"""followers

Revision ID: 0502fceefd2d
Revises: 3c85782765fb
Create Date: 2018-12-09 19:14:17.135593

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '0502fceefd2d'
down_revision = '3c85782765fb'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('followers',
    sa.Column('follower_id', sa.Integer(), nullable=True),
    sa.Column('followed_id', sa.Integer(), nullable=True),
    sa.ForeignKeyConstraint(['followed_id'], ['user.id'], ),
    sa.ForeignKeyConstraint(['follower_id'], ['user.id'], )
    )
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_table('followers')
    # ### end Alembic commands ###