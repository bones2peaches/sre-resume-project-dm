import os
from urllib.parse import quote_plus
import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT


def wipe_database():
    # Load environment variables
    DB_USER = os.getenv("DB_USER")
    DB_PASSWORD = quote_plus(os.getenv("DB_PASSWORD"))  # Ensure password is URL-encoded
    DB_HOST = os.getenv("DB_HOST")
    DB_PORT = os.getenv("DB_PORT")
    DB_NAME = os.getenv("DB_NAME", "postgres")

    # Construct the PostgreSQL connection URL
    postgres_url = f"postgresql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
    print(f"Connecting to: {postgres_url}")

    try:
        # Connect to the PostgreSQL server
        conn = psycopg2.connect(postgres_url)
        conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
        cursor = conn.cursor()

        # Execute the wipe
        cursor.execute("SELECT tablename FROM pg_tables WHERE schemaname='public';")
        tables = cursor.fetchall()
        for table in tables:
            print(f"Dropping table: {table[0]}")
            cursor.execute(f"DROP TABLE IF EXISTS {table[0]} CASCADE;")

        print("All tables have been dropped.")
    except Exception as e:
        print("An error occurred:", e)
    finally:
        # Close the database connection
        cursor.close()
        conn.close()


if __name__ == "__main__":
    # WARNING: This script will wipe your database. Use with caution.
    confirm = input(
        "Are you sure you want to wipe the database? Type 'yes' to confirm: "
    )
    if confirm.lower() == "yes":
        wipe_database()
    else:
        print("Operation cancelled.")
