#!/bin/bash
# Script de Configuración de Ambiente de Desarrollo
# Grupo: 1
# 2016-03-09
#
bundle exec sidekiq -d -l ./log/sidekiq.log
puma -p 3000 -e production -d