from flask import Flask, jsonify, request
from flask_cors import CORS, cross_origin
from flask_jwt_extended import JWTManager, jwt_required, create_access_token
from flask_sqlalchemy import SQLAlchemy
from datetime import timedelta

app = Flask(__name__)
cors = CORS(app)
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://root:password@localhost/samviddhi'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['JWT_SECRET_KEY'] = 'acs17%^&81bja()'
app.config['JWT_EXPIRATION_DELTA'] = timedelta(seconds=1800)
app.config['CORS_HEADER'] = 'Content-Type'
jwt = JWTManager(app)
db = SQLAlchemy(app)

class TA(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    native_english_speaker = db.Column(db.Integer, nullable=False)
    course_instructor = db.Column(db.Integer, nullable=False)
    course = db.Column(db.Integer, nullable=False)
    summer_or_regular = db.Column(db.Integer, nullable=False)
    class_size = db.Column(db.Integer, nullable=False)
    class_attribute = db.Column(db.Integer, nullable=False)
    
    def __repr__(self):
        return f"TA(id={self.id}, native_english_speaker={self.native_english_speaker}, course_instructor='{self.course_instructor}', course='{self.course}', semester={self.summer_or_regular}, class_size={self.class_size}, performance_score={self.class_attribute})"


@app.route('/')
@cross_origin()
def index():
    return 'Hello, From Samviddhi!'


@app.route('/login', methods=['POST'])
@cross_origin()
def login():
    username = request.json.get('username')
    password = request.json.get('password')
    print(username, password)
    if username != 'admin' or password != 'password':
        return jsonify({'msg': 'Invalid credentials'}), 401
    access_token = create_access_token(identity=username)
    return jsonify({'access_token': access_token}), 200



@app.route('/api/add', methods=['POST'])
@jwt_required()
@cross_origin()
def add_ta():
    try:
        data = request.get_json()
        new_ta = TA(
            native_english_speaker=int(data['native_english_speaker']),
            course_instructor=int(data['course_instructor']),
            course=int(data['course']),
            summer_or_regular=int(data['semester']),
            class_size=int(data['class_size']),
            class_attribute=int(data['performance_score'])
        )
        db.session.add(new_ta)
        db.session.commit()
        return jsonify({'message': 'New TA added successfully.'}), 201
    except Exception as e:
        return jsonify({'message': 'Failed to add New TA'}), 401
    

@app.route('/api/retrieve', methods=['POST'])
@cross_origin()
def retrieve_ta():
    try:
        data = request.get_json()
        id = int(data['id'])
        ta_obj = TA.query.filter_by(id = id).all()[0]
        response = {"native_english_speaker" : ta_obj.native_english_speaker, "course_instructor" : ta_obj.course_instructor, "course" : ta_obj.course, "summer_or_regular" : ta_obj.summer_or_regular, "class_size" : ta_obj.class_size, "class_attribute" : ta_obj.class_attribute}
        return jsonify({'message': 'success',  "data" : [response]}), 201
    except Exception as e:
        return jsonify({'message': 'Failed to fetch TA data'}), 401
    


@app.route('/api/retrieve-all', methods=['POST'])
@cross_origin()
def retrieve_all_ta():
    try:
        ta_objs = TA.query.all()
        data = []
        for ta_obj in ta_objs:
            response = {"native_english_speaker" : ta_obj.native_english_speaker, "course_instructor" : ta_obj.course_instructor, "course" : ta_obj.course, "summer_or_regular" : ta_obj.summer_or_regular, "class_size" : ta_obj.class_size, "class_attribute" : ta_obj.class_attribute}
            data.append(response)
        return jsonify({'message': 'success',  "data" : data}), 201
    except Exception as e:
        return jsonify({'message': 'Failed to fetch TA data'}), 401
    
    
@app.route('/api/update', methods=['POST'])
@jwt_required()
@cross_origin()
def update_ta():
    try:
        data = request.get_json()
        id = int(data['id'])
        ta_obj = TA.query.get_or_404(id)
        native_english_speaker = int(data['native_english_speaker']),
        course_instructor = int(data['course_instructor']),
        course = int(data['course']),
        summer_or_regular = int(data['semester']),
        class_size = int(data['class_size']),
        class_attribute = int(data['performance_score'])
        
        ta_obj.native_english_speaker = native_english_speaker
        ta_obj.course_instructor = course_instructor
        ta_obj.course = course
        ta_obj.summer_or_regular = summer_or_regular
        ta_obj.class_size = class_size
        ta_obj.class_attribute = class_attribute
        
        db.session.add(ta_obj)
        db.session.commit()
        return jsonify({'message': 'TA Updated successfully.'}), 201
    except Exception as e:
        return jsonify({'message': 'Failed to update exhisting TA'}), 401
    
    
@app.route('/api/delete', methods=['POST'])
@jwt_required()
@cross_origin()
def delete_ta():
    try:
        data = request.get_json()
        id = int(data['id'])
        ta_obj = TA.query.get_or_404(id)
        db.session.delete(ta_obj)
        db.session.commit()
        return jsonify({'message': 'TA deleted successfully.'}), 201
    except Exception as e:
        return jsonify({'message': 'Failed delete the TA'}), 401



if __name__ == '__main__':
    app.run(debug=True,  host='192.168.1.103', port=5000)