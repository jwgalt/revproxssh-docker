# Basic SSHd Reverse Proxy

## Running the container

Pull the container with 
```docker pull jgalt042/revproxssh```

On first run the container will run runtime-setup.sh which will add config and your pubkey for authentication.
Add your desired username port and pubkey to the docker env with these variables:
```
ENV SSH_PORT=722
ENV TUNNEL_USER=tunnel
ENV TUNNEL_PUBLIC_KEY='Dont forget to set your pubkey'
```

## Connecting the tunnel

Connect your reverse tunnel with a command like this:

```ssh -N -T 1.2.3.4 -l tunnel -R 0:localhost:5050 -p 722```
