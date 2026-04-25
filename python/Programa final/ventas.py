import oracledb
from conexion import obtener_conexion


def menu_ventas():
    while True:
        print("""
        ===== VENTAS =====
        1. Crear venta
        2. Ver ventas
        3. Ver detalle de venta
        4. Eliminar venta
        5. Volver
        """)

        opcion = input("Seleccione una opción: ")

        if opcion == "1":
            crear_venta()
        elif opcion == "2":
            listar_ventas()
        elif opcion == "3":
            ver_detalle_venta()
        elif opcion == "4":
            eliminar_venta()
        elif opcion == "5":
            break
        else:
            print("Opción inválida")


def crear_venta():
    conn = obtener_conexion()
    if conn is None:
        return

    cursor = conn.cursor()

    try:
        id_cliente = int(input("ID Cliente: "))

        id_venta = cursor.var(int)

        cursor.callproc("SP_CREAR_VENTA", [id_cliente, id_venta])

        id_generado = id_venta.getvalue()  # ← CORREGIDO

        print(f"Venta creada con ID: {id_generado}")

        while True:
            print("\n1. Agregar producto")
            print("2. Finalizar venta")

            op = input("Seleccione: ")

            if op == "1":
                try:
                    id_producto = int(input("ID Producto: "))
                    cantidad = int(input("Cantidad: "))

                    cursor.callproc("SP_AGREGAR_DETALLE_VENTA", [
                        id_generado,
                        id_producto,
                        cantidad
                    ])

                    print("Producto agregado")

                except Exception as e:
                    print("Error:", e)

            elif op == "2":
                break

        conn.commit()
        print("Venta finalizada")

    except Exception as e:
        print("Error:", e)

    finally:
        cursor.close()
        conn.close()


def listar_ventas():
    conn = obtener_conexion()
    if conn is None:
        return

    cursor = conn.cursor()

    try:
        cursor_out = cursor.var(oracledb.CURSOR)

        cursor.callproc("SP_LISTAR_VENTAS", [cursor_out])

        print("\n--- VENTAS ---")

        datos = cursor_out.getvalue().fetchall()

        if not datos:
            print("No hay ventas")
        else:
            for row in datos:
                print(f"ID: {row[0]} | Cliente: {row[2]} | Total: {row[3]}")

    except Exception as e:
        print("Error:", e)

    finally:
        cursor.close()
        conn.close()


def ver_detalle_venta():
    conn = obtener_conexion()
    if conn is None:
        return

    try:
        cursor = conn.cursor()

        id_venta = int(input("ID Venta: "))

        cursor_out = cursor.var(oracledb.CURSOR)

        cursor.execute("""
            BEGIN
                SP_LISTAR_DETALLE_VENTA(:1, :2);
            END;
        """, [id_venta, cursor_out])

        ref_cursor = cursor_out.getvalue()

        print("\n--- DETALLE VENTA ---")

        filas = ref_cursor.fetchall()

        if not filas:
            print("No hay detalles para esta venta")
        else:
            for row in filas:
                print(f"Producto: {row[2]} | Cantidad: {row[3]} | Subtotal: {row[5]}")

        ref_cursor.close()

    except Exception as e:
        print("Error:", e)

    finally:
        conn.close()


def eliminar_venta():
    conn = obtener_conexion()
    if conn is None:
        return

    cursor = conn.cursor()

    try:
        id_venta = int(input("ID Venta: "))

        cursor.callproc("SP_ELIMINAR_VENTA", [id_venta])

        conn.commit()
        print("Venta eliminada correctamente")

    except Exception as e:
        print("Error:", e)

    finally:
        cursor.close()
        conn.close()