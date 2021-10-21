# Programación Distribuida sobre Grandes Volúmenes de Datos

## Para el uso de este repositorio

### En Windows

Para tener disponible este repositorio en tu maquina de trabajo e instalar el software de la materia hay que instalar el programa [git](https://git-scm.com/download/win).

Despues ejecutar en la terminal:

1. `git config --global core.autocrlf false`
1. `git clone https://bigdata_famaf@bitbucket.org/bigdata_famaf/diplodatos_bigdata.git`

## Como instalar el software necesario para la materia

### En tu computadora (>=8GB ram)

#### Instalación [docker](https://www.docker.com/)

* Instalar docker en tu computadora: https://docs.docker.com/get-docker/

* Ir al directorio con la defininición de la imagen en este repo:
```
        cd docker
```

* Crear la imagen ejecutando el comando:
```
        docker build --tag diplodatos/bigdata:1.0 -f ./diplodatos_bigdata/dockerfiles/Dockerfile ./diplodatos_bigdata/context
```
**Nota:** Si tiene Linux puede ejecutar el script `./diplodatos_bigdata/build.sh` en vez del comando anterior.

* Para arrancar el container con [Zeppelin](https://zeppelin.apache.org/) ejecutar
    - en **Linux**:
```
docker run -u $(id -u) -it --rm --hostname localhost -p 8080:8080 -p 4040:4040 \
    -v vols/conf:/opt/zeppelin/conf \
    -v vols/logs:/logs \
    -v vols/notebook:/notebook \
    -e ZEPPELIN_LOG_DIR='/logs' -e ZEPPELIN_NOTEBOOK_DIR='/notebook' \
    --name diplodatos_bigdata diplodatos/bigdata:1.0
```
**o** puede ejecutar el script `./zeppelin.sh` en vez del comando anterior.

    - en **Windows**:
```
docker run -u 1000 -it --rm --hostname localhost -p 8080:8080 -p 4040:4040^
        -v "%CD%\vols\conf:/opt/zeppelin/conf"^
        -v "%CD%\vols\logs:/logs"^
        -v "%CD%\vols\notebook:/notebook"^
        -v "%CD%\..:/diplodatos_bigdata"^
        -e ZEPPELIN_LOG_DIR=/logs -e ZEPPELIN_NOTEBOOK_DIR=/notebook^
        --name diplodatos_bigdata diplodatos/bigdata:1.0
```
**o** puede ejecutar el script `zeppelin.cmd` en vez del comando anterior.

* Para utilizar [Zeppelin](https://zeppelin.apache.org/) en un navegador ir a [http://localhost:8080]().
#### Instalación directa

* Instalar anaconda si no lo tiene ya instalado (ver https://docs.anaconda.com/anaconda/install).

* Crear un environment anaconda:  
```
        conda create -n python-zeppelin python=3.7
```

* Instalar los paquetes:
```
        conda activate python-zeppelin
        conda install matplotlib pandas plotly
        conda install openjdk=8.0.152
```

* Bajar el archivo zip desde [aquí](http://cs.famaf.unc.edu.ar/~damian/tmp/bigdatasoft.zip) y descomprimir
(debe haberse creado un directorio `spark`).

* Ejecutar desde el directorio `spark` recién creado y en el environment de anaconda:
```sh
        cd zeppelin-0.10.0-bin-all
        bin/zeppelin.sh
```

* En navegador abrir http://localhost:8080.
  Se tiene que ver la interfaz inicial a [Zepelin](https://zeppelin.apache.org/docs/0.10.0/quickstart/explore_ui.html).

* Hay que instalar también [git](https://git-scm.com).
  La versión para Windows está en [https://git-scm.com/download/win](https://git-scm.com/download/win).
  
### En nabucodonosor

* Hacer ssh a tu cuenta en nabucodonosor

* Instalar [Anaconda](https://www.anaconda.com).
```sh
        wget https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-x86_64.sh
        chmod 755 Anaconda3-2021.05-Linux-x86_64.sh
        ./Anaconda3-2021.05-Linux-x86_64.sh
        . .bashrc
```

* Crear un environment anaconda:  
```
        conda create -n python-zeppelin python=3.7
```

* Instalar los paquetes:
```
        conda activate python-zeppelin
        conda install matplotlib pandas plotly
        conda install openjdk=8.0.152
```

* Bajar el archivo zip desde [aquí](http://cs.famaf.unc.edu.ar/~damian/tmp/bigdatasoft.zip) y descomprimir:
```sh
        cd
        wget http://cs.famaf.unc.edu.ar/~damian/tmp/bigdatasoft.zip
        unzip bigdatasoft.zip
``` 
> (debe haberse creado un directorio `spark`)

* Ejecutar desde el directorio `spark` recién creado los siguientes comandos (cambiar puerto para que cada usuario use uno distinto):
```sh
        echo $[$UID+8080] # recordar <nuevo puerto> (anotarlo)
        cd spark/zeppelin-0.10.0-bin-all/conf
        sed "s/<value>8080/<value>$[$UID+8080]/" zeppelin-site.xml.template > zeppelin-site.xml
```

* Ejecutar (en el environment de anaconda):
```sh
        cd ..
        bin/zeppelin.sh
```

##### En tu maquina (linux):

* En terminal hacer port forwarding de ssh:
```sh
        ssh -vCN -L 8080:localhost:<nuevo puerto> -l <login en nabuco> nabucodonosor2.ccad.unc.edu.ar
```

* En navegador abrir http://localhost:8080.
  Se tiene que ver la interfaz inicial a [Zepelin](https://zeppelin.apache.org/docs/0.10.0/quickstart/explore_ui.html).

* Si se quiere ver el SparkUI hay que hacer port forwarding tambien.
    - Despues de ejecutar alguna celda en zeppelin (asi levanta spark) imprimir en otra el puerto que usa SparkUI:
```python
        print(sc.uiWebUrl.split(":")[-1])
```

    - En terminal hacer otro port forwarding de ssh:
```sh
        ssh -vCN -L 4040:localhost:<puerto SparkUI> -l <login en nabuco> nabucodonosor2.ccad.unc.edu.ar
```

##### Nota: 
Para hacer port forwarding de ssh en windows ver [https://docs.microsoft.com/en-us/azure/hdinsight/hdinsight-linux-ambari-ssh-tunnel](https://docs.microsoft.com/en-us/azure/hdinsight/hdinsight-linux-ambari-ssh-tunnel).
