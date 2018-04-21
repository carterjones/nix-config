Install XCode tools:
    cmd.run:
        - name: xcode-select --install &> /dev/null || true
        - unless:
            - which make
