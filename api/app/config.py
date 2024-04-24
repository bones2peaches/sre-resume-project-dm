import os

from urllib.parse import quote_plus
from pydantic import PostgresDsn
from pydantic_settings import BaseSettings
import json
from json import JSONDecodeError

stage = os.getenv("STAGE").lower()
if stage == "unit":
    pg_url = f"postgresql+asyncpg://unit:unit@unit:5432/unit"

elif stage == "test":

    try:
        secret = json.loads(os.getenv("DB_PASSWORD"))
        DB_USER = secret["username"]
        DB_PASSWORD = db_password = quote_plus(secret["password"])

    except JSONDecodeError:
        DB_USER = os.getenv("DB_USER")
        DB_PASSWORD = os.getenv("DB_PASSWORD")

    DB_HOST = os.getenv("DB_HOST")
    DB_PORT = os.getenv("DB_PORT")
    DB_NAME = os.getenv("DB_NAME")
    pg_url = (
        f"postgresql+asyncpg://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
    )


jwt_algo = os.getenv("JWT_ALGORITHM", "HS256")
jwt_expire = os.getenv("JWT_EXPIRE", "30")
jwt_key = os.getenv(
    "JWT_KEY", "09d25e094faa6ca2556c818166b7a9563b93f7099f6f0f4caa6cf63b88e8d3e7"
)


class Settings(BaseSettings):
    asyncpg_url: PostgresDsn = pg_url
    jwt_algorithm: str = jwt_algo
    jwt_expire: int = jwt_expire
    jwt_key: str = jwt_key


#

settings = Settings()
