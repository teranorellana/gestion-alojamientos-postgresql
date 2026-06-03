-- 01. INSERT: Insertar propietario
-- Descripción: Agregar un nuevo propietario a la tabla.
INSERT INTO propietarios (nombre, apellido, email, telefono) 
VALUES ('Roberto', 'Flores', 'roberto.flores@email.com', '+503-7888-9999');

-- 02. INSERT: Insertar alojamiento
-- Descripción: Crear alojamiento vinculado al propietario recién creado (id_propietario = 6).
INSERT INTO alojamientos (id_propietario, nombre, descripcion, tipo, direccion, ciudad, pais, precio_noche, capacidad_personas, num_habitaciones, num_banos, activo) 
VALUES (6, 'Glamping Volcán de San Salvador', 'Tienda de lujo con vista al cráter', 'casa', 'Km 16 Carretera al Boquerón', 'San Salvador', 'El Salvador', 95.00, 2, 1, 1, true);

-- 03. INSERT: Huésped y reserva
-- Descripción: Registrar un nuevo huésped y su correspondiente reserva.
INSERT INTO huespedes (nombre, apellido, email, telefono, nacionalidad) 
VALUES ('Carlos', 'Gomez', 'carlos.gomez@email.com', '+503-6001-2233', 'El Salvador');

INSERT INTO reservas (id_alojamiento, id_huesped, fecha_entrada, fecha_salida, num_personas, precio_total, estado) 
VALUES (11, 11, '2026-07-10', '2026-07-12', 2, 190.00, 'confirmada');

-- 04. INSERT: Insertar pago
-- Descripción: Registrar el pago asociado a la reserva creada anteriormente (id_reserva = 15).
INSERT INTO pagos (id_reserva, monto, metodo_pago, estado_pago) 
VALUES (15, 190.00, 'tarjeta', 'completado');

-- 05. SELECT: Alojamientos activos
-- Descripción: Filtrar solo los alojamientos que se encuentran con estado activo de disponibilidad.
SELECT id_alojamiento, nombre, ciudad, precio_noche 
FROM alojamientos 
WHERE activo = true;

-- 06. SELECT: Huéspedes por país
-- Descripción: Filtrar huéspedes según una nacionalidad específica (Ej: Estados Unidos).
SELECT id_huesped, nombre, apellido, email, nacionalidad 
FROM huespedes 
WHERE nacionalidad = 'Estados Unidos';

-- 07. SELECT: Reservas por fechas
-- Descripción: Uso de operador BETWEEN para filtrar reservas según rangos temporales de entrada.
SELECT id_reserva, id_alojamiento, fecha_entrada, fecha_salida, precio_total 
FROM reservas 
WHERE fecha_entrada BETWEEN '2025-07-01' AND '2025-08-31';

-- 08. UPDATE: Actualizar precio
-- Descripción: Modificar el precio por noche de un alojamiento específico.
UPDATE alojamientos 
SET precio_noche = 135.00 
WHERE id_alojamiento = 2;

-- 09. UPDATE: Estado reserva
-- Descripción: Actualizar el estado de una reserva específica de la base de datos.
UPDATE reservas 
SET estado = 'completada' 
WHERE id_reserva = 14;

-- 10. DELETE: Eliminar reseña
-- Descripción: DELETE WHERE para remover un registro específico de reseñas.
DELETE FROM resenas 
WHERE id_resena = 7;


-- 11. JOIN: Reservas + huésped
-- Descripción: INNER JOIN para listar las reservas junto con el nombre del huésped.
SELECT 
    r.id_reserva, 
    CONCAT(h.nombre, ' ', h.apellido) AS nombre_huesped, 
    r.fecha_entrada, 
    r.fecha_salida, 
    r.precio_total
FROM reservas r
INNER JOIN huespedes h ON r.id_huesped = h.id_huesped;


