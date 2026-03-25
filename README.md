## Launch n8n with Docker Compose

### Launch docker compose
To start the containers in the background, just run:
```commandline
sudo docker compose up -d
```
This command tells Docker to launch everything based on your docker-compose.yml file, including n8n and Traefik.

### Stop docker compose
To stop n8n, use the following command:
```commandline
sudo docker compose stop
```

## GitHub Actions + SSH Deploy

A GitHub Actions workflow that SSHes into a GCP instance and pulls the latest code on every push to `main`.

The workflow file is located at `.github/workflows/deploy.yml`.

### Step 1 — Generate a deploy key on your GCP instance

```bash
ssh-keygen -t ed25519 -C "github-deploy" -f ~/.ssh/github_deploy -N ""
cat ~/.ssh/github_deploy.pub >> ~/.ssh/authorized_keys
cat ~/.ssh/github_deploy  # copy this — it's your private key
```

### Step 2 — Add SSH credentials to GitHub Secrets

In your GitHub repo, go to **Settings → Secrets and variables → Actions** and add the following secrets:

| Secret Name | Value |
|---|---|
| `GCP_SSH_PRIVATE_KEY` | Contents of `~/.ssh/github_deploy` |
| `GCP_HOST` | Your GCP instance's external IP |
| `GCP_USER` | Your SSH username (e.g. `vinnakota4201`) |
| `GCP_DEPLOY_PATH` | Path to your docker files, e.g. `/home/vinnakota4201/n8n-compose` |

### Step 3 — Initialize the repo on your GCP instance

SSH into your GCP instance and run:

```bash
cd /home/vinnakota4201/n8n-compose
git init
git remote add origin https://github.com/priyatam-v/morning-n8n.git
git fetch origin

# Reset the local folder to exactly match remote main (Needed if we already have files)
git reset --hard origin/main
git branch -M main
```

### Step 4 — Grant your user Docker permissions

```bash
# Add the SSH user to the docker group
sudo usermod -aG docker $USER

# Apply the group change without logging out
newgrp docker

# Verify it works (should run without sudo)
docker ps
```
