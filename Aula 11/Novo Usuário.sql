-- CRIANDO USUÁRIO:	
-- 1° Passo
CREATE USER bruno WITH PASSWORD 'newuser';
ALTER USER bruno WITH SUPERUSER;

-- 2° Passo
ALTER USER bruno WITH NOSUPERUSER;

-- Criando trigger
CREATE TABLE users(
id SERIAL PRIMARY KEY,
nome VARCHAR (100) NOT NULL,
idade INT CHECK (idade >= 0) NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE funcionarios(
id SERIAL PRIMARY KEY,
cargo VARCHAR(100) NOT NULL,
salario NUMERIC(10,2) NOT NULL,
user_id INT REFERENCES users(id) NOT NULL 
);

CREATE TABLE log_funcionarios(
id SERIAL PRIMARY KEY,
operacao VARCHAR(10) NOT NULL,
funcionario_id INT,
cargo VARCHAR(100),
salario NUMERIC(10,2),
user_id INT,
username VARCHAR DEFAULT CURRENT_USER,
data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION log_funcionario()
RETURNS TRIGGER AS $$
BEGIN
 IF (TG_OP = 'INSERT') THEN
    INSERT INTO log_funcionarios (operacao, funcionario_id, cargo, salario, user_id)
    VALUES ('INSERT', NEW.id, NEW.cargo, NEW.salario, NEW.user_id);
    RETURN NEW;
 ELSIF (TG_OP = 'UPDATE') THEN
    INSERT INTO log_funcionarios (operacao, funcionario_id, cargo, salario, user_id)
    VALUES ('UPDATE', NEW.id, NEW.cargo, NEW.salario, NEW.user_id);
    RETURN NEW;
 ELSIF (TG_OP = 'DELETE') THEN
    INSERT INTO log_funcionarios (operacao, funcionario_id, cargo, salario, user_id)
    VALUES ('DELETE', OLD.id, OLD.cargo, OLD.salario, OLD.user_id);
    RETURN OLD;
 END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_log_funcionario
AFTER INSERT OR UPDATE OR DELETE ON funcionarios
FOR EACH ROW 
EXECUTE FUNCTION log_funcionario();


-- PARA O NOVO USUÁRIO:
INSERT INTO users (nome, idade, email) VALUES 
(), 
();

INSERT INTO funcionarios (cargo, salario, user_id) VALUES 
(), 
();

UPDATE funcionarios SET cargo = '' WHERE id = 2;

DELETE FROM funcionarios WHERE id = 2;

SELECT * FROM log_funcionarios;

CREATE VIEW user_salary AS SELECT nome,cargo, salario FROM funcionarios
JOIN users ON user_id = users.id; 

SELECT * FROM user_salary;
