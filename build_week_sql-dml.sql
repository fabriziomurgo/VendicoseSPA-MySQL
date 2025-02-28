-- Usa il database db_vendicose_spa
USE  db_vendicose_spa;



-- Comandi di controllo dati nelle tabelle
SHOW TABLES;
SELECT * FROM area_nielsen;
SELECT * FROM categoria;
SELECT * FROM citta;
SELECT * FROM fornitore;
SELECT * FROM magazzino;
SELECT * FROM negozio;
SELECT * FROM prodotto;
SELECT * FROM scontrino;
SELECT * FROM carrello;
SELECT * FROM ddt_magazzino;
SELECT * FROM riassortimento_magazzino;
SELECT * FROM ddt_fornitore;
SELECT * FROM riassortimento_fornitore;
SELECT * FROM restock_soglie_magazzino;
SELECT * FROM restock_soglie_negozio;
-- SELECT * FROM stock_negozio;
-- SELECT * FROM stock_magazzino;

-- MOSTRA VISTE
SELECT * FROM stock_negozio;
SELECT * FROM stock_magazzino;
SELECT * FROM alert_riordine_negozio;
SELECT * FROM alert_riordine_magazzino;
























-- Mostra la quantita totale riassortita, per un determinato negozio e per un determinato prodotto   [FUNZIONA]
SELECT n.nome AS nome_negozio, p.nome AS nome_prodotto, SUM(r.quantita_riassortita) AS totale_quantita_riassortita
FROM negozio n
JOIN ddt_magazzino d ON d.negozioID = n.ID
JOIN riassortimento_magazzino r ON r.ddt_magazzinoID = d.ID
JOIN prodotto p ON p.ID = r.prodottoID
WHERE n.nome LIKE '%torino%' AND p.nome LIKE '%pasta%'
GROUP BY n.nome, p.nome;


-- Mostra la quantita totale venduta, per un determinato negozio e per un determinato prodotto   [FUNZIONA]
SELECT n.nome AS nome_negozio, p.nome AS nome_prodotto, SUM(c.quantita_venduta) AS totale_quantita_venduta
FROM negozio n
JOIN scontrino s ON s.negozioID = n.ID
JOIN carrello c ON c.scontrinoID = s.ID
JOIN prodotto p ON p.ID = c.prodottoID
WHERE n.nome LIKE '%torino%' AND p.nome LIKE '%pasta%'
GROUP BY n.nome, p.nome;

    
-- Verifica la quantita attuale di un determinato prodotto in un determinato negozio   [FUNZIONA]
SELECT n.nome AS nome_negozio, p.nome AS nome_prodotto, 
	(SELECT SUM(rm.quantita_riassortita)  
	FROM riassortimento_magazzino rm  
	JOIN ddt_magazzino dm ON rm.ddt_magazzinoID = dm.ID  
	WHERE dm.negozioID = n.ID AND rm.prodottoID = p.ID)  
	-  
	(SELECT SUM(c.quantita_venduta)  
	FROM carrello c  
	JOIN scontrino s ON c.scontrinoID = s.ID  
	WHERE s.negozioID = n.ID AND c.prodottoID = p.ID)  
	AS quantita_attuale  
FROM negozio n  
JOIN riassortimento_magazzino r ON r.ddt_magazzinoID = n.ID 
JOIN prodotto p ON p.ID = r.prodottoID  
WHERE n.nome LIKE '%torino%' AND p.nome LIKE '%pasta%';


-- Crea Vista per la disponibilità dinamica in tempo reale della giacenza di tutti i prodotti e in tutti i negozi [FUNZIONA]
CREATE VIEW stock_negozio AS
SELECT n.ID AS negozioID, n.nome AS nome_negozio, p.ID AS prodottoID, p.nome AS nome_prodotto, 
	(SELECT SUM(rm.quantita_riassortita)  
	FROM riassortimento_magazzino rm  
	JOIN ddt_magazzino dm ON rm.ddt_magazzinoID = dm.ID  
	WHERE dm.negozioID = n.ID AND rm.prodottoID = p.ID)  
	-  
	(SELECT SUM(c.quantita_venduta)  
	FROM carrello c  
	JOIN scontrino s ON c.scontrinoID = s.ID  
	WHERE s.negozioID = n.ID AND c.prodottoID = p.ID)  
	AS quantita_attuale  
