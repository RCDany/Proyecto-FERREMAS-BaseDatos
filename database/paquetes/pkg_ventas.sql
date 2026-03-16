CREATE OR REPLACE PACKAGE pkg_ventas AS
    PROCEDURE crear_venta(
        p_idcliente NUMBER,
        p_totalventa NUMBER
    );

    FUNCTION total_ventas
    RETURN NUMBER;
END pkg_ventas;
/

CREATE OR REPLACE PACKAGE BODY pkg_ventas AS

    PROCEDURE crear_venta(
        p_idcliente NUMBER,
        p_totalventa NUMBER
    )
    AS
    BEGIN
        INSERT INTO VENTAS
        (IDCliente, TotalVenta)
        VALUES
        (p_idcliente, p_totalventa);
    END;

    FUNCTION total_ventas
    RETURN NUMBER
    AS
        v_total NUMBER;
    BEGIN
        SELECT SUM(TotalVenta)
        INTO v_total
        FROM VENTAS;

        RETURN v_total;
    END;

END pkg_ventas;
/