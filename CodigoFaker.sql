import mysql.connector
from faker import Faker
import random

# Faker en español
fake = Faker('es_ES')

# conexión MySQL
conexion = mysql.connector.connect(
    host='localhost',
    user='root',
    password='1234',
    database='logistica_transporte'
)

cursor = conexion.cursor()

# =========================================================
# INSERTAR CLIENTES
# =========================================================

for i in range(1, 101):

    sql = """
    INSERT INTO clientes (
        id_cliente,
        nombre,
        telefono,
        correo,
        direccion,
        departamento,
        tipo_cliente,
        fecha_registro,
        estado_cliente,
        ciudad
    )
    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """

    valores = (
        i,
        fake.name(),
        fake.phone_number(),
        fake.email(),
        fake.address(),
        fake.state(),

        random.choice([
            'Premium',
            'Regular',
            'Corporativo'
        ]),

        fake.date_between(
            start_date='-3y',
            end_date='today'
        ),

        random.choice([
            'Activo',
            'Inactivo'
        ]),

        fake.city()
    )

    cursor.execute(sql, valores)

print("Clientes insertados")


# =========================================================
# INSERTAR RUTAS
# =========================================================

for i in range(50):

    sql = """
    INSERT INTO rutas (
        Destino,
        Distancia,
        Tipo_Ruta,
        Tiempo_Estimado
    )
    VALUES (%s, %s, %s, %s)
    """

    valores = (

        fake.city(),

        round(
            random.uniform(10, 2000),
            2
        ),

        random.choice([
            'Nacional',
            'Regional',
            'Internacional'
        ]),

        random.randint(1, 72)
    )

    cursor.execute(sql, valores)

print("Rutas insertadas")


# =========================================================
# INSERTAR ENVIOS
# =========================================================

for i in range(300):

    fecha_envio = fake.date_between(
        start_date='-1y',
        end_date='today'
    )

    fecha_entrega = fake.date_between(
        start_date=fecha_envio,
        end_date='+10d'
    )

    sql = """
    INSERT INTO envios (
        id_remitente,
        id_destinatario,
        id_ruta,
        tipo_envio,
        peso,
        fecha_envio,
        fecha_entrega,
        estado,
        tiempo_entrega,
        costo_envio
    )
    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """

    valores = (

        random.randint(1, 100),

        random.randint(1, 100),

        random.randint(1, 50),

        random.choice([
            'Express',
            'Estandar',
            'Internacional'
        ]),

        round(
            random.uniform(0.5, 80),
            2
        ),

        fecha_envio,

        fecha_entrega,

        random.choice([
            'Entregado',
            'En tránsito',
            'Pendiente'
        ]),

        random.randint(1, 15),

        round(
            random.uniform(10000, 500000),
            2
        )
    )

    cursor.execute(sql, valores)

print("Envios insertados")


# =========================================================
# INSERTAR SEGUIMIENTO
# =========================================================

for i in range(500):

    sql = """
    INSERT INTO seguimiento (
        id_envio,
        fecha_evento,
        estado,
        ubicacion,
        tipo_evento
    )
    VALUES (%s, %s, %s, %s, %s)
    """

    valores = (

        random.randint(1, 300),

        fake.date_between(
            start_date='-1y',
            end_date='today'
        ),

        random.choice([
            'En tránsito',
            'Entregado',
            'Retrasado',
            'Procesando'
        ]),

        fake.city(),

        random.choice([
            'Salida',
            'Llegada',
            'Entrega',
            'Retención'
        ])
    )

    cursor.execute(sql, valores)

print("Seguimiento insertado")


# =========================================================
# GUARDAR CAMBIOS
# =========================================================

conexion.commit()

print("Todos los datos fueron insertados correctamente")

cursor.close()
conexion.close()