FROM negozio n  
JOIN riassortimento_magazzino r ON r.ddt_magazzinoID = n.ID 
JOIN prodotto p ON p.ID = r.prodottoID;

-- Verifica la Vista appena creata
SELECT * FROM stock_negozio;
SELECT * FROM stock_negozio WHERE nome_negozio LIKE '%torino%' AND nome_prodotto LIKE '%pasta%';
SELECT * FROM stock_negozio WHERE nome_negozio LIKE '%padova%' AND nome_prodotto LIKE '%pane%';
-- DROP VIEW stock_negozio;

-- Creiamo al volo una vendita di pasta nel negozio di torino
INSERT INTO scontrino (data_vendita, negozioID) VALUES (CURDATE(), 8);
SELECT * FROM scontrino WHERE negozioID = 8;
INSERT INTO carrello (quantita_venduta, scontrinoID, prodottoID) VALUES (3, 104, 23);

-- Mostra i movimenti in entrata e uscita di un determinato prodotto in un determinato negozio
SELECT * FROM negozio WHERE nome LIKE '%padova%'; -- 8
SELECT * FROM prodotto WHERE nome LIKE '%pane%'; -- 23

SELECT * 
FROM riassortimento_magazzino r 
JOIN ddt_magazzino d ON r.ddt_magazzinoID = d.ID
WHERE d.negozioID = 8 AND r.prodottoID = 23;

SELECT * 
FROM carrello c 
JOIN scontrino s ON c.scontrinoID = s.ID
WHERE s.negozioID = 8 AND c.prodottoID = 23;

-- Tutto ciò ha risposto alla domanda 1: Quando un prodotto viene venduto in un negozio, qual è la query da eseguire per aggironare le tabelle di riferimento?




-- Crea Vista per la disponibilità dinamica in tempo reale della giacenza di tutti i magazzini e in tutti i negozi [FUNZIONA]
CREATE VIEW stock_magazzino AS
SELECT n.ID AS magazzinoID, n.nome AS nome_magazzino, p.ID AS prodottoID, p.nome AS nome_prodotto, 
	(SELECT SUM(rm.quantita_riassortita)  
	FROM riassortimento_fornitore rm  
	JOIN ddt_fornitore dm ON rm.ddt_fornitoreID = dm.ID  
	WHERE dm.magazzinoID = n.ID AND rm.prodottoID = p.ID)  
	-  
	(SELECT SUM(c.quantita_riassortita)  
	FROM riassortimento_magazzino c  
	JOIN ddt_magazzino s ON c.ddt_magazzinoID = s.ID  
	WHERE s.magazzinoID = n.ID AND c.prodottoID = p.ID)  
	AS quantita_attuale  
FROM magazzino n  
JOIN riassortimento_fornitore r ON r.ddt_fornitoreID = n.ID 
JOIN prodotto p ON p.ID = r.prodottoID;

-- Verifica la Vista appena creata
SELECT * FROM stock_magazzino;
SELECT * FROM stock_magazzino WHERE nome_magazzino LIKE '%sud%' AND nome_prodotto LIKE '%frago%';
SELECT * FROM stock_magazzino WHERE nome_magazzino LIKE '%nord%' AND nome_prodotto LIKE '%ciocc%';
-- DROP VIEW stock_magazzino;







-- Crea Vista che visualizza quando un determinato prodotto è sceso sotto la soglia di riordino in un determinato negozio
CREATE VIEW alert_riordine_negozio AS
SELECT n.ID AS negozioID, n.nome AS nome_negozio, p.ID AS prodottoID, p.nome AS nome_prodotto, r.quantita_soglia, (r.quantita_soglia - s.quantita_attuale) AS quantita_riordino
FROM prodotto p
JOIN restock_soglie_negozio r ON p.ID = r.prodottoID
JOIN negozio n ON n.id = r.negozioID
JOIN stock_negozio s ON n.ID = s.negozioID AND s.prodottoID = p.ID 
WHERE s.quantita_attuale < r.quantita_soglia;

-- Verifica la Vista appena creata
SELECT * FROM alert_riordine_negozio;
SELECT * FROM alert_riordine_negozio WHERE nome_negozio LIKE '%torino%' AND nome_prodotto LIKE '%pasta%';
SELECT * FROM alert_riordine_negozio WHERE nome_negozio LIKE '%padova%' AND nome_prodotto LIKE '%pane%';
-- DROP VIEW alert_riordine_negozio;


