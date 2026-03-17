import oracledb

def obtener_conexion():
    return oracledb.connect(
        user="system",
        password="oracle",
        dsn="localhost:1521/XEPDB1"
    )