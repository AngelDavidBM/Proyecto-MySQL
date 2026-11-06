USE proyecto_gestion;
CREATE TABLE CLIENTE (
    id_cliente INT AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    telefono VARCHAR(20),
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_cliente
        PRIMARY KEY (id_cliente)
);






CREATE TABLE PROVEEDOR (
    id_proveedor INT AUTO_INCREMENT,
    nombre VARCHAR(150) NOT NULL,
    contacto VARCHAR(100),
    telefono VARCHAR(20),
    email VARCHAR(150),
    direccion VARCHAR(255),

    CONSTRAINT pk_proveedor
        PRIMARY KEY (id_proveedor)
);





CREATE TABLE CATEGORIA (
    id_categoria INT AUTO_INCREMENT,
    id_categoria_padre INT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,

    CONSTRAINT pk_categoria
        PRIMARY KEY (id_categoria),

    CONSTRAINT fk_categoria_padre
        FOREIGN KEY (id_categoria_padre)
        REFERENCES CATEGORIA(id_categoria)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);






CREATE TABLE PRODUCTO (
    id_producto INT AUTO_INCREMENT,
    id_categoria INT NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(12,2) NOT NULL,
    estado VARCHAR(30) NOT NULL,

    CONSTRAINT pk_producto
        PRIMARY KEY (id_producto),

    CONSTRAINT fk_producto_categoria
        FOREIGN KEY (id_categoria)
        REFERENCES CATEGORIA(id_categoria)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT chk_producto_precio
        CHECK (precio >= 0)
);






CREATE TABLE SUMINISTRA (
    id_proveedor INT,
    id_producto INT,
    precio_proveedor DECIMAL(12,2) NOT NULL,
    fecha_suministro DATE,

    CONSTRAINT pk_suministra
        PRIMARY KEY (id_proveedor, id_producto),

    CONSTRAINT fk_suministra_proveedor
        FOREIGN KEY (id_proveedor)
        REFERENCES PROVEEDOR(id_proveedor)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_suministra_producto
        FOREIGN KEY (id_producto)
        REFERENCES PRODUCTO(id_producto)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT chk_suministra_precio
        CHECK (precio_proveedor >= 0)
);






CREATE TABLE FOTO_PRODUCTO (
    id_foto INT AUTO_INCREMENT,
    id_producto INT NOT NULL,
    url VARCHAR(500) NOT NULL,
    orden INT,

    CONSTRAINT pk_foto_producto
        PRIMARY KEY (id_foto),

    CONSTRAINT fk_foto_producto
        FOREIGN KEY (id_producto)
        REFERENCES PRODUCTO(id_producto)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT chk_foto_orden
        CHECK (orden IS NULL OR orden >= 0)
);





CREATE TABLE CARACTERISTICA_PRODUCTO (
    id_caracteristica INT AUTO_INCREMENT,
    id_producto INT NOT NULL,
    nombre_atributo VARCHAR(100) NOT NULL,
    valor_atributo VARCHAR(255) NOT NULL,

    CONSTRAINT pk_caracteristica_producto
        PRIMARY KEY (id_caracteristica),

    CONSTRAINT fk_caracteristica_producto
        FOREIGN KEY (id_producto)
        REFERENCES PRODUCTO(id_producto)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);






CREATE TABLE PROMOCION (
    id_promocion INT AUTO_INCREMENT,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    descuento DECIMAL(5,2) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,

    CONSTRAINT pk_promocion
        PRIMARY KEY (id_promocion),

    CONSTRAINT chk_promocion_descuento
        CHECK (descuento >= 0 AND descuento <= 100),

    CONSTRAINT chk_promocion_fechas
        CHECK (fecha_fin >= fecha_inicio)
);





