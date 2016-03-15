#!/bin/bash
# Script de Configuración de Ambiente de Desarrollo
# Grupo: 1
# 2016-03-09
#
sudo service postgresql start
sudo service mongod start
RAILS_ENV=production bundle exec sidekiq -d -l log/sidekiq.log stop
thin stop -P tmp/pids/thin.pid