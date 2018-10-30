# Analisis Proyecto

## Integrantes
* Andres Felipe Zapata Palacio
* Esteban Echeverri Jaramillo
* Juan David Arcila Moreno

## Problema a resolver
Son conocidas las diversas dificultades que se tiene para desplegar adecuadamente el ecosistema de Hadoop dentro de varias máquinas, permitiendo su completo funcionamiento y parametrización. Son muchos pasos, tediosos y conocidos, donde la mayoria de problemas surgen a partir de la inexperiencia para la instalación de software base y la configuración adecuada. Además en caso de querer desplegar otro cluster Hadoop, se debe realizar de manera manual todos los pasos nuevamente, manteniendo el riesgo al error.


## Objetivo
Este proyecto pretende desarrollar a partir de diversas prácticas de DevOps un despliegue y aprovisionamiento automatizado de un cluster Hadoop tanto para virtualización como para BareMetal.

## Tecnologías y Herramientas

* **XCat:** Aprovisionamiento de OS e instalación de software minimo. Redes y Hardaware.
* **Ansible:** Instalación y configuración de software base y Aplicación.
* **Hortonworks:** Ecosistema de Hadoop a instalar.
* **Ambari:** Servicio central de Hadoop a usar. 

## Pipe-line general
* Creación de servidor de aprovicionamiento (XCat) .
* Instalación de imagenes OS a las maquinas seleccionadas.
* Instalacion de paquetes báse (Ansible, drives, etc.).
* Configuracion de redes (en caso de ser necesario).
* Ejecución de playbooks de Ansible (Instalacion HortonWorks y demás software base)
* Configuraciones finales
* Ejecución de pruebas de funcionamiento.

## Ambiente de desarollo y Testing

El desarrollo se dará en virtualizacion, usando el hipervisor tipo 2 VirtualBox. Para emular el ambiente se usarán dos maquinas virtuales con pocos recursos en una misma maquina host. En otra maquina host diferente y siguiendo la misma táctica de virtualización se creará el servidor de XCat (aprovisionamiento). El desarrollo de los diversos playbooks en ansible se darán y probarán en estos ambiente mencionados, según el caso. 

Dada las tecnologias a usar, nos permite tener una portabilidad casi completa al ambiente de producción, una vez terminado el desarrollo, y al mismo tiempo brindandonos ambiente que funciona practicamente igual para cualquiera de nuestros casos de uso en producción: BareMetal y virtualización.
