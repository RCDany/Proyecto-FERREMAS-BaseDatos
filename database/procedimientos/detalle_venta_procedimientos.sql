CREATE OR REPLACE PROCEDURE sp_agregar_detalle_venta(
    p_idventa NUMBER,
    p_idproducto NUMBER,
    p_cantidad NUMBER,
    p_preciounitario NUMBER,
    p_subtotal NUMBER
)
AS
BEGIN
    INSERT INTO DETALLE_VENTA(IDVenta, IDProducto, Cantidad, PrecioUnitario, Subtotal)
    VALUES(p_idventa, p_idproducto, p_cantidad, p_preciounitario, p_subtotal);
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
CREATE OR REPLACE PROCEDURE SP_LISTAR_DETALLE_VENTA (
    p_cursor OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN p_cursor FOR
    SELECT * FROM DETALLE_VENTA;
END;
/