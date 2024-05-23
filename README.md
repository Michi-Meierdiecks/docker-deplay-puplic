```markdown
# Docker Deployment Script

Dieses Skript installiert Docker, konfiguriert die Firewall, klont ein Git-Repository und startet einen Docker-Container.

## Anleitung

Führen Sie die folgenden Befehle in Ihrer EC2-Instanz aus:

### Installation und Konfiguration

```sh
#!/bin/bash

# Aktualisiere die Paketliste und installiere benötigte Pakete
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common git -y

# Füge den Docker GPG-Schlüssel hinzu
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Füge das Docker Repository hinzu
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Aktualisiere die Paketliste erneut
sudo apt update

# Installiere Docker
sudo apt install docker-ce -y

# Starte den Docker-Dienst und aktiviere ihn, damit er beim Booten startet
sudo systemctl start docker
sudo systemctl enable docker

# Füge den aktuellen Benutzer zur Docker-Gruppe hinzu
sudo usermod -aG docker $USER

# Setze die Firewall-Regeln, um Port 8080 und Port 80 freizugeben
sudo ufw allow 8080
sudo ufw allow 80

# Aktualisiere die Gruppenzugehörigkeit im laufenden Terminal
newgrp docker

# Klone das Git-Repository
git clone https://github.com/Michi-Meierdiecks/docker-deplay-puplic.git
cd docker-deplay-puplic

# Baue das Docker-Image
docker build -t webhookd-deploy .

# Starte einen Docker-Container aus dem erstellten Image
docker run -d -p 8080:8080 -p 80:80 --name webhookd-deploy webhookd-deploy

# Setze die erforderlichen Berechtigungen für das Update-Skript
sudo chmod +x ~/docker-deplay-puplic/update.sh

# Zeige die Logs des gestarteten Containers an
docker logs webhookd-deploy
```

### Automatische Aktualisierung

Dieses Setup verwendet Webhooks, um automatische Updates durchzuführen, wenn neue Änderungen an das GitHub-Repository gepusht werden.

1. Erstelle ein Webhook in deinem GitHub-Repository:
    - Gehe zu den Einstellungen deines Repositories.
    - Klicke auf "Webhooks" und dann auf "Add webhook".
    - Setze die Payload-URL auf `http://<YOUR_EC2_PUBLIC_IP>:8080/hooks/deploy`.
    - Wähle `application/json` als Content-Type.
    - Setze das Ereignis auf "Just the push event".
    - Klicke auf "Add webhook".

2. Die `hooks.json` Datei in deinem Repository sollte wie folgt aussehen:

    ```json
    [
      {
        "id": "deploy",
        "execute-command": "/home/ubuntu/selfmade-pipeline/auto-deploy-website/update.sh",
        "command-working-directory": "/home/ubuntu/selfmade-pipeline/auto-deploy-website"
      }
    ]
    ```

3. Das `update.sh` Skript sollte sicherstellen, dass das Repository aktualisiert wird und der Webserver neu gestartet wird:

    ```sh
    #!/bin/bash
    cd /home/ubuntu/selfmade-pipeline/auto-deploy-website
    git pull origin main
    sudo systemctl restart apache2
    ```

### Troubleshooting

- Stellen Sie sicher, dass Ihre Sicherheitsgruppe in AWS die Ports 80 und 8080 zulässt.
- Möglicherweise müssen Sie sich nach der Ausführung des Skripts ab- und wieder anmelden, damit die Gruppenzugehörigkeit wirksam wird.
- Das Update-Skript wird automatisch ausgeführt, wenn ein neuer Commit in das Repository gepusht wird.

## Hinweise

Dieses Setup ermöglicht die automatische Bereitstellung und Aktualisierung einer Website basierend auf Commits in einem GitHub-Repository. Stellen Sie sicher, dass alle Pfade und Berechtigungen korrekt gesetzt sind, um einen reibungslosen Ablauf zu gewährleisten.
```

Diese README-Datei führt alle notwendigen Schritte und Befehle aus, um eine EC2-Instanz zu konfigurieren, Docker zu installieren, ein Git-Repository zu klonen, einen Docker-Container zu starten und automatische Updates über GitHub-Webhooks zu ermöglichen.
