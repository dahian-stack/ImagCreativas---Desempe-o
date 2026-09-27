CREATE DATABASE mediapro;

USE mediapro; 

SHOW TABLES;

CREATE TABLE Cliente (
    ID_cliente INTEGER PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(100),
    Tipo VARCHAR(50),
    Contacto VARCHAR(100)
);

SELECT * FROM cliente;

CREATE TABLE Produccion (
    ID_produccion INT PRIMARY KEY AUTO_INCREMENT,
    Titulo VARCHAR(150),
    Tipo VARCHAR(50),
    Genero VARCHAR(50),
    Presupuesto_inicial DECIMAL(15,2),
    Presupuesto_gastado DECIMAL(15,2),
    Estado_presupuesto VARCHAR(50),
    Fecha_inicio DATE,
    Duracion_estimada INT,
    Etapa VARCHAR(50),
    Estado VARCHAR(50),
    ID_cliente INT,
    FOREIGN KEY (ID_cliente) REFERENCES Cliente(ID_cliente)
);

SELECT * FROM Produccion;

CREATE TABLE Personal (
    ID_personal INTEGER PRIMARY KEY AUTO_INCREMENT,
    Nombres VARCHAR(100),
    Apellidos VARCHAR(100),
    Especialidad VARCHAR(100),
    Experiencia TEXT,
    Portafolio TEXT,
    Disponibilidad VARCHAR(50),
    Tarifa DECIMAL(10,2),
    Contacto VARCHAR(100)
);

SELECT * FROM Personal;

CREATE TABLE Produccion_Personal (
    ID_produccion INTEGER,
    ID_personal INTEGER,
    Rol VARCHAR(50),
    FOREIGN KEY (ID_produccion) REFERENCES Produccion(ID_produccion),
    FOREIGN KEY (ID_personal) REFERENCES Personal(ID_personal)
);

SELECT * FROM Produccion_Personal;

CREATE TABLE Equipo_Tecnico (
    ID_equipo INT PRIMARY KEY AUTO_INCREMENT,
    Categoria VARCHAR(50),
    Marca VARCHAR(50),
    Modelo VARCHAR(50),
    Caracteristicas TEXT,
    Fecha_adquisicion DATE,
    Valor DECIMAL(12,2),
    Estado VARCHAR(50),
    Disponibilidad VARCHAR(50),
    Seguro VARCHAR(50),
    Proximo_mantenimiento DATE,
    Estado_mantenimiento VARCHAR(50)
);

SELECT * FROM Equipo_Tecnico;

CREATE TABLE Mantenimiento (
    ID_mantenimiento INTEGER PRIMARY KEY AUTO_INCREMENT,
    ID_equipo INTEGER,
    Fecha DATE,
    Tipo VARCHAR(50),
    Descripcion TEXT,
    FOREIGN KEY (ID_equipo) REFERENCES Equipo_Tecnico(ID_equipo)
);

SELECT * FROM Mantenimiento;

CREATE TABLE Produccion_Equipo (
    ID_produccion INTEGER,
    ID_equipo INTEGER,
    FOREIGN KEY (ID_produccion) REFERENCES Produccion(ID_produccion),
    FOREIGN KEY (ID_equipo) REFERENCES Equipo_Tecnico(ID_equipo)
);

SELECT * FROM Produccion_Equipo;

CREATE TABLE Localizacion (
    ID_localizacion INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(100),
    Direccion VARCHAR(150),
    Coordenadas VARCHAR(100),
    Tipo VARCHAR(50),
    Propietario VARCHAR(100),
    Caracteristicas TEXT,
    Permisos TEXT,
    Estado VARCHAR(50),
    Costo DECIMAL(10,2),
    Limitaciones TEXT,
    Facilidades TEXT,
    Accesibilidad TEXT
);

SELECT * FROM Localizacion;

CREATE TABLE Produccion_Localizacion (
    ID_produccion INTEGER,
    ID_localizacion INTEGER,
    FOREIGN KEY (ID_produccion) REFERENCES Produccion(ID_produccion),
    FOREIGN KEY (ID_localizacion) REFERENCES Localizacion(ID_localizacion)
);

SELECT * FROM Produccion_Localizacion;

CREATE TABLE Plan_Rodaje (
    ID_plan INT PRIMARY KEY AUTO_INCREMENT,
    ID_produccion INT,
    Dia_rodaje INT,
    Fecha DATE,
    Hora_inicio TIME,
    Hora_fin TIME,
    Hora_inicio_real TIME,
    Hora_fin_real TIME,
    Eficiencia VARCHAR(50),
    Requerimientos TEXT,
    Plan_contingencia TEXT,
    ID_localizacion INT,
    FOREIGN KEY (ID_produccion) REFERENCES Produccion(ID_produccion),
    FOREIGN KEY (ID_localizacion) REFERENCES Localizacion(ID_localizacion)
);

SELECT * FROM Plan_Rodaje;

CREATE TABLE Escena (
    ID_escena INTEGER AUTO_INCREMENT PRIMARY KEY,
    ID_produccion INT,
    Descripcion TEXT,
    Tiempo_estimado INTEGER,
    Complejidad VARCHAR(50),
    Necesidades_especiales TEXT,
    Estado VARCHAR(50),
    FOREIGN KEY (ID_produccion) REFERENCES Produccion(ID_produccion)
);

SELECT * FROM Escena;

CREATE TABLE Plan_Rodaje_Escena (
    ID_plan INTEGER,
    ID_escena INTEGER,
    FOREIGN KEY (ID_plan) REFERENCES Plan_Rodaje(ID_plan),
    FOREIGN KEY (ID_escena) REFERENCES Escena(ID_escena)
);

SELECT * FROM Plan_Rodaje_Escena;

CREATE TABLE Actor (
    ID_actor INT PRIMARY KEY AUTO_INCREMENT,
    Nombres VARCHAR(100),
    Apellidos VARCHAR(100),
    Documento VARCHAR(20),
    Fecha_nacimiento DATE,
    Representante VARCHAR(100),
    Caracteristicas_fisicas TEXT,
    Habilidades TEXT,
    Trabajos_previos TEXT,
    Disponibilidad VARCHAR(50),
    Categoria VARCHAR(50),
    Salario DECIMAL(10,2)
);

SELECT * FROM actor;

CREATE TABLE Personaje (
    ID_personaje INTEGER PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(100),
    Descripcion TEXT
);

