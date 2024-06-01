-- Tabla Seguro Médico
CREATE TABLE Seguro_Medico (
    No_poliza VARCHAR(50) PRIMARY KEY,
    Empresa VARCHAR(255),
    estado boolean,
    porcentaje DECIMAL(11,2)
);

-- Tabla Paciente
CREATE TABLE Paciente (
    DPI VARCHAR(13) PRIMARY KEY,
    nombre VARCHAR(30),
    apellido VARCHAR(30),
    genero VARCHAR(15),
    direccion VARCHAR(50),
    fecha_nacimiento DATE,
    telefono VARCHAR(50),
    correo VARCHAR(50),
    No_poliza VARCHAR(50),
    FOREIGN key (No_poliza) REFERENCES Seguro_Medico(No_poliza) 
);

-- Tabla Historial Clínico
CREATE TABLE Historial_Clinico (
    id_historial SERIAL PRIMARY KEY NOT NULL,
    enfermedades_pasadas VARCHAR(100),
    alergias VARCHAR(100),
    cirugias_previas VARCHAR(100),
    medicamentos_pasados VARCHAR(100),
    medicamentos_actuales VARCHAR(100),
    dpi VARCHAR(13),
    Id_medico INTEGER,
    FOREIGN key (dpi)  REFERENCES Paciente(DPI), 
    FOREIGN key (Id_medico)  REFERENCES Medico(Id_medico) 
);

-- Tabla Contacto Médico
CREATE TABLE Medico (
    Id_medico SERIAL PRIMARY KEY NOT NULL,
    nombre_medico VARCHAR(30),
    apellido_medico VARCHAR(30),
    telefono_medico VARCHAR(20),
    direccion_medico VARCHAR(200),
    genero_medico VARCHAR(20),
    correo_medico VARCHAR(50),
    especialidad VARCHAR(100)
);

-- Forma de Pago
CREATE TABLE Forma_de_pago(
    id_pago SERIAL PRIMARY KEY,
    tipo_pago VARCHAR(30)
);

-- Tabla servicios
CREATE TABLE serivicios (
    No_factura SERIAL PRIMARY KEY NOT NULL,
    NIT INT,
    fecha DATE,
    total DECIMAL(11,2),
    id_pago INTEGER,
    DPI VARCHAR(13),
    id_detalle_servicio INTEGER,
    FOREIGN key (id_pago) REFERENCES Forma_de_pago(id_pago), 
    FOREIGN key (DPI) REFERENCES Paciente(DPI), 
    FOREIGN key (id_detalle_servicio) REFERENCES detalle_servicio(id_detalle_servicio) 
    );

--Tabla detalle servicio
CREATE TABLE detalle_servicio(
    id_detalle_servicio SERIAL PRIMARY KEY,
    subtotal DECIMAL(11,2),
    cantidad FLOAT,
    descripcion VARCHAR(150),
    precio_unitario DECIMAL(11,2),
    id_resultado INTEGER,
    id_clinica INTEGER,
    id_analisis INTEGER,
    FOREIGN key (id_resultado)  REFERENCES Resultado(id_resultado), 
    FOREIGN key (id_clinica)  REFERENCES clinica(id_clinica), 
    FOREIGN key (id_analisis)  REFERENCES analisis(id_analisis) 
);

-- Tabla laboratorio
CREATE TABLE clinica (
    id_clinica SERIAL PRIMARY KEY,
    nombre_clinica VARCHAR(60),
    direccion_clinica VARCHAR(60),
    telefono_clinica VARCHAR(20),
    nombre_encargado VARCHAR(255)
);

--Tabla analisis
CREATE TABLE analisis(
    id_analisis SERIAL NOT NULL PRIMARY KEY,
    precio DECIMAL(11,2),
    nombre_analisis VARCHAR(50),
    tiempo_entrega FLOAT,
    estado_analisis boolean
);

-- Tabla Laboratorista 
CREATE TABLE Laboratorista(
    id_laboratorista SERIAL PRIMARY KEY ,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    direccion VARCHAR(200),
    genero VARCHAR(10),
    especialidad VARCHAR(50),
    telefono VARCHAR(50),
    correo VARCHAR(50)
);

-- Tabla Factura
CREATE TABLE Resultado (
    id_resultado SERIAL PRIMARY KEY NOT NULL,
    resultado_analisis VARCHAR(300),
    fecha_realizacion DATE,
    rango_referencias VARCHAR(25),
    fecha_entrega DATE,
    metodologia VARCHAR(300),
    observaciones VARCHAR(1000),
    id_laboratorista INTEGER,
    FOREIGN key (id_laboratorista) REFERENCES Laboratorista(id_laboratorista)
);

