#!/bin/sh
# If /etc/ssh/setup exists just exit the script
if [ -f /etc/ssh/setup-complete ]; then
  echo : Already setup, starting sshd.
  exit 0
fi


echo : Running setup\n: Writing config

cat << EOF > /etc/ssh/sshd_config
Port $SSH_PORT

AllowUsers          $TUNNEL_USER
HostKey             /etc/ssh/ssh_host_ecdsa_key
HostKey             /etc/ssh/ssh_host_ed25519_key
HostKey             /etc/ssh/ssh_host_rsa_key
AuthorizedKeysFile  /etc/ssh/authorized_keys

Match User $TUNNEL_USER
  ForceCommand            /bin/echo do-not-send-commands
  AllowTcpForwarding      yes
  PubkeyAuthentication    yes
  PasswordAuthentication  no
EOF

echo : Writing authorized_keys

echo $TUNNEL_PUBLIC_KEY > /etc/ssh/authorized_keys

echo The runtime-setup.sh script was run already so this file is checked by it on run to make sure it was setup. > /etc/ssh/setup-complete

echo : All done, starting sshd!