-- Se la Vista è vuota, facciamo un test di modifica soglia quantità per restock negozio
SELECT * FROM negozio WHERE nome LIKE '%torino%'; -- trova id negozio torino: 3
SELECT * FROM prodotto WHERE nome LIKE '%pasta%'; -- trova id prodotto pane: 1
SELECT * FROM restock_soglie_negozio WHERE negozioID = 3 AND prodottoID = 1; -- visulizza la quantita soglia del pane per il negozio di torino
UPDATE restock_soglie_negozio SET quantita_soglia = 30 WHERE ID = 32; -- aggiorniamo a piacimento la nuova soglia di restock del pane per il negozio di torino

SELECT * FROM negozio WHERE nome LIKE '%padova%'; -- trova id negozio torino: 8
SELECT * FROM prodotto WHERE nome LIKE '%pane%'; -- trova id prodotto pane: 23
SELECT * FROM restock_soglie_negozio WHERE negozioID = 8 AND prodottoID = 23; -- visulizza la quantita soglia del pane per il negozio di torino
UPDATE restock_soglie_negozio SET quantita_soglia = 30 WHERE ID = 102; -- aggiorniamo a piacimento la nuova soglia di restock del pane per il negozio di torino









-- Crea Vista che visualizza quando un determinato prodotto è sceso sotto la soglia di riordino in un determinato magazzino
CREATE VIEW alert_riordine_magazzino AS
SELECT n.ID AS magazzinoID, n.nome AS nome_magazzino, p.ID AS prodottoID, p.nome AS nome_prodotto, r.quantita_soglia, (r.quantita_soglia - s.quantita_attuale) AS quantita_riordino
FROM prodotto p
JOIN restock_soglie_magazzino r ON p.ID = r.prodottoID
JOIN magazzino n ON n.id = r.magazzinoID
JOIN stock_magazzino s ON n.ID = s.magazzinoID AND s.prodottoID = p.ID 
WHERE s.quantita_attuale < r.quantita_soglia;

-- Verifica la Vista appena creata
SELECT * FROM alert_riordine_magazzino;
SELECT * FROM alert_riordine_magazzino WHERE nome_magazzino LIKE '%nord%' AND nome_prodotto LIKE '%pasta%';
SELECT * FROM alert_riordine_magazzino WHERE nome_magazzino LIKE '%sud%' AND nome_prodotto LIKE '%pane%';
-- DROP VIEW alert_riordine_magazzino;


-- Se la Vista è vuota, facciamo un test di modifica soglia quantità per restock magazzino
SELECT * FROM magazzino WHERE nome LIKE '%sud%'; -- trova id magazzino sud: 4
SELECT * FROM prodotto WHERE nome LIKE '%pane%'; -- trova id magazzino pasta: 1 - pane: 23
SELECT * FROM restock_soglie_magazzino WHERE negozioID = 3 AND prodottoID = 1; -- visulizza la quantita soglia del pane per il negozio di torino
UPDATE restock_soglie_magazzino SET quantita_soglia = 30 WHERE ID = 32; -- aggiorniamo a piacimento la nuova soglia di restock del pane per il negozio di torino












-- ALTRE RICHIESTE:



-- Fatturato totale di tutti i negozi nel 2024
SELECT n.Nome, YEAR(s.data_vendita) as Anno, SUM(c.quantita_venduta*p.prezzo) as Totale 
FROM Negozio as n JOIN Scontrino as s ON n.ID = s.NegozioID
JOIN Carrello as c ON s.ID = c.ScontrinoID
JOIN Prodotto as p ON c.ProdottoID = p.ID
WHERE YEAR(s.data_vendita) = 2024 
GROUP BY n.Nome, Anno;


-- Qual è il negozio che ha generato il maggior fatturato nel 2024?
SELECT n.Nome, YEAR(s.data_vendita) as Anno, SUM(c.quantita_venduta*p.prezzo) as Totale 
FROM Negozio as n JOIN Scontrino as s ON n.ID = s.NegozioID
JOIN Carrello as c ON s.ID = c.ScontrinoID
JOIN Prodotto as p ON c.ProdottoID = p.ID
WHERE YEAR(s.data_vendita) = 2024 
GROUP BY n.Nome, Anno
ORDER BY Totale DESC
LIMIT 1;


