CREATE DATABASE "Vitalygt"

CREATE TABLE seguro_medico (
  no_poliza varchar(50) PRIMARY KEY,
  empresa varchar(100),
  estado boolean,
  porcentaje decimal(10,2)
);

CREATE TABLE pacientes (
  dpi varchar(13) PRIMARY KEY,
  nombre varchar(50),
  apellido varchar(50),
  fecha_nacimiento date,
  correo varchar(50),
  telefono varchar(15),
  direccion varchar(200),
  genero varchar(10),
  no_poliza varchar(50),
  FOREIGN KEY (no_poliza) REFERENCES seguro_medico(no_poliza)
);

CREATE TABLE historial_clinico (
  id_historial SERIAL PRIMARY KEY,
  cirugias_previas varchar(300),
  medicamentos_pasados varchar(100),
  medicamentos_actuales varchar(100),
  alergias varchar(200),
  id_medico integer,
  dpi varchar(13),
  id_resultado integer,
  FOREIGN KEY (dpi) REFERENCES pacientes(dpi),
  FOREIGN KEY (id_medico) REFERENCES medico(id_medico),
  FOREIGN KEY (id_resultado) REFERENCES resultado_analisis(id_resultado)
);

CREATE TABLE medico (
  id_medico SERIAL PRIMARY KEY,
  nombre varchar(50),
  apellido varchar(50),
  telefono varchar(50),
  direccion varchar(200),
  genero varchar(10),
  correo varchar(60),
  especialidad varchar(50)
);

CREATE TABLE servicios (
  no_factura SERIAL PRIMARY KEY,
  nit integer,
  fecha date,
  total decimal(11,2),
  id_pago integer,
  dpi varchar(13),
  id_detalle integer,
  estado varchar(20),
  FOREIGN KEY (dpi) REFERENCES pacientes(dpi),
  FOREIGN KEY (id_pago) REFERENCES forma_pago(id_pago),
  FOREIGN KEY (id_detalle) REFERENCES detalle_servicio(id_detalle)
);

CREATE TABLE forma_pago (
  id_pago SERIAL PRIMARY KEY,
  tipo_pago varchar(30)
);

CREATE TABLE detalle_servicio (
  id_detalle SERIAL PRIMARY KEY,
  subtotal decimal(11,2),
  cantidad float,
  descripcion varchar(150),
  precio_unitario decimal(11,2),
  id_resultado integer,
  id_clinica integer,
  id_analisis integer,
  FOREIGN KEY (id_resultado) REFERENCES resultado_analisis(id_resultado),
  FOREIGN KEY (id_clinica) REFERENCES clinicas(id_clinica),
  FOREIGN KEY (id_analisis) REFERENCES analisis(id_analisis)
);

CREATE TABLE analisis (
  id_analisis SERIAL PRIMARY KEY,
  precio decimal(11,2),
  nombre_analisis varchar(50),
  tiempo_entrega float,
  estado boolean
);

CREATE TABLE clinicas (
  id_clinica SERIAL PRIMARY KEY,
  direccion varchar(200),
  nombre_clinica varchar(200),
  telefono varchar(15),
  encargado varchar(200)
);

CREATE TABLE resultado_analisis (
  id_resultado SERIAL PRIMARY KEY,
  resultado varchar(300),
  fecha_realizacion date,
  rango_referencias varchar(25),
  fecha_entrega date,
  metodologia varchar(300),
  observaciones varchar(300),
  id_laboratorista integer,
  FOREIGN KEY (id_laboratorista) REFERENCES laboratorista(id_laboratorista)
);

CREATE TABLE laboratorista (
  id_laboratorista SERIAL PRIMARY KEY,
  nombre varchar(50),
  apellido varchar(50),
  direccion varchar(200),
  genero varchar(10),
  especialidad varchar(50),
  telefono varchar(50),
  correo varchar(50)
);


