CREATE OR REPLACE PROCEDURE sp_crear_venta(
    p_idcliente NUMBER,
    p_idventa OUT NUMBER
)
AS
BEGIN
    INSERT INTO VENTAS(IDCliente)
    VALUES(p_idcliente)
    RETURNING IDVenta INTO p_idventa;
END;
/

CREATE OR REPLACE PROCEDURE sp_listar_ventas(
    p_cursor OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN p_cursor FOR
    SELECT * FROM VENTAS;
END;
/

CREATE OR REPLACE PROCEDURE sp_obtener_venta(
    p_idventa NUMBER,
    p_cursor OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN p_cursor FOR
    SELECT * FROM VENTAS WHERE IDVenta = p_idventa;
END;
/

CREATE OR REPLACE PROCEDURE sp_eliminar_venta(
    p_idventa NUMBER
)
AS
BEGIN
    DELETE FROM DETALLE_VENTA
    WHERE IDVenta = p_idventa;

    IF SQL%ROWCOUNT = 0 THEN
        NULL; -- puede no tener detalles, no pasa nada
    END IF;

    DELETE FROM VENTAS
    WHERE IDVenta = p_idventa;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20070, 'Venta no existe');
    END IF;
END;
/