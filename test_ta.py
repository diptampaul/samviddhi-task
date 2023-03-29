from flask import url_for
from main import app


def test_ta_addition():
    with app.test_request_context():
        with app.test_client() as client:
            data = {
                "username": "admin",
                "password": "password"
            }
            response = client.post('login', json=data)
            token = response.json["access_token"]
            
            headers = {
                "Authorization": f"Bearer {token}",
                "Content-Type": "application/json"
            }
            
            data = {
                "native_english_speaker": 1,
                "course_instructor": 23,
                "course": 3,
                "semester": 1,
                "class_size": 19,
                "performance_score": 3
            }
            response = client.post('api/add', json=data, headers=headers)
            print(response)
            assert response.status_code == 201
        
        
def test_ta_retrieval():
    with app.test_request_context():
        with app.test_client() as client:
            data = {
                "username": "admin",
                "password": "password"
            }
            response = client.post('login', json=data)
            token = response.json["access_token"]
            
            headers = {
                "Authorization": f"Bearer {token}",
                "Content-Type": "application/json"
            }
            
            data = {
                "id": 2
            }
            response = client.post('api/retrieve', json=data, headers=headers)
            assert response.status_code == 201
        
        
def test_ta_update():
    with app.test_request_context():
        with app.test_client() as client:
            data = {
                "username": "admin",
                "password": "password"
            }
            response = client.post('login', json=data)
            token = response.json["access_token"]
            
            headers = {
                "Authorization": f"Bearer {token}",
                "Content-Type": "application/json"
            }
            
            data = {
                "id": 2,
                "native_english_speaker": 1,
                "course_instructor": 23,
                "course": 3,
                "semester": 1,
                "class_size": 19,
                "performance_score": 2
            }
            response = client.post('api/update', json=data, headers=headers)
            assert response.status_code == 201
        
        
def test_ta_deletion():
    with app.test_request_context():
        with app.test_client() as client:
            data = {
                "username": "admin",
                "password": "password"
            }
            response = client.post('login', json=data)
            token = response.json["access_token"]
            
            headers = {
                "Authorization": f"Bearer {token}",
                "Content-Type": "application/json"
            }
            
            data = {
                "id": 2
            }
            response = client.post('api/delete', json=data, headers=headers)
            assert response.status_code == 201