INSERT INTO analisis (nombre_analisis, precio, tiempo_entrega, estado)
VALUES 
('Análisis de sangre', 100.00, 1.5, true),  -- 1.5 días
('Análisis de orina', 50.00, 1.0, true),   -- 1.0 días
('Análisis de heces', 125.00, 2.0, true),  -- 2.0 días
('Cultivos microbiológicos', 175.00, 3.5, true),  -- 3.5 días
('Pruebas de diagnóstico molecular', 200.00, 4.0, true),  -- 4.0 días
('Pruebas de imagenología', 300.00, 2.5, true),  -- 2.5 días
('Pruebas de diagnóstico especializado', 500.00, 5.0, true),  -- 5.0 días
('Pruebas de alergia', 175.00, 3.0, true),  -- 3.0 días
('Pruebas de función tiroidea', 100.00, 2.0, true),  -- 2.0 días
('Pruebas de ETS', 125.00, 2.5, true);  -- 2.5 días

INSERT INTO seguro_medico (no_poliza, empresa, estado, porcentaje)
VALUES
('P00001', 'Seguro Universal', true, 85.50),
('P00002', 'Seguro Vida', true, 75.25),
('P00003', 'Salud Total', false, 65.00),
('P00004', 'Vida Segura', true, 80.00),
('P00005', 'Salud y Vida', true, 90.50),
('P00006', 'Protección Salud', true, 88.75),
('P00007', 'Seguro Protegido', false, 70.00),
('P00008', 'Vida y Salud', true, 95.00),
('P00009', 'Salud Plena', true, 60.50),
('P00010', 'Vida Plena', true, 78.25),
('P00011', 'Salud Familiar', false, 68.75),
('P00012', 'Protección Total', true, 92.00),
('P00013', 'Vida Integral', true, 85.00),
('P00014', 'Salud Integral', true, 88.50),
('P00015', 'Protección Vida', false, 77.00);

INSERT INTO pacientes (dpi, nombre, apellido, fecha_nacimiento, correo, telefono, direccion, genero, no_poliza)
VALUES
('1234567890123', 'Juan', 'Perez', '1980-01-01', 'juan.perez@example.com', '5551234', '1234 Main St', 'M', 'P00001'),
('2345678901234', 'Maria', 'Lopez', '1985-02-02', 'maria.lopez@example.com', '5555678', '5678 Elm St', 'F', 'P00002'),
('3456789012345', 'Carlos', 'Gonzalez', '1990-03-03', 'carlos.gonzalez@example.com', '5559101', '9101 Oak St', 'M', 'P00003'),
('4567890123456', 'Ana', 'Martinez', '1995-04-04', 'ana.martinez@example.com', '5552345', '2345 Pine St', 'F', 'P00004'),
('5678901234567', 'Luis', 'Rodriguez', '2000-05-05', 'luis.rodriguez@example.com', '5556789', '6789 Maple St', 'M', 'P00005'),
('6789012345678', 'Sofia', 'Hernandez', '2005-06-06', 'sofia.hernandez@example.com', '5550123', '0123 Cedar St', 'F', 'P00006'),
('7890123456789', 'Jose', 'Ramirez', '2010-07-07', 'jose.ramirez@example.com', '5553456', '3456 Birch St', 'M', 'P00007'),
('8901234567890', 'Laura', 'Diaz', '2015-08-08', 'laura.diaz@example.com', '5557890', '7890 Spruce St', 'F', 'P00008'),
('9012345678901', 'Miguel', 'Torres', '1975-09-09', 'miguel.torres@example.com', '5551235', '1235 Fir St', 'M', 'P00009'),
('0123456789012', 'Lucia', 'Sanchez', '1982-10-10', 'lucia.sanchez@example.com', '5555679', '5679 Aspen St', 'F', 'P00010'),
('1234567890124', 'Jorge', 'Ramirez', '1994-11-11', 'jorge.ramirez@example.com', '5559102', '9102 Redwood St', 'M', 'P00011'),
('2345678901235', 'Valeria', 'Gomez', '1988-12-12', 'valeria.gomez@example.com', '5552346', '2346 Cypress St', 'F', 'P00012'),
('3456789012346', 'Roberto', 'Fernandez', '1979-01-13', 'roberto.fernandez@example.com', '5556780', '6780 Magnolia St', 'M', 'P00013'),
('4567890123457', 'Elena', 'Morales', '1987-02-14', 'elena.morales@example.com', '5550124', '0124 Willow St', 'F', 'P00014'),
('5678901234568', 'Pablo', 'Cruz', '1996-03-15', 'pablo.cruz@example.com', '5553457', '3457 Palm St', 'M', 'P00015');

