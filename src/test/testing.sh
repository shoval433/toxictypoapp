#!bin/bash
docker build -t testing-img . >/dev/null
docker run -it --rm  --name testing --network ${network} testing-img bash


# x=$(docker run -it --rm  --name testing --network app testing-img bash)
