CREATE OR REPLACE PACKAGE pkg_inventario AS
    PROCEDURE actualizar_stock(p_id_producto NUMBER, p_cantidad NUMBER);
END pkg_inventario;
/

CREATE OR REPLACE PACKAGE BODY pkg_inventario AS

    PROCEDURE actualizar_stock(p_id_producto NUMBER, p_cantidad NUMBER) IS
    BEGIN
        UPDATE PRODUCTOS
        SET StockActual = StockActual + p_cantidad
        WHERE IDProducto = p_id_producto;
    END;

END pkg_inventario;
/
