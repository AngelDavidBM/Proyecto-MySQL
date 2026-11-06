

USE proyecto_gestion;


SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE CALIFICACION;
TRUNCATE TABLE PAGO;
TRUNCATE TABLE HISTORIAL_ESTADO_PEDIDO;
TRUNCATE TABLE DETALLE_PEDIDO;
TRUNCATE TABLE PEDIDO;
TRUNCATE TABLE DIRECCION;
TRUNCATE TABLE PROMOCION_PRODUCTO;
TRUNCATE TABLE PROMOCION;
TRUNCATE TABLE CARACTERISTICA_PRODUCTO;
TRUNCATE TABLE FOTO_PRODUCTO;
TRUNCATE TABLE SUMINISTRA;
TRUNCATE TABLE PRODUCTO;
TRUNCATE TABLE CATEGORIA;
TRUNCATE TABLE PROVEEDOR;
TRUNCATE TABLE CLIENTE;
SET FOREIGN_KEY_CHECKS = 1;


INSERT INTO CLIENTE (nombre, email, password, telefono) VALUES
('Ana Gómez',      'ana@ejemplo.com',    'hash_demo_ana_0001',    '3001234567'),
('Luis Pérez',     'luis@ejemplo.com',   'hash_demo_luis_0002',   '3109876543'),
('Marta Rojas',    'marta@ejemplo.com',  'hash_demo_marta_0003',  '3152345678'),
('Carlos Mendoza', 'carlos@ejemplo.com', 'hash_demo_carlos_0004', '3205558899'),
('Sofía Herrera',  'sofia@ejemplo.com',  'hash_demo_sofia_0005',  NULL);


INSERT INTO PROVEEDOR (nombre, contacto, telefono, email, direccion) VALUES
('TecnoDistribuciones SAS',  'Carlos Ruiz',   '6041112233', 'ventas@tecnodistribuciones.com', 'Calle 10 # 20-30, Medellín'),
('Textiles Andinos Ltda.',   'Paula Vargas',  '6013334455', 'contacto@textilesandinos.com',   'Carrera 13 # 45-12, Bogotá'),
('Calzado y Hogar del Caribe', 'Jorge Salcedo', '6055556677', 'pedidos@calzadohogar.com',      'Zona Industrial, Barranquilla');


INSERT INTO CATEGORIA (id_categoria_padre, nombre, descripcion) VALUES
(NULL, 'Tecnología',   'Dispositivos y accesorios electrónicos'),   -- 1
(1,    'Computadores', 'Portátiles y equipos de escritorio'),       -- 2
(1,    'Celulares',    'Teléfonos móviles'),                        -- 3
(NULL, 'Ropa',         'Prendas de vestir'),                        -- 4
(4,    'Camisas',      'Camisas para hombre y mujer'),              -- 5
(4,    'Calzado',      'Tenis y zapatos'),                          -- 6
(NULL, 'Hogar',        'Electrodomésticos y textiles para el hogar'); -- 7


INSERT INTO PRODUCTO (id_categoria, nombre, descripcion, precio, estado) VALUES
(2, 'Portátil Lenovo IdeaPad 3',      'Portátil de 15.6 pulgadas para trabajo y estudio', 2350000.00, 'disponible'),   -- 1
(2, 'Portátil HP Pavilion 15',        'Portátil con pantalla Full HD y teclado numérico', 3200000.00, 'disponible'),   -- 2
(3, 'Samsung Galaxy A55',             'Smartphone con pantalla AMOLED y cámara de 50 MP', 1450000.00, 'disponible'),   -- 3
(3, 'Xiaomi Redmi Note 13',           'Smartphone de gama media con carga rápida',          899000.00, 'disponible'),   -- 4
(1, 'Audífonos Sony WH-CH520',        'Audífonos inalámbricos con 50 horas de batería',     189000.00, 'disponible'),   -- 5
(5, 'Camisa Oxford Slim Fit',         'Camisa de algodón manga larga',                       89900.00, 'disponible'),   -- 6
(5, 'Camisa de Lino Manga Larga',     'Camisa fresca de lino para clima cálido',            119900.00, 'disponible'),   -- 7
(6, 'Tenis Nike Revolution',          'Tenis de running livianos',                          259000.00, 'disponible'),   -- 8
(6, 'Zapatos Casuales de Cuero',      'Zapato de cuero para uso diario',                    179000.00, 'agotado'),      -- 9
(7, 'Licuadora Oster 600 W',          'Licuadora con vaso de vidrio',                       159000.00, 'disponible'),   -- 10
(7, 'Juego de Sábanas Queen',         'Sábanas de microfibra, 4 piezas',                     99000.00, 'disponible'),   -- 11
(4, 'Chaqueta Impermeable',           'Chaqueta ligera con capucha',                        149000.00, 'descontinuado'); -- 12

