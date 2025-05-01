docker build -t ljinan/multi-client -f ./client/Dockerfile ./client
docker build -t ljinan/multi-server -f ./server/Dockerfile ./server
docker build -t ljinan/multi-worker -f ./worker/Dockerfile ./worker
