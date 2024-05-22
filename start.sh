#!/bin/bash


service apache2 start


webhook -hooks /home/ubuntu/webhooks/hooks.json -port 8080 -verbose
