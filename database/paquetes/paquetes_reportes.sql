CREATE OR REPLACE PACKAGE pkg_reportes AS
    FUNCTION total_ventas RETURN NUMBER;
    FUNCTION total_productos RETURN NUMBER;
END pkg_reportes;
/

CREATE OR REPLACE PACKAGE BODY pkg_reportes AS

    FUNCTION total_ventas RETURN NUMBER IS
        total NUMBER;
    BEGIN
        SELECT SUM(TotalVenta) INTO total FROM VENTAS;
        RETURN NVL(total,0);
    END;

    FUNCTION total_productos RETURN NUMBER IS
        total NUMBER;
    BEGIN
        SELECT COUNT(*) INTO total FROM PRODUCTOS;
        RETURN total;
    END;

END pkg_reportes;
/
