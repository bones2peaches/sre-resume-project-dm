import unittest
import psycopg2
import os
from urllib.parse import quote_plus


# Unit test
class TestDatabaseConnection(unittest.TestCase):
    def test_connection(self):
        """Test if connection to PostgreSQL database is successful."""
        try:
            DB_USER = os.getenv("DB_USER")
            DB_PASSWORD = quote_plus(os.getenv("DB_PASSWORD"))
            DB_HOST = os.getenv("DB_HOST")
            DB_PORT = os.getenv("DB_PORT")
            DB_NAME = "postgres"
            postgres_url = (
                f"postgresql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
            )
            print(postgres_url)
            conn = psycopg2.connect(postgres_url)
            cursor = conn.cursor()
            cursor.execute("SELECT 1;")  # Execute a simple SELECT statement
            self.assertTrue(cursor.fetchone(), "Unable to fetch from PostgreSQL")
            cursor.close()
            conn.close()
            print("Connection to PostgreSQL database was successful.")
        except psycopg2.OperationalError as e:
            self.fail(f"PostgreSQL connection test failed: {e}")


if __name__ == "__main__":
    unittest.main()
