docker build -t balazsprehoda/multi-client:latest -t balazsprehoda/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t balazsprehoda/multi-server:latest -t balazsprehoda/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t balazsprehoda/multi-worker:latest -t balazsprehoda/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push balazsprehoda/multi-client:latest
docker push balazsprehoda/multi-server:latest
docker push balazsprehoda/multi-worker:latest
docker push balazsprehoda/multi-client:$SHA
docker push balazsprehoda/multi-server:$SHA
docker push balazsprehoda/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=balazsprehoda/multi-server:$SHA
kubectl set image deployments/client-deployment client=balazsprehoda/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=balazsprehoda/multi-worker:$SHA
