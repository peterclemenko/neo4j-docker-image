$containerName = "navrie-neo4j-dev"
$containerPort1 = "7687"
$containerPort2 = "7474"
$imageFileName = "navrie-neo4j-i"
$dockerFile = "Dockerfile"

docker exec -i -t $containerName /bin/bash