INSERT INTO medico (nombre, apellido, telefono, direccion, genero, correo, especialidad)
VALUES
('Dr. Juan', 'Martinez', '5550001', '1234 Doctor St', 'M', 'juan.martinez@example.com', 'Cardiología'),
('Dra. Maria', 'Perez', '5550002', '5678 Doctor St', 'F', 'maria.perez@example.com', 'Neurología'),
('Dr. Carlos', 'Lopez', '5550003', '9101 Doctor St', 'M', 'carlos.lopez@example.com', 'Ortopedia'),
('Dra. Ana', 'Gonzalez', '5550004', '2345 Doctor St', 'F', 'ana.gonzalez@example.com', 'Pediatría'),
('Dr. Luis', 'Rodriguez', '5550005', '6789 Doctor St', 'M', 'luis.rodriguez@example.com', 'Ginecología'),
('Dra. Sofia', 'Hernandez', '5550006', '0123 Doctor St', 'F', 'sofia.hernandez@example.com', 'Dermatología'),
('Dr. Jose', 'Ramirez', '5550007', '3456 Doctor St', 'M', 'jose.ramirez@example.com', 'Oncología'),
('Dra. Laura', 'Diaz', '5550008', '7890 Doctor St', 'F', 'laura.diaz@example.com', 'Endocrinología')
('Dr. Miguel', 'Torres', '5550009', '1235 Doctor St', 'M', 'miguel.torres@example.com', 'Urología'),
('Dra. Lucia', 'Sanchez', '5550010', '5679 Doctor St', 'F', 'lucia.sanchez@example.com', 'Oftalmología'),
('Dr. Jorge', 'Ramirez', '5550011', '9102 Doctor St', 'M', 'jorge.ramirez@example.com', 'Reumatología'),
('Dra. Valeria', 'Gomez', '5550012', '2346 Doctor St', 'F', 'valeria.gomez@example.com', 'Psiquiatría'),
('Dr. Roberto', 'Fernandez', '5550013', '6780 Doctor St', 'M', 'roberto.fernandez@example.com', 'Gastroenterología'),
('Dra. Elena', 'Morales', '5550014', '0124 Doctor St', 'F', 'elena.morales@example.com', 'Nefrología'),
('Dr. Pablo', 'Cruz', '5550015', '3457 Doctor St', 'M', 'pablo.cruz@example.com', 'Hematología');

INSERT INTO forma_pago (tipo_pago)
VALUES
('Efectivo'),
('Tarjeta de Crédito'),
('Tarjeta de Débito'),
('Transferencia Bancaria'),
('Cheque'),
('PayPal'),
('Bitcoin'),
('Ethereum'),
('Litecoin'),
('Apple Pay'),
('Google Pay'),
('Amazon Pay'),
('Samsung Pay'),
('Stripe'),
('Square');

INSERT INTO clinicas (direccion, nombre_clinica, telefono, encargado)
VALUES
('1234 Health St', 'Clínica Salud', '5551234', 'Dr. Juan Perez'),
('5678 Wellness St', 'Clínica Bienestar', '5555678', 'Dra. Maria Lopez'),
('9101 Care St', 'Clínica Cuidado', '5559101', 'Dr. Carlos Gonzalez'),
('2345 Health St', 'Clínica Vida', '5552345', 'Dra. Ana Martinez'),
('6789 Wellness St', 'Clínica Saludable', '5556789', 'Dr. Luis Rodriguez'),
('0123 Care St', 'Clínica Bienestar', '5550123', 'Dra. Sofia Hernandez'),
('3456 Health St', 'Clínica Salud Plena', '5553456', 'Dr. Jose Ramirez'),
('7890 Wellness St', 'Clínica Vida Plena', '5557890', 'Dra. Laura Diaz'),
('1235 Care St', 'Clínica Total', '5551235', 'Dr. Miguel Torres'),
('5679 Health St', 'Clínica Integral', '5555679', 'Dra. Lucia Sanchez'),
('9102 Wellness St', 'Clínica Avanzada', '5559102', 'Dr. Jorge Ramirez'),
('2346 Care St', 'Clínica Especializada', '5552346', 'Dra. Valeria Gomez'),
('6780 Health St', 'Clínica Completa', '5556780', 'Dr. Roberto Fernandez'),
('0124 Wellness St', 'Clínica Experta', '5550124', 'Dra. Elena Morales'),
('3457 Care St', 'Clínica Profesional', '5553457', 'Dr. Pablo Cruz');

