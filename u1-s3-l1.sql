-- dati di esempio per i test
INSERT INTO clienti (nome, cognome, anno_di_nascita, regione_residenza) VALUES
('Mario', 'Rossi', 1982, 'Lazio'),
('Luigi', 'Bianchi', 1990, 'Lombardia'),
('Mario', 'Verdi', 1975, 'Veneto');

INSERT INTO prodotti (descrizione, in_produzione, in_commercio, data_attivazione, data_disattivazione) VALUES
('Prodotto A', TRUE, FALSE, '2017-05-10', NULL),
('Prodotto B', FALSE, TRUE, '2017-03-22', NULL),
('Prodotto C', TRUE, TRUE, '2018-01-15', NULL);

INSERT INTO fornitori (denominazione, regione_residenza) VALUES
('Fornitore Uno', 'Lazio'),
('Fornitore Due', 'Lombardia');

INSERT INTO fatture (tipologia, importo, iva, id_cliente, data_fattura, numero_fornitore) VALUES
('Elettronica', 900.00, 20, 1, '2021-02-15', 1),
('Servizi', 1200.00, 22, 2, '2022-06-10', 2),
('Software', 800.00, 20, 1, '2020-08-05', 1),
('Consulenza', 500.00, 10, 3, '2023-04-12', 2);

-- Esercizi 

-- 1. Estrai tutti i clienti con nome Mario
SELECT * FROM clienti WHERE nome = 'Mario';

-- 2. Estrai nome e cognome dei clienti nati nel 1982
SELECT nome, cognome FROM clienti WHERE anno_di_nascita = 1982;

-- 3. Estrai il numero delle fatture con iva al 20%
SELECT COUNT(*) FROM fatture WHERE iva = 20;

-- 4. Estrai i prodotti attivati nel 2017 e che sono in produzione oppure in commercio
SELECT * FROM prodotti
WHERE EXTRACT(YEAR FROM data_attivazione) = 2017
  AND (in_produzione = TRUE OR in_commercio = TRUE);

-- 5. Estrai le fatture con importo < 1000 e i dati dei clienti collegati
SELECT f.*, c.*
FROM fatture f
JOIN clienti c ON f.id_cliente = c.numero_cliente
WHERE f.importo < 1000;

-- 6. Elenco delle fatture con nome del fornitore
SELECT f.numero_fattura, f.importo, f.iva, f.data_fattura, fo.denominazione
FROM fatture f
JOIN fornitori fo ON f.numero_fornitore = fo.numero_fornitore;

-- 7. Fatture con iva al 20%, numero per anno
SELECT EXTRACT(YEAR FROM data_fattura) AS anno, COUNT(*) AS numero_fatture
FROM fatture
WHERE iva = 20
GROUP BY anno
ORDER BY anno;

-- 8. Numero di fatture e somma importi divisi per anno
SELECT EXTRACT(YEAR FROM data_fattura) AS anno, COUNT(*) AS numero_fatture, SUM(importo) AS somma_importi
FROM fatture
GROUP BY anno
ORDER BY anno;