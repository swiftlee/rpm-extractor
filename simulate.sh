docker build -t rpm-extractor -f Dockerfile.rpms .
docker run --rm -d --name rpm-extractor -it rpm-extractor
docker cp rpm-extractor:/rpms/python3.12_offline_rpms ./
docker stop rpm-extractor
docker build -t ubi-python -f Dockerfile .
docker run --rm -it ubi-python python --version
docker run --rm -it ubi-python python3 --version
docker run --rm -it ubi-python python3.12 --version
docker run --rm -it ubi-python python -m pip install pandas