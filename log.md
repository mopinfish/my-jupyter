# logs for operation this repository

## 2023/12/06

1. add lxml, html5lib to Pipfile

```

...
+ lxml = "*"
+ html5lib = "*"
...

```

2. update Pipfile.lock for installing lxml, html5lib

```shell
docker cp src/notebook/Pipfile my-jupyter:/home/jovyan/Pipfile
```

3. execute `pipenv lock` for updating Pipfile.lock. And cp from container `my-jupyter`.


```shell
# at guest
pipenv lock
```


```shell
# at host
docker cp my-jupyter:/home/jovyan/Pipfile.lock src/notebook/Pipfile.lock
```

3. add libxml2-dev and libxslt-dev to Dockerfile 

```

...
+    && apt-get install -y --no-install-recommends libxml2-dev libxslt-dev \
...

```

4. rebuild docker container

```shell
# at host
docker compose down
docker compose build
docker compose up -d
```

---