INSERT INTO SUMINISTRA (id_proveedor, id_producto, precio_proveedor, fecha_suministro) VALUES
(1, 1, 1900000.00, '2026-08-01'),
(1, 2, 2700000.00, '2026-08-01'),
(1, 3, 1150000.00, '2026-08-05'),
(1, 4,  700000.00, '2026-08-05'),
(1, 5,  140000.00, '2026-08-10'),
(2, 6,   45000.00, '2026-08-12'),
(2, 7,   62000.00, '2026-08-12'),
(2, 11,  55000.00, '2026-08-15'),
(2, 12,  90000.00, '2026-07-20'),
(3, 8,  170000.00, '2026-08-18'),
(3, 9,  110000.00, '2026-08-18'),
(3, 10, 105000.00, '2026-08-20'),
(3, 11,  60000.00, '2026-08-22');   -- el producto 11 tiene dos proveedores


INSERT INTO FOTO_PRODUCTO (id_producto, url, orden) VALUES
(1,  'https://ejemplo.com/fotos/ideapad3_1.jpg', 1),
(1,  'https://ejemplo.com/fotos/ideapad3_2.jpg', 2),
(2,  'https://ejemplo.com/fotos/pavilion15_1.jpg', 1),
(3,  'https://ejemplo.com/fotos/galaxy_a55_1.jpg', 1),
(3,  'https://ejemplo.com/fotos/galaxy_a55_2.jpg', 2),
(4,  'https://ejemplo.com/fotos/redmi_note13_1.jpg', 1),
(5,  'https://ejemplo.com/fotos/sony_ch520_1.jpg', 1),
(6,  'https://ejemplo.com/fotos/oxford_1.jpg', 1),
(7,  'https://ejemplo.com/fotos/lino_1.jpg', 1),
(8,  'https://ejemplo.com/fotos/nike_revolution_1.jpg', 1),
(8,  'https://ejemplo.com/fotos/nike_revolution_2.jpg', 2),
(10, 'https://ejemplo.com/fotos/oster_600_1.jpg', 1),
(11, 'https://ejemplo.com/fotos/sabanas_queen_1.jpg', 1);


INSERT INTO CARACTERISTICA_PRODUCTO (id_producto, nombre_atributo, valor_atributo) VALUES
(1, 'Memoria RAM', '8 GB'),
(1, 'Almacenamiento', '512 GB SSD'),
(1, 'Procesador', 'Intel Core i5'),
(2, 'Memoria RAM', '16 GB'),
(2, 'Almacenamiento', '1 TB SSD'),
(3, 'Memoria RAM', '8 GB'),
(3, 'Almacenamiento', '256 GB'),
(3, 'Pantalla', '6.6 pulgadas'),
(4, 'Memoria RAM', '8 GB'),
(4, 'Almacenamiento', '256 GB'),
(4, 'Color', 'Negro'),
(6, 'Talla', 'M'),
(6, 'Color', 'Azul'),
(7, 'Talla', 'L'),
(7, 'Color', 'Blanco'),
(8, 'Talla', '41'),
(8, 'Color', 'Gris'),
(10, 'Potencia', '600 W'),
(10, 'Capacidad', '1.5 L');


INSERT INTO PROMOCION (nombre, descripcion, descuento, fecha_inicio, fecha_fin) VALUES
('Octubre Tecnológico',  'Descuentos en celulares y accesorios',  10.00, '2026-10-01', '2026-10-31'), -- 1
('Moda de Temporada',    'Descuentos en ropa y calzado',          15.00, '2026-10-10', '2026-10-25'), -- 2
('Black Friday',         'Grandes descuentos en tecnología',      30.00, '2026-11-20', '2026-11-30'), -- 3
('Septiembre del Hogar', 'Descuentos en productos para el hogar', 20.00, '2026-09-01', '2026-09-30'); -- 4

