import grp
import os
import pwd


def current():
    if 'SUDO_USER' in os.environ:
        return os.environ['SUDO_USER']
    else:
        return os.environ['USER']


def group():
    stat_info = os.stat(os.environ['HOME'])
    gid = stat_info.st_gid
    group = grp.getgrgid(gid)[0]
    return group
