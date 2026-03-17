-- Restar stock en ventas
CREATE OR REPLACE TRIGGER trg_restar_stock_venta
AFTER INSERT ON DETALLE_VENTA
FOR EACH ROW
BEGIN
    UPDATE PRODUCTOS
    SET StockActual = StockActual - :NEW.Cantidad
    WHERE IDProducto = :NEW.IDProducto;
END;
/

-- Sumar stock en compras
CREATE OR REPLACE TRIGGER trg_sumar_stock_compra
AFTER INSERT ON DETALLE_COMPRA
FOR EACH ROW
BEGIN
    UPDATE PRODUCTOS
    SET StockActual = StockActual + :NEW.Cantidad
    WHERE IDProducto = :NEW.IDProducto;
END;
/

-- Evitar stock negativo
CREATE OR REPLACE TRIGGER trg_evitar_stock_negativo
BEFORE UPDATE ON PRODUCTOS
FOR EACH ROW
BEGIN
    IF :NEW.StockActual < 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Stock no puede ser negativo');
    END IF;
END;
/

-- Validar precio
CREATE OR REPLACE TRIGGER trg_validar_precio_producto
BEFORE INSERT OR UPDATE ON PRODUCTOS
FOR EACH ROW
BEGIN
    IF :NEW.PrecioVenta <= 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Precio inválido');
    END IF;
END;
/

-- Log de ventas (simple)
CREATE OR REPLACE TRIGGER trg_log_venta
AFTER INSERT ON VENTAS
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('Venta registrada ID: ' || :NEW.IDVenta);
END;
/
