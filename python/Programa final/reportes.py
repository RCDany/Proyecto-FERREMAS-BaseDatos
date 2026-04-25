from conexion import obtener_conexion
import oracledb


def menu_reportes():
    while True:
        print("""
        ===== REPORTES =====
        1. Total ingresos
        2. Ventas por mes
        3. Total productos vendidos
        4. Productos bajo stock
        5. Ver ventas con cliente
        6. Volver
        """)

        opcion = input("Seleccione: ")

        if opcion == "1":
            total_ingresos()
        elif opcion == "2":
            ventas_mes()
        elif opcion == "3":
            total_productos()
        elif opcion == "4":
            bajo_stock()
        elif opcion == "5":
            ver_vista_ventas()
        elif opcion == "6":
            break
        else:
            print("Opción inválida")




def total_ingresos():
    conn = obtener_conexion()
    cursor = conn.cursor()

    result = cursor.callfunc("FN_TOTAL_INGRESOS", float)
    print(f"Total ingresos: {result}")

    conn.close()


def ventas_mes():
    conn = obtener_conexion()
    cursor = conn.cursor()

    mes = int(input("Mes (1-12): "))
    anio = int(input("Año: "))

    result = cursor.callfunc("FN_TOTAL_VENTAS_MES", float, [mes, anio])
    print(f"Ventas del mes: {result}")

    conn.close()


def total_productos():
    conn = obtener_conexion()
    cursor = conn.cursor()

    result = cursor.callfunc("FN_TOTAL_PRODUCTOS_VENDIDOS", float)
    print(f"Productos vendidos: {result}")

    conn.close()


def bajo_stock():
    conn = obtener_conexion()
    cursor = conn.cursor()

    result = cursor.callfunc("FN_PRODUCTOS_BAJO_STOCK", int)
    print(f"Productos con bajo stock: {result}")

    conn.close()



def ver_vista_ventas():
    conn = obtener_conexion()
    cursor = conn.cursor()

    cursor_out = cursor.var(oracledb.CURSOR)

    cursor.callproc("SP_LISTAR_VENTAS_CLIENTES", [cursor_out])

    ref_cursor = cursor_out.getvalue()

    print("\n--- VENTAS CON CLIENTE ---")

    for row in ref_cursor:
        print(f"ID: {row[0]} | Cliente: {row[2]} | Total: {row[3]}")

    ref_cursor.close()
    conn.close()