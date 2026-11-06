USE proyecto_gestion;

-- =====================================================================
-- Funciones almacenadas (prefijo fn_)
-- Declaran DETERMINISTIC / NO SQL / READS SQL DATA para poder crearse
-- aunque el binlog esté activo (log_bin_trust_function_creators=0).
-- =====================================================================
DROP FUNCTION IF EXISTS fn_precio_con_descuento;
DROP FUNCTION IF EXISTS fn_promedio_calificacion;
DROP FUNCTION IF EXISTS fn_total_pedido;
DROP FUNCTION IF EXISTS fn_margen_producto;
DROP FUNCTION IF EXISTS fn_dias_desde_pedido;

DELIMITER $$

-- ---------------------------------------------------------------------
-- fn_precio_con_descuento: precio con un porcentaje de descuento (0-100).
-- Si el porcentaje es NULL se devuelve el precio sin descuento.
-- ---------------------------------------------------------------------
CREATE FUNCTION fn_precio_con_descuento(
    p_precio     DECIMAL(12,2),
    p_porcentaje DECIMAL(5,2)
)
RETURNS DECIMAL(12,2)
DETERMINISTIC
NO SQL
BEGIN
    IF p_porcentaje IS NULL THEN
        RETURN p_precio;
    END IF;
    IF p_porcentaje < 0 OR p_porcentaje > 100 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El porcentaje de descuento debe estar entre 0 y 100';
    END IF;
    RETURN ROUND(p_precio * (1 - p_porcentaje / 100), 2);
END$$

-- ---------------------------------------------------------------------
-- fn_promedio_calificacion: promedio de puntuación del producto.
-- Devuelve 0 si no tiene calificaciones.
-- ---------------------------------------------------------------------
CREATE FUNCTION fn_promedio_calificacion(p_id_producto INT)
RETURNS DECIMAL(3,2)
READS SQL DATA
BEGIN
    DECLARE v_promedio DECIMAL(3,2);
    SELECT ROUND(AVG(puntuacion), 2) INTO v_promedio
      FROM CALIFICACION
     WHERE id_producto = p_id_producto;
    RETURN COALESCE(v_promedio, 0);
END$$

-- ---------------------------------------------------------------------
-- fn_total_pedido: suma de cantidad × precio_venta del pedido.
-- Devuelve 0 si el pedido no tiene detalle.
-- ---------------------------------------------------------------------
CREATE FUNCTION fn_total_pedido(p_id_pedido INT)
RETURNS DECIMAL(12,2)
READS SQL DATA
BEGIN
    DECLARE v_total DECIMAL(12,2);
    SELECT SUM(cantidad * precio_venta) INTO v_total
      FROM DETALLE_PEDIDO
     WHERE id_pedido = p_id_pedido;
    RETURN COALESCE(v_total, 0);
END$$

-- ---------------------------------------------------------------------
-- fn_margen_producto: precio de venta menos el precio_proveedor más bajo.
-- Devuelve NULL si el producto no existe o no tiene proveedores.
-- ---------------------------------------------------------------------
CREATE FUNCTION fn_margen_producto(p_id_producto INT)
RETURNS DECIMAL(12,2)
READS SQL DATA
BEGIN
    DECLARE v_margen DECIMAL(12,2);
    SELECT p.precio - MIN(s.precio_proveedor) INTO v_margen
      FROM PRODUCTO p
      JOIN SUMINISTRA s ON s.id_producto = p.id_producto
     WHERE p.id_producto = p_id_producto
     GROUP BY p.precio;
    RETURN v_margen;
END$$

-- ---------------------------------------------------------------------
-- fn_dias_desde_pedido: días transcurridos desde la fecha del pedido
-- hasta hoy. Devuelve NULL si el pedido no existe.
-- ---------------------------------------------------------------------
CREATE FUNCTION fn_dias_desde_pedido(p_id_pedido INT)
RETURNS INT
NOT DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_dias INT;
    SELECT DATEDIFF(CURDATE(), DATE(fecha)) INTO v_dias
      FROM PEDIDO
     WHERE id_pedido = p_id_pedido;
    RETURN v_dias;
END$$

DELIMITER ;


DELIMITER //

CREATE PROCEDURE sp_actualizar_estado_pedido(
    IN p_id_pedido INT,
    IN p_nuevo_estado VARCHAR(50)
)
BEGIN
    -- Declarar manejador de errores para control de transacciones
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    -- 1. Actualizar el estado actual en la tabla PEDIDO
    UPDATE PEDIDO 
    SET estado_actual = p_nuevo_estado 
    WHERE id_pedido = p_id_pedido;

    -- 2. Registrar el cambio en el historial de estados
    INSERT INTO HISTORIAL_ESTADO_PEDIDO (id_pedido, estado, fecha_cambio)
    VALUES (p_id_pedido, p_nuevo_estado, NOW());

    COMMIT;
END //

DELIMITER ;