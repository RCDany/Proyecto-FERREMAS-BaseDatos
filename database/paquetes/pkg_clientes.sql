CREATE OR REPLACE PACKAGE pkg_clientes AS
    PROCEDURE crear_cliente(
        p_nombre VARCHAR2,
        p_telefono VARCHAR2,
        p_email VARCHAR2,
        p_direccion VARCHAR2
    );

    FUNCTION obtener_cliente(
        p_idcliente NUMBER
    ) RETURN VARCHAR2;
END pkg_clientes;
/

CREATE OR REPLACE PACKAGE BODY pkg_clientes AS

    PROCEDURE crear_cliente(
        p_nombre VARCHAR2,
        p_telefono VARCHAR2,
        p_email VARCHAR2,
        p_direccion VARCHAR2
    )
    AS
    BEGIN
        INSERT INTO CLIENTES
        (Nombre, Telefono, Email, Direccion)
        VALUES
        (p_nombre, p_telefono, p_email, p_direccion);
    END;

    FUNCTION obtener_cliente(
        p_idcliente NUMBER
    ) RETURN VARCHAR2
    AS
        v_nombre VARCHAR2(100);
    BEGIN
        SELECT Nombre
        INTO v_nombre
        FROM CLIENTES
        WHERE IDCliente = p_idcliente;

        RETURN v_nombre;
    END;

END pkg_clientes;
/