-- Qual è il prodotto che ha generato il maggior profitto (quantità venduta × prezzo) in un mese specifico?
SELECT p.Nome, SUM(c.quantita_venduta*p.prezzo) as Totale , MONTH(s.data_vendita) AS Mese
FROM Scontrino as s JOIN Carrello as c ON s.ID = c.ScontrinoID
JOIN Prodotto as p ON c.ProdottoID = p.ID
WHERE MONTH(s.data_vendita) = 3
GROUP BY p.Nome, Mese
ORDER BY Totale DESC
LIMIT 1;


-- Quanto ha venduto il negozio di Napoli nel mese di Febbraio 2024?
SELECT n.Nome, MONTH(s.data_vendita) AS Mese , YEAR(s.data_vendita) AS Anno , SUM(c.quantita_venduta*p.prezzo) AS Totale
FROM Negozio as n JOIN Scontrino as s ON n.ID = s.NegozioID
JOIN Carrello as c ON s.ID = c.ScontrinoID
JOIN Prodotto as p ON c.ProdottoID = p.ID
WHERE n.Nome LIKE '%Napoli%' AND MONTH(s.data_vendita) = 2 AND YEAR(s.data_vendita) = 2024
GROUP BY n.Nome, Mese, Anno;





















-- appunti
SELECT * FROM negozio WHERE nome LIKE '%torino%'; -- 3
SELECT * FROM prodotto WHERE nome LIKE '%pane%'; -- 23

SELECT * 
FROM riassortimento_magazzino r 
JOIN ddt_magazzino d ON r.ddt_magazzinoID = d.ID
WHERE d.negozioID = 3 AND r.prodottoID = 4;

SELECT * 
FROM carrello c 
JOIN scontrino s ON c.scontrinoID = s.ID
WHERE s.negozioID = 3 AND c.prodottoID = 23;



UPDATE carrello
SET quantita_venduta = 91
WHERE ID = 168;








-- Verifica la quantita soglia di determinati prodotti
-- CREATE VIEW restock_operativo AS
SELECT c.nome AS nome_categoria, p.nome AS nome_prodotto, r.quantita_soglia, m.nome AS nome_magazzino, p.ID AS prodottoID, m.ID AS magazzinoID
FROM categoria c
JOIN prodotto p ON p.categoriaID = c.ID
JOIN restock_soglie_magazzino r ON r.prodottoID = p.ID
JOIN magazzino m ON r.magazzinoID = m.ID
WHERE p.nome LIKE '%latte%' OR p.nome LIKE '%ciocco%' OR p.nome LIKE '%pasta%'
ORDER BY p.nome;










-- Controllo entrate dai fornitori al "Magazzino Centro" per "Cioccolato Fondente"
SELECT SUM(rf.quantita_riassortita) AS entrate_magazzino
FROM riassortimento_fornitore rf
JOIN ddt_fornitore df ON rf.ddt_fornitoreID = df.ID
JOIN prodotto p ON rf.prodottoID = p.ID
JOIN magazzino m ON df.magazzinoID = m.ID
WHERE p.nome LIKE '%latte%' AND m.nome = 'Magazzino Centro';

-- Controllo uscite dal "Magazzino Centro" ai negozi per "Cioccolato Fondente"
SELECT SUM(rm.quantita_riassortita) AS uscite_magazzino
FROM riassortimento_magazzino rm
JOIN ddt_magazzino dm ON rm.ddt_magazzinoID = dm.ID
JOIN prodotto p ON rm.prodottoID = p.ID
JOIN magazzino m ON dm.magazzinoID = m.ID
WHERE p.nome LIKE '%latte%' AND m.nome = 'Magazzino Centro';







SELECT * FROM restock_soglie_magazzino;
SELECT * FROM restock_soglie_magazzino WHERE magazzinoID = 2 AND prodottoID = 6;
-- vedi su SELECT * FROM restock_operativo;

-- Modifica quantita
UPDATE restock_soglie_magazzino
SET quantita_soglia = 40
WHERE prodottoID = 6 AND magazzinoID = 3;




 
 








-- Visualizzate i prodotti che non sono venduti in un determinato negozio







SELECT * FROM restock_soglie_magazzino;
SELECT * FROM restock_soglie_negozio;

-- Modifica quantita Soglia Negozio
UPDATE restock_soglie_negozio
SET quantita_soglia = 1000
WHERE prodottoID = 1 AND negozioID = 1;



