import oracledb
from conexion import obtener_conexion


def menu_proveedores():
    while True:
        print("""
        ===== PROVEEDORES =====
        1. Crear proveedor
        2. Listar proveedores
        3. Actualizar proveedor
        4. Eliminar proveedor
        5. Volver
        """)

        opcion = input("Seleccione una opción: ")

        if opcion == "1":
            crear_proveedor()
        elif opcion == "2":
            listar_proveedores()
        elif opcion == "3":
            actualizar_proveedor()
        elif opcion == "4":
            eliminar_proveedor()
        elif opcion == "5":
            break
        else:
            print("Opción inválida")


def crear_proveedor():
    conn = obtener_conexion()
    if conn is None:
        return

    cursor = conn.cursor()

    try:
        nombre = input("Nombre: ")
        telefono = input("Teléfono: ")
        email = input("Email: ")
        direccion = input("Dirección: ")

        cursor.callproc("SP_CREAR_PROVEEDOR", [
            nombre,
            telefono,
            email,
            direccion
        ])

        conn.commit()
        print("Proveedor creado")

    except Exception as e:
        print("Error:", e)

    finally:
        cursor.close()
        conn.close()


def listar_proveedores():
    conn = obtener_conexion()
    if conn is None:
        return

    cursor = conn.cursor()

    try:
        cursor_out = cursor.var(oracledb.CURSOR)

        cursor.callproc("SP_LISTAR_PROVEEDORES", [cursor_out])

        print("\n--- PROVEEDORES ---")
        for row in cursor_out.getvalue():
            print(row)

    except Exception as e:
        print("Error:", e)

    finally:
        cursor.close()
        conn.close()


def actualizar_proveedor():
    conn = obtener_conexion()
    if conn is None:
        return

    cursor = conn.cursor()

    try:
        id_proveedor = int(input("ID del proveedor: "))

        existe = cursor.var(int)
        cursor.callproc("SP_EXISTE_PROVEEDOR", [id_proveedor, existe])

        if existe.getvalue() == 0:
            print("El proveedor no existe")
            return

        nombre = input("Nuevo nombre: ")
        telefono = input("Nuevo teléfono: ")
        email = input("Nuevo email: ")
        direccion = input("Nueva dirección: ")

        cursor.callproc("SP_ACTUALIZAR_PROVEEDOR", [
            id_proveedor,
            nombre,
            telefono,
            email,
            direccion
        ])

        conn.commit()
        print("Proveedor actualizado")

    except Exception as e:
        print("Error:", e)

    finally:
        cursor.close()
        conn.close()


def eliminar_proveedor():
    conn = obtener_conexion()
    if conn is None:
        return

    cursor = conn.cursor()

    try:
        id_proveedor = int(input("ID del proveedor: "))

        cursor.callproc("SP_ELIMINAR_PROVEEDOR", [id_proveedor])

        conn.commit()
        print("Proveedor eliminado (Estado = 0)")

    except Exception as e:
        print("Error:", e)

    finally:
        cursor.close()
        conn.close()