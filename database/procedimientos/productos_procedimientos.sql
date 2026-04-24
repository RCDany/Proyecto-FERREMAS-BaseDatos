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

CREATE OR REPLACE PROCEDURE SP_ACTUALIZAR_PRODUCTO (
    p_id NUMBER,
    p_nombre VARCHAR2,
    p_descripcion VARCHAR2,
    p_precio NUMBER,
    p_stock NUMBER,
    p_stock_min NUMBER,
    p_id_proveedor NUMBER
)
AS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM PRODUCTOS
    WHERE IDProducto = p_id;

    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'El producto no existe');
    END IF;

    UPDATE PRODUCTOS
    SET Nombre = p_nombre,
        Descripcion = p_descripcion,
        PrecioVenta = p_precio,
        StockActual = p_stock,
        StockMinimo = p_stock_min,
        IDProveedor = p_id_proveedor
    WHERE IDProducto = p_id;
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

CREATE OR REPLACE PROCEDURE SP_LISTAR_PRODUCTOS (
    p_cursor OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN p_cursor FOR
    SELECT * FROM PRODUCTOS;
END;
/
CREATE OR REPLACE PROCEDURE SP_EXISTE_PRODUCTO (
    p_id NUMBER,
    p_existe OUT NUMBER
)
AS
BEGIN
    SELECT COUNT(*)
    INTO p_existe
    FROM PRODUCTOS
    WHERE IDProducto = p_id;
END;
/