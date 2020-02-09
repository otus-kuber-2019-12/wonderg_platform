# Generate base64
echo -n 'admin' | base64

# Run
kubectl port-forward svc/minio 9000:9000
mc config host add minio http://127.0.0.1:9000 minio minio123
mc mb minio/bucket01
mc ls minio
