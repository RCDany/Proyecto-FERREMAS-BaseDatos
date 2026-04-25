CREATE OR REPLACE TRIGGER trg_restar_stock_venta
BEFORE INSERT ON DETALLE_VENTA
FOR EACH ROW
DECLARE
    v_stock NUMBER;
BEGIN
    SELECT StockActual INTO v_stock
    FROM PRODUCTOS
    WHERE IDProducto = :NEW.IDProducto;

    IF v_stock < :NEW.Cantidad THEN
        RAISE_APPLICATION_ERROR(-20030, 'Stock insuficiente');
    END IF;

    UPDATE PRODUCTOS
    SET StockActual = StockActual - :NEW.Cantidad
    WHERE IDProducto = :NEW.IDProducto;
END;
/
CREATE OR REPLACE TRIGGER trg_sumar_stock_compra
AFTER INSERT ON DETALLE_COMPRA
FOR EACH ROW
BEGIN
    UPDATE PRODUCTOS
    SET StockActual = StockActual + :NEW.Cantidad
    WHERE IDProducto = :NEW.IDProducto;
END;
/
CREATE OR REPLACE TRIGGER trg_validar_precio_producto
BEFORE INSERT OR UPDATE ON PRODUCTOS
FOR EACH ROW
BEGIN
    IF :NEW.PrecioVenta <= 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Precio inválido');
    END IF;
END;
/
CREATE OR REPLACE TRIGGER trg_actualizar_total_venta
AFTER INSERT OR UPDATE OR DELETE ON DETALLE_VENTA
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        UPDATE VENTAS
        SET TotalVenta = NVL(TotalVenta,0) + :NEW.Subtotal
        WHERE IDVenta = :NEW.IDVenta;

    ELSIF DELETING THEN
        UPDATE VENTAS
        SET TotalVenta = NVL(TotalVenta,0) - :OLD.Subtotal
        WHERE IDVenta = :OLD.IDVenta;

    ELSIF UPDATING THEN
        UPDATE VENTAS
        SET TotalVenta = NVL(TotalVenta,0) - :OLD.Subtotal + :NEW.Subtotal
        WHERE IDVenta = :NEW.IDVenta;
    END IF;
END;
/