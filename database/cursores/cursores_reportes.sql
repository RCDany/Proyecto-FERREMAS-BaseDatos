DECLARE
    CURSOR cursor_productos IS SELECT * FROM PRODUCTOS;
    CURSOR cursor_clientes IS SELECT * FROM CLIENTES;
    CURSOR cursor_ventas IS SELECT * FROM VENTAS;
    CURSOR cursor_stock_bajo IS 
        SELECT * FROM PRODUCTOS WHERE StockActual <= StockMinimo;

    v_producto PRODUCTOS%ROWTYPE;
BEGIN
    OPEN cursor_productos;
    LOOP
        FETCH cursor_productos INTO v_producto;
        EXIT WHEN cursor_productos%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_producto.Nombre);
    END LOOP;
    CLOSE cursor_productos;
END;
/
