# Cloud-Native 3-Tier Web Application

## Stack
- Frontend: HTML/Node.js (React later)
- Backend: Node.js + Express + PostgreSQL client
- Database: Postgres (Docker for dev, RDS for prod)
- Reverse Proxy: Nginx
- Orchestration: Docker Compose (local), Kubernetes (prod)

## Run Locally
```bash
docker-compose up --build