SELECT * FROM Personaje;

CREATE TABLE Escena_Actor (
    ID_escena INTEGER,
    ID_actor INTEGER,
    ID_personaje INTEGER,
    FOREIGN KEY (ID_escena) REFERENCES Escena(ID_escena),
    FOREIGN KEY (ID_actor) REFERENCES Actor(ID_actor),
    FOREIGN KEY (ID_personaje) REFERENCES Personaje(ID_personaje)
);

SELECT * FROM Escena_Actor;

CREATE TABLE Plan_Rodaje_Actor (
    ID_plan INTEGER,
    ID_actor INTEGER,
    FOREIGN KEY (ID_plan) REFERENCES Plan_Rodaje(ID_plan),
    FOREIGN KEY (ID_actor) REFERENCES Actor(ID_actor)
);

SELECT * FROM Plan_Rodaje_Actor;

CREATE TABLE Plan_Rodaje_Equipo (
    ID_plan INTEGER,
    ID_equipo INTEGER,
    FOREIGN KEY (ID_plan) REFERENCES Plan_Rodaje(ID_plan),
    FOREIGN KEY (ID_equipo) REFERENCES Equipo_Tecnico(ID_equipo)
);

SELECT * FROM Plan_Rodaje_Equipo;

CREATE TABLE Material_Grabado (
    ID_material INTEGER PRIMARY KEY AUTO_INCREMENT,
    ID_produccion INTEGER,
    ID_escena INTEGER,
    Toma INTEGER,
    Duracion INTEGER,
    Formato VARCHAR(50),
    Resolucion VARCHAR(50),
    Camara VARCHAR(50),
    Almacenamiento VARCHAR(100),
    Timecode_inicio VARCHAR(50),
    Timecode_fin VARCHAR(50),
    Observaciones TEXT,
    Calificacion VARCHAR(50),
    FOREIGN KEY (ID_produccion) REFERENCES Produccion(ID_produccion),
    FOREIGN KEY (ID_escena) REFERENCES Escena(ID_escena)
);

SELECT * FROM Material_Grabado;

CREATE TABLE Audio (
    ID_audio INTEGER PRIMARY KEY AUTO_INCREMENT,
    ID_material INTEGER,
    Tipo VARCHAR(50),
    Descripcion TEXT,
    FOREIGN KEY (ID_material) REFERENCES Material_Grabado(ID_material)
);

SELECT * FROM Audio;

CREATE TABLE Postproduccion (
    ID_post INT PRIMARY KEY AUTO_INCREMENT,
    ID_produccion INT,
    Tipo VARCHAR(50),
    Responsable VARCHAR(100),
    Fecha_inicio DATE,
    Fecha_fin DATE,
    Porcentaje INT,
    Avance_general INT,
    Software VARCHAR(100),
    Estado VARCHAR(50),
    FOREIGN KEY (ID_produccion) REFERENCES Produccion(ID_produccion)
);

SELECT * FROM Postproduccion;

CREATE TABLE Material_Postproduccion (
    ID_material_post INT AUTO_INCREMENT PRIMARY KEY,
    ID_post INT,
    Descripcion TEXT,
    FOREIGN KEY (ID_post) REFERENCES Postproduccion(ID_post)
);

SELECT * FROM Material_Postproduccion;

CREATE TABLE Versiones (
    ID_version INTEGER PRIMARY KEY AUTO_INCREMENT,
    ID_post INTEGER,
    Numero_version VARCHAR(20),
    Fecha DATE,
    Descripcion TEXT,
    FOREIGN KEY (ID_post) REFERENCES Postproduccion(ID_post)
);

SELECT * FROM Versiones;

CREATE TABLE Aprobacion (
    ID_aprobacion INTEGER PRIMARY KEY AUTO_INCREMENT,
    ID_post INTEGER,
    Estado VARCHAR(50),
    Responsable VARCHAR(100),
    Fecha DATE,
    FOREIGN KEY (ID_post) REFERENCES Postproduccion(ID_post)
);

SELECT * FROM Aprobacion;

CREATE TABLE Distribucion (
    ID_distribucion INTEGER PRIMARY KEY AUTO_INCREMENT,
    ID_produccion INTEGER,
    Territorio VARCHAR(100),
    Plataforma VARCHAR(50),
    Distribuidor VARCHAR(100),
    Acuerdo VARCHAR(100),
    Fecha_inicio DATE,
    Fecha_fin DATE,
    Mercado VARCHAR(100),
    Presupuesto_marketing DECIMAL(12,2),
    Resultados TEXT,
    FOREIGN KEY (ID_produccion) REFERENCES Produccion(ID_produccion)
);

SELECT * FROM Distribucion;

CREATE TABLE Material_Promocional (
    ID_material_prom INTEGER PRIMARY KEY AUTO_INCREMENT,
    ID_distribucion INTEGER,
    Tipo VARCHAR(50),
    Descripcion TEXT,
    FOREIGN KEY (ID_distribucion) REFERENCES Distribucion(ID_distribucion)
);

SELECT * FROM Material_Promocional;


-- IMPLEMENTAR ELIMINACIÓN DE CASCADA --

-- PRODUCCION -> CLIENTE
ALTER TABLE Produccion DROP FOREIGN KEY Produccion_ibfk_1;
ALTER TABLE Produccion
ADD FOREIGN KEY (id_cliente)
REFERENCES Cliente(id_cliente)
ON DELETE CASCADE;

-- ESCENA -> PRODUCCION
ALTER TABLE Escena DROP FOREIGN KEY Escena_ibfk_1;
ALTER TABLE Escena
ADD FOREIGN KEY (id_produccion)
REFERENCES Produccion(id_produccion)
ON DELETE CASCADE;

-- MATERIAL_GRABADO -> PRODUCCION
ALTER TABLE Material_Grabado DROP FOREIGN KEY Material_Grabado_ibfk_1;
ALTER TABLE Material_Grabado
ADD FOREIGN KEY (id_produccion)
REFERENCES Produccion(id_produccion)
ON DELETE CASCADE;

-- MATERIAL_GRABADO -> ESCENA
ALTER TABLE Material_Grabado DROP FOREIGN KEY Material_Grabado_ibfk_2;
ALTER TABLE Material_Grabado
ADD FOREIGN KEY (id_escena)
REFERENCES Escena(id_escena)
ON DELETE CASCADE;

