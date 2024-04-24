from fastapi import APIRouter, status, Depends, HTTPException
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select
from app.database import get_db

import httpx

router = APIRouter()


async def get_public_ip():
    """Fetches the public IP address using an external API."""
    async with httpx.AsyncClient() as client:
        response = await client.get("https://api64.ipify.org?format=json")
        ip_data = response.json()
        return ip_data["ip"]


@router.get("/ip", status_code=status.HTTP_200_OK)
async def healthcheck_ip():
    public_ip = await get_public_ip()  # Retrieve the public IP
    return {"status": "OK", "ip": public_ip}


@router.get("/postgres", status_code=status.HTTP_200_OK)
async def postgres_healthcheck(db: AsyncSession = Depends(get_db)):
    try:
        result = await db.execute(select(1))
        _ = result.fetchall()
        resp = {"status": "OK"}
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_503_SERVICE_UNAVAILABLE,
            detail="Database connection error",
        )
    return resp


@router.get("/postgres", status_code=status.HTTP_200_OK)
async def postgres_healthcheck(db: AsyncSession = Depends(get_db)):
    try:
        result = await db.execute(select(1))
        _ = result.fetchall()
        resp = {"status": "OK"}
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_503_SERVICE_UNAVAILABLE,
            detail="Database connection error",
        )
    return resp
