$containerName = "neo4j-w-plugins"
$containerPort1 = "7687"
$containerPort2 = "7474"
$imageFileName = "neo4j-w-plugins-i"
$dockerFile = "Dockerfile"

docker build -t $imageFileName -f $dockerFile .

#neo4j-w-plugins
#docker run -v d:/data:/data alpine ls /data