import oracledb
from conexion import obtener_conexion


def menu_clientes():
    while True:
        print("""
        ===== CLIENTES =====
        1. Crear cliente
        2. Listar clientes
        3. Actualizar cliente
        4. Eliminar cliente
        5. Volver
        """)

        opcion = input("Seleccione una opción: ")

        if opcion == "1":
            crear_cliente()
        elif opcion == "2":
            listar_clientes()
        elif opcion == "3":
            actualizar_cliente()
        elif opcion == "4":
            eliminar_cliente()
        elif opcion == "5":
            break
        else:
            print("Opción inválida")


def crear_cliente():
    conn = obtener_conexion()
    if conn is None:
        return

    cursor = conn.cursor()

    try:
        nombre = input("Nombre: ")
        telefono = input("Teléfono: ")
        email = input("Email: ")
        direccion = input("Dirección: ")

        cursor.callproc("SP_CREAR_CLIENTE", [
            nombre,
            telefono,
            email,
            direccion
        ])

        conn.commit()
        print("Cliente creado correctamente")

    except Exception as e:
        print("Error:", e)

    finally:
        cursor.close()
        conn.close()


def listar_clientes():
    conn = obtener_conexion()
    if conn is None:
        return

    cursor = conn.cursor()

    try:
        cursor_out = cursor.var(oracledb.CURSOR)

        cursor.callproc("SP_LISTAR_CLIENTES", [cursor_out])

        print("\n--- LISTA DE CLIENTES ---")
        for row in cursor_out.getvalue():
            print(row)

    except Exception as e:
        print("Error:", e)

    finally:
        cursor.close()
        conn.close()


def eliminar_cliente():
    conn = obtener_conexion()
    if conn is None:
        return

    cursor = conn.cursor()

    try:
        id_cliente = int(input("ID del cliente a eliminar: "))

        cursor.callproc("SP_ELIMINAR_CLIENTE", [id_cliente])

        conn.commit()
        print("Cliente eliminado")

    except Exception as e:
        print("Error:", e)

    finally:
        cursor.close()
        conn.close()

def actualizar_cliente():
    conn = obtener_conexion()
    if conn is None:
        return

    cursor = conn.cursor()

    try:
        id_cliente = int(input("ID del cliente: "))

        # validar existencia
        existe = cursor.var(int)
        cursor.callproc("SP_EXISTE_CLIENTE", [id_cliente, existe])

        if existe.getvalue() == 0:
            print("El cliente no existe")
            return

        
        nombre = input("Nuevo nombre: ")
        telefono = input("Nuevo teléfono: ")
        email = input("Nuevo email: ")
        direccion = input("Nueva dirección: ")

        cursor.callproc("SP_ACTUALIZAR_CLIENTE", [
            id_cliente,
            nombre,
            telefono,
            email,
            direccion
        ])

        conn.commit()
        print("Cliente actualizado")

    except Exception as e:
        print("Error:", e)

    finally:
        cursor.close()
        conn.close()