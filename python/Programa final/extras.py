from conexion import obtener_conexion
import oracledb


def menu_extras():
    while True:
        print("""
        ===== FUNCIONES EXTRA =====
        1. Promedio ventas
        2. Ventas hoy
        3. Cliente con mayor compra
        4. Producto más vendido
        5. Ver productos con proveedor
        6. Ver productos bajo stock
        7. Ver ventas resumen
        8. Ejecutar cursor productos
        9. Ejecutar cursor ventas
        10. Usar paquete reportes
        11. Volver
        """)

        opcion = input("Seleccione: ")

        if opcion == "1":
            ejecutar_funcion("FN_PROMEDIO_VENTAS", float)

        elif opcion == "2":
            ejecutar_funcion("FN_VENTAS_HOY", float)

        elif opcion == "3":
            ejecutar_funcion("FN_CLIENTE_MAYOR_COMPRA", int)

        elif opcion == "4":
            ejecutar_funcion("FN_PRODUCTO_MAS_VENDIDO", int)

        elif opcion == "5":
            mostrar_vista("VW_PRODUCTOS_PROVEEDOR")

        elif opcion == "6":
            mostrar_vista("VW_PRODUCTOS_BAJO_STOCK")

        elif opcion == "7":
            mostrar_vista("VW_VENTAS_RESUMEN")

        elif opcion == "8":
            ejecutar_procedimiento("SP_CURSOR_PRODUCTOS")

        elif opcion == "9":
            ejecutar_procedimiento("SP_CURSOR_VENTAS")

        elif opcion == "10":
            usar_paquete()

        elif opcion == "11":
            break

        else:
            print("Opción inválida")


def ejecutar_funcion(nombre, tipo):
    conn = obtener_conexion()
    cursor = conn.cursor()

    try:
        result = cursor.callfunc(nombre, tipo)
        print("Resultado:", result)
    except Exception as e:
        print("Error:", e)

    conn.close()


def mostrar_vista(vista):
    conn = obtener_conexion()
    cursor = conn.cursor()

    try:
        cursor.execute(f"SELECT * FROM {vista}")

        print(f"\n--- {vista} ---")

        for row in cursor:
            print(row)

    except Exception as e:
        print("Error:", e)

    conn.close()


def ejecutar_procedimiento(nombre):
    conn = obtener_conexion()
    cursor = conn.cursor()

    try:
        cursor.callproc(nombre)
        print("Procedimiento ejecutado (ver DBMS_OUTPUT)")
    except Exception as e:
        print("Error:", e)

    conn.close()


def usar_paquete():
    conn = obtener_conexion()
    cursor = conn.cursor()

    try:
        total = cursor.callfunc("PKG_REPORTES.TOTAL_INGRESOS", float)
        print("Total ingresos (pkg):", total)

        mes = int(input("Mes: "))
        anio = int(input("Año: "))

        ventas = cursor.callfunc("PKG_REPORTES.VENTAS_MES", float, [mes, anio])
        print("Ventas mes (pkg):", ventas)

    except Exception as e:
        print("Error:", e)

    conn.close()