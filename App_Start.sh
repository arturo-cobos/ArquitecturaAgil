#!/bin/bash
# Script de Configuración de Ambiente de Desarrollo
# Grupo: 1
# 2016-03-09
#
sudo service postgresql stop
sudo service mongod stop
bundle exec sidekiq -d -l ./log/sidekiq.log
thin start -p 3000 -P tmp/pids/thin.pid -l log/server.log -d -e production