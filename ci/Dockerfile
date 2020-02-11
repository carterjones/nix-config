ARG IMAGE=carterjones/replace-me
FROM $IMAGE

RUN /bin/bash -c "echo notroot ALL=\(ALL\) NOPASSWD: ALL >> /etc/sudoers"
RUN useradd -ms /bin/bash notroot
USER notroot
