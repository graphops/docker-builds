# docker-builds

```sh
cd dockerfiles/graph-toolbox
export TAG="v0.36.0"
docker build --platform=linux/amd64 -t pamanseau/graph-toolbox:$TAG -f Dockerfile . \
&& docker login \
&& docker push pamanseau/graph-toolbox:$TAG
cd ../..
```
