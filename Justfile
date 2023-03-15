frontend-dev:
  #!/bin/bash
  cd frontend
  yarn dev
  cd ..

dev:
  overmind start

build-web:
  #!/bin/bash
  cd frontend
  yarn build
  yarn export
  cd ..

build-server:
  go build -o app main.go

build: build-web build-server

start:
  ./app serve --publicDir=frontend/out --http=0.0.0.0:8090 --dir=./pb_data

build-docker:
  docker build . -t app

run-docker:
  docker run -p 8090:8090 -v $(pwd)/pb_data:/pb_data app
