Implementación
==============

Las siguientes imagenes muestran los pasos conceptuales del despliegue completo de el cluster de HortonWorks. 

* ***Paso 1:*** A partir de Xcat se provicionan con un software Base (S.O, Ansible, git, etc) las N maquinas a usar. Se hacen las configuraciones iniciales 
y luego se corre Ansible

* ***Paso 2:*** Según los roles de ansible, se corre los playbooks de ansible. 

* ***Paso 3:*** Dentro de ansible, se hace uso de la API REST BLueprints para configurar e iniciar el cluster para los servicios de
HortonWorks. 
