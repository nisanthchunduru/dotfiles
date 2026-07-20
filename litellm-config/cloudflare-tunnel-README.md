# Cloudflare Tunnel

Configure Cloudflare tunnel for LiteLLM

## Prerequisites

- A Cloudflare account
- A domain managed by Cloudflare
- LiteLLM running locally on port 4000

## Setup

Install `cloudflared`

```bash
brew install cloudflared
```

Login

```bash
cloudflared tunnel login
```

This opens a browser to authenticate. Select your domain and authorize.

Create a tunnel

```bash
cloudflared tunnel create ll
```

This creates a tunnel named `ll` and generates a credentials file at:
`~/.cloudflared/<TUNNEL_ID>.json`

Configure the tunnel. Create a `~/.cloudflared/config.yml` file

```yaml
tunnel: ll
credentials-file: /Users/<USERNAME>/.cloudflared/<TUNNEL_ID>.json

ingress:
  - hostname: ll.<YOUR_DOMAIN>
    service: http://localhost:4000
  - service: http_status:404
```

When creating the config file above, replace

- `<USERNAME>` with your macOS username
- `<YOUR_DOMAIN>` with your Cloudflare-managed domain
- `<TUNNEL_ID>` with the ID from the create step

Create a DNS record

```bash
cloudflared tunnel route dns ll ll.<YOUR_DOMAIN>
```

This creates a CNAME record pointing `ll.<YOUR_DOMAIN>` to your tunnel.

Start the tunnel

```bash
cloudflared tunnel run ll
```

LiteLLM should now be accessible at `https://ll.<YOUR_DOMAIN>`

### Run as Background Service (Optional)

To run the tunnel as a launchd service

```bash
sudo cloudflared service install
```

## Useful Commands

List tunnels

```bash
cloudflared tunnel list
```

Print tunnel info

```bash
cloudflared tunnel info ll
```

Delete tunnel

```bash
cloudflared tunnel delete ll
```

View tunnel logs

```bash
cloudflared tunnel run ll --loglevel debug
```
