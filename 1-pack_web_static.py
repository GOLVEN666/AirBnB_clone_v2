#!/usr/bin/python3
"""A Fabric script that generates a .tgz"""

from datetime import datetime
from fabric.api import local
from os.path import isdir

def do_pack():
    """Generates a tgz archive from the contents of the web_static folder."""
    try:
        date = datetime.now().strftime("%Y%m%d%H%M%S")
        if not isdir("versions"):
            local("mkdir versions")
        file_name = "versions/web_static_{}.tgz".format(date)
        local("tar -cvzf {} web_static".format(file_name))
        print("Archive created successfully: {}".format(file_name))
        return file_name
    except Exception as e:
        print("Error: {}".format(e))
        return None