-- Insertar datos en la tabla Forma_de_pago
INSERT INTO Forma_de_pago (tipo_pago)
VALUES 
('Tarjeta de crédito'),
('Transferencia bancaria'),
('Efectivo'),
('Cheque');

-- Insertar datos en la tabla Medico
INSERT INTO Medico (nombre_medico, apellido_medico, telefono_medico, direccion_medico, genero_medico, correo_medico, especialidad)
VALUES 
('Dr. Juan', 'González', '111-1111', 'Calle Principal 123', 'Masculino', 'juan@example.com', 'Pediatría'),
('Dra. María', 'López', '222-2222', 'Avenida Central 456', 'Femenino', 'maria@example.com', 'Ginecología'),
('Dr. Pedro', 'Martínez', '333-3333', 'Calle Secundaria 789', 'Masculino', 'pedro@example.com', 'Cardiología'),
('Dra. Ana', 'García', '444-4444', 'Avenida Principal 1011', 'Femenino', 'ana@example.com', 'Dermatología');

-- Insertar datos en la tabla clinica
INSERT INTO clinica (nombre_clinica, direccion_clinica, telefono_clinica, nombre_encargado)
VALUES 
('Clínica ABC', 'Calle Principal 123', '555-5555', 'Dr. Rodríguez'),
('Hospital XYZ', 'Avenida Central 456', '666-6666', 'Dr. Pérez'),
('Centro Médico 123', 'Calle Secundaria 789', '777-7777', 'Dr. Gómez'),
('Hospital Municipal', 'Avenida Principal 1011', '888-8888', 'Dr. Hernández');

-- Insertar datos en la tabla Paciente
INSERT INTO Paciente (DPI, nombre, apellido, genero, direccion, fecha_nacimiento, telefono, correo, No_poliza)
VALUES 
('1234567891011', 'Juan', 'Pérez', 'Masculino', 'Calle 123, Ciudad', '1990-05-15', '555-5555', 'juan@example.com', '12345'),
('9876543210123', 'María', 'Gómez', 'Femenino', 'Avenida ABC, Pueblo', '1985-08-20', '444-4444', 'maria@example.com', '67890'),
('1357924681012', 'Pedro', 'López', 'Masculino', 'Carretera X, Villa', '1978-03-10', '333-3333', 'pedro@example.com', '54321'),
('2468013579101', 'Ana', 'Martínez', 'Femenino', 'Avenida YZ, Colonia', '2000-12-28', '222-2222', 'ana@example.com', '09876'),
('1111222233344', 'Luis', 'Hernández', 'Masculino', 'Calle Z, Barrio', '1995-07-18', '111-1111', 'luis@example.com', '13579'),
('2233445566778', 'Laura', 'Sánchez', 'Femenino', 'Avenida DEF, Comunidad', '1982-11-30', '999-9999', 'laura@example.com', '24680'),
('3344556677889', 'Carlos', 'García', 'Masculino', 'Calle MNO, Sector', '1973-09-25', '888-8888', 'carlos@example.com', '97531'),
('4455667788990', 'Sofía', 'Díaz', 'Femenino', 'Carretera PQR, Aldea', '1998-02-14', '777-7777', 'sofia@example.com', '86420'),
('5566778899001', 'Eduardo', 'Rodríguez', 'Masculino', 'Avenida STU, Urbanización', '1989-06-05', '666-6666', 'eduardo@example.com', '11111'),
('6677889900112', 'Patricia', 'Fernández', 'Femenino', 'Calle VWX, Residencial', '1993-04-03', '333-3333', 'patricia@example.com', '22222'),
('7788990011223', 'Mario', 'Gutiérrez', 'Masculino', 'Carretera YZ, Conjunto', '1976-10-12', '555-5555', 'mario@example.com', '33333'),
('8899001122334', 'Diana', 'López', 'Femenino', 'Avenida 123, Complejo', '2002-07-22', '444-4444', 'diana@example.com', '44444'),
('9900112233445', 'Roberto', 'Alvarez', 'Masculino', 'Calle 456, Lote', '1987-08-17', '777-7777', 'roberto@example.com', '55555'),
('0011223344556', 'Carolina', 'Rivera', 'Femenino', 'Avenida 789, Quinta', '1991-12-08', '888-8888', 'carolina@example.com', '66666'),
('1122334455667', 'Jorge', 'Méndez', 'Masculino', 'Carretera 1011, Parcela', '1979-05-03', '999-9999', 'jorge@example.com', '77777');


