CREATE OR REPLACE PROCEDURE sp_crear_venta(
    p_idcliente NUMBER,
    p_totalventa NUMBER
)
AS
BEGIN
    INSERT INTO VENTAS(IDCliente, TotalVenta)
    VALUES(p_idcliente, p_totalventa);
END;
/

CREATE OR REPLACE PROCEDURE sp_eliminar_venta(
    p_idventa NUMBER
)
AS
BEGIN
    DELETE FROM VENTAS
    WHERE IDVenta = p_idventa;
END;
/

CREATE OR REPLACE PROCEDURE sp_obtener_venta(
    p_idventa NUMBER
)
AS
BEGIN
    FOR r IN (SELECT * FROM VENTAS WHERE IDVenta = p_idventa)
    LOOP
        DBMS_OUTPUT.PUT_LINE('Venta ' || r.IDVenta || ' Total: ' || r.TotalVenta);
    END LOOP;
END;
/

CREATE OR REPLACE PROCEDURE sp_listar_ventas
AS
BEGIN
    FOR r IN (SELECT * FROM VENTAS)
    LOOP
        DBMS_OUTPUT.PUT_LINE('Venta ' || r.IDVenta || ' Cliente ' || r.IDCliente);
    END LOOP;
END;
/