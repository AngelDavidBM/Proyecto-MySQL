USE proyecto_gestion;
DELIMITER $$
CREATE TRIGGER trg_calificacion_entregado
BEFORE INSERT ON CALIFICACION
FOR EACH ROW
BEGIN
  IF (SELECT estado_actual FROM PEDIDO WHERE id_pedido = NEW.id_pedido) <> 'entregado' THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Solo se pueden calificar productos de pedidos entregados';
  END IF;
END$$
DELIMITER ;