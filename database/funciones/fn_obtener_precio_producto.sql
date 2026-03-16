CREATE OR REPLACE FUNCTION fn_obtener_precio_producto(
    p_idproducto NUMBER
)
RETURN NUMBER
AS
    v_precio NUMBER;
BEGIN
    SELECT PrecioVenta
    INTO v_precio
    FROM PRODUCTOS
    WHERE IDProducto = p_idproducto;

    RETURN v_precio;
END;
/