INSERT INTO laboratorista (nombre, apellido, direccion, genero, especialidad, telefono, correo)
VALUES
('Alfredo', 'Gomez', '1234 Laboratorio St', 'M', 'Químico', '5550001', 'alfredo.gomez@example.com'),
('Beatriz', 'Martinez', '5678 Laboratorio St', 'F', 'Bióloga', '5550002', 'beatriz.martinez@example.com'),
('Carlos', 'Lopez', '9101 Laboratorio St', 'M', 'Bioquímico', '5550003', 'carlos.lopez@example.com'),
('Diana', 'Gonzalez', '2345 Laboratorio St', 'F', 'Microbióloga', '5550004', 'diana.gonzalez@example.com'),
('Eduardo', 'Perez', '6789 Laboratorio St', 'M', 'Genetista', '5550005', 'eduardo.perez@example.com'),
('Fernanda', 'Rodriguez', '0123 Laboratorio St', 'F', 'Hematóloga', '5550006', 'fernanda.rodriguez@example.com'),
('Guillermo', 'Hernandez', '3456 Laboratorio St', 'M', 'Parasitólogo', '5550007', 'guillermo.hernandez@example.com'),
('Helena', 'Diaz', '7890 Laboratorio St', 'F', 'Immunóloga', '5550008', 'helena.diaz@example.com'),
('Ignacio', 'Torres', '1235 Laboratorio St', 'M', 'Epidemiólogo', '5550009', 'ignacio.torres@example.com'),
('Julieta', 'Sanchez', '5679 Laboratorio St', 'F', 'Bacterióloga', '5550010', 'julieta.sanchez@example.com'),
('Kevin', 'Ramirez', '9102 Laboratorio St', 'M', 'Técnico de Laboratorio', '5550011', 'kevin.ramirez@example.com'),
('Laura', 'Gomez', '2346 Laboratorio St', 'F', 'Analista Clínico', '5550012', 'laura.gomez@example.com'),
('Miguel', 'Fernandez', '6780 Laboratorio St', 'M', 'Bioestadístico', '5550013', 'miguel.fernandez@example.com'),
('Natalia', 'Morales', '0124 Laboratorio St', 'F', 'Química Analítica', '5550014', 'natalia.morales@example.com'),
('Oscar', 'Cruz', '3457 Laboratorio St', 'M', 'Investigador Biomédico', '5550015', 'oscar.cruz@example.com');

