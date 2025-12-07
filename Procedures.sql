USE ecommerce;

SELECT * FROM clients;
drop procedure gerencia_cliente;

DELIMITER \\
CREATE PROCEDURE gerencia_cliente(
    
    p_idClient INT,
	p_Fname VARCHAR(15),
    p_Minit VARCHAR(3),
    p_Lname Varchar(15),
    p_CPF CHAR(11),
    p_street VARCHAR(40),
    p_district VARCHAR(40),
    p_complement VARCHAR(40),
    p_Zip CHAR(8),
    p_case int
    )
    BEGIN
    CASE p_case
    -- Se o p_case for 1, sera feito uma consulta, validando o idClient ou CPF, dependendo da informacao passada pelo usuario
		WHEN 1 THEN
			IF p_idClient IS NOT NULL THEN
				SELECT * FROM clients WHERE idClient = p_idClient;
			ELSEIF p_CPF IS NOT NULL THEN
				SELECT * FROM clients WHERE CPF = p_CPF;
			END IF;
            
		WHEN 2 THEN
        -- Se p_case for 2, sera feito a alteracao de um cliente, sendo a validacao feita pelo id do cliente por ser unico
			UPDATE clients SET 
				Fname = p_Fname,
				Minit = p_Minit,
				Lname = p_Lname,
				CPF = p_CPF,
				street = p_street,
				district = p_district,
				complement = p_complement,
				Zip = p_Zip
			WHERE idClient = p_idClient;
            
		WHEN 3 THEN 
        -- se p_case for 3 ira adicionar um cliente
        INSERT INTO clients( Fname, Minit, Lname, CPF, street, district, complement, Zip)
			VALUES(p_Fname, p_Minit, p_Lname, p_CPF, p_street, p_district, p_complement, p_Zip);
        
	END CASE;
END \\
DELIMITER ;

-- seleciona o case 1 pelo id do cliente
CALL gerencia_cliente('2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
-- Seleciona o case 1 tambem, mas pelo CPF
CALL gerencia_cliente(NULL, NULL, NULL, NULL, '45678901234', NULL, NULL, NULL, NULL, 1);

-- Seleciona o case 2 e altera os valores da linha
CALL gerencia_cliente(7, 'Aurelio', NULL, 'Machado', '87301634921', 'Floreira', 'Aguas verdes', '3456', '01762217', 2);

-- Seleciona case 3 e exclui uma linha
CALL gerencia_cliente(NULL, 'Angelica', 'M', 'Schimidt', '63910273461', 'Rua albuquerque', 'Pedreiras', NULL, '91635276', 3);