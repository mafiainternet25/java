#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
IMAGE_NAME=${IMAGE_NAME:-projectjavademo:latest}
CONTAINER_NAME=${CONTAINER_NAME:-projectjavademo}

# detect docker compose command (docker compose vs docker-compose)
COMPOSE_CMD=""
if command -v docker >/dev/null 2>&1 && docker compose version >/dev/null 2>&1; then
  COMPOSE_CMD="docker compose"
elif command -v docker-compose >/dev/null 2>&1; then
  COMPOSE_CMD="docker-compose"
else
  echo "Docker Compose is required. Install Docker and Docker Compose." >&2
  exit 1
fi

usage(){
  cat <<EOF
Usage: $0 <command>
Commands:
  build     Build the Docker image
  up        Start the service (docker compose up -d --build)
  down      Stop and remove containers
  restart   Restart service
  logs      Tail service logs
  status    Show running container for ${CONTAINER_NAME}
EOF
  exit 1
}

cmd=${1:-}
case "$cmd" in
  build)
    echo "Building image ${IMAGE_NAME} from ${REPO_DIR}..."
    docker build -t "${IMAGE_NAME}" "${REPO_DIR}"
    ;;
  up)
    echo "Starting with: ${COMPOSE_CMD} up -d --build"
    eval ${COMPOSE_CMD} up -d --build
    ;;
  down)
    echo "Stopping and removing containers..."
    eval ${COMPOSE_CMD} down
    ;;
  restart)
    echo "Restarting service..."
    eval ${COMPOSE_CMD} restart
    ;;
  logs)
    echo "Showing logs (ctrl-c to exit)..."
    eval ${COMPOSE_CMD} logs -f
    ;;
  status)
    docker ps --filter "name=${CONTAINER_NAME}"
    ;;
  *)
    usage
    ;;
esac