-- 12. JOIN: Alojamiento completo
-- Descripción: INNER JOIN múltiple para conectar reservas, alojamientos y propietarios.
SELECT 
    r.id_reserva, 
    a.nombre AS nombre_alojamiento, 
    a.ciudad,
    CONCAT(p.nombre, ' ', p.apellido) AS nombre_propietario
FROM reservas r
INNER JOIN alojamientos a ON r.id_alojamiento = a.id_alojamiento
INNER JOIN propietarios p ON a.id_propietario = p.id_propietario;


-- 13. JOIN: Pagos + reservas
-- Descripción: JOIN combinado para ver el detalle de cada pago con las fechas de su reserva.
SELECT 
    p.id_pago, 
    p.monto, 
    p.metodo_pago, 
    r.fecha_entrada, 
    r.fecha_salida
FROM pagos p
INNER JOIN reservas r ON p.id_reserva = r.id_reserva;


-- 14. LEFT JOIN: Sin reseñas
-- Descripción: Incluye nulls para identificar qué alojamientos NO han recibido comentarios todavía.
SELECT 
    a.id_alojamiento, 
    a.nombre AS alojamiento, 
    re.comentario
FROM alojamientos a
LEFT JOIN resenas re ON a.id_alojamiento = re.id_alojamiento
WHERE re.id_resena IS NULL;


-- 15. LEFT JOIN: Sin reservas
-- Descripción: Filtrar nulls usando LEFT JOIN para encontrar alojamientos que nunca han sido reservados.
SELECT 
    a.id_alojamiento, 
    a.nombre AS alojamiento, 
    a.ciudad
FROM alojamientos a
LEFT JOIN reservas r ON a.id_alojamiento = r.id_alojamiento
WHERE r.id_reserva IS NULL;


-- 16. AGG: Total ingresos
-- Descripción: Uso de la función SUM para calcular el dinero total recaudado en pagos completados.
SELECT 
    SUM(monto) AS total_ingresos_recaudados 
FROM pagos 
WHERE estado_pago = 'completado';


-- 17. AGG: Promedio rating
-- Descripción: Uso de la función AVG para obtener la calificación promedio general de la plataforma.
SELECT 
    ROUND(AVG(calificacion), 2) AS promedio_rating_general 
FROM resenas;


-- 18. AGG: Top alojamientos
-- Descripción: Uso de COUNT + LIMIT para descubrir las 3 propiedades con más cantidad de reservas.
SELECT 
    a.nombre AS alojamiento, 
    COUNT(r.id_reserva) AS total_reservas
FROM alojamientos a
INNER JOIN reservas r ON a.id_alojamiento = r.id_alojamiento
GROUP BY a.id_alojamiento, a.nombre
ORDER BY total_reservas DESC
LIMIT 3;


-- 19. HAVING: Más de 3 reservas
-- Descripción: Agrupación con GROUP BY y filtrado estricto con HAVING para ver clientes frecuentes.
SELECT 
    h.id_huesped, 
    CONCAT(h.nombre, ' ', h.apellido) AS huesped, 
    COUNT(r.id_reserva) AS cantidad_reservas
FROM huespedes h
INNER JOIN reservas r ON h.id_huesped = r.id_huesped
GROUP BY h.id_huesped, h.nombre, h.apellido
HAVING COUNT(r.id_reserva) >= 2; -- Nota: Se ajusta a >= 2 porque en los datos muestra máximos de 2 por usuario.


SELECT * FROM public.alojamientos;
-- 20. Subconsulta: Alojamiento más caro
-- Descripción: Uso de una subquery para encontrar de forma dinámica la propiedad con el precio por noche más alto.
SELECT 
    a.id_alojamiento, 
    a.nombre AS alojamiento_mas_caro, 
    a.ciudad, 
    a.precio_noche
FROM alojamientos a
WHERE a.precio_noche = (SELECT MAX(precio_noche) FROM alojamientos


