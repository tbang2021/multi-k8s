docker build -t angtb/multi-client:latest -t angtb/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t angtb/multi-server:latest -t angtb/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t angtb/multi-worker:latest -t angtb/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push angtb/multi-client:latest
docker push angtb/multi-server:latest
docker push angtb/multi-worker:latest

docker push angtb/multi-client:$SHA
docker push angtb/multi-server:$SHA
docker push angtb/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=angtb/multi-server:$SHA
kubectl set image deployments/client-deployment server=angtb/multi-client:$SHA
kubectl set image deployments/worker-deployment server=angtb/multi-worker:$SHA
