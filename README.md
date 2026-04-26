# Proyecto-FERREMAS-BaseDatos
Este proyecto consiste en el diseño e implementación de un sistema de gestión de información para la empresa FERREMÁS Centro de Construcción, C.A., ubicada en Heredia, Costa Rica.

El sistema busca centralizar la administración de inventario, ventas, compras, clientes y proveedores mediante una arquitectura de dos capas:

Base de datos relacional en SQL / PL-SQL

Capa de aplicación desarrollada en Python





INSTRUCCIONES


Proyecto FERREMAS – Instrucciones de Ejecución
Requisitos
Oracle Database (con PDB XEPDB1)
SQL Developer o herramienta similar
Python 3
Librería oracledb instalada
Configuración de Base de Datos

Antes de ejecutar los scripts, asegúrese de estar en el contenedor correcto:

ALTER SESSION SET CONTAINER = XEPDB1;

Verificar:

SHOW CON_NAME;

Debe mostrar: XEPDB1

Orden de Ejecución de Scripts

Es importante seguir este orden para evitar errores de dependencias:

1. Crear tablas

Ruta:

Proyecto-FERREMAS-BaseDatos/tablas

Ejecutar:

tablas.sql



2. Crear procedimientos almacenados

Ruta:

Proyecto-FERREMAS-BaseDatos/procedimientos

Ejecutar todos los archivos EXCEPTO estos:

02_paquete_proveedores_nicole.sql
03_paquete_compras_nicole.sql
3. Crear funciones, vistas y lógica adicional

Ruta:

Proyecto-FERREMAS-BaseDatos/database

Ejecutar todos los archivos EXCEPTO:

04_funciones_nicole.sql

Nota:
El archivo reportes_final.sql contiene funciones, vistas y lógica relacionada a reportes.




4. Crear triggers

Ruta:

Proyecto-FERREMAS-BaseDatos/triggers

Ejecutar:

Triggers Final.sql





5. Ejecutar extras

Ruta:

Proyecto-FERREMAS-BaseDatos/miscelaneo

Ejecutar:

Extras.sql

Este archivo incluye funciones adicionales, vistas, cursores y un paquete de reportes.

Ejecución del Programa en Python

Ruta:

Proyecto-FERREMAS-BaseDatos/python/Programa final

Ejecutar:

python main.py



Notas importantes
La conexión a la base de datos está configurada en el archivo conexion.py.
Verificar que coincida con su entorno (usuario, contraseña y DSN).
El sistema utiliza procedimientos almacenados, funciones, triggers, vistas y cursores.
No se realizan consultas directas desde Python.
Algunos procedimientos usan DBMS_OUTPUT, por lo que sus resultados solo son visibles en SQL Developer si está habilitado.