CREATE TABLE PROMOCION_PRODUCTO (
    id_promocion INT,
    id_producto INT,
    descuento_aplicado DECIMAL(5,2) NOT NULL,

    CONSTRAINT pk_promocion_producto
        PRIMARY KEY (id_promocion, id_producto),

    CONSTRAINT fk_promocion_producto_promocion
        FOREIGN KEY (id_promocion)
        REFERENCES PROMOCION(id_promocion)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_promocion_producto_producto
        FOREIGN KEY (id_producto)
        REFERENCES PRODUCTO(id_producto)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT chk_descuento_aplicado
        CHECK (descuento_aplicado >= 0 AND descuento_aplicado <= 100)
);





CREATE TABLE DIRECCION (
    id_direccion INT AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    calle VARCHAR(150) NOT NULL,
    ciudad VARCHAR(100) NOT NULL,
    departamento VARCHAR(100) NOT NULL,
    codigo_postal VARCHAR(20),
    pais VARCHAR(100) NOT NULL,
    referencia VARCHAR(255),

    CONSTRAINT pk_direccion
        PRIMARY KEY (id_direccion),

    CONSTRAINT fk_direccion_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES CLIENTE(id_cliente)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);






CREATE TABLE PEDIDO (
    id_pedido INT AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    id_direccion INT NOT NULL,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    estado_actual VARCHAR(50) NOT NULL,
    valor_total DECIMAL(12,2) NOT NULL,

    CONSTRAINT pk_pedido
        PRIMARY KEY (id_pedido),

    CONSTRAINT fk_pedido_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES CLIENTE(id_cliente)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_pedido_direccion
        FOREIGN KEY (id_direccion)
        REFERENCES DIRECCION(id_direccion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT chk_pedido_total
        CHECK (valor_total >= 0)
);





CREATE TABLE DETALLE_PEDIDO (
    id_pedido INT,
    id_producto INT,
    cantidad INT NOT NULL,
    precio_venta DECIMAL(12,2) NOT NULL,

    CONSTRAINT pk_detalle_pedido
        PRIMARY KEY (id_pedido, id_producto),

    CONSTRAINT fk_detalle_pedido_pedido
        FOREIGN KEY (id_pedido)
        REFERENCES PEDIDO(id_pedido)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_detalle_pedido_producto
        FOREIGN KEY (id_producto)
        REFERENCES PRODUCTO(id_producto)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT chk_detalle_cantidad
        CHECK (cantidad > 0),

    CONSTRAINT chk_detalle_precio
        CHECK (precio_venta >= 0)
);






CREATE TABLE HISTORIAL_ESTADO_PEDIDO (
    id_historial INT AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    estado VARCHAR(50) NOT NULL,
    fecha_cambio DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_historial_estado_pedido
        PRIMARY KEY (id_historial),

    CONSTRAINT fk_historial_pedido
        FOREIGN KEY (id_pedido)
        REFERENCES PEDIDO(id_pedido)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);



-- 14. PAGO
-- Un pedido puede tener uno o varios intentos/registros de pago


CREATE TABLE PAGO (
    id_pago INT AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    medio_pago VARCHAR(50) NOT NULL,
    monto DECIMAL(12,2) NOT NULL,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    estado_pago VARCHAR(50) NOT NULL,

    CONSTRAINT pk_pago
        PRIMARY KEY (id_pago),

    CONSTRAINT fk_pago_pedido
        FOREIGN KEY (id_pedido)
        REFERENCES PEDIDO(id_pedido)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT chk_pago_monto
        CHECK (monto >= 0)
);






CREATE TABLE CALIFICACION (
    id_calificacion INT AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    id_producto INT NOT NULL,
    id_pedido INT NOT NULL,
    puntuacion INT NOT NULL,
    comentario TEXT,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_calificacion
        PRIMARY KEY (id_calificacion),

    CONSTRAINT fk_calificacion_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES CLIENTE(id_cliente)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_calificacion_producto
        FOREIGN KEY (id_producto)
        REFERENCES PRODUCTO(id_producto)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_calificacion_pedido
        FOREIGN KEY (id_pedido)
        REFERENCES PEDIDO(id_pedido)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT chk_calificacion_puntuacion
        CHECK (puntuacion BETWEEN 1 AND 5)
);