-- AUDIO -> MATERIAL
ALTER TABLE Audio DROP FOREIGN KEY Audio_ibfk_1;
ALTER TABLE Audio
ADD FOREIGN KEY (id_material)
REFERENCES Material_Grabado(id_material)
ON DELETE CASCADE;

-- POSTPRODUCCION -> PRODUCCION
ALTER TABLE Postproduccion DROP FOREIGN KEY Postproduccion_ibfk_1;
ALTER TABLE Postproduccion
ADD FOREIGN KEY (id_produccion)
REFERENCES Produccion(id_produccion)
ON DELETE CASCADE;


-- DEFINIR INDICES APROPIADOS --
-- índice simple
CREATE INDEX idx_titulo ON Produccion(titulo);

-- índice compuesto
CREATE INDEX idx_tipo_genero ON Produccion(tipo, genero);

-- índice único
CREATE UNIQUE INDEX idx_documento ON Actor(documento);

-- índice de texto
CREATE FULLTEXT INDEX idx_desc ON Material_Postproduccion(descripcion);


-- INSERT INTO'S
INSERT INTO Cliente (nombre, tipo, contacto) VALUES
('Netflix','Empresa','netflix@email.com'),
('Caracol TV','Empresa','caracol@email.com'),
('RCN','Empresa','rcn@email.com'),
('Disney','Empresa','disney@email.com'),
('HBO','Empresa','hbo@email.com'),
('Sony Pictures','Empresa','sony@email.com'),
('Warner Bros','Empresa','warner@email.com'),
('Paramount','Empresa','paramount@email.com'),
('Fox','Empresa','fox@email.com'),
('Amazon Studios','Empresa','amazon@email.com');


INSERT INTO Produccion (titulo,tipo,genero,presupuesto_inicial,presupuesto_gastado,estado_presupuesto,fecha_inicio,duracion_estimada,etapa,estado,id_cliente) VALUES
('Sombras del Valle','Película','Drama',120000,80000,'En proceso','2025-01-15',110,'Rodaje','Activo',1),
('Código Silente','Serie','Thriller',250000,200000,'En proceso','2025-02-10',12,'Rodaje','Activo',2),
('Raíces Ancestrales','Documental','Historia',90000,90000,'Completado','2025-03-05',80,'Post','Activo',3),
('Impulso Urbano','Comercial','Publicidad',40000,40000,'Completado','2025-04-12',25,'Final','Cerrado',4),
('Latidos Nocturnos','Videoclip','Musical',30000,15000,'En proceso','2025-05-08',7,'Rodaje','Activo',5),
('El Último Ritual','Película','Terror',150000,50000,'En proceso','2025-06-20',105,'Pre','Activo',6),
('Risas en Serie','Serie','Comedia',180000,100000,'En proceso','2025-07-01',14,'Rodaje','Activo',7),
('El Tiempo Perdido','Documental','Naturaleza',110000,60000,'En proceso','2025-08-03',85,'Post','Activo',8),
('Amor y Destino','Película','Romance',95000,70000,'En proceso','2025-09-10',100,'Rodaje','Activo',9),
('Horizonte 9','Serie','Sci-Fi',300000,100000,'En proceso','2025-10-02',16,'Pre','Activo',10);

INSERT INTO Personal (nombres, apellidos, especialidad, experiencia, portafolio, disponibilidad, tarifa, contacto) VALUES
('Juan', 'Pérez', 'Dirección', '5 años', 'link1', 'Ocupado', 500, 'juan@mail.com'),
('Ana', 'Gómez', 'Fotografía', '3 años', 'link2', 'Disponible', 400, 'ana@mail.com'),
('Luis', 'Martínez', 'Sonido', '4 años', 'link3', 'Ocupado', 350, 'luis@mail.com'),
('Carla', 'Rojas', 'Edición', '6 años', 'link4', 'Disponible', 450, 'carla@mail.com'),
('Pedro', 'López', 'Arte', '2 años', 'link5', 'Disponible', 300, 'pedro@mail.com'),
('Sara', 'Torres', 'Dirección', '7 años', 'link6', 'Ocupado', 600, 'sara@mail.com'),
('Mario', 'Ramírez', 'Fotografía', '5 años', 'link7', 'Disponible', 420, 'mario@mail.com'),
('Lucía', 'Castro', 'Sonido', '3 años', 'link8', 'Disponible', 330, 'lucia@mail.com'),
('Andrés', 'Vega', 'Edición', '4 años', 'link9', 'Ocupado', 410, 'andres@mail.com'),
('Diana', 'Morales', 'Arte', '6 años', 'link10', 'Disponible', 380, 'diana@mail.com');

INSERT INTO Produccion_Personal VALUES
(1,1,'Director'),(2,2,'Foto'),(3,3,'Sonido'),(4,4,'Editor'),
(5,5,'Arte'),(6,6,'Director'),(7,7,'Foto'),(8,8,'Sonido'),
(9,9,'Editor'),(10,10,'Arte');

INSERT INTO Equipo_Tecnico (Categoria,Marca,Modelo,Caracteristicas,Fecha_adquisicion,Valor,Estado,Disponibilidad,Seguro,Proximo_mantenimiento,Estado_mantenimiento) VALUES
('Drone','DJI','Mavic','4K','2023-01-01',15000,'Bueno','Ocupado','Si','2026-01-01','Pendiente'),
('Estabilizador','DJI','Ronin','Gimbal','2023-02-01',3000,'Bueno','Libre','Si','2026-02-01','Al día'),
('Monitor','SmallHD','Focus','HD','2023-03-01',1200,'Bueno','Libre','No','2026-03-01','Pendiente'),
('Audio','Zoom','H6','Grabadora','2023-04-01',800,'Bueno','Libre','No','2026-04-01','Al día'),
('Camara','Sony','A7','4K','2023-05-01',9000,'Bueno','Ocupado','Si','2026-05-01','Pendiente'),
('Luz','Godox','LED','Potente','2023-06-01',2000,'Bueno','Ocupado','Si','2026-06-01','Al día'),
('Grip','Manfrotto','Tripod','Aluminio','2023-07-01',500,'Bueno','Libre','Si','2026-07-01','Pendiente'),
('Microfono','Rode','NTG','Shotgun','2023-08-01',600,'Bueno','Libre','No','2026-08-01','Al día'),
('Switcher','ATEM','Mini','Streaming','2023-09-01',700,'Bueno','Libre','Si','2026-09-01','Pendiente'),
('Proyector','Epson','X','HD','2023-10-01',1500,'Bueno','Ocupado','No','2026-10-01','Al día');

