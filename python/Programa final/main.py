from clientes import menu_clientes
from productos import menu_productos
from proveedores import menu_proveedores
from ventas import menu_ventas
from reportes import menu_reportes


def main():
    while True:
        print("""
    ===== FERREMAS =====
    1. Clientes
    2. Productos
    3. Proveedores
    4. Ventas
    5. Reportes
    6. Salir
        """)

        opcion = input("Seleccione: ")

        if opcion == "1":
            menu_clientes()

        elif opcion == "2":
            menu_productos()

        elif opcion == "3":
            menu_proveedores()

        elif opcion == "4":
            menu_ventas()

        elif opcion == "5":
            menu_reportes()

        elif opcion == "6":
            print("Saliendo del sistema...")
            break

        else:
            print("Opción inválida")


if __name__ == "__main__":
    main()