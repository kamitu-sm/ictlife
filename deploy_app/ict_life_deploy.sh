#!/bin/bash
#
# Coder is Stephen Kamitu Munguti -> kamitu.sm@gmail.com
#
# Be sure to have followed the instructions in the readme for the repository 

repository="https://github.com/ictlife/infra-interview-may-2020.git"
localFolder="/home/stephen/dev/myfolder"
dbFolder="/db/apps/pgdata"

git clone "$repository" "$localFolder"


# Backend
cd $localFolder
cd ./backend
npm install
cp .env.development.sample .env.development
cp docker-compose.yml.sample docker-compose.yml
sed -i 's|{PATH/TO/PGDATA}|$dbFolder|g' docker-compose.yml
docker-compose up -d
goose postgres -dir app/db/migrations up
gulp server


# Frontend
cd $localFolder
cd ./frontend
npm install
npm run build
cp -r ./build/. /srv/webdata/build
