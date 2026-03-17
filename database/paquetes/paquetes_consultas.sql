CREATE OR REPLACE PACKAGE pkg_consultas AS
    PROCEDURE listar_productos;
END pkg_consultas;
/

CREATE OR REPLACE PACKAGE BODY pkg_consultas AS

    PROCEDURE listar_productos IS
        CURSOR c_productos IS SELECT Nombre FROM PRODUCTOS;
        v_nombre PRODUCTOS.Nombre%TYPE;
    BEGIN
        OPEN c_productos;
        LOOP
            FETCH c_productos INTO v_nombre;
            EXIT WHEN c_productos%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(v_nombre);
        END LOOP;
        CLOSE c_productos;
    END;

END pkg_consultas;
/
