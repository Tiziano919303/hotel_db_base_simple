-- Tabella OSPITI
CREATE TABLE ospiti (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(50),
  cognome VARCHAR(50),
  email VARCHAR(100)
);

-- Tabella CAMERE
CREATE TABLE camere (
  id INT AUTO_INCREMENT PRIMARY KEY,
  numero INT,
  tipo VARCHAR(50),
  prezzo_per_notte DEC(5,2)
);

-- Tabella PRENOTAZIONI
CREATE TABLE prenotazioni (
  id INT AUTO_INCREMENT PRIMARY KEY,
  id_ospite INT,
  id_camera INT,
  checkin DATE,
  checkout DATE,
  FOREIGN KEY (id_ospite) REFERENCES ospiti(id),
  FOREIGN KEY (id_camera) REFERENCES camere(id)
);

INSERT INTO ospiti (nome, cognome, email) VALUES
('Mario', 'Rossi', 'mariorossi@gmail.com'),
('Giulia', 'Bianchi', 'giuliabianchi@gmail.com');

INSERT INTO camere (numero, tipo, prezzo_per_notte) VALUES
(101, 'Singola', 50.00),
(102, 'Doppia', 80.00),
(103, 'Suite', 150.00);

INSERT INTO prenotazioni (id_ospite, id_camera, checkin, checkout) VALUES
(1, 2, '2024-07-01', '2024-07-04'),
(2, 3, '2024-07-03', '2024-07-07');

-- Lista prenotazioni con nome ospite e tipo camera
SELECT
p.id,
CONCAT(o.nome, " ", o.cognome) as ospite,
c.tipo as tipo_camera,
p.checkin,
p.checkout
FROM prenotazioni p
JOIN ospiti o ON p.id_ospite = o.id
JOIN camere c ON p.id_camera = c.id;

-- Calcolo notti e costo totale
SELECT
p.id,
CONCAT(o.nome, " ", o.cognome) AS ospite,
DATEDIFF(p.checkout, p.checkin) AS notti,
DATEDIFF(p.checkout, p.checkin) * c.prezzo_per_notte AS costo_totale
FROM prenotazioni p
JOIN ospiti o ON p.id_ospite = o.id
JOIN camere c ON p.id_camera = c.id;

-- Entrate totali
SELECT
ROUND(SUM(DATEDIFF(p.checkout, p.checkin) * c.prezzo_per_notte), 2) AS entrate_totali
FROM prenotazioni p
JOIN camere c ON p.id_camera = c.id;
