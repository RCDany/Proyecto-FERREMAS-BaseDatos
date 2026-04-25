CREATE OR REPLACE PROCEDURE sp_agregar_detalle_venta(
    p_idventa NUMBER,
    p_idproducto NUMBER,
    p_cantidad NUMBER
)
AS
    v_precio NUMBER;
BEGIN
    SELECT PrecioVenta INTO v_precio
    FROM PRODUCTOS
    WHERE IDProducto = p_idproducto;

    INSERT INTO DETALLE_VENTA(
        IDVenta,
        IDProducto,
        Cantidad,
        PrecioUnitario,
        Subtotal
    )
    VALUES(
        p_idventa,
        p_idproducto,
        p_cantidad,
        v_precio,
        v_precio * p_cantidad
    );
END;
/

CREATE OR REPLACE PROCEDURE sp_eliminar_detalle_venta(
    p_iddetalle NUMBER
)
AS
BEGIN
    DELETE FROM DETALLE_VENTA
    WHERE IDDetalleVenta = p_iddetalle;
END;
/

CREATE OR REPLACE PROCEDURE sp_listar_detalle_venta(
    p_idventa NUMBER,
    p_cursor OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN p_cursor FOR
    SELECT 
        d.IDDetalleVenta,
        d.IDProducto,
        p.Nombre,
        d.Cantidad,
        d.PrecioUnitario,
        d.Subtotal
    FROM DETALLE_VENTA d
    JOIN PRODUCTOS p ON d.IDProducto = p.IDProducto
    WHERE d.IDVenta = p_idventa;
END;
/