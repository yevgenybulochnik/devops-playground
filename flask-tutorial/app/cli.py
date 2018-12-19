import subprocess
from app import app
import click


@app.cli.group()
def testcli():
    """Test CLI command"""
    pass


@testcli.command()
@click.argument('user')
def echo(user):
    """Enter username to echo to command line"""
    subprocess.call(['echo', 'Hello World CLI!', user])
