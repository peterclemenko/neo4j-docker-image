$containerName = "navrie-neo4j-dev"
$containerPort1 = "7687"
$containerPort2 = "7474"
$imageFileName = "navrie-neo4j-i"
$dockerFile = "Dockerfile"

docker run -d --name $containerName --publish=7474:7474 --publish=7687:7687 --volume=$HOME/neo4j/data:/data $imageFileName

#docker run -d --name $containerName -p 1880:1880 -v $pwd/navrie-dragon:/data $imageFileName
