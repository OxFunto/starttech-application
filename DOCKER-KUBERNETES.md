# Month 2 Assessment - Docker and Kubernetes Setup

## Quick Start

### Docker Compose
```bash
docker-compose up --build -d
curl http://localhost:8080/ping
```

### Kubernetes with Kind
```bash
kind create cluster --name starttech
docker build -t notfunn/starttech-backend:latest ./Server/MuchToDo
kind load docker-image notfunn/starttech-backend:latest --name starttech
kubectl apply -f kubernetes/namespace.yaml
kubectl apply -f kubernetes/mongodb/
kubectl apply -f kubernetes/backend/
kubectl port-forward service/backend-service 8081:8080 -n starttech &
curl http://localhost:8081/ping
```
