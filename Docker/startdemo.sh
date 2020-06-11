@_ECHO_OFF
clear
cd busybox
@_ECHO_ON
#Basic Dockerfile
docker login --username=marygabry1508
docker images
bat Dockerfile
clear
docker image build . -t marygabry1508/busybox:latest
docker images
clear
#Check DockerHub
python -m webbrowser "https://hub.docker.com/repositories"
docker image push marygabry1508/busybox:latest
clear
docker run --rm marygabry1508/busybox:latest sh -c 'cat /version.txt'
clear
docker image remove marygabry1508/busybox:latest
docker images |grep busybox
docker image pull marygabry1508/busybox:latest
docker images |grep busybox
@_ECHO_OFF
clear
cd ../summer2020
@_ECHO_ON
#A Sophisticated Dockerfile
bat Dockerfile
clear
docker image build . -t marygabry1508/summer:latest
docker images
docker run -it --rm marygabry1508/summer:latest
docker image inspect marygabry1508/summer
#Inspect layers
dive marygabry1508/summer
clear
docker images
dive
docker image prune -a

