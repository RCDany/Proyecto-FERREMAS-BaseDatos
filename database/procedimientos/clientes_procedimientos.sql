CREATE OR REPLACE PROCEDURE sp_crear_cliente(
    p_nombre VARCHAR2,
    p_telefono VARCHAR2,
    p_email VARCHAR2,
    p_direccion VARCHAR2
)
AS
BEGIN
    INSERT INTO CLIENTES(Nombre, Telefono, Email, Direccion)
    VALUES(p_nombre, p_telefono, p_email, p_direccion);
END;
/

CREATE OR REPLACE PROCEDURE sp_actualizar_cliente(
    p_idcliente NUMBER,
    p_nombre VARCHAR2,
    p_telefono VARCHAR2,
    p_email VARCHAR2,
    p_direccion VARCHAR2
)
AS
BEGIN
    UPDATE CLIENTES
    SET Nombre = p_nombre,
        Telefono = p_telefono,
        Email = p_email,
        Direccion = p_direccion
    WHERE IDCliente = p_idcliente;
END;
/

CREATE OR REPLACE PROCEDURE sp_eliminar_cliente(
    p_idcliente NUMBER
)
AS
BEGIN
    DELETE FROM CLIENTES
    WHERE IDCliente = p_idcliente;
END;
/

CREATE OR REPLACE PROCEDURE sp_obtener_cliente(
    p_idcliente NUMBER
)
AS
BEGIN
    FOR r IN (SELECT * FROM CLIENTES WHERE IDCliente = p_idcliente)
    LOOP
        DBMS_OUTPUT.PUT_LINE(r.Nombre || ' - ' || r.Email);
    END LOOP;
END;
/

CREATE OR REPLACE PROCEDURE sp_listar_clientes
AS
BEGIN
    FOR r IN (SELECT * FROM CLIENTES)
    LOOP
        DBMS_OUTPUT.PUT_LINE(r.IDCliente || ' - ' || r.Nombre);
    END LOOP;
END;
/