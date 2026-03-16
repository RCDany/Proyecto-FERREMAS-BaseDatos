CREATE OR REPLACE PROCEDURE sp_crear_producto(
    p_nombre VARCHAR2,
    p_descripcion VARCHAR2,
    p_precioventa NUMBER,
    p_stockactual NUMBER,
    p_stockminimo NUMBER,
    p_idproveedor NUMBER
)
AS
BEGIN
    INSERT INTO PRODUCTOS(Nombre, Descripcion, PrecioVenta, StockActual, StockMinimo, IDProveedor)
    VALUES(p_nombre, p_descripcion, p_precioventa, p_stockactual, p_stockminimo, p_idproveedor);
END;
/

CREATE OR REPLACE PROCEDURE sp_actualizar_producto(
    p_idproducto NUMBER,
    p_nombre VARCHAR2,
    p_descripcion VARCHAR2,
    p_precioventa NUMBER,
    p_stockactual NUMBER,
    p_stockminimo NUMBER,
    p_idproveedor NUMBER
)
AS
BEGIN
    UPDATE PRODUCTOS
    SET Nombre = p_nombre,
        Descripcion = p_descripcion,
        PrecioVenta = p_precioventa,
        StockActual = p_stockactual,
        StockMinimo = p_stockminimo,
        IDProveedor = p_idproveedor
    WHERE IDProducto = p_idproducto;
END;
/

CREATE OR REPLACE PROCEDURE sp_eliminar_producto(
    p_idproducto NUMBER
)
AS
BEGIN
    DELETE FROM PRODUCTOS
    WHERE IDProducto = p_idproducto;
END;
/

CREATE OR REPLACE PROCEDURE sp_obtener_producto(
    p_idproducto NUMBER
)
AS
BEGIN
    FOR r IN (SELECT * FROM PRODUCTOS WHERE IDProducto = p_idproducto)
    LOOP
        DBMS_OUTPUT.PUT_LINE(r.Nombre || ' - ' || r.PrecioVenta);
    END LOOP;
END;
/

CREATE OR REPLACE PROCEDURE sp_listar_productos
AS
BEGIN
    FOR r IN (SELECT * FROM PRODUCTOS)
    LOOP
        DBMS_OUTPUT.PUT_LINE(r.IDProducto || ' - ' || r.Nombre);
    END LOOP;
END;
/