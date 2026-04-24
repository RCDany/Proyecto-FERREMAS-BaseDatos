CREATE OR REPLACE PROCEDURE sp_crear_proveedor(
    p_nombre VARCHAR2,
    p_telefono VARCHAR2,
    p_email VARCHAR2,
    p_direccion VARCHAR2
)
AS
BEGIN
    INSERT INTO PROVEEDORES(Nombre, Telefono, Email, Direccion)
    VALUES(p_nombre, p_telefono, p_email, p_direccion);
END;
/

CREATE OR REPLACE PROCEDURE sp_actualizar_proveedor(
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
    FROM PROVEEDORES
    WHERE IDProveedor = p_id;

    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20020, 'El proveedor no existe');
    END IF;

    UPDATE PROVEEDORES
    SET Nombre = p_nombre,
        Telefono = p_telefono,
        Email = p_email,
        Direccion = p_direccion
    WHERE IDProveedor = p_id;
END;
/

CREATE OR REPLACE PROCEDURE sp_eliminar_proveedor(
    p_id NUMBER
)
AS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM PROVEEDORES
    WHERE IDProveedor = p_id;

    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20021, 'El proveedor no existe');
    END IF;

    UPDATE PROVEEDORES
    SET Estado = 0
    WHERE IDProveedor = p_id;
END;
/

CREATE OR REPLACE PROCEDURE sp_obtener_proveedor(
    p_id NUMBER,
    p_cursor OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN p_cursor FOR
    SELECT * FROM PROVEEDORES
    WHERE IDProveedor = p_id AND Estado = 1;
END;
/

CREATE OR REPLACE PROCEDURE sp_listar_proveedores(
    p_cursor OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN p_cursor FOR
    SELECT * FROM PROVEEDORES
    WHERE Estado = 1;
END;
/

CREATE OR REPLACE PROCEDURE sp_existe_proveedor(
    p_id NUMBER,
    p_existe OUT NUMBER
)
AS
BEGIN
    SELECT COUNT(*)
    INTO p_existe
    FROM PROVEEDORES
    WHERE IDProveedor = p_id AND Estado = 1;
END;
/