INSERT INTO Mantenimiento (id_equipo,fecha,tipo,descripcion) VALUES
(1,'2024-01-01','Limpieza','ok'),
(2,'2024-01-02','Revisión','ok'),
(3,'2024-01-03','Cambio','pieza'),
(4,'2024-01-04','Ajuste','ok'),
(5,'2024-01-05','Limpieza','ok'),
(6,'2024-01-06','Revisión','ok'),
(7,'2024-01-07','Cambio','pieza'),
(8,'2024-01-08','Ajuste','ok'),
(9,'2024-01-09','Limpieza','ok'),
(10,'2024-01-10','Revisión','ok');

INSERT INTO Produccion_Equipo VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),
(6,6),(7,7),(8,8),(9,9),(10,10);


INSERT INTO Localizacion (Nombre,Direccion,Coordenadas,Tipo,Propietario,Caracteristicas,Permisos,Estado,Costo,Limitaciones,Facilidades,Accesibilidad) VALUES
('Casa Luna','Calle 10','6.24,-75.57','Interior','Juan','Moderna','Contrato firmado','Disponible',150,'Ruido','Wifi','Alta'),
('Parque Verde','Cra 5','6.25,-75.56','Exterior','Alcaldía','Lago','Permiso municipal','Ocupado',200,'Clima','Parking','Media'),
('Estudio Alfa','Zona','6.26','Studio','Empresa','Luces','Permiso total','Disponible',500,'Horario','Camerinos','Alta'),
('Apartamento Sol','Calle 8','6.23','Interior','Ana','Pequeño','Contrato','Disponible',120,'Espacio','Wifi','Media'),
('Plaza Central','Centro','6.24','Exterior','Gob','Amplia','Permiso evento','Ocupado',300,'Multitud','Acceso','Alta'),
('Estudio Beta','Sur','6.22','Studio','Empresa','Pantalla verde','Permiso','Disponible',450,'Reserva','Luces','Alta'),
('Casa Campo','Vereda','6.30','Interior','Pedro','Rústica','Permiso rural','Disponible',180,'Acceso','Parking','Baja'),
('Puente Río','Km3','6.28','Exterior','Gob','Vista','Permiso vial','Ocupado',250,'Seguridad','Acceso','Media'),
('Estudio Gamma','Norte','6.27','Studio','Empresa','Set','Permiso','Disponible',550,'Horario','Camerinos','Alta'),
('Oficina Nova','Av1','6.24','Interior','Empresa','Moderna','Contrato','Disponible',200,'Espacio','Wifi','Alta');

INSERT INTO Produccion_Localizacion VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),
(6,6),(7,7),(8,8),(9,9),(10,10);

INSERT INTO Plan_Rodaje (ID_produccion, Dia_rodaje, Fecha, Hora_inicio, Hora_fin, Hora_inicio_real, Hora_fin_real, Eficiencia, Requerimientos, Plan_contingencia, ID_localizacion) VALUES
(1,1,'2025-01-15','07:00','17:00','07:10','17:20','Alta','Equipo completo','Plan lluvia',1),
(1,2,'2025-01-16','08:00','18:00','08:05','17:50','Media','Sonido profesional','Backup técnico',2),
(1,3,'2025-01-18','07:30','16:30','07:40','16:45','Alta','Cámara principal','Sin contingencia',3),
(2,1,'2025-02-10','09:00','19:00','09:20','19:30','Baja','Extras necesarios','Set alterno',4),
(2,2,'2025-02-11','07:30','16:00','07:35','16:10','Alta','Iluminación','Respaldo eléctrico',5),
(3,1,'2025-03-05','06:00','14:00','06:10','14:05','Alta','Drone','Clima adverso',6),
(3,2,'2025-03-06','06:00','14:00','06:20','14:30','Media','Audio ambiental','Equipo backup',7),
(4,1,'2025-04-12','09:00','17:00','09:00','17:00','Alta','Producto','Ninguno',8),
(5,1,'2025-05-08','10:00','20:00','10:15','20:30','Baja','Luces LED','Técnico en espera',9),
(6,1,'2025-06-20','07:00','15:00','07:05','15:10','Alta','FX especiales','Sin contingencia',10);

INSERT INTO Escena (id_produccion,descripcion,tiempo_estimado,complejidad,necesidades_especiales,estado) VALUES
(1,'Persecución en carretera con vehículos',15,'alta','dobles de acción','finalizada'),
(2,'Diálogo emocional entre protagonistas',10,'media','iluminación suave','rodada'),
(3,'Narración en locación histórica',8,'baja','permiso cultural','finalizada'),
(4,'Grabación de producto en estudio',6,'baja','equipo macro','finalizada'),
(5,'Escena musical en club nocturno',12,'media','luces LED','rodada'),
(6,'Ritual oscuro con efectos especiales',14,'alta','fx y maquillaje','pendiente'),
(7,'Escena cómica en apartamento',9,'baja','utilería básica','finalizada'),
(8,'Toma aérea de paisaje natural',11,'alta','drone','rodada'),
(9,'Encuentro romántico bajo lluvia',10,'media','lluvia artificial','finalizada'),
(10,'Escape futurista en laboratorio',13,'alta','pantalla verde','pendiente');

INSERT INTO Plan_Rodaje_Escena VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),
(6,6),(7,7),(8,8),(9,9),(10,10);

INSERT INTO Actor (nombres,apellidos,documento,fecha_nacimiento,representante,caracteristicas_fisicas,habilidades,trabajos_previos,disponibilidad,categoria,salario) VALUES
('Mateo','Salazar','1023456789','1990-02-14','TalentPro','Alto, atlético','Acción, drama','Serie policial','Disponible','A',1200),
('Valentina','Ríos','1034567890','1995-06-21','StarGroup','Delgada, ojos verdes, expresiva','Drama, canto','Película indie','Disponible','A',1100),
('Sebastián','Cruz','1045678901','1988-11-03','ActingCo','Robusto, barba','Acción','Serie acción','Ocupado','A',1300),
('Camila','Ortega','1056789012','1993-04-17','EliteRep','Alta, elegante','Drama','Novelas','Disponible','B',900),
('Daniel','Vargas','1067890123','1991-08-09','TalentPro','Medio, cabello corto','Comedia','Sitcom','Disponible','B',800),
('Isabella','Méndez','1078901234','1996-12-01','StarGroup','Atlética, cabello rubio','Baile, canto','Videoclips','Disponible','A',1000),
('Andrés','Pardo','1089012345','1987-03-22','ActingCo','Alto, fuerte, barba','Acción, drama','Película acción','Ocupado','A',1400),
('Lucía','Navarro','1090123456','1994-07-30','EliteRep','Media, cabello corto','Drama','Serie juvenil','Disponible','B',850),
('Tomás','Herrera','1001234567','1989-10-11','TalentPro','Delgado, alto','Comedia','Stand-up','Disponible','A',950),
('Paula','Gil','1012345678','1997-05-05','StarGroup','Baja, cabello rojo','Canto','Reality show','Disponible','B',870);


