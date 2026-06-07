from fastapi.testclient import TestClient

from src.server import app

client = TestClient(app)


def test_ping_endpoint():
    response = client.get("/ping")
    assert response.status_code == 200
    assert response.json() == "pong"


def test_root_redirects_to_docs():
    response = client.get("/", follow_redirects=False)
    assert response.status_code in (301, 302, 307, 308)
    assert "/docs" in response.headers["location"]
