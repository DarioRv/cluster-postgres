
-- Creación de la base de datos (no es compatible con USE, se debe conectar externamente)
-- CREATE DATABASE sistema_ausentismo;

-- Crear tipos ENUM
CREATE TYPE sexo_enum AS ENUM ('M', 'F');
CREATE TYPE turno_enum AS ENUM ('Matutino', 'Vespertino');
CREATE TYPE tipo_parte_enum AS ENUM ('Médico', 'Licencia', 'Falta con aviso');
CREATE TYPE estado_enum AS ENUM ('Anulado', 'Justificado');

-- Tabla de Categorías
CREATE TABLE categorias (
    id_categoria UUID PRIMARY KEY,
    nombre_categoria VARCHAR(50) NOT NULL,
    fecha_designacion DATE NOT NULL,
    resolucion VARCHAR(50) NOT NULL
);

-- Tabla de Empleados
CREATE TABLE empleados (
    id_empleado UUID PRIMARY KEY,
    apellido VARCHAR(50) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    dni VARCHAR(20) UNIQUE NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    cuil VARCHAR(20) NOT NULL,
    sexo sexo_enum NOT NULL,
    estado_civil VARCHAR(20) NOT NULL,
    nivel_estudio VARCHAR(50) NOT NULL,
    nacionalidad VARCHAR(50) NOT NULL
);

-- Crear índice en la columna DNI para mejorar las búsquedas rápidas
CREATE INDEX idx_empleado_dni ON empleados (dni);

-- Tabla de Departamentos
CREATE TABLE departamentos (
    id_departamento UUID PRIMARY KEY,
    nombre_departamento VARCHAR(100) NOT NULL
);

-- Tabla de Funciones
CREATE TABLE funciones (
    id_funcion UUID PRIMARY KEY,
    nombre_funcion VARCHAR(100) NOT NULL
);

-- Tabla de Turnos
CREATE TABLE turnos (
    id_turno UUID PRIMARY KEY,
    nombre_turno turno_enum NOT NULL
);

-- Tabla de Datos Laborales
CREATE TABLE datos_laborales (
    id_dato_laboral UUID PRIMARY KEY,
    id_empleado UUID NOT NULL,
    id_categoria UUID NOT NULL,
    id_departamento UUID NOT NULL,
    id_funcion UUID NOT NULL,
    id_turno UUID NOT NULL,
    legajo VARCHAR(20) UNIQUE NOT NULL,
    fecha_ingreso DATE NOT NULL,
    horario_trabajo VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria),
    FOREIGN KEY (id_departamento) REFERENCES departamentos(id_departamento),
    FOREIGN KEY (id_funcion) REFERENCES funciones(id_funcion),
    FOREIGN KEY (id_turno) REFERENCES turnos(id_turno)
);

-- Crear índice en el legajo para búsquedas eficientes
CREATE INDEX idx_datos_laborales_legajo ON datos_laborales (legajo);

-- Tabla de Domicilio
CREATE TABLE domicilios (
    id_domicilio UUID PRIMARY KEY,
    id_empleado UUID NOT NULL,
    calle VARCHAR(100) NOT NULL,
    numero INT NOT NULL,
    barrio VARCHAR(50) NOT NULL,
    localidad VARCHAR(50) NOT NULL,
    provincia VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
);

-- Tabla de Grupo Familiar
CREATE TABLE grupo_familiar (
    id_familiar UUID PRIMARY KEY,
    id_empleado UUID NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    dni VARCHAR(20) NOT NULL,
    vinculo VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
);

-- Tabla de Tardanzas
CREATE TABLE tardanzas (
    id_tardanza UUID PRIMARY KEY,
    id_empleado UUID NOT NULL,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
);

-- Crear índice para acelerar las búsquedas por fecha
CREATE INDEX idx_tardanzas_fecha ON tardanzas (fecha);

-- Tabla de Partes y Novedades
CREATE TABLE partes_novedades (
    id_parte UUID PRIMARY KEY,
    id_empleado UUID NOT NULL,
    tipo_parte tipo_parte_enum NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_finalizacion DATE NOT NULL,
    observacion TEXT NOT NULL,
    estado estado_enum NOT NULL,
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
);

-- Tabla de Ficha Médica
CREATE TABLE ficha_medica (
    id_ficha_medica UUID PRIMARY KEY,
    id_empleado UUID NOT NULL,
    antecedentes_medicos TEXT NOT NULL,
    alergia_medico VARCHAR(100) NOT NULL,
    factor_sangre VARCHAR(3) NOT NULL,
    diagnostico TEXT NOT NULL,
    dias_establecidos INT NOT NULL,
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
);

-- Tabla de Sanciones
CREATE TABLE sanciones (
    id_sancion UUID PRIMARY KEY,
    id_empleado UUID NOT NULL,
    nombre_sancion VARCHAR(100) NOT NULL,
    articulo VARCHAR(100) NOT NULL,
    observacion TEXT NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
);

-- Tabla de Expedientes
CREATE TABLE expedientes (
    id_expediente UUID PRIMARY KEY,
    id_empleado UUID NOT NULL,
    numero_expediente VARCHAR(20) NOT NULL,
    legajo VARCHAR(20) NOT NULL,
    libro VARCHAR(20) NOT NULL,
    tomo VARCHAR(20) NOT NULL,
    fojas VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
);

-- Tabla de Trámites del Expediente
CREATE TABLE tramites_expediente (
    id_tramite UUID PRIMARY KEY,
    id_expediente UUID NOT NULL,
    descripcion_tramite TEXT NOT NULL,
    fecha_tramite DATE NOT NULL,
    FOREIGN KEY (id_expediente) REFERENCES expedientes(id_expediente)
);

-- Tabla de Títulos
CREATE TABLE titulos (
    id_titulo UUID PRIMARY KEY,
    id_empleado UUID NOT NULL,
    nombre_titulo VARCHAR(100) NOT NULL,
    nombre_institucion VARCHAR(100) NOT NULL,
    fecha_obtencion DATE NOT NULL,
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
);