INSERT INTO Personaje (id_personaje, nombre, descripcion) VALUES
(1,'Alejandro Vega','Protagonista - Detective principal'),
(2,'Marco Silva','Antagonista - Villano principal'),
(3,'Lucía Ferrer','Extra - Periodista'),
(4,'Elena Ríos','Secundario - Mentora sabia'),
(5,'Tomás León','Secundario - Amigo leal'),
(6,'Valeria Cruz','Extra - Mujer misteriosa'),
(7,'Diego Soto','Protagonista - Joven rebelde'),
(8,'Camilo Torres','Antagonista - Policía corrupto'),
(9,'Sara Méndez','Secundario - Científica'),
(10,'Iván Duarte','Antagonista - Líder criminal');

INSERT INTO Escena_Actor (id_escena, id_actor, id_personaje) VALUES
(1,1,1),(2,2,2),(3,3,3),(4,4,4),(5,5,1),
(6,6,2),(7,7,5),(8,8,6),(9,9,1),(10,10,2); 

INSERT INTO Plan_Rodaje_Actor VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),
(6,6),(7,7),(8,8),(9,9),(10,10);

INSERT INTO Material_Grabado (id_produccion,id_escena,toma,duracion,formato,resolucion,camara,almacenamiento,timecode_inicio,timecode_fin,observaciones,calificacion) VALUES
(1,1,1,12,'MP4','4K','Sony A1','SSD_A','00:00:00','00:00:12','Plano estable','óptima'),
(2,2,2,15,'MOV','4K','Canon C300','SSD_B','00:01:00','00:01:15','Buena iluminación','buena'),
(3,3,1,9,'MP4','1080p','Blackmagic 6K','SSD_C','00:02:00','00:02:09','Ligero ruido','descartada'),
(4,4,3,20,'MOV','4K','Sony FX6','SSD_D','00:03:00','00:03:20','Escena compleja','óptima'),
(5,5,2,7,'MP4','1080p','Canon R5','SSD_E','00:04:00','00:04:07','Toma rápida','buena'),
(6,6,1,14,'MOV','4K','Blackmagic 4K','SSD_F','00:05:00','00:05:14','Buen enfoque','óptima'),
(7,7,2,11,'MP4','1080p','Sony A7S','SSD_G','00:06:00','00:06:11','Audio regular','buena'),
(8,8,1,18,'MOV','4K','Canon C70','SSD_H','00:07:00','00:07:18','Escena nocturna','óptima'),
(9,9,3,10,'MP4','1080p','Blackmagic Pocket','SSD_I','00:08:00','00:08:10','Plano medio','buena'),
(10,10,1,16,'MOV','4K','Sony FX3','SSD_J','00:09:00','00:09:16','Excelente color','óptima');

INSERT INTO Audio (id_material,tipo,descripcion) VALUES
(1,'Diálogo','Audio claro sin interferencias'),
(2,'Ambiente','Sonido de fondo urbano'),
(3,'Efectos','Explosión leve'),
(4,'Diálogo','Voces nítidas'),
(5,'Música','Pista instrumental'),
(6,'Diálogo','Audio limpio'),
(7,'Ambiente','Ruido natural exterior'),
(8,'Efectos','Viento fuerte'),
(9,'Música','Tema emocional'),
(10,'Diálogo','Excelente calidad');

INSERT INTO Postproduccion (ID_produccion,Tipo,Responsable,Fecha_inicio,Fecha_fin,Porcentaje,Avance_general,Software,Estado) VALUES
(1,'Montaje','Juan Pérez','2025-02-01','2025-02-10',60,50,'Adobe Premiere','Activo'),
(2,'Color','Ana Gómez','2025-03-01','2025-03-10',50,45,'DaVinci Resolve','Finalizado'),
(3,'Sonido','Luis Martínez','2025-04-01','2025-04-12',40,35,'Pro Tools','Finalizado'),
(4,'Edición','Carla Rojas','2025-05-01','2025-05-10',80,75,'Final Cut','Activo'),
(5,'Arte','Pedro López','2025-06-01','2025-06-08',30,25,'Photoshop','Finalizado'),
(6,'Montaje','Sara Torres','2025-07-01','2025-07-10',70,65,'Adobe Premiere','Activo'),
(7,'Color','Mario Ramírez','2025-08-01','2025-08-12',55,50,'DaVinci Resolve','Activo'),
(8,'Sonido','Lucía Castro','2025-09-01','2025-09-10',65,60,'Pro Tools','Activo'),
(9,'Edición','Andrés Vega','2025-10-01','2025-10-10',75,70,'Final Cut','Activo'),
(10,'Arte','Diana Morales','2025-11-01','2025-11-08',45,40,'Photoshop','Finalizado'),
(11,'VFX','Carlos Ruiz','2025-12-01','2025-12-15',35,30,'After Effects','Activo'),
(12,'Corrección','Laura Díaz','2026-01-01','2026-01-10',90,85,'DaVinci Resolve','Finalizado');

INSERT INTO Material_Postproduccion (id_post, descripcion) VALUES
(1,'Selección de tomas principales y material bruto organizado'),
(2,'Corrección de color base aplicada a escenas clave'),
(3,'Primeros efectos visuales integrados (pantalla verde)'),
(4,'Limpieza y sincronización de audio de diálogos'),
(5,'Corte preliminar con estructura narrativa definida'),
(6,'Ajustes avanzados de color y contraste por escena'),
(7,'Integración de efectos visuales intermedios'),
(8,'Mezcla de sonido inicial con ambientación'),
(9,'Edición final con transiciones y ritmo optimizado'),
(10,'Corrección final de color y exportación master');