INSERT INTO resultado_analisis (resultado, fecha_realizacion, rango_referencias, fecha_entrega, metodologia, observaciones, id_laboratorista)
VALUES
('Normal', '2023-01-01', '4-6', '2023-01-02', 'Método 1', 'Ninguna', 1),
('Anormal', '2023-02-02', '3-5', '2023-02-03', 'Método 2', 'Revisar', 2),
('Normal', '2023-03-03', '4-6', '2023-03-04', 'Método 3', 'Ninguna', 3),
('Anormal', '2023-04-04', '2-4', '2023-04-05', 'Método 4', 'Revisar', 4),
('Normal', '2023-05-05', '3-5', '2023-05-06', 'Método 5', 'Ninguna', 5),
('Anormal', '2023-06-06', '4-6', '2023-06-07', 'Método 6', 'Revisar', 6),
('Normal', '2023-07-07', '3-5', '2023-07-08', 'Método 7', 'Ninguna', 7),
('Anormal', '2023-08-08', '2-4', '2023-08-09', 'Método 8', 'Revisar', 8),
('Normal', '2023-09-09', '4-6', '2023-09-10', 'Método 9', 'Ninguna', 9),
('Anormal', '2023-10-10', '3-5', '2023-10-11', 'Método 10', 'Revisar', 10),
('Normal', '2023-11-11', '4-6', '2023-11-12', 'Método 11', 'Ninguna', 11),
('Anormal', '2023-12-12', '3-5', '2023-12-13', 'Método 12', 'Revisar', 12),
('Normal', '2023-01-13', '4-6', '2023-01-14', 'Método 13', 'Ninguna', 13),
('Anormal', '2023-02-14', '2-4', '2023-02-15', 'Método 14', 'Revisar', 14),
('Normal', '2023-03-15', '3-5', '2023-03-16', 'Método 15', 'Ninguna', 15);

INSERT INTO historial_clinico (cirugias_previas, medicamentos_pasados, medicamentos_actuales, alergias, id_medico, dpi, id_resultado)
VALUES
('Apendicectomía', 'Ibuprofeno', 'Paracetamol', 'Ninguna', 1, '1234567890123', 1),
('Cesárea', 'Amoxicilina', 'Ibuprofeno', 'Penicilina', 2, '2345678901234', 2),
('Cirugía de rodilla', 'Diclofenaco', 'Naproxeno', 'Ninguna', 3, '3456789012345', 3),
('Bypass gástrico', 'Metformina', 'Lisinopril', 'Ninguna', 4, '4567890123456', 4),
('Colecistectomía', 'Omeprazol', 'Atenolol', 'Ninguna', 5, '5678901234567', 5),
('Cirugía de columna', 'Tramadol', 'Gabapentina', 'Ninguna', 6, '6789012345678', 6),
('Cirugía cardíaca', 'Enalapril', 'Losartán', 'Ninguna', 7, '7890123456789', 7),
('Histerectomía', 'Clonazepam', 'Sertralina', 'Ninguna', 8, '8901234567890', 8),
('Cirugía de hombro', 'Ketorolaco', 'Meloxicam', 'Ninguna', 9, '9012345678901', 9),
('Cirugía de cadera', 'Prednisona', 'Metotrexato', 'Ninguna', 10, '0123456789012', 10),
('Apendicectomía', 'Ibuprofeno', 'Paracetamol', 'Ninguna', 11, '1234567890124', 11),
('Cesárea', 'Amoxicilina', 'Ibuprofeno', 'Penicilina', 12, '2345678901235', 12),
('Cirugía de rodilla', 'Diclofenaco', 'Naproxeno', 'Ninguna', 13, '3456789012346', 13),
('Bypass gástrico', 'Metformina', 'Lisinopril', 'Ninguna', 14, '4567890123457', 14),
('Colecistectomía', 'Omeprazol', 'Atenolol', 'Ninguna', 15, '5678901234568', 15);

INSERT INTO detalle_servicio (subtotal, cantidad, descripcion, precio_unitario, id_resultado, id_clinica, id_analisis)
VALUES
(25.00, 1.0, 'Análisis de sangre', 25.00, 1, 1, 1),
(75.00, 1.0, 'Análisis de orina', 75.00, 2, 2, 2),
(150.00, 1.0, 'Análisis de heces', 150.00, 3, 3, 3),
(175.00, 1.0, 'Cultivos microbiológicos', 175.00, 4, 4, 4),
(200.00, 1.0, 'Pruebas de diagnóstico molecular', 200.00, 5, 5, 5),
(125.00, 1.0, 'Pruebas de imagenología', 125.00, 6, 6, 6),
(300.00, 1.0, 'Pruebas de diagnóstico especializado', 300.00, 7, 7, 7),
(150.00, 1.0, 'Pruebas de alergia', 150.00, 8, 8, 8),
(100.00, 1.0, 'Pruebas de función tiroidea', 100.00, 9, 9, 9),
(50.00, 1.0, 'Pruebas de ETS', 50.00, 10, 10, 10),
(200.00, 1.0, 'Pruebas de diagnóstico molecular', 200.00, 11, 11, 5),
(125.00, 1.0, 'Pruebas de imagenología', 125.00, 12, 12, 6),
(75.00, 1.0, 'Análisis de orina', 75.00, 13, 13, 2),
(50.00, 1.0, 'Pruebas de ETS', 50.00, 14, 14, 10),
(25.00, 1.0, 'Análisis de sangre', 25.00, 15, 15, 1);

