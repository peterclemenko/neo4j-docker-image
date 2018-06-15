$containerName = "neo4j-w-plugins"
$containerPort1 = "7687"
$containerPort2 = "7474"
$imageFileName = "neo4j-w-plugins-i"
$dockerFile = "Dockerfile"

docker run -d --rm --publish=7474:7474 --publish=7687:7687 --volume=$HOME/neo4j/data:/data $imageFileName

#docker run -d --name $containerName -p 1880:1880 -v $pwd/navrie-dragon:/data $imageFileName
