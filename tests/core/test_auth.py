from fastapi.testclient import TestClient

from src.server import app

client = TestClient(app)


def test_protected_valid_token():
    response = client.get("/protected", headers={"X-API-Key": "banana"})
    assert response.status_code == 200
    assert response.json() == "secret-value"


def test_protected_invalid_token():
    response = client.get("/protected", headers={"X-API-Key": "wrong"})
    assert response.status_code == 401


def test_protected_missing_token():
    response = client.get("/protected")
    assert response.status_code == 401
