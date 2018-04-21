Configure Gnome settings:
    cmd.run:
        - name: |
            # Set up terminal settings.
            PROFILE_PATH=/org/gnome/terminal/legacy/profiles:/
            PROFILE=$(dconf list $PROFILE_PATH)
            dconf write ${PROFILE_PATH}${PROFILE}scrollback-unlimited true
            # Set up workspaces
            gsettings set org.compiz.core:/org/compiz/profiles/unity/plugins/core/ hsize 3
            gsettings set org.compiz.core:/org/compiz/profiles/unity/plugins/core/ vsize 3
        - onlyif: apt list --installed 2>/dev/null | grep -q gnome-desktop
