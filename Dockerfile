FROM python:3.11-slim
WORKDIR /app
COPY . .
RUN echo "App DevSecOps lista"
CMD ["echo", "Corriendo pipeline DevSecOps"]