#!/bin/bash
# Script de Configuración de Ambiente de Desarrollo
# Grupo: 1
# 2016-03-09
#
echo "Inicio de Script"
# Repositorio
echo "Agregar nuevos repositorios"
# PostgreSQL
sudo sh -c "echo 'deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main' > /etc/apt/sources.list.d/pgdg.list"
wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
# MongoDB
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list

# Actualizacion de Indices de repositorios y versiones
echo "Actualizacion de Indices de repositorios y versiones"
sudo apt-get update
sudo apt-get upgrade

# Configuración de despendencias
sudo apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev

# Instalación de Ruby
echo "Instalando Ruby"
cd
wget -c -t 0 http://ftp.ruby-lang.org/pub/ruby/2.2/ruby-2.2.3.tar.gz
tar -xzvf ruby-2.2.3.tar.gz
cd ruby-2.2.3/
./configure
make
sudo make install
ruby -v
# Limitación de Documentación en gemas
echo "gem: --no-ri --no-rdoc" > ~/.gemrc
gem install bundler

# Instalación de Rails
echo "Instalando dependencias de Rails"
# Inclusión de Node.js para compilación de CoffeeScript en Rails
curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
sudo apt-get install -y nodejs
gem install rails -v 4.2.4
echo "Instalando Base de Datos"
# Instalando pendencias para Postgresql
sudo apt-get update
sudo apt-get install -y postgresql-common
sudo apt-get install -y postgresql-9.3 libpq-dev
# Instalando MongoDB
sudo apt-get install -y mongodb-org
sudo service mongod start
# Instalando Redis
sudo apt-get install -y redis-server

# Descargando IDE de desarrollo
wget -t 0 -c https://download.jetbrains.com/ruby/RubyMine-8.0.3.tar.gz
tar -zxf RubyMine-8.0.3.tar.gz
mv RubyMine-8.0.3 RubyMine
cd RubyMine/bin/
./rubymine.sh

# Instalación Completada
echo "Instalación completada"
