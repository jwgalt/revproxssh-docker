FROM alpine:3.19

# Change these if you want to use a different port or user name
ENV SSH_PORT=722
ENV TUNNEL_USER=tunnel
ENV TUNNEL_PUBLIC_KEY='Dont forget to set your pubkey'

# Install xvfb and other dependencies
RUN apk add --no-cache \
  openssh

# Create a user
RUN adduser -D ${TUNNEL_USER}

# Unlock the user account for login
RUN passwd -u ${TUNNEL_USER}

# lets add the setup
COPY runtime-setup.sh /runtime-setup.sh

# Generate host keys
RUN ssh-keygen -A

# Expose the port
EXPOSE ${SSH_PORT}

# Run runtime-setup and then sshd
CMD /bin/sh /runtime-setup.sh && /usr/sbin/sshd -D