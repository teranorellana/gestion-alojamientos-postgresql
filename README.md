# Sistema de Gestión de Alojamientos Turísticos - Práctica SQL

Este repositorio contiene el script de desarrollo correspondiente a la práctica académica de consultas avanzadas CRUD y operaciones relacionales JOIN utilizando bases de datos relacionales.

## 🛠️ Motor de Base de Datos Utilizado
* **Motor:** PostgreSQL (v14 o superior)
* **Entorno de Administración:** pgAdmin 4 / DBeaver

---

## 📊 Esquema de la Base de Datos

El diseño relacional está optimizado para la gestión de alquileres vacacionales a través de 6 entidades principales interconectadas de forma lógica y restrictiva:

### 1. Tabla: `propietarios`
* Registra los datos de contacto de los dueños de los inmuebles.
* **Campos clave:** `id_propietario (PK)`, `email (UNIQUE)`.

### 2. Tabla: `alojamientos`
* Contiene el catálogo físico, características operativas y precio por noche de las propiedades.
* **Relación:** Vinculado fuertemente a un dueño mediante `id_propietario (FK)` con propiedad `ON DELETE CASCADE`.

### 3. Tabla: `huespedes`
* Almacena el perfil técnico e identificación nacional/internacional de los clientes.
* **Campos clave:** `id_huesped (PK)`, `email (UNIQUE)`.

### 4. Tabla: `reservas`
* Modula las fechas de estadía, transacciones brutas y estados de flujo de la ocupación.
* **Relaciones:** Vincula de forma compuesta a un `id_alojamiento (FK)` y a un `id_huesped (FK)`. Cuenta con restricción `CHECK (fecha_salida > fecha_entrada)`.

### 5. Tabla: `pagos`
* Controla las transacciones monetarias netas procesadas por pasarelas externas.
* **Relación:** Depende enteramente de un registro de alquiler mediante `id_reserva (FK)`.

### 6. Tabla: `resenas`
* Histórico cualitativo y cuantitativo sobre la experiencia del usuario.
* **Relación:** Conexión triple vía FK con `alojamientos`, `huespedes` y `reservas`. Control numérico mediante `CHECK (calificacion BETWEEN 1 AND 5)`.

---

## 📂 Contenido del Archivo SQL (`consultas_sql.sql`)

El script está segmentado y comentado minuciosamente para ser ejecutado de forma secuencial sin dependencias rotas, abarcando:
1. **Sección CRUD (Consultas 01 a 10):** Mutaciones directas de datos mediante `INSERT`, transformaciones dinámicas con `UPDATE`, filtros directos en `SELECT` empleando rangos (`BETWEEN`), y eliminaciones lógicas/físicas con `DELETE`.
2. **Sección Relacional Avanzada (Consultas 11 a 20):** Manipulación de consultas cruzadas usando `INNER JOIN` múltiple, control de valores nulos con `LEFT JOIN`, funciones de agregación (`SUM`, `AVG`, `COUNT`), segmentaciones de grupos condicionales (`GROUP BY` + `HAVING`), y resolución de lógicas dinámicas con Subconsultas (`Subquery`).
