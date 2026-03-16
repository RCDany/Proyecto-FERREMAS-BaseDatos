CREATE OR REPLACE FUNCTION fn_stock_producto(
    p_idproducto NUMBER
)
RETURN NUMBER
AS
    v_stock NUMBER;
BEGIN
    SELECT StockActual
    INTO v_stock
    FROM PRODUCTOS
    WHERE IDProducto = p_idproducto;

    RETURN v_stock;
END;
/