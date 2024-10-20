
-- Función para insertar empleados
CREATE OR REPLACE FUNCTION insertar_datos_laborales(cantidad INT) RETURNS VOID AS $$
DECLARE
    i INT := 1;
    empleado_id UUID;
    categoria_id UUID;
    departamento_id UUID;
    anios INT;  -- Variable para almacenar el cálculo del intervalo
BEGIN
    WHILE i <= cantidad LOOP
        -- Obtener un id_empleado existente aleatoriamente
        SELECT id_empleado INTO empleado_id FROM empleados WHERE id_empleado NOT IN (SELECT id_empleado FROM datos_laborales) ORDER BY RANDOM() LIMIT 1;
        -- Obtener un id_categoria existente aleatoriamente
        SELECT id_categoria INTO categoria_id FROM categorias ORDER BY RANDOM() LIMIT 1;
        -- Obtener un id_departamento existente aleatoriamente
        SELECT id_departamento INTO departamento_id FROM departamentos ORDER BY RANDOM() LIMIT 1;

        -- Calcular el intervalo de años aleatorio
        anios := FLOOR(RANDOM() * 10)::INT;

        -- Insertar el registro en datos_laborales
        INSERT INTO datos_laborales (id_dato_laboral, id_empleado, id_categoria, id_departamento, legajo, fecha_ingreso, funcion, horario_trabajo, turno)
        VALUES (gen_random_uuid(), empleado_id, categoria_id, departamento_id, 
                'LEG-' || i, 
                CURRENT_DATE - (anios || ' years')::INTERVAL, 
                'Funcion-' || i, 
                CASE WHEN i % 2 = 0 THEN '08:00-16:00' ELSE '16:00-00:00' END, 
                CASE WHEN i % 2 = 0 THEN 'Matutino' ELSE 'Vespertino' END);
        i := i + 1;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Función para insertar categorías
CREATE OR REPLACE FUNCTION insertar_categorias(cantidad INT) RETURNS VOID AS $$
DECLARE
    i INT := 1;
    anios INT;
BEGIN
    WHILE i <= cantidad LOOP
        -- Calcular el valor aleatorio de años
        anios := FLOOR(RANDOM() * 10)::INT;

        INSERT INTO categorias (id_categoria, nombre_categoria, fecha_designacion, resolucion)
        VALUES (gen_random_uuid(), 
                'Categoria' || i, 
                CURRENT_DATE - (anios || ' years')::INTERVAL, 
                'Resolucion-' || i);
        i := i + 1;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Función para insertar departamentos
CREATE OR REPLACE FUNCTION insertar_departamentos(cantidad INT) RETURNS VOID AS $$
DECLARE
    i INT := 1;
BEGIN
    WHILE i <= cantidad LOOP
        INSERT INTO departamentos (id_departamento, nombre_departamento)
        VALUES (gen_random_uuid(), 
                'Departamento' || i);
        i := i + 1;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Función para insertar datos laborales
CREATE OR REPLACE FUNCTION insertar_datos_laborales(cantidad INT) RETURNS VOID AS $$
DECLARE
    i INT := 1;
    empleado_id UUID;
    categoria_id UUID;
    departamento_id UUID;
    anios INT;  -- Variable para almacenar el cálculo del intervalo
BEGIN
    WHILE i <= cantidad LOOP
        -- Obtener un id_empleado existente aleatoriamente
        SELECT id_empleado INTO empleado_id FROM empleados WHERE id_empleado NOT IN (SELECT id_empleado FROM datos_laborales) ORDER BY RANDOM() LIMIT 1;
        -- Obtener un id_categoria existente aleatoriamente
        SELECT id_categoria INTO categoria_id FROM categorias ORDER BY RANDOM() LIMIT 1;
        -- Obtener un id_departamento existente aleatoriamente
        SELECT id_departamento INTO departamento_id FROM departamentos ORDER BY RANDOM() LIMIT 1;

        -- Calcular el intervalo de años aleatorio
        anios := FLOOR(RANDOM() * 10)::INT;

        -- Insertar el registro en datos_laborales
        INSERT INTO datos_laborales (id_dato_laboral, id_empleado, id_categoria, id_departamento, legajo, fecha_ingreso, funcion, horario_trabajo, turno)
        VALUES (gen_random_uuid(), empleado_id, categoria_id, departamento_id, 
                'LEG-' || i, 
                CURRENT_DATE - (anios || ' years')::INTERVAL, 
                'Funcion-' || i, 
                CASE WHEN i % 2 = 0 THEN '08:00-16:00' ELSE '16:00-00:00' END, 
                CASE WHEN i % 2 = 0 THEN 'Matutino' ELSE 'Vespertino' END);
        i := i + 1;
    END LOOP;
END;
$$ LANGUAGE plpgsql;