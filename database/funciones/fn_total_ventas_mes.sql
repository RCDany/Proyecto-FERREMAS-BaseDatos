CREATE OR REPLACE FUNCTION fn_total_ventas_mes(
    p_mes NUMBER,
    p_anio NUMBER
)
RETURN NUMBER
AS
    v_total NUMBER;
BEGIN
    SELECT SUM(TotalVenta)
    INTO v_total
    FROM VENTAS
    WHERE EXTRACT(MONTH FROM Fecha) = p_mes
    AND EXTRACT(YEAR FROM Fecha) = p_anio;

    RETURN v_total;
END;
/