INSERT INTO PROMOCION_PRODUCTO (id_promocion, id_producto, descuento_aplicado) VALUES
(1, 3, 10.00),
(1, 4, 10.00),
(1, 5, 12.00),   
(2, 6, 15.00),
(2, 7, 15.00),
(2, 8, 20.00),
(3, 1, 30.00),
(3, 2, 25.00),
(4, 10, 20.00),
(4, 11, 20.00);


INSERT INTO DIRECCION (id_cliente, calle, ciudad, departamento, codigo_postal, pais, referencia) VALUES
(1, 'Carrera 45 # 12-34',        'Medellín',     'Antioquia',       '050001', 'Colombia', 'Apto 301'),            -- 1
(1, 'Calle 100 # 15-20',         'Bogotá',       'Cundinamarca',    '110111', 'Colombia', 'Oficina 502'),         -- 2
(2, 'Carrera 8 # 20-15',         'Cali',         'Valle del Cauca', '760001', 'Colombia', 'Casa esquinera'),     -- 3
(3, 'Calle 72 # 50-10',          'Barranquilla', 'Atlántico',       '080001', 'Colombia', 'Torre B, apto 804'),  -- 4
(4, 'Avenida del Lago # 5-30',   'Cartagena',    'Bolívar',         '130001', 'Colombia', NULL),                 -- 5
(5, 'Calle 30 # 25-40',          'Bogotá',       'Cundinamarca',    '110221', 'Colombia', 'Conjunto Los Pinos'), -- 6
(2, 'Transversal 5 # 40-12',     'Cali',         'Valle del Cauca', '760002', 'Colombia', 'Local comercial');    -- 7


INSERT INTO PEDIDO (id_cliente, id_direccion, fecha, estado_actual, valor_total) VALUES
(1, 1, '2026-09-15 10:30:00', 'entregado',  1639000.00),  -- 1
(2, 3, '2026-09-20 14:15:00', 'entregado',   438800.00),  -- 2
(3, 4, '2026-10-02 09:00:00', 'enviado',     975420.00),  -- 3
(4, 5, '2026-10-08 16:45:00', 'confirmado',  357000.00),  -- 4
(1, 2, '2026-10-10 11:20:00', 'cancelado',  3200000.00),  -- 5
(5, 6, '2026-10-12 08:05:00', 'creado',      178330.00),  -- 6
(2, 7, '2026-08-25 18:00:00', 'devuelto',    259000.00),  -- 7
(3, 4, '2026-09-05 12:40:00', 'entregado',  2509000.00);  -- 8


INSERT INTO DETALLE_PEDIDO (id_pedido, id_producto, cantidad, precio_venta) VALUES
(1, 3, 1, 1450000.00),
(1, 5, 1,  189000.00),
(2, 6, 2,   89900.00),
(2, 8, 1,  259000.00),
(3, 4, 1,  809100.00),   -- 899.000 con 10% de descuento
(3, 5, 1,  166320.00),   -- 189.000 con 12% de descuento
(4, 10, 1, 159000.00),
(4, 11, 2,  99000.00),
(5, 2, 1, 3200000.00),
(6, 7, 1,  101915.00),   -- 119.900 con 15% de descuento
(6, 6, 1,   76415.00),   -- 89.900 con 15% de descuento
(7, 8, 1,  259000.00),
(8, 1, 1, 2350000.00),
(8, 10, 1, 159000.00);


INSERT INTO HISTORIAL_ESTADO_PEDIDO (id_pedido, estado, fecha_cambio) VALUES
(1, 'creado',     '2026-09-15 10:30:00'),
(1, 'confirmado', '2026-09-15 10:45:00'),
(1, 'preparado',  '2026-09-16 09:00:00'),
(1, 'enviado',    '2026-09-16 15:00:00'),
(1, 'entregado',  '2026-09-19 12:10:00'),
(2, 'creado',     '2026-09-20 14:15:00'),
(2, 'confirmado', '2026-09-20 14:30:00'),
(2, 'preparado',  '2026-09-21 10:00:00'),
(2, 'enviado',    '2026-09-21 16:00:00'),
(2, 'entregado',  '2026-09-24 11:30:00'),
(3, 'creado',     '2026-10-02 09:00:00'),
(3, 'confirmado', '2026-10-02 09:06:00'),
(3, 'preparado',  '2026-10-03 10:00:00'),
(3, 'enviado',    '2026-10-04 14:00:00'),
(4, 'creado',     '2026-10-08 16:45:00'),
(4, 'confirmado', '2026-10-08 17:00:00'),
(5, 'creado',     '2026-10-10 11:20:00'),
(5, 'cancelado',  '2026-10-10 12:00:00'),
(6, 'creado',     '2026-10-12 08:05:00'),
(7, 'creado',     '2026-08-25 18:00:00'),
(7, 'confirmado', '2026-08-25 18:10:00'),
(7, 'preparado',  '2026-08-26 09:00:00'),
(7, 'enviado',    '2026-08-26 15:00:00'),
(7, 'entregado',  '2026-08-29 10:00:00'),
(7, 'devuelto',   '2026-09-02 09:30:00'),
(8, 'creado',     '2026-09-05 12:40:00'),
(8, 'confirmado', '2026-09-05 12:55:00'),
(8, 'preparado',  '2026-09-06 09:00:00'),
(8, 'enviado',    '2026-09-06 15:00:00'),
(8, 'entregado',  '2026-09-09 13:20:00');


