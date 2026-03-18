import oracledb
from conexion import obtener_conexion

def menu_principal():
    while True:
        print("""
        ===== SISTEMA =====
        Este menu demuestra la correcta funcionalidad del CRUD a traves de procedimientos
        Se realiza una conexion con la base de datos
    
        1. Clientes
        2. Productos
        3. Ventas
        4. Detalle Venta
        5. Salir
        """)

        opcion = input("Seleccione una opción: ")

        if opcion == "1":
            menu_clientes()
        elif opcion == "2":
            menu_productos()
        elif opcion == "3":
            menu_ventas()
        elif opcion == "4":
            menu_detalle_venta()
        elif opcion == "5":
            print("Saliendo...")
            break
        else:
            print("Opción inválida")


# CLIENTES 

def menu_clientes():
    while True:
        print("""
        --- CLIENTES ---
        1. Crear
        2. Listar
        3. Eliminar
        4. Volver
        """)

        op = input("Opción: ")

        conn = obtener_conexion()
        if conn is None:
            continue

        cursor = conn.cursor()

        try:
            if op == "1":
                nombre = input("Nombre: ")
                telefono = input("Telefono: ")
                email = input("Email: ")
                direccion = input("Direccion: ")

                cursor.callproc("SP_CREAR_CLIENTE", [nombre, telefono, email, direccion])
                conn.commit()
                print("Cliente creado")

            elif op == "2":
                cursor_out = cursor.var(oracledb.CURSOR)

                cursor.callproc("SP_LISTAR_CLIENTES", [cursor_out])

                for row in cursor_out.getvalue():
                    print(row)
            elif op == "3":
                idc = int(input("ID Cliente: "))
                cursor.callproc("SP_ELIMINAR_CLIENTE", [idc])
                conn.commit()
                print("Cliente eliminado")

            elif op == "4":
                break

            else:
                print("Opción inválida")

        except Exception as e:
            print("Error:", e)

        finally:
            cursor.close()
            conn.close()


# PRODUCTOS 

def menu_productos():
    while True:
        print("""
        --- PRODUCTOS ---
        1. Crear
        2. Listar
        3. Eliminar
        4. Volver
        """)

        op = input("Opción: ")

        conn = obtener_conexion()
        if conn is None:
            continue

        cursor = conn.cursor()

        try:
            if op == "1":
                nombre = input("Nombre: ")
                desc = input("Descripción: ")
                precio = float(input("Precio: "))
                stock = int(input("Stock: "))
                stock_min = int(input("Stock mínimo: "))
                idprov = int(input("ID Proveedor: "))

                cursor.callproc("SP_CREAR_PRODUCTO", [nombre, desc, precio, stock, stock_min, idprov])
                conn.commit()
                print("Producto creado")

            elif op == "2":
                cursor.callproc("SP_LISTAR_PRODUCTOS")
                for row in cursor:
                    print(row)

            elif op == "3":
                idp = int(input("ID Producto: "))
                cursor.callproc("SP_ELIMINAR_PRODUCTO", [idp])
                conn.commit()
                print("Producto eliminado")

            elif op == "4":
                break

            else:
                print("Opción inválida")

        except Exception as e:
            print("Error:", e)

        finally:
            cursor.close()
            conn.close()


# VENTAS 

def menu_ventas():
    while True:
        print("""
        --- VENTAS ---
        1. Crear venta
        2. Listar ventas
        3. Volver
        """)

        op = input("Opción: ")

        conn = obtener_conexion()
        if conn is None:
            continue

        cursor = conn.cursor()

        try:
            if op == "1":
                idc = int(input("ID Cliente: "))
                total = float(input("Total venta: "))

                cursor.callproc("SP_CREAR_VENTA", [idc, total])
                conn.commit()
                print("Venta creada")

            elif op == "2":
                cursor_out = cursor.var(oracledb.CURSOR)

                cursor.callproc("SP_LISTAR_VENTAS", [cursor_out])

                for row in cursor_out.getvalue():
                    print(row)

            elif op == "3":
                break

            else:
                print("Opción inválida")

        except Exception as e:
            print("Error:", e)

        finally:
            cursor.close()
            conn.close()


# DETALLE VENTA

def menu_detalle_venta():
    while True:
        print("""
        --- DETALLE VENTA ---
        1. Agregar detalle
        2. Eliminar detalle
        3. Volver
        """)

        op = input("Opción: ")

        conn = obtener_conexion()
        if conn is None:
            continue

        cursor = conn.cursor()

        try:
            if op == "1":
                idv = int(input("ID Venta: "))
                idp = int(input("ID Producto: "))
                cant = int(input("Cantidad: "))
                precio = float(input("Precio: "))
                subtotal = float(input("Subtotal: "))

                cursor.callproc("SP_AGREGAR_DETALLE_VENTA", [idv, idp, cant, precio, subtotal])
                conn.commit()
                print("Detalle agregado")

            elif op == "2":
                idd = int(input("ID Detalle: "))
                cursor.callproc("SP_ELIMINAR_DETALLE_VENTA", [idd])
                conn.commit()
                print("Detalle eliminado")

            elif op == "3":
                break

            else:
                print("Opción inválida")

        except Exception as e:
            print("Error:", e)

        finally:
            cursor.close()
            conn.close()