INSERT INTO Versiones (id_post, numero_version, fecha, descripcion) VALUES
(1,'v1.0','2025-02-05','Primer ensamblaje del material grabado'),
(2,'v1.1','2025-03-06','Ajuste inicial de color en escenas principales'),
(3,'v1.0','2025-04-07','Integración base de efectos visuales'),
(4,'v1.2','2025-05-08','Corrección de audio y sincronización labial'),
(5,'v2.0','2025-06-09','Segundo corte con mejoras narrativas'),
(6,'v2.1','2025-07-10','Ajuste fino de color y contraste'),
(7,'v2.0','2025-08-11','Efectos visuales en etapa intermedia'),
(8,'v2.2','2025-09-12','Mezcla de sonido mejorada'),
(9,'v3.0','2025-10-13','Versión final lista para revisión'),
(10,'v3.1','2025-11-14','Master final exportado en alta calidad');

INSERT INTO Aprobacion (id_post, estado, responsable, fecha) VALUES
(1,'Pendiente','Director General','2026-01-06'),
(2,'Aprobado','Director de Fotografía','2025-03-07'),
(3,'Pendiente','Supervisor VFX','2025-04-08'),
(4,'Aprobado','Ingeniero de Sonido','2025-05-09'),
(5,'Pendiente','Productor Ejecutivo','2025-06-10'),
(6,'Aprobado','Director General','2025-07-11'),
(7,'Pendiente','Supervisor VFX','2025-08-12'),
(8,'Aprobado','Ingeniero de Sonido','2025-09-13'),
(9,'Aprobado','Productor Ejecutivo','2025-10-14'),
(10,'Pendiente','Director General','2026-03-15');

INSERT INTO Distribucion (id_produccion, territorio, plataforma, distribuidor, acuerdo, fecha_inicio, fecha_fin, mercado, presupuesto_marketing, resultados) VALUES
(1,'Estados Unidos','Streaming','Netflix Distribución','Royalty 10%','2025-03-01','2025-06-01','Global',80000,'Alta audiencia en estreno'),
(2,'Europa','Televisión','HBO Media','Mínimo garantizado','2025-04-01','2025-07-01','Regional',60000,'Buena recepción crítica'),
(3,'Latinoamérica','Cine','CineCol Distribución','Royalty 8%','2025-05-01','2025-08-01','Local',40000,'Recepción moderada'),
(4,'Estados Unidos','Streaming','Disney Media','Mínimo garantizado','2025-06-01','2025-09-01','Global',90000,'Alto impacto comercial'),
(5,'Europa','Televisión','Sony TV','Royalty 9%','2025-07-01','2025-10-01','Regional',30000,'Resultados positivos'),
(6,'Latinoamérica','Cine','Andes Films','Mínimo garantizado','2025-08-01','2025-11-01','Local',35000,'Aceptación media'),
(7,'Estados Unidos','Streaming','Amazon Studios','Royalty 12%','2025-09-01','2025-12-01','Global',100000,'Gran éxito en plataforma'),
(8,'Europa','Televisión','Warner Media','Mínimo garantizado','2025-10-01','2026-01-01','Regional',55000,'Críticas favorables'),
(9,'Latinoamérica','Cine','Latam Films','Royalty 7%','2025-11-01','2026-02-01','Local',32000,'Ingresos estables'),
(10,'Global','Streaming','Paramount+','Mínimo garantizado','2025-12-01','2026-03-01','Global',120000,'Excelente rendimiento global');

INSERT INTO Material_Promocional (id_distribucion, tipo, descripcion) VALUES
(1,'Trailer','Avance oficial con escenas destacadas'),
(2,'Poster','Afiche promocional principal'),
(3,'Teaser','Video corto para redes sociales'),
(4,'Banner','Publicidad digital para plataformas web'),
(5,'Clip','Fragmento exclusivo de la producción'),
(6,'Trailer','Segundo avance con nuevas escenas'),
(7,'Poster','Versión alternativa del afiche'),
(8,'Teaser','Promoción para televisión'),
(9,'Clip','Escena destacada para marketing'),
(10,'Banner','Campaña digital internacional');


-- =========================================================
-- PROCEDURES

USE mediapro;


-- INSERTAR PERSONAL

DELIMITER //

DROP PROCEDURE IF EXISTS sp_InsertPersonal//

