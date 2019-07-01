docker build -t syellanki7/multi-client:latest -t syellanki7/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t syellanki7/multi-server:latest -t syellanki7/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t syellanki7/multi-worker:latest -t syellanki7/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker build -t syellanki7/multi-worker:latest -t syellanki7/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push syellanki7/multi-client:latest
docker push syellanki7/multi-server:latest
docker push syellanki7/multi-worker:latest

docker push syellanki7/multi-client:$SHA
docker push syellanki7/multi-server:$SHA
docker push syellanki7/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=syellanki7/multi-server:$SHA
kubectl set image deployments/client-deployment client=syellanki7/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=syellanki7/multi-worker:$SHA