-- Insertar datos en la tabla Historial_Clinico
INSERT INTO Historial_Clinico (enfermedades_pasadas, alergias, cirugias_previas, medicamentos_pasados, medicamentos_actuales, dpi, Id_medico)
VALUES 
('Hipertensión', 'Polen', 'Apendicectomía', 'Ibuprofeno', 'Ninguno', '1234567891011', 1),
('Asma', 'Ninguna', 'Ninguna', 'Ninguno', 'Salbutamol', '9876543210123', 2),
('Diabetes', 'Ácaros', 'Ninguna', 'Insulina', 'Metformina', '1357924681012', 3),
('Colesterol alto', 'Polvo', 'Ninguna', 'Atorvastatina', 'Ninguno', '2468013579101', 4),
('Ninguna', 'Ninguna', 'Ninguna', 'Ninguno', 'Ninguno', '1111222233344', 4),
('Ninguna', 'Ninguna', 'Ninguna', 'Ninguno', 'Ninguno', '2233445566778', 3),
('Ninguna', 'Ninguna', 'Ninguna', 'Ninguno', 'Ninguno', '3344556677889', 2),
('Ninguna', 'Ninguna', 'Ninguna', 'Ninguno', 'Ninguno', '4455667788990', 1),
('Ninguna', 'Ninguna', 'Ninguna', 'Ninguno', 'Ninguno', '5566778899001', 2),
('Ninguna', 'Ninguna', 'Ninguna', 'Ninguno', 'Ninguno', '6677889900112', 3),
('Ninguna', 'Ninguna', 'Ninguna', 'Ninguno', 'Ninguno', '7788990011223', 2),
('Ninguna', 'Ninguna', 'Ninguna', 'Ninguno', 'Ninguno', '8899001122334', 1),
('Ninguna', 'Ninguna', 'Ninguna', 'Ninguno', 'Ninguno', '9900112233445', 3),
('Ninguna', 'Ninguna', 'Ninguna', 'Ninguno', 'Ninguno', '0011223344556', 4),
('Ninguna', 'Ninguna', 'Ninguna', 'Ninguno', 'Ninguno', '1122334455667', 4);

-- Insertar datos en la tabla serivicios
INSERT INTO serivicios (NIT, fecha, total, id_pago, DPI, id_detalle_servicio)
VALUES 
(123456789, '2024-05-01', 50.00, 1, '1234567891011', 1),
(987654321, '2024-05-02', 80.00, 2, '9876543210123', 2),
(246801357, '2024-05-03', 120.00, 3, '1357924681012', 3),
(111122223, '2024-05-04', 40.00, 4, '2468013579101', 4);

-- Insertar datos en la tabla Laboratorista
INSERT INTO Laboratorista (nombre, apellido, direccion, genero, especialidad, telefono, correo)
VALUES 
('Luis', 'Martínez', 'Calle Principal 123', 'Masculino', 'Laboratorio Clínico', '111-1111', 'luis@example.com'),
('Laura', 'Gómez', 'Avenida Central 456', 'Femenino', 'Microbiología', '222-2222', 'laura@example.com'),
('Carlos', 'Hernández', 'Calle Secundaria 789', 'Masculino', 'Biología Molecular', '333-3333', 'carlos@example.com'),
('Sofía', 'Pérez', 'Avenida Principal 1011', 'Femenino', 'Genética', '444-4444', 'sofia@example.com');

-- Insertar datos en la tabla Resultado
INSERT INTO Resultado (resultado_analisis, fecha_realizacion, rango_referencias, fecha_entrega, metodologia, observaciones, id_laboratorista)
VALUES 
('Normal', '2024-05-01', '10-50', '2024-05-02', 'Prueba de laboratorio', 'Sin observaciones', 1),
('Anormal', '2024-05-02', '20-80', '2024-05-03', 'Examen físico', 'Leve inflamación', 2),
('Normal', '2024-05-03', '0-1', '2024-05-04', 'Biopsia', 'Sin observaciones', 3),
('Anormal', '2024-05-04', '0-20', '2024-05-05', 'Prueba de laboratorio', 'Alta presencia de bacterias', 4);

-- Insertar datos en la tabla detalle_servicio
INSERT INTO detalle_servicio (subtotal, cantidad, descripcion, precio_unitario, id_resultado, id_clinica, id_analisis)
VALUES 
(50.00, 1.0, 'Análisis de sangre', 50.00, 1, 1, 1),
(80.00, 1.0, 'Ecografía abdominal', 80.00, 2, 2, 2),
(120.00, 1.0, 'Resonancia de cráneo', 120.00, 3, 3, 3),
(40.00, 1.0, 'Análisis de orina', 40.00, 4, 4, 4);


