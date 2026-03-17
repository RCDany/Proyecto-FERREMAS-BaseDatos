CREATE OR REPLACE PACKAGE pkg_estadisticas AS
    FUNCTION promedio_precio RETURN NUMBER;
END pkg_estadisticas;
/

CREATE OR REPLACE PACKAGE BODY pkg_estadisticas AS

    FUNCTION promedio_precio RETURN NUMBER IS
        promedio NUMBER;
    BEGIN
        SELECT AVG(PrecioVenta) INTO promedio FROM PRODUCTOS;
        RETURN promedio;
    END;

END pkg_estadisticas;
/
