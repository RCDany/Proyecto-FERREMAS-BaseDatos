CREATE OR REPLACE FUNCTION fn_total_ingresos
RETURN NUMBER
AS
    v_total NUMBER;
BEGIN
    SELECT SUM(TotalVenta)
    INTO v_total
    FROM VENTAS;

    RETURN v_total;
END;
/