# Auto-Deploy Website

## Projektbeschreibung

Dieses Projekt ermöglicht automatische Deployments einer Website mittels Webhooks und Docker. Bei jedem Push auf das GitHub-Repository wird die Website automatisch aktualisiert und neu bereitgestellt.

## Anforderungen

- Docker muss installiert sein.

## Schritte zur Ausführung des Projekts

1. **Docker-Image herunterladen:**

    ```bash
    docker pull dein-dockerhub-benutzername/auto-deploy-website:latest
    ```

2. **Docker-Container starten:**

    ```bash
    docker run -d -p 80:80 -p 8080:8080 --name auto-deploy-website dein-dockerhub-benutzername/auto-deploy-website:latest
    ```

3. **Logs überprüfen:**

    ```bash
    docker logs auto-deploy-website
    ```

## Beispiel-Befehle

- **Container stoppen:**

    ```bash
    docker stop auto-deploy-website
    ```

- **Container starten:**

    ```bash
    docker start auto-deploy-website
    ```

- **Container löschen:**

    ```bash
    docker rm -f auto-deploy-website
    ```

## Details

Das Docker-Image enthält:

- Apache HTTP Server
- Webhookd
- Ein Git-Repository, das automatisch aktualisiert wird
- Ein Skript zum Starten von Apache und Webhookd
