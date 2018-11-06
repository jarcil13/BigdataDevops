Creación automática de Cluster Hortonworks
===========================================
* [Documento de análisis](analisis.md)

* [Documento de implementación](implementacion.md)

Tecnologías
------------

* Ansible  (Automatización del aprovisionamiento)
* Ambari   (Configuración del cluster Hortonworks)
* Blueprint (API REST para configuracion de servicios en un cluster Ambari)

Modo de uso
-----------

    $ cd BigdataDevops/ansible/
    $ ansible-playbook playbooks/main.yml
    |
    |--> playbooks/ambari_master.yml
    |--> playbooks/ambari_slave.yml

Requisitos
----------

* Mínimo 2 Servidores CentOS 7 (Virtuales o Físicas) en el mismo segmento de red.

* Ansible instalado en la máquina central (master)


Aclaraciones
-------------

(1) El nodo master cumple las siguientes funciones:

* Aprovisionar la instalación del ambari-agent en los nodos.

* Ser el ambari-server (con los respectivos permisos de acceso en los nodos) para cumplir la función de coordinador de configuración.

* No necesariamente tiene que ser el master al momento de crear los clusters desde Ambari, el rol de master en un cluster puede ser asumido por cualquier nodo.

(2) Para que el nodo master pueda ser parte de un cluster, debe tener instalado **ambari-agent**, por lo que deberá ser añadido a la lista de nodos en la definición de Hosts en Ansible.

(3) Por defecto el **ambari-server** trae un stack de hdp en su version 2.6, por lo tanto la forma en que se implementaron las configuraciones para el cluster tienen en cuenta esto, si se llega a tener otra version de hdp en este al momento de empezar a configurar el cluster no se podra configurar.

(5) Algunos servicios de Hadoop hacen uso de diversos puertos para sus comunicaciones. Nuestra implmentación actual agregá las reglas de firewall necesiarias para la correcta instalación del cluster, sin embargo, puede que no permita la cominucacion de algunos servicios y por consiguente, no permita que inicien satisfactoriamente.  

Pasos Previos
--------------

1. Instalar en el master los siguientes paquetes, así:
 
       $ yum install git epel-release 
       # ansible >= 2.7.0
       $ yum install ansible
       
2. Configurar el hostname  de todas las maquinas del cluster (master y hosts) apropiadamente, siendo *n* el numero de hosts, así:

       $ hostnamectl set-hostname <master.local | host-[0-n].local>

3. Tener reconocimiento por nombre de todas las maquinas del cluster (ruteo DNS). Si no posee un servidor DNS en su red, puede hacerlo usando  el archivo ***/etc/hosts***. Lso siguientes son un ejemplo con 1 host. Deberá cambiar las IP segun el caso. 

En el master:

       10.1.0.4 host-0 host-0.local

En cada uno de los hosts: 

       10.1.0.5 master master.local

4. Crear relacion de confianza con root entre el **master** y los **hosts**
así

       $ ssh-keygen -t rsa -b 1024
       $ ssh-copy-id <nombre del host>


Procedimiento
-------------
En la maquina master se realizará toda la instalación, por tanto allí se realizará todo el procedimiento. 
1. Clone el repo 

       $ git clone https://github.com/jarcil13/BigdataDevops.git

2. Ingrese al repo y ejejute el playbook de los hosts, así:

(recuerde modificar el archivo hosts de ansible, según sus necesidades)

       $ cd BigdataDevpps/ansible
       $ ansible-playbook playbooks/ambari_slave.yml
       

3. Ejecute el playbook master

```
    $ ansible-playbook playbooks/ambari_master.yml
```

**NOTA:** Es importante ejcutar los playbooks desde el directorio *BigdataDevops/ansible* de modo que Ansible pueda deducir adecuadamente la estructura de directorios. 

4. Ahora puede acceder a ***http:/ip_master:8080*** y podrá ver la interfaz de ambari, una vez acceda con la cuenta admid podrá ver el progreso la descarga, instalación e inicio de cadau no de los servicios de Hadoop. 

Ansible
-------

#### Estructura General

##### Master:

    ---
    - include_tasks: hostname.yml
    - include_tasks: packages.yml
    - include_tasks: firewall-config.yml
    - include_tasks: ambari-check.yml
    - include_tasks: ambari-execute-install.yml
      when: ansible_facts.services['ambari-server.service'] is not defined
    - include_tasks: blueprint-cluster.yml

##### Slave:

    ---
    - include_tasks: ambari-repo.yml
    - include_tasks: ambari-install.yml
    - include_tasks: ambari-start.yml

Agrega el repositorio de Ambari al manejador de paquetes, instala ambari-agent y configura correctamente el archivo **ambari-agent.ini**.

JSON
-------

#### Funcionamiento

* **cluster_configuration.json:** en este se establecen los grupos en los cuales los host seran agrupados en el cluster, dado que cada nodo de cada grupo tendra instalado lo que se le especifica al grupo en el archivo

* **hostmapping.json:** en este se establecen que nodos se van a usar, y en que grupo van a estar

Trabajo Futuro
--------------

* Hacer uso de **Xcat** para la creación de las maquinas de forma automatica, de forma que ansible sea ejecutado automaticamente y el aprovicionamiento de las maquinas sea transparente para el usuario.
* Tener un manejo de errores más especifico y elegante en las task de Ansible.