INSERT INTO servicios (nit, fecha, total, id_pago, dpi, id_detalle, estado)
VALUES
(123456789, '2023-01-01', 150.00, 1, '1234567890123', 1, 'Completado'),
(234567890, '2023-02-02', 200.00, 2, '2345678901234', 2, 'Pendiente'),
(345678901, '2023-03-03', 250.00, 3, '3456789012345', 3, 'Completado'),
(456789012, '2023-04-04', 300.00, 4, '4567890123456', 4, 'Pendiente'),
(567890123, '2023-05-05', 350.00, 5, '5678901234567', 5, 'Completado'),
(678901234, '2023-06-06', 400.00, 6, '6789012345678', 6, 'Pendiente'),
(789012345, '2023-07-07', 450.00, 7, '7890123456789', 7, 'Completado'),
(890123456, '2023-08-08', 500.00, 8, '8901234567890', 8, 'Pendiente'),
(901234567, '2023-09-09', 550.00, 9, '9012345678901', 9, 'Completado'),
(123456780, '2023-10-10', 600.00, 10, '0123456789012', 10, 'Pendiente'),
(234567891, '2023-11-11', 650.00, 11, '1234567890124', 11, 'Completado'),
(345678902, '2023-12-12', 700.00, 12, '2345678901235', 12, 'Pendiente'),
(456789013, '2023-01-13', 750.00, 13, '3456789012346', 13, 'Completado'),
(567890124, '2023-02-14', 800.00, 14, '4567890123457', 14, 'Pendiente'),
(678901235, '2023-03-15', 850.00, 15, '5678901234568', 15, 'Completado');

-- A. Realizar una consulta para obtener los servicios proveídos en enero de cualquier año
SELECT *
FROM servicios
WHERE EXTRACT(MONTH FROM fecha) = 1;

-- B. Realizar una consulta donde se indique las veces que se ha contratado cada servicio
SELECT id_analisis, COUNT(*) AS veces_contratado
FROM detalle_servicio
GROUP BY id_analisis;

--C. Realizar una consulta donde se indiquen los servicios cuyo estado no sea completado
SELECT *
FROM servicios
WHERE estado <> 'Completado';

--D. Realizar una consulta indicando los servicios/pruebas/exámenes realizados por cada profesional encargado de la prueba
SELECT l.nombre AS nombre_laboratorista, l.apellido AS apellido_laboratorista,
       r.nombre_analisis AS analisis_realizado
FROM resultado_analisis ra
JOIN laboratorista l ON ra.id_laboratorista = l.id_laboratorista
JOIN analisis r ON r.id_analisis = r.id_analisis;

--E. Indicar cuál es el servicio más vendido por clínica
WITH AnalisisPorClinica AS (
    SELECT c.id_clinica, a.nombre_analisis,
           ROW_NUMBER() OVER (PARTITION BY c.id_clinica ORDER BY COUNT(ds.id_analisis) DESC) AS ranking
    FROM clinicas c
    JOIN detalle_servicio ds ON c.id_clinica = ds.id_clinica
    JOIN analisis a ON ds.id_analisis = a.id_analisis
    GROUP BY c.id_clinica, a.nombre_analisis
)
SELECT c.nombre_clinica, ac.nombre_analisis AS analisis_mas_vendido
FROM clinicas c
JOIN AnalisisPorClinica ac ON c.id_clinica = ac.id_clinica
WHERE ac.ranking = 1;

