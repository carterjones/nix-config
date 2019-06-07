from __future__ import (absolute_import, division, print_function)

import os
import subprocess

from ranger.api.commands import Command


class fzf_select(Command):
    """
    :fzf_select

    Find a file using fzf.

    With a prefix argument select only directories.

    See:
    - https://github.com/junegunn/fzf
    - https://www.youtube.com/watch?v=C64LKCZFzME
    - https://github.com/gotbletu/shownotes/blob/master/ranger_file_locate_fzf.md
    """

    def execute(self):
        command = r"find -L . \( -path '*/\.*' -o -fstype 'dev' -o -fstype 'proc' \) \
            -print 2> /dev/null | grep -v '.git$' | grep -v '.git/' | cut -b3- | fzf +m"
        fzf = self.fm.execute_command(command, stdout=subprocess.PIPE)
        stdout = fzf.communicate()
        if fzf.returncode == 0:
            fzf_file = os.path.abspath(stdout.decode('utf-8').rstrip('\n'))
            if os.path.isdir(fzf_file):
                self.fm.cd(fzf_file)
            else:
                self.fm.select_file(fzf_file)