-- Insertar datos en la tabla Seguro_Medico
INSERT INTO Seguro_Medico (No_poliza, Empresa, estado, porcentaje) 
VALUES 
('12345', 'Seguros XYZ', true, 10.5),
('67890', 'Seguros ABC', false, 15.75),
('54321', 'Seguros DEF', true, 12.25),
('09876', 'Seguros GHI', true, 8.5),
('13579', 'Seguros JKL', false, 20.0),
('24680', 'Seguros MNO', true, 14.0),
('97531', 'Seguros PQR', false, 17.25),
('86420', 'Seguros STU', true, 9.75),
('11111', 'Seguros VWX', false, 22.0),
('22222', 'Seguros YZ', true, 11.5),
('33333', 'Seguros 123', true, 16.75),
('44444', 'Seguros 456', false, 13.0),
('55555', 'Seguros 789', true, 18.25),
('66666', 'Seguros 1011', false, 25.0),
('77777', 'Seguros 1213', true, 12.0);


-- Insertar datos en la tabla analisis
INSERT INTO analisis (precio, nombre_analisis, tiempo_entrega, estado_analisis)
VALUES 
-- Análisis de sangre
(60.00, 'Análisis de sangre básico', 1.5, true),
(300.00, 'Análisis de sangre avanzado', 2.0, true),
-- Análisis de orina
(35.00, 'Análisis de orina básico', 1.0, true),
(125.00, 'Análisis de orina avanzado', 2.0, true),
-- Análisis de heces
(125.00, 'Análisis de heces básico', 2.0, true),
(300.00, 'Análisis de heces avanzado', 3.0, true),
-- Cultivos microbiológicos
(150.00, 'Cultivo microbiológico básico', 3.0, true),
(400.00, 'Cultivo microbiológico avanzado', 4.0, true),
-- Pruebas de diagnóstico molecular
(200.00, 'Prueba de diagnóstico molecular básica', 2.0, true),
(1000.00, 'Prueba de diagnóstico molecular genética', 5.0, true),
-- Pruebas de imagenología
(150.00, 'Radiografía', 1.0, true),
(300.00, 'Ecografía', 2.0, true),
(500.00, 'Tomografía computarizada', 3.0, true),
-- Pruebas de diagnóstico especializado
(200.00, 'Prueba de diagnóstico especializado básica', 2.0, true),
(5000.00, 'Prueba de diagnóstico especializado avanzada', 7.0, true),
-- Pruebas de alergia
(125.00, 'Prueba de alergia cutánea', 2.0, true),
(200.00, 'Prueba de alergia en sangre', 3.0, true),
-- Pruebas de función tiroidea
(100.00, 'Prueba de función tiroidea básica', 2.0, true),
(150.00, 'Prueba de función tiroidea avanzada', 3.0, true),
-- Pruebas de ETS
(125.00, 'Prueba de ETS básica', 2.0, true),
(200.00, 'Prueba de ETS avanzada', 3.0, true);

-- A. Realizar una consulta para obtener los servicios proveídos en enero de cualquier año:
SELECT *
FROM serivicios
WHERE EXTRACT(MONTH FROM fecha) = 1;

--b. Realizar una consulta donde se indique las veces que se ha contratado cada servicio
SELECT COUNT(*), id_detalle_servicio
FROM serivicios
GROUP BY id_detalle_servicio;

--c. Realizar una consulta donde se indiquen los servicios cuyo estado no sea completado
SELECT *
FROM serivicios
WHERE estado != 'completado';

--d. Realizar una consulta indicando los servicios/pruebas/exámenes realizados por cada profesional encargado de la prueba
SELECT s.*, m.nombre_medico, m.apellido_medico
FROM serivicios s
JOIN Historial_Clinico h ON s.DPI = h.dpi
JOIN Medico m ON h.Id_medico = m.Id_medico;

--e. Indicar cuál es el servicio más vendido por clínica
SELECT c.nombre_clinica AS clinica, a.nombre_analisis AS analisis, COUNT(*) AS cantidad_vendida
FROM detalle_servicio ds
JOIN analisis a ON ds.id_analisis = a.id_analisis
JOIN clinica c ON ds.id_clinica = c.id_clinica
GROUP BY c.nombre_clinica, a.nombre_analisis
ORDER BY clinica, cantidad_vendida DESC;

