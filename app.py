from flask import Flask, render_template, request
import requests
import os

app = Flask(__name__)

API_KEY = os.getenv('WEATHER_API_KEY')  # Make sure to set your API key in environment variables

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/weather', methods=['POST'])
def weather():
    city = request.form['city']
    weather_data = get_weather(city)
    return render_template('index.html', weather_data=weather_data, city=city)

def get_weather(city):
    url = f'http://api.openweathermap.org/data/2.5/weather?q={city}&appid={API_KEY}&units=metric'
    response = requests.get(url)
    return response.json()

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
