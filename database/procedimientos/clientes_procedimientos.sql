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

CREATE OR REPLACE PROCEDURE SP_ACTUALIZAR_CLIENTE (
    p_id NUMBER,
    p_nombre VARCHAR2,
    p_telefono VARCHAR2,
    p_email VARCHAR2,
    p_direccion VARCHAR2
)
AS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM CLIENTES
    WHERE IDCliente = p_id;

    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'El cliente no existe');
    END IF;

    UPDATE CLIENTES
    SET Nombre = p_nombre,
        Telefono = p_telefono,
        Email = p_email,
        Direccion = p_direccion
    WHERE IDCliente = p_id;

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

CREATE OR REPLACE PROCEDURE SP_LISTAR_CLIENTES (
    p_cursor OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN p_cursor FOR
    SELECT * FROM CLIENTES;
END;
/
CREATE OR REPLACE PROCEDURE SP_EXISTE_CLIENTE (
    p_id NUMBER,
    p_existe OUT NUMBER
)
AS
BEGIN
    SELECT COUNT(*)
    INTO p_existe
    FROM CLIENTES
    WHERE IDCliente = p_id;
END;
/