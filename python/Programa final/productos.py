import oracledb
from conexion import obtener_conexion


def menu_productos():
    while True:
        print("""
        ===== PRODUCTOS =====
        1. Crear producto
        2. Listar productos
        3. Actualizar producto
        4. Eliminar producto
        5. Volver
        """)

        opcion = input("Seleccione una opción: ")

        if opcion == "1":
            crear_producto()
        elif opcion == "2":
            listar_productos()
        elif opcion == "3":
            actualizar_producto()
        elif opcion == "4":
            eliminar_producto()
        elif opcion == "5":
            break
        else:
            print("Opción inválida")


def crear_producto():
    conn = obtener_conexion()
    if conn is None:
        return

    cursor = conn.cursor()

    try:
        nombre = input("Nombre: ")
        descripcion = input("Descripción: ")
        precio = float(input("Precio: "))
        stock = int(input("Stock actual: "))
        stock_min = int(input("Stock mínimo: "))
        id_proveedor = int(input("ID proveedor: "))

        cursor.callproc("SP_CREAR_PRODUCTO", [
            nombre, descripcion, precio, stock, stock_min, id_proveedor
        ])

        conn.commit()
        print("Producto creado")

    except Exception as e:
        print("Error:", e)

    finally:
        cursor.close()
        conn.close()


def listar_productos():
    conn = obtener_conexion()
    if conn is None:
        return

    cursor = conn.cursor()

    try:
        cursor_out = cursor.var(oracledb.CURSOR)
        cursor.callproc("SP_LISTAR_PRODUCTOS", [cursor_out])

        print("\n--- PRODUCTOS ---")
        for row in cursor_out.getvalue():
            print(row)

    except Exception as e:
        print("Error:", e)

    finally:
        cursor.close()
        conn.close()


def actualizar_producto():
    conn = obtener_conexion()
    if conn is None:
        return

    cursor = conn.cursor()

    try:
        id_producto = int(input("ID del producto: "))

        existe = cursor.var(int)
        cursor.callproc("SP_EXISTE_PRODUCTO", [id_producto, existe])

        if existe.getvalue() == 0:
            print("El producto no existe")
            return

        nombre = input("Nuevo nombre: ")
        descripcion = input("Nueva descripción: ")
        precio = float(input("Nuevo precio: "))
        stock = int(input("Nuevo stock: "))
        stock_min = int(input("Nuevo stock mínimo: "))
        id_proveedor = int(input("Nuevo ID proveedor: "))

        cursor.callproc("SP_ACTUALIZAR_PRODUCTO", [
            id_producto, nombre, descripcion, precio, stock, stock_min, id_proveedor
        ])

        conn.commit()
        print("Producto actualizado")

    except Exception as e:
        print("Error:", e)

    finally:
        cursor.close()
        conn.close()


def eliminar_producto():
    conn = obtener_conexion()
    if conn is None:
        return

    cursor = conn.cursor()

    try:
        id_producto = int(input("ID del producto: "))

        cursor.callproc("SP_ELIMINAR_PRODUCTO", [id_producto])

        conn.commit()
        print("Producto eliminado")

    except Exception as e:
        print("Error:", e)

    finally:
        cursor.close()
        conn.close()