CREATE PROCEDURE sp_InsertPersonal(
    IN p_Nombres VARCHAR(100),
    IN p_Apellidos VARCHAR(100),
    IN p_Especialidad VARCHAR(100),
    IN p_Disponibilidad VARCHAR(100),
    IN p_Contacto VARCHAR(100)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    INSERT INTO personal
    (
        Nombres,
        Apellidos,
        Especialidad,
        Disponibilidad,
        Contacto
    )
    VALUES
    (
        p_Nombres,
        p_Apellidos,
        p_Especialidad,
        p_Disponibilidad,
        p_Contacto
    );

    COMMIT;

    SELECT
        LAST_INSERT_ID() AS ID_personal,
        'Personal insertado correctamente' AS Message;
END//


-- =========================================================
-- ACTUALIZAR PERSONAL

DROP PROCEDURE IF EXISTS sp_UpdatePersonal//

CREATE PROCEDURE sp_UpdatePersonal(
    IN p_ID_personal INT,
    IN p_Nombres VARCHAR(100),
    IN p_Apellidos VARCHAR(100),
    IN p_Especialidad VARCHAR(100),
    IN p_Disponibilidad VARCHAR(100),
    IN p_Contacto VARCHAR(100)
)
BEGIN
    DECLARE v_count INT DEFAULT 0;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    SELECT COUNT(*)
    INTO v_count
    FROM personal
    WHERE ID_personal = p_ID_personal;

    IF v_count = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El personal no existe';
    END IF;

    UPDATE personal
    SET
        Nombres = p_Nombres,
        Apellido = p_Apellidos,
        Especialidad = p_Especialidad,
        Disponibilidad = p_Disponibilidad,
        Contacto = p_Contacto
    WHERE ID_personal = p_ID_personal;

    COMMIT;

    SELECT 'Personal actualizado correctamente' AS Message;
END//


-- =========================================================
-- ELIMINAR PERSONAL

DROP PROCEDURE IF EXISTS sp_DeletePersonal//

CREATE PROCEDURE sp_DeletePersonal(
    IN p_ID_personal INT
)
BEGIN
    DECLARE v_count INT DEFAULT 0;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    SELECT COUNT(*)
    INTO v_count
    FROM personal
    WHERE ID_personal = p_ID_personal;

    IF v_count = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El personal no existe';
    END IF;

    DELETE FROM personal
    WHERE ID_personal = p_ID_personal;

    COMMIT;

    SELECT 'Personal eliminado correctamente' AS Message;
END//


-- =========================================================
-- OBTENER PERSONAL POR ID

DROP PROCEDURE IF EXISTS sp_GetPersonal//

CREATE PROCEDURE sp_GetPersonal(
    IN p_ID_personal INT
)
BEGIN
    SELECT
        ID_personal AS ID,
        Nombres,
        Apellidos,
        Especialidad,
        Disponibilidad,
        Contacto
    FROM personal
    WHERE ID_personal = p_ID_personal;
END//


-- =========================================================
-- OBTENER TODO EL PERSONAL

DROP PROCEDURE IF EXISTS sp_GetAllPersonal//

CREATE PROCEDURE sp_GetAllPersonal()
BEGIN
    SELECT
        ID_personal AS ID,
        Nombres,
        Apellidos,
        Especialidad,
        Disponibilidad,
        Contacto
    FROM personal
    ORDER BY Nombres, Apellidos;
END//

DELIMITER ;




-- ========================EQUIPOS=================================
-- INSERTAR EQUIPO

DELIMITER //

DROP PROCEDURE IF EXISTS sp_InsertEquipos//

CREATE PROCEDURE sp_InsertEquipos(
    IN p_Categoria VARCHAR(100),
    IN p_Marca VARCHAR(100),
    IN p_Modelo VARCHAR(100),
    IN p_Caracteristicas TEXT,
    IN p_Disponibilidad VARCHAR(100)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    INSERT INTO equipo_tecnico
    (
        Categoria,
        Marca,
        Modelo,
        Caracteristicas,
        Disponibilidad
    )
    VALUES
    (
        p_Categoria,
        p_Marca,
        p_Modelo,
        p_Caracteristicas,
        p_Disponibilidad
    );

    COMMIT;

    SELECT
        LAST_INSERT_ID() AS ID_equipo,
        'Equipo insertado correctamente' AS Message;
END//


-- =========================================================
-- ACTUALIZAR EQUIPO
DROP PROCEDURE IF EXISTS sp_UpdateEquipos//

CREATE PROCEDURE sp_UpdateEquipos(
    IN p_ID_equipo INT,
    IN p_Categoria VARCHAR(100),
    IN p_Marca VARCHAR(100),
    IN p_Modelo VARCHAR(100),
    IN p_Caracteristicas TEXT,
    IN p_Disponibilidad VARCHAR(100)
)
BEGIN
    DECLARE v_count INT DEFAULT 0;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    SELECT COUNT(*)
    INTO v_count
    FROM equipo_tecnico
    WHERE ID_equipo = p_ID_equipo;

    IF v_count = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El equipo no existe';
    END IF;

    UPDATE equipo_tecnico
    SET
        Categoria = p_Categoria,
        Marca = p_Marca,
        Modelo = p_Modelo,
        Caracteristicas = p_Caracteristicas,
        Disponibilidad = p_Disponibilidad
    WHERE ID_equipo = p_ID_equipo;

    COMMIT;

    SELECT 'Equipo actualizado correctamente' AS Message;
END//


-- =========================================================
-- ELIMINAR EQUIPO

DROP PROCEDURE IF EXISTS sp_DeleteEquipos//

CREATE PROCEDURE sp_DeleteEquipos(
    IN p_ID_equipo INT
)
BEGIN
    DECLARE v_count INT DEFAULT 0;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    SELECT COUNT(*)
    INTO v_count
    FROM equipo_tecnico
    WHERE ID_equipo = p_ID_equipo;

    IF v_count = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El equipo no existe';
    END IF;

    DELETE FROM equipo_tecnico
    WHERE ID_equipo = p_ID_equipo;

    COMMIT;

    SELECT 'Equipo eliminado correctamente' AS Message;
END//


-- =========================================================
-- OBTENER EQUIPO POR ID

DROP PROCEDURE IF EXISTS sp_GetEquipos//

CREATE PROCEDURE sp_GetEquipos(
    IN p_ID_equipo INT
)
BEGIN
    SELECT
        ID_equipo AS ID,
        Categoria,
        Marca,
        Modelo,
        Caracteristicas,
        Disponibilidad
    FROM equipo_tecnico
    WHERE ID_equipo = p_ID_equipo;
END//


-- =========================================================
-- OBTENER TODOS LOS EQUIPOS

DROP PROCEDURE IF EXISTS sp_GetAllEquipos//

CREATE PROCEDURE sp_GetAllEquipos()
BEGIN
    SELECT
        ID_equipo AS ID,
        Categoria,
        Marca,
        Modelo,
        Caracteristicas,
        Disponibilidad
    FROM equipo_tecnico
    ORDER BY Categoria, Marca, Modelo;
END//

DELIMITER ;


USE mediapro;

-- =========================================================
-- INSERTAR LOCALIZACION

DELIMITER //

DROP PROCEDURE IF EXISTS sp_InsertLocalizacion//

CREATE PROCEDURE sp_InsertLocalizacion(
    IN p_Nombre VARCHAR(150),
    IN p_Direccion VARCHAR(200),
    IN p_Tipo VARCHAR(100),
    IN p_Permisos VARCHAR(100),
    IN p_Estado VARCHAR(100),
    IN p_Facilidades TEXT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    INSERT INTO localizacion
    (
        Nombre,
        Direccion,
        Tipo,
        Permisos,
        Estado,
        Facilidades
    )
    VALUES
    (
        p_Nombre,
        p_Direccion,
        p_Tipo,
        p_Permisos,
        p_Estado,
        p_Facilidades
    );

    COMMIT;

    SELECT
        LAST_INSERT_ID() AS ID_localizacion,
        'Localizacion insertada correctamente' AS Message;
END//


-- =========================================================
-- ACTUALIZAR LOCALIZACION

DROP PROCEDURE IF EXISTS sp_UpdateLocalizacion//

CREATE PROCEDURE sp_UpdateLocalizacion(
    IN p_ID_localizacion INT,
    IN p_Nombre VARCHAR(150),
    IN p_Direccion VARCHAR(200),
    IN p_Tipo VARCHAR(100),
    IN p_Permisos VARCHAR(100),
    IN p_Estado VARCHAR(100),
    IN p_Facilidades TEXT
)
BEGIN
    DECLARE v_count INT DEFAULT 0;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    SELECT COUNT(*)
    INTO v_count
    FROM localizacion
    WHERE ID_localizacion = p_ID_localizacion;

    IF v_count = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La localizacion no existe';
    END IF;

    UPDATE localizacion
    SET
        Nombre = p_Nombre,
        Direccion = p_Direccion,
        Tipo = p_Tipo,
        Permisos = p_Permisos,
        Estado = p_Estado,
        Facilidades = p_Facilidades
    WHERE ID_localizacion = p_ID_localizacion;

    COMMIT;

    SELECT 'Localizacion actualizada correctamente' AS Message;
END//


-- =========================================================
-- ELIMINAR LOCALIZACION

DROP PROCEDURE IF EXISTS sp_DeleteLocalizacion//

CREATE PROCEDURE sp_DeleteLocalizacion(
    IN p_ID_localizacion INT
)
BEGIN
    DECLARE v_count INT DEFAULT 0;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    SELECT COUNT(*)
    INTO v_count
    FROM localizacion
    WHERE ID_localizacion = p_ID_localizacion;

    IF v_count = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La localizacion no existe';
    END IF;

    DELETE FROM localizacion
    WHERE ID_localizacion = p_ID_localizacion;

    COMMIT;

    SELECT 'Localizacion eliminada correctamente' AS Message;
END//


-- =========================================================
-- OBTENER LOCALIZACION POR ID

DROP PROCEDURE IF EXISTS sp_GetLocalizacion//

CREATE PROCEDURE sp_GetLocalizacion(
    IN p_ID_localizacion INT
)
BEGIN
    SELECT
        ID_localizacion AS ID,
        Nombre,
        Direccion,
        Tipo,
        Permisos,
        Estado,
        Facilidades
    FROM localizacion
    WHERE ID_localizacion = p_ID_localizacion;
END//


-- =========================================================
-- OBTENER TODAS LAS LOCALIZACIONES

DROP PROCEDURE IF EXISTS sp_GetAllLocalizaciones//

CREATE PROCEDURE sp_GetAllLocalizaciones()
BEGIN
    SELECT
        ID_localizacion AS ID,
        Nombre,
        Direccion,
        Tipo,
        Permisos,
        Estado,
        Facilidades
    FROM localizacion
    ORDER BY Nombre;
END//

DELIMITER ;

USE mediapro;
SELECT * FROM plan_rodaje
-- =========================================================
-- INSERTAR PLAN DE RODAJE

DELIMITER //

DROP PROCEDURE IF EXISTS sp_InsertPlanRodaje//

CREATE PROCEDURE sp_InsertPlanRodaje(
    IN p_Fecha DATE,
    IN p_Dia_rodaje VARCHAR(100),
    IN p_Eficiencia VARCHAR(100),
    IN p_Requerimientos TEXT,
    IN p_Plan_contingencia TEXT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    INSERT INTO plan_rodaje
    (
        Fecha,
        Dia_rodaje,
        Eficiencia,
        Requerimientos,
        Plan_contingencia
    )
    VALUES
    (
        p_Fecha,
        p_Dia_rodaje,
        p_Eficiencia,
        p_Requerimientos,
        p_Plan_contingencia
    );

    COMMIT;

    SELECT
        LAST_INSERT_ID() AS ID_plan,
        'Plan de rodaje insertado correctamente' AS Message;
END//


-- =========================================================
-- ACTUALIZAR PLAN DE RODAJE

DROP PROCEDURE IF EXISTS sp_UpdatePlanRodaje//

CREATE PROCEDURE sp_UpdatePlanRodaje(
    IN p_ID_plan INT,
    IN p_Fecha DATE,
    IN p_Dia_rodaje VARCHAR(100),
    IN p_Eficiencia VARCHAR(100),
    IN p_Requerimientos TEXT,
    IN p_Plan_contingencia TEXT
)
BEGIN
    DECLARE v_count INT DEFAULT 0;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    SELECT COUNT(*)
    INTO v_count
    FROM plan_rodaje
    WHERE ID_plan = p_ID_plan;

    IF v_count = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El plan de rodaje no existe';
    END IF;

    UPDATE plan_rodaje
    SET
        Fecha = p_Fecha,
        Dia_rodaje = p_Dia_rodaje,
        Eficiencia = p_Eficiencia,
        Requerimientos = p_Requerimientos,
        Plan_contigencia = p_Plan_contingencia
    WHERE ID_plan = p_ID_plan;

    COMMIT;

    SELECT 'Plan de rodaje actualizado correctamente' AS Message;
END//


-- =========================================================
-- ELIMINAR PLAN DE RODAJE

DROP PROCEDURE IF EXISTS sp_DeletePlanRodaje//

CREATE PROCEDURE sp_DeletePlanRodaje(
    IN p_ID_plan INT
)
BEGIN
    DECLARE v_count INT DEFAULT 0;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    SELECT COUNT(*)
    INTO v_count
    FROM plan_rodaje
    WHERE ID_plan = p_ID_plan;

    IF v_count = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El plan de rodaje no existe';
    END IF;

    DELETE FROM plan_rodaje
    WHERE ID_plan = p_ID_plan;

    COMMIT;

    SELECT 'Plan de rodaje eliminado correctamente' AS Message;
END//


-- =========================================================
-- OBTENER PLAN DE RODAJE POR ID

DROP PROCEDURE IF EXISTS sp_GetPlanRodaje//

CREATE PROCEDURE sp_GetPlanRodaje(
    IN p_ID_plan INT
)
BEGIN
    SELECT
        ID_plan AS ID,
        Fecha,
        Dia_rodaje,
        Eficiencia,
        Requerimientos,
        Plan_contingencia
    FROM plan_rodaje
    WHERE ID_plan = p_ID_plan;
END//


-- =========================================================
-- OBTENER TODOS LOS PLANES DE RODAJE

DROP PROCEDURE IF EXISTS sp_GetAllPlanRodaje//

CREATE PROCEDURE sp_GetAllPlanRodaje()
BEGIN
    SELECT
        ID_plan AS ID,
        Fecha,
        Dia_rodaje,
        Eficiencia,
        Requerimientos,
        Plan_contingencia
    FROM plan_rodaje
    ORDER BY Fecha;
END//

DELIMITER ;