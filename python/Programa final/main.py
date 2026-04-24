from clientes import menu_clientes
from productos import menu_productos
from proveedores import menu_proveedores

while True:
    print("""
    ===== FERREMAS =====
    1. Clientes
    2. Productos
    3. Proveedores
    4. Salir
    """)

    op = input("Seleccione: ")

    if op == "1":
        menu_clientes()
    elif op == "2":
        menu_productos()
    elif op == "3":
        menu_proveedores()
    elif op == "4":
        break