--F. Indicar el monto total de los servicios completados por un rango de fechas
SELECT SUM(total) AS monto_total
FROM servicios
WHERE estado = 'Completado'
AND fecha BETWEEN '2020-01-01' AND '2024-06-01';

--G. Realizar una consulta que devuelva la cantidad de servicios completados por mes
SELECT DATE_TRUNC('month', fecha) AS mes,
       COUNT(*) AS cantidad_servicios_completados
FROM servicios
WHERE estado = 'Completado'
GROUP BY mes
ORDER BY mes;

--H. Realizar una consulta que devuelva el monto de los servicios divididos en montos pagados por el cliente y montos pagados por el seguro
SELECT
    SUM(CASE WHEN dpi IS NOT NULL THEN total ELSE 0 END) AS monto_cliente,
    SUM(CASE WHEN dpi IS NULL THEN total ELSE 0 END) AS monto_seguro
FROM servicios;

--I. Realizar una consulta del porcentaje pagado por el paciente y el porcentaje pagado por los seguros en un rango de fechas
WITH total_porcentaje AS (
    SELECT
        SUM(CASE WHEN dpi IS NOT NULL THEN total ELSE 0 END) AS total_cliente,
        SUM(CASE WHEN dpi IS NULL THEN total ELSE 0 END) AS total_seguro
    FROM servicios
    WHERE fecha BETWEEN '2022-01-01' AND '2024-06-01'
)
SELECT
    total_cliente / (total_cliente + total_seguro) * 100 AS porcentaje_cliente,
    total_seguro / (total_cliente + total_seguro) * 100 AS porcentaje_seguro
FROM total_porcentaje;

--J. Realizar un resumen de los servicios indicando para ello el nombre del paciente, la fecha de completado, el monto y si viene referido por algún médico o no
SELECT
    p.nombre || ' ' || p.apellido AS paciente,
    ra.fecha_entrega AS fecha_completado,
    s.total AS monto,
    CASE 
        WHEN h.dpi IS NOT NULL THEN 'Referido por médico'
        ELSE 'No referido'
    END AS referido_por_medico
FROM servicios s
JOIN pacientes p ON s.dpi = p.dpi
JOIN resultado_analisis ra ON s.id_detalle = ra.id_resultado
LEFT JOIN historial_clinico h ON p.dpi = h.dpi
WHERE s.estado = 'Completado';

--K. Actualizar el valor de los servicios en un 2%
UPDATE analisis
SET precio = precio * 1.02;

--L. Actualizar el nombre de los servicios agregando el nombre en mayúsculas (todo el nombre)
UPDATE analisis
SET nombre_analisis = UPPER(nombre_analisis);

--M. Inactivar un servicio en específico
UPDATE analisis
SET estado = false
WHERE nombre_analisis = 'Pruebas de ETS';

--N. Indicar la última fecha en la que se vendió un servicio específico
SELECT MAX(fecha) AS ultima_fecha_venta
FROM servicios
JOIN detalle_servicio ON servicios.no_factura = detalle_servicio.id_detalle
JOIN analisis ON detalle_servicio.id_analisis = analisis.id_analisis
WHERE analisis.nombre_analisis = 'ANÁLISIS DE ORINA';

--O.Realizar una consulta que indique el tiempo más tardado de una prueba
SELECT nombre_analisis, MAX(tiempo_entrega) AS tiempo_mas_tardado
FROM analisis
GROUP BY nombre_analisis;

--P. Realizar una consulta que indique el nombre del doctor que tenga más referidos
SELECT m.nombre, COUNT(hc.dpi) AS cantidad_referidos
FROM medico m
JOIN historial_clinico hc ON m.id_medico = hc.id_medico
GROUP BY m.nombre
ORDER BY cantidad_referidos DESC
LIMIT 1;

--Q. Indicar una consulta que devuelva el seguro más utilizado
SELECT sm.empresa, COUNT(p.dpi) AS cantidad_pacientes
FROM seguro_medico sm
JOIN pacientes p ON sm.no_poliza = p.no_poliza
GROUP BY sm.empresa
ORDER BY cantidad_pacientes DESC
LIMIT 1;