--f.Indicar el monto total de los servicios completados por un rango de fechas
SELECT SUM(total) AS monto_total
FROM serivicios
WHERE estado = 'completado'
AND fecha BETWEEN '2023-01-01' AND '2023-12-31';

--g. Realizar una consulta que devuelva la cantidad de servicios completados por mes
SELECT EXTRACT(MONTH FROM fecha) AS mes, COUNT(*) AS cantidad_servicios
FROM serivicios
WHERE estado = 'completado'
GROUP BY mes;

--h. Realizar una consulta que devuelva el monto de los servicios divididos en montos pagados por el cliente y montos pagados por el seguro
SELECT
    s.No_factura,
    s.total AS monto_total,
    CASE
        WHEN p.No_poliza IS NOT NULL THEN s.total * (1 - sm.porcentaje / 100) -- Si el paciente tiene seguro
        ELSE s.total
    END AS monto_pagado_por_paciente,
    CASE
        WHEN p.No_poliza IS NOT NULL THEN s.total * (sm.porcentaje / 100) -- Si el paciente tiene seguro
        ELSE 0
    END AS monto_pagado_por_seguro
FROM
    serivicios s
LEFT JOIN
    Paciente p ON s.DPI = p.DPI
LEFT JOIN
    Seguro_Medico sm ON p.No_poliza = sm.No_poliza;

--i. Realizar una consulta del porcentaje pagado por el paciente y el porcentaje pagado por los seguros en un rango de fechas
   SELECT
    s.No_factura,
    s.total AS monto_total,
    CASE
        WHEN p.No_poliza IS NOT NULL THEN s.total * (1 - sm.porcentaje / 100) -- Si el paciente tiene seguro
        ELSE s.total
    END AS monto_pagado_por_paciente,
    CASE
        WHEN p.No_poliza IS NOT NULL THEN s.total * (sm.porcentaje / 100) -- Si el paciente tiene seguro
        ELSE 0
    END AS monto_pagado_por_seguro,
    s.fecha
FROM
    serivicios s
LEFT JOIN
    Paciente p ON s.DPI = p.DPI
LEFT JOIN
    Seguro_Medico sm ON p.No_poliza = sm.No_poliza
WHERE
    s.fecha BETWEEN '2024-05-01' AND '2024-05-31'; -- Aquí especifica el rango de fechas deseado

--j. Realizar un resumen de los servicios indicando para ello el nombre del paciente, la fecha de completado, el monto y si viene referido por algún médico o no
SELECT
    p.nombre AS nombre_paciente,
    s.fecha AS fecha_completado,
    s.total AS monto,
    CASE
        WHEN hc.Id_medico IS NOT NULL THEN 'Sí'
        ELSE 'No'
    END AS referido_por_medico
FROM
    serivicios s
JOIN
    Paciente p ON s.DPI = p.DPI
LEFT JOIN
    Historial_Clinico hc ON p.DPI = hc.dpi
ORDER BY
    s.fecha;
   
--k. Actualizar el valor de los servicios en un 2%
UPDATE serivicios
SET total = total * 1.02;

--l. Actualizar el nombre de los servicios agregando el nombre en mayúsculas (todo el nombre)
UPDATE analisis
SET nombre_analisis = 'ANÁLISIS DE SANGRE AVANZADO'
WHERE nombre_analisis = 'Análisis de sangre avanzado';

--m. Inactivar un servicio en específico
UPDATE analisis
SET estado_analisis = false
WHERE nombre_analisis = 'Prueba de ETS básica';

--n. Indicar la última fecha en la que se vendió un servicio específico
SELECT MAX(fecha) AS ultima_fecha_venta
FROM serivicios
WHERE id_detalle_servicio = 1;

--o. Realizar una consulta que indique el tiempo más tardado de una prueba
SELECT MAX(tiempo_entrega) AS tiempo_mas_tardado
FROM analisis;

--p. Realizar una consulta que indique el nombre del doctor que tenga más referidos
SELECT m.nombre_medico, COUNT(h.id_historial) AS cantidad_referidos
FROM Medico m
JOIN Historial_Clinico h ON m.Id_medico = h.Id_medico
GROUP BY m.nombre_medico
ORDER BY cantidad_referidos DESC
LIMIT 1;

--q. Indicar una consulta que devuelva el seguro más utilizado
SELECT sm.Empresa, COUNT(*) AS cantidad_servicios
FROM Seguro_Medico sm
JOIN Paciente p ON sm.No_poliza = p.No_poliza
JOIN serivicios s ON p.DPI = s.DPI
GROUP BY sm.Empresa
ORDER BY cantidad_servicios DESC
LIMIT 1;