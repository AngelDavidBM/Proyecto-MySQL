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