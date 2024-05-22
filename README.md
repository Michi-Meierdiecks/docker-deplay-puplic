markdown

# Webhook Deployment Project

Dieses Projekt richtet einen Webhook-Server ein, der automatische Deployments ausführt, wenn Push-Events von GitHub empfangen werden.

## Voraussetzungen

- Ein Computer oder Server mit installiertem Docker
- Git installiert (falls nicht, siehe [Git Installationsanleitung](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git))

## Schritt-für-Schritt-Anleitung

### 1. Repository klonen

1.1 Öffnen Sie die Eingabeaufforderung (Windows) oder das Terminal (Mac/Linux).

1.2 Führen Sie den folgenden Befehl aus, um das Repository zu klonen:

```bash
git clone https://github.com/Michi-Meierdiecks/docker-deplay-puplic.git
cd docker-deplay-puplic

2. Docker-Image bauen

2.1 Stellen Sie sicher, dass Docker installiert und gestartet ist. Falls nicht, laden Sie Docker von der Docker-Website herunter und installieren Sie es.

2.2 Führen Sie den folgenden Befehl aus, um das Docker-Image zu bauen:

bash

docker build -t webhookd-deploy .

3. Docker-Container starten

3.1 Starten Sie den Docker-Container mit dem folgenden Befehl:

bash

docker run -d -p 8080:8080 -p 80:80 --name webhookd-deploy webhookd-deploy

4. GitHub-Webhooks konfigurieren

4.1 Gehen Sie zu Ihrem GitHub-Repository.

4.2 Navigieren Sie zu Settings > Webhooks.

4.3 Klicken Sie auf Add webhook.

4.4 Füllen Sie das Formular wie folgt aus:

    Payload URL: http://<Ihre-Server-IP>:8080/hooks/deploy
    Content type: application/json
    Secret: Optional, aber empfohlen
    Events: Just the push event

4.5 Klicken Sie auf Add webhook.
5. Überprüfung

5.1 Machen Sie eine Änderung an Ihrem GitHub-Repository und pushen Sie diese.

5.2 Überprüfen Sie, ob der Webhook-Server die Anfrage empfängt und das Deployment-Skript ausführt, indem Sie die Logs des Containers ansehen:

bash

docker logs webhookd-deploy

6. Fehlerbehebung

    Docker-Container läuft nicht: Stellen Sie sicher, dass Docker gestartet ist und der Container läuft:

    bash

docker ps

Logs überprüfen: Falls Probleme auftreten, überprüfen Sie die Logs des Containers:

bash

    docker logs webhookd-deploy

Wichtige Dateien im Repository

    Dockerfile: Enthält Anweisungen, wie das Docker-Image gebaut wird.
    start.sh: Start-Skript für den Webhook-Server.
    hooks.json: Konfigurationsdatei für Webhooks.
    update.sh: Skript für automatische Deployments.
    index.html: Beispiel-HTML-Datei für die Website.

Kontakt

Falls Sie Fragen oder Probleme haben, kontaktieren Sie bitte den Projektinhaber über das GitHub-Repository.

perl


Diese `README.md`-Datei enthält alle notwendigen Schritte und Informationen, die ein Benutzer benötigt, um das Projekt einzurichten und zu nutzen. Kopieren Sie diesen Text in eine Datei namens `README.md` im Stammverzeichnis Ihres Projekts.
