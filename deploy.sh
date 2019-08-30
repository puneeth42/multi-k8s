docker build -t puneeth8994/multi-client -t puneeth8994/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t puneeth8994/multi-server -t puneeth8994/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t puneeth8994/multi-worker -f puneeth8994/multi-worker:$SHA ./worker/Dockerfile ./worker
docker push puneeth8994/multi-client
docker push puneeth8994/multi-worker
docker push puneeth8994/multi-server

docker push puneeth8994/multi-client:$SHA
docker push puneeth8994/multi-worker:$SHA
docker push puneeth8994/multi-server:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=puneeth8994/multi-server:$SHA
kubectl set image deployments/client-deployment client=puneeth8994/multi-client:$SHA
kubectl set image deployments/worker-deployment client=puneeth8994/multi-worker:$SHA