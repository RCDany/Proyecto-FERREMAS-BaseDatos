CREATE OR REPLACE PACKAGE pkg_productos AS
    PROCEDURE crear_producto(
        p_nombre VARCHAR2,
        p_descripcion VARCHAR2,
        p_precioventa NUMBER,
        p_stockactual NUMBER,
        p_stockminimo NUMBER,
        p_idproveedor NUMBER
    );

    FUNCTION obtener_stock(
        p_idproducto NUMBER
    ) RETURN NUMBER;
END pkg_productos;
/
CREATE OR REPLACE PACKAGE BODY pkg_productos AS

    PROCEDURE crear_producto(
        p_nombre VARCHAR2,
        p_descripcion VARCHAR2,
        p_precioventa NUMBER,
        p_stockactual NUMBER,
        p_stockminimo NUMBER,
        p_idproveedor NUMBER
    )
    AS
    BEGIN
        INSERT INTO PRODUCTOS
        (Nombre, Descripcion, PrecioVenta, StockActual, StockMinimo, IDProveedor)
        VALUES
        (p_nombre, p_descripcion, p_precioventa, p_stockactual, p_stockminimo, p_idproveedor);
    END;

    FUNCTION obtener_stock(
        p_idproducto NUMBER
    ) RETURN NUMBER
    AS
        v_stock NUMBER;
    BEGIN
        SELECT StockActual
        INTO v_stock
        FROM PRODUCTOS
        WHERE IDProducto = p_idproducto;

        RETURN v_stock;
    END;

END pkg_productos;
/
