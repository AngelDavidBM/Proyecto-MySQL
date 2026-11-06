USE proyecto_gestion;

-- 1 y 4. Calificación solo de productos realmente comprados, por el dueño del pedido
ALTER TABLE PEDIDO
  ADD CONSTRAINT uq_pedido_cliente UNIQUE (id_pedido, id_cliente);

ALTER TABLE CALIFICACION
  ADD CONSTRAINT fk_calif_detalle
    FOREIGN KEY (id_pedido, id_producto)
    REFERENCES DETALLE_PEDIDO (id_pedido, id_producto)
    ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT fk_calif_pedido_cliente
    FOREIGN KEY (id_pedido, id_cliente)
    REFERENCES PEDIDO (id_pedido, id_cliente)
    ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT uq_calif_unica UNIQUE (id_pedido, id_producto);

-- 2. La dirección del pedido debe ser del mismo cliente
ALTER TABLE DIRECCION
  ADD CONSTRAINT uq_direccion_cliente UNIQUE (id_direccion, id_cliente);

ALTER TABLE PEDIDO
  ADD CONSTRAINT fk_pedido_dir_cliente
    FOREIGN KEY (id_direccion, id_cliente)
    REFERENCES DIRECCION (id_direccion, id_cliente)
    ON DELETE RESTRICT ON UPDATE CASCADE;

-- 3. Estados válidos
ALTER TABLE PEDIDO
  ADD CONSTRAINT chk_pedido_estado CHECK (estado_actual IN
    ('creado','confirmado','preparado','enviado','entregado','cancelado','devuelto'));

ALTER TABLE HISTORIAL_ESTADO_PEDIDO
  ADD CONSTRAINT chk_historial_estado CHECK (estado IN
    ('creado','confirmado','preparado','enviado','entregado','cancelado','devuelto'));

ALTER TABLE PAGO
  ADD CONSTRAINT chk_pago_estado CHECK (estado_pago IN
    ('pendiente','aprobado','rechazado'));