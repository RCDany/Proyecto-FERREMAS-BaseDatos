import oracledb

def obtener_conexion():
    try:
        connection = oracledb.connect(
            user="system",
            password="oracle",
            dsn="localhost:1521/XEPDB1"
        )
        print("Conexión a Oracle exitosa")
        return connection

    except Exception as e:
        print("Error al conectar a Oracle:", e)
        return None