INSERT INTO PAGO (id_pedido, medio_pago, monto, fecha, estado_pago) VALUES
(1, 'tarjeta',  1639000.00, '2026-09-15 10:35:00', 'aprobado'),
(2, 'PSE',       438800.00, '2026-09-20 14:20:00', 'aprobado'),
(3, 'tarjeta',   975420.00, '2026-10-02 09:02:00', 'rechazado'),
(3, 'tarjeta',   975420.00, '2026-10-02 09:05:00', 'aprobado'),
(4, 'PSE',       357000.00, '2026-10-08 16:55:00', 'aprobado'),
(5, 'tarjeta',  3200000.00, '2026-10-10 11:25:00', 'rechazado'),
(5, 'tarjeta',  3200000.00, '2026-10-10 11:40:00', 'rechazado'),
(6, 'PSE',       178330.00, '2026-10-12 08:10:00', 'pendiente'),
(7, 'tarjeta',   259000.00, '2026-08-25 18:05:00', 'aprobado'),
(8, 'PSE',      2509000.00, '2026-09-05 12:50:00', 'aprobado');


INSERT INTO CALIFICACION (id_cliente, id_producto, id_pedido, puntuacion, comentario, fecha) VALUES
(1, 3, 1, 5, 'Excelente celular, la cámara es muy buena.',        '2026-09-22 20:00:00'),
(1, 5, 1, 4, 'Buen sonido y la batería dura muchísimo.',          '2026-09-22 20:10:00'),
(2, 6, 2, 4, 'La tela es cómoda, la talla coincide.',             '2026-09-27 18:30:00'),
(2, 8, 2, 5, 'Muy livianos para correr.',                         '2026-09-27 18:40:00'),
(3, 1, 8, 5, 'Rápido y silencioso, ideal para estudiar.',         '2026-09-12 21:00:00'),
(3, 10, 8, 3, 'Funciona bien pero es algo ruidosa.',              '2026-09-12 21:05:00');


SELECT 'CLIENTE' AS tabla, COUNT(*) AS filas FROM CLIENTE
UNION ALL SELECT 'PROVEEDOR', COUNT(*) FROM PROVEEDOR
UNION ALL SELECT 'CATEGORIA', COUNT(*) FROM CATEGORIA
UNION ALL SELECT 'PRODUCTO', COUNT(*) FROM PRODUCTO
UNION ALL SELECT 'SUMINISTRA', COUNT(*) FROM SUMINISTRA
UNION ALL SELECT 'FOTO_PRODUCTO', COUNT(*) FROM FOTO_PRODUCTO
UNION ALL SELECT 'CARACTERISTICA_PRODUCTO', COUNT(*) FROM CARACTERISTICA_PRODUCTO
UNION ALL SELECT 'PROMOCION', COUNT(*) FROM PROMOCION
UNION ALL SELECT 'PROMOCION_PRODUCTO', COUNT(*) FROM PROMOCION_PRODUCTO
UNION ALL SELECT 'DIRECCION', COUNT(*) FROM DIRECCION
UNION ALL SELECT 'PEDIDO', COUNT(*) FROM PEDIDO
UNION ALL SELECT 'DETALLE_PEDIDO', COUNT(*) FROM DETALLE_PEDIDO
UNION ALL SELECT 'HISTORIAL_ESTADO_PEDIDO', COUNT(*) FROM HISTORIAL_ESTADO_PEDIDO
UNION ALL SELECT 'PAGO', COUNT(*) FROM PAGO
UNION ALL SELECT 'CALIFICACION', COUNT(*) FROM CALIFICACION;
