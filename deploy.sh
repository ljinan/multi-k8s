docker build -t ljinan/multi-client:latest -t ljinan/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ljinan/multi-server:latest -t ljinan/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ljinan/multi-worker:latest -t ljinan/multi-worker:$SHA -f ./worker/Dockerfile ./worker
# tagging the docker image with 2 tags, latest and SHA number. 
# helps to allow for debugging. -> app is breaking -> check which image is the deployment running (image:SHA #)
# -> git checkout SHA# (revert codebase back to that particular commit) -> debug the app
docker push ljinan/multi-client:latest
docker push ljinan/multi-server:latest
docker push ljinan/multi-worker:latest

docker push ljinan/multi-client:$SHA
docker push ljinan/multi-server:$SHA
docker push ljinan/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ljinan/multi-server:$SHA
kubectl set image deployments/cilent-deployment client=ljinan/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ljinan/multi-worker:$SHA
