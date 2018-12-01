from flask import render_template
from app import app


@app.route('/')
@app.route('/index')
def index():
    user = {'username': 'Eugene'}
    posts = [
        {
            'author': {'username': 'John'},
            'body': "It's a beautiful day in portland"
        },
        {
            'author': {'username': 'Susan'},
            'body': "The Avengers movie was awesome!"
        }
    ]
    return render_template('index.html', title='Home', user=user, posts=posts)
