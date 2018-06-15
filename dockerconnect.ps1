$containerName = "neo4j-w-plugins"
$containerPort1 = "7687"
$containerPort2 = "7474"
$imageFileName = "neo4j-w-plugins-i"
$dockerFile = "Dockerfile"

docker exec -i -t $containerName /bin/bash