from app import app


@app.route('/')
@app.route('/index')
def index():
    user = {'username': 'Eugene'}
    return f'''
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Home Page -- Flask Tutorial</title>
</head>
<body>
   <h1>Hello, {user["username"]}!</h1>
</body>
</html>
    '''
