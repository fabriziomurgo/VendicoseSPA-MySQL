-- Crea e usa il database db_vendicose_spa
CREATE DATABASE  db_vendicose_spa;
USE  db_vendicose_spa;





-- Crea la tabella "area_nielsen"
CREATE TABLE area_nielsen (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL
    );


-- Crea la tabella "categoria"
CREATE TABLE categoria (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    soglia_restock INT NOT NULL
    );


-- Crea la tabella "citta"
CREATE TABLE citta (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    area_nielsenID INT NOT NULL,
    FOREIGN KEY (area_nielsenID) REFERENCES area_nielsen(ID)
    );


-- Crea la tabella "fornitore"
CREATE TABLE fornitore (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    indirizzo VARCHAR(100),
    cittaID INT NOT NULL,
    FOREIGN KEY (cittaID) REFERENCES citta(ID)
    );


-- Crea la tabella "magazzino"
CREATE TABLE magazzino (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    indirizzo VARCHAR(100),
    cittaID INT NOT NULL,
    FOREIGN KEY (cittaID) REFERENCES citta(ID)
    );


-- Crea la tabella "negozio"
CREATE TABLE negozio (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    indirizzo VARCHAR(100),
    cittaID INT NOT NULL,
    FOREIGN KEY (cittaID) REFERENCES citta(ID)
    );


-- Crea la tabella "prodotto"
CREATE TABLE prodotto (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    barcode VARCHAR(15),
    nome VARCHAR(50) NOT NULL,
    prezzo DECIMAL(10,2) NOT NULL,
    categoriaID INT NOT NULL,
    FOREIGN KEY (categoriaID) REFERENCES categoria(ID)
    );


-- Crea la tabella "scontrino"
CREATE TABLE scontrino (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    data_vendita DATE NOT NULL,
    negozioID INT NOT NULL,
	FOREIGN KEY (negozioID) REFERENCES negozio(ID)
    );


-- Crea la tabella "carrello"
CREATE TABLE carrello (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    quantita_venduta INT NOT NULL,
    scontrinoID INT NOT NULL,
    prodottoID INT NOT NULL,
    FOREIGN KEY (scontrinoID) REFERENCES scontrino(ID),
    FOREIGN KEY (prodottoID) REFERENCES prodotto(ID)
    );


-- Crea la tabella "ddt_magazzino" (documento di trasporto)
CREATE TABLE ddt_magazzino (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    data_riassortimento DATE NOT NULL,
    magazzinoID INT NOT NULL,
    negozioID INT NOT NULL,
	FOREIGN KEY (magazzinoID) REFERENCES magazzino(ID),
    FOREIGN KEY (negozioID) REFERENCES negozio(ID)
    );


-- Crea la tabella "ddt_fornitore" (documento di trasporto)
CREATE TABLE ddt_fornitore (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    data_riassortimento DATE NOT NULL,
    fornitoreID INT NOT NULL,
    magazzinoID INT NOT NULL,
	FOREIGN KEY (fornitoreID) REFERENCES fornitore(ID),
    FOREIGN KEY (magazzinoID) REFERENCES magazzino(ID)
    );

-- Crea la tabella "riassortimento_magazzino"
CREATE TABLE riassortimento_magazzino (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    quantita_riassortita INT NOT NULL,
    ddt_magazzinoID INT NOT NULL,
    prodottoID INT NOT NULL,
    FOREIGN KEY (ddt_magazzinoID) REFERENCES ddt_magazzino(ID),
    FOREIGN KEY (prodottoID) REFERENCES prodotto(ID)
    );


-- Crea la tabella "riassortimento_fornitore"
CREATE TABLE riassortimento_fornitore (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    quantita_riassortita INT NOT NULL,
    ddt_fornitoreID INT NOT NULL,
    prodottoID INT NOT NULL,
    FOREIGN KEY (ddt_fornitoreID) REFERENCES ddt_fornitore(ID),
    FOREIGN KEY (prodottoID) REFERENCES prodotto(ID)
    );


-- Crea la tabella "restock_soglie_magazzino"
CREATE TABLE restock_soglie_magazzino (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    quantita_soglia INT NOT NULL,
    magazzinoID INT NOT NULL,
    prodottoID INT NOT NULL,
    FOREIGN KEY (magazzinoID) REFERENCES magazzino(ID),
    FOREIGN KEY (prodottoID) REFERENCES prodotto(ID)
    );


-- Crea la tabella "restock_soglie_negozio"
CREATE TABLE restock_soglie_negozio (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    quantita_soglia INT NOT NULL,
    negozioID INT NOT NULL,
    prodottoID INT NOT NULL,
    FOREIGN KEY (negozioID) REFERENCES negozio(ID),
    FOREIGN KEY (prodottoID) REFERENCES prodotto(ID)
    );
    
    
    
    


-- Crea la tabella "stock_magazzino"
-- CREATE TABLE stock_magazzino (
--    ID INT AUTO_INCREMENT PRIMARY KEY,
--    quantita_trasferita INT NOT NULL,
--    magazzinoID INT NOT NULL,
--    prodottoID INT NOT NULL,
--    FOREIGN KEY (magazzinoID) REFERENCES magazzino(ID),
--    FOREIGN KEY (prodottoID) REFERENCES prodotto(ID)
--    );


-- Crea la tabella "stock_negozio"
-- CREATE TABLE stock_negozio (
--    ID INT AUTO_INCREMENT PRIMARY KEY,
--    quantita INT NOT NULL,
--    negozioID INT NOT NULL,
--    prodottoID INT NOT NULL,
--    FOREIGN KEY (negozioID) REFERENCES negozio(ID),
--    FOREIGN KEY (prodottoID) REFERENCES prodotto(ID)
--    );
    






-- Popolare la tabella `area_nielsen`
INSERT INTO area_nielsen (nome) VALUES
('Nord-Ovest'),
('Nord-Est'),
('Centro'),
('Sud');


-- Popolare la tabella `categoria`
INSERT INTO categoria (nome, soglia_restock) VALUES
('Abbigliamento', 20),
('Alimentari', 30),
('Casa e Giardino', 15),
('Cosmetica', 20),
('Elettronica', 10),
('Sport', 25);


-- Popolare la tabella `citta`
INSERT INTO citta (nome, area_nielsenID) VALUES
('Milano', 1),    -- Nord-Ovest
('Torino', 1),    -- Nord-Ovest
('Genova', 1),    -- Nord-Ovest
('Asti', 1),	  -- Nord-Ovest
('Venezia', 2),   -- Nord-Est
('Bologna', 2),   -- Nord-Est
('Padova', 2),    -- Nord-Est
('Verona', 2),    -- Nord-Est
('Roma', 3),      -- Centro
('Firenze', 3),   -- Centro
('Perugia', 3),   -- Centro
('Pesaro', 3),   -- Centro
('Napoli', 4),    -- Sud
('Palermo', 4),   -- Sud
('Bari', 4),      -- Sud
('Catania', 4);   -- Sud


-- Popolare la tabella `fornitore` 
INSERT INTO fornitore (nome, indirizzo, cittaID) VALUES
('Delta Spa', 'Via Rossi 123', 2),  
('Sigma Spa', 'Via Verdi 456', 4),  
('Alpha Spa', 'Via Bianchi 789', 6),   
('Beta Spa', 'Via Neri 101', 8);     


-- Popolare la tabella `magazzino` (4 magazzini)
INSERT INTO magazzino (nome, indirizzo, cittaID) VALUES
('Magazzino Nord-Ovest', 'Via Milano 123', 1),  -- Milano
('Magazzino Nord-Est', 'Via Venezia 456',  4),   -- Venezia
('Magazzino Centro', 'Via Roma 789', 7),        -- Roma
('Magazzino Sud', 'Via Napoli 101', 10);        -- Napoli


-- Popolare la tabella `negozio`
INSERT INTO negozio (nome, indirizzo, cittaID) VALUES
('Negozio Milano Centro', 'Via Torino 10', 1),    -- Milano
('Negozio Milano Nord', 'Via Como 20', 1),        -- Milano)
('Negozio Torino Centro', 'Via Roma 30', 2),      -- Torino
('Negozio Genova Centro', 'Via Genova 40', 3),    -- Genova
('Negozio Asti Centro', 'Via Asti 50', 4),        -- Asti
('Negozio Venezia Centro', 'Via Venezia 60', 5),  -- Venezia
('Negozio Bologna Centro', 'Via Bologna 70', 6),  -- Bologna
('Negozio Padova Centro', 'Via Padova 80', 7),    -- Padova
('Negozio Verona Centro', 'Via Verona 90', 8),    -- Verona
('Negozio Roma Centro', 'Via Firenze 100', 9),    -- Roma
('Negozio Roma Sud', 'Via Napoli 110', 9),        -- Roma
('Negozio Firenze Centro', 'Via Firenze 120', 10), -- Firenze
('Negozio Perugia Centro', 'Via Perugia 130', 11), -- Perugia
('Negozio Pesaro Centro', 'Via Pesaro 140', 12),  -- Pesaro
('Negozio Napoli Centro', 'Via Napoli 150', 13),  -- Napoli
('Negozio Palermo Centro', 'Via Palermo 160', 14), -- Palermo
('Negozio Bari Centro', 'Via Bari 170', 15),      -- Bari
('Negozio Catania Centro', 'Via Catania 180', 16); -- Catania


-- Popolare la tabella `prodotto`
INSERT INTO prodotto (barcode, nome, prezzo, categoriaID) VALUES
-- Alimentari (CategoriaID = 2) - 60 prodotti
('8001234567890', 'Pasta Barilla', 1.99, 2),
('8001234567891', 'Riso Basmati', 2.99, 2),
('8001234567892', 'Olio Extra Vergine d\'Oliva', 8.99, 2),
('8001234567893', 'Sugo al Pomodoro', 1.49, 2),
('8001234567894', 'Caffè in Grani', 5.99, 2),
('8001234567895', 'Cioccolato Fondente', 3.99, 2),
('8001234567896', 'Biscotti Integrali', 2.49, 2),
('8001234567897', 'Acqua Minerale', 0.49, 2),
('8001234567898', 'Yogurt Greco', 1.29, 2),
('8001234567899', 'Miele Biologico', 6.99, 2),
('8001234567800', 'Farina 00', 1.99, 2),
('8001234567801', 'Zucchero', 1.49, 2),
('8001234567802', 'Sale', 0.99, 2),
('8001234567803', 'Pomodori Pelati', 1.29, 2),
('8001234567804', 'Tonno in Scatola', 2.99, 2),
('8001234567805', 'Fagioli in Scatola', 1.99, 2),
('8001234567806', 'Pesto alla Genovese', 3.49, 2),
('8001234567807', 'Cereali Integrali', 2.99, 2),
('8001234567808', 'Latte UHT', 1.19, 2),
('8001234567809', 'Burro', 2.49, 2),
('8001234567810', 'Formaggio Parmigiano', 7.99, 2),
('8001234567811', 'Mozzarella', 2.99, 2),
('8001234567812', 'Pane Integrale', 1.99, 2),
('8001234567813', 'Salmone Affumicato', 4.99, 2),
('8001234567814', 'Prosciutto Crudo', 5.99, 2),
('8001234567815', 'Salsiccia', 3.99, 2),
('8001234567816', 'Pizza Surgelata', 2.99, 2),
('8001234567817', 'Gelato alla Vaniglia', 3.99, 2),
('8001234567818', 'Succhi di Frutta', 1.99, 2),
('8001234567819', 'Vino Rosso', 9.99, 2),
('8001234567820', 'Birra Artigianale', 2.49, 2),
('8001234567821', 'Patatine Fritte', 1.49, 2),
('8001234567822', 'Crackers Integrali', 1.99, 2),
('8001234567823', 'Marmellata di Frutta', 2.99, 2),
('8001234567824', 'Passata di Pomodoro', 1.29, 2),
('8001234567825', 'Couscous', 2.49, 2),
('8001234567826', 'Quinoa', 3.99, 2),
('8001234567827', 'Lenticchie', 1.99, 2),
('8001234567828', 'Ceci in Scatola', 1.49, 2),
('8001234567829', 'Piselli', 1.29, 2),
('8001234567830', 'Carote', 0.99, 2),
('8001234567831', 'Zucchine', 1.49, 2),
('8001234567832', 'Mele', 1.99, 2),
('8001234567833', 'Banane', 1.49, 2),
('8001234567834', 'Arance', 1.29, 2),
('8001234567835', 'Uva', 2.99, 2),
('8001234567836', 'Fragole', 3.99, 2),
('8001234567837', 'Pesche', 2.49, 2),
('8001234567838', 'Kiwi', 1.99, 2),
('8001234567839', 'Ananas', 2.99, 2),
('8001234567840', 'Mango', 3.99, 2),
('8001234567841', 'Avocado', 2.49, 2),
('8001234567842', 'Spinaci', 1.99, 2),
('8001234567843', 'Broccoli', 1.49, 2),
('8001234567844', 'Cavolfiore', 1.99, 2),
('8001234567845', 'Funghi', 2.49, 2),
('8001234567846', 'Peperoni', 1.99, 2),
('8001234567847', 'Pomodori', 1.49, 2),
('8001234567848', 'Cetrioli', 0.99, 2),
('8001234567849', 'Insalata', 1.29, 2),
-- Abbigliamento (CategoriaID = 1) - 10 prodotti
('8001234567850', 'Maglietta Uomo', 19.99, 1),
('8001234567851', 'Maglietta Donna', 19.99, 1),
('8001234567852', 'Jeans Uomo', 49.99, 1),
('8001234567853', 'Jeans Donna', 49.99, 1),
('8001234567854', 'Felpa con Cappuccio', 39.99, 1),
('8001234567855', 'Giacca a Vento', 69.99, 1),
('8001234567856', 'Scarpe da Ginnastica', 59.99, 1),
('8001234567857', 'Cappello', 14.99, 1),
('8001234567858', 'Sciarpa', 9.99, 1),
('8001234567859', 'Cintura', 12.99, 1),
-- Casa e Giardino (CategoriaID = 3) - 10 prodotti
('8001234567860', 'Vaso per Piante', 19.99, 3),
('8001234567861', 'Lampada da Tavolo', 29.99, 3),
('8001234567862', 'Tappeto', 49.99, 3),
('8001234567863', 'Set di Pentole', 89.99, 3),
('8001234567864', 'Tovaglia', 14.99, 3),
('8001234567865', 'Cuscini Decorativi', 9.99, 3),
('8001234567866', 'Tenda per Esterno', 39.99, 3),
('8001234567867', 'Tagliaerba Elettrico', 149.99, 3),
('8001234567868', 'Set di Utensili da Giardino', 29.99, 3),
('8001234567869', 'Sedia da Giardino', 24.99, 3),
-- Cosmetica (CategoriaID = 4) - 10 prodotti
('8001234567870', 'Crema Viso', 14.99, 4),
('8001234567871', 'Shampoo', 7.99, 4),
('8001234567872', 'Balsamo', 7.99, 4),
('8001234567873', 'Dentifricio', 2.99, 4),
('8001234567874', 'Sapone Liquido', 3.99, 4),
('8001234567875', 'Deodorante', 4.99, 4),
('8001234567876', 'Profumo', 29.99, 4),
('8001234567877', 'Crema Mani', 5.99, 4),
('8001234567878', 'Maschera Viso', 9.99, 4),
('8001234567879', 'Olio per Capelli', 12.99, 4),
-- Elettronica (CategoriaID = 5) - 5 prodotti
('8001234567880', 'Smartphone', 599.99, 5),
('8001234567881', 'Tablet', 299.99, 5),
('8001234567882', 'Laptop', 899.99, 5),
('8001234567883', 'Cuffie Wireless', 79.99, 5),
('8001234567884', 'Smartwatch', 199.99, 5),
-- Sport (CategoriaID = 6) - 5 prodotti
('8001234567885', 'Palla da Calcio', 39.99, 6),
('8001234567886', 'Palla da Basket', 29.99, 6),
('8001234567887', 'Palla da Tennis', 4.99, 6),
('8001234567888', 'Racchetta da Tennis', 49.99, 6),
('8001234567889', 'Set di Pesi', 79.99, 6);









-- Inserimento in ddt_fornitore
INSERT INTO ddt_fornitore (data_riassortimento, fornitoreID, magazzinoID) VALUES
-- Fornitore 1 rifornisce tutti i magazzini
('2024-01-07', 1, 1), -- Fornitore 1 - Magazzino Nord-Ovest
('2024-01-16', 1, 2), -- Fornitore 1 - Magazzino Nord-Est
('2024-01-22', 1, 3), -- Fornitore 1 - Magazzino Centro
('2024-01-28', 1, 4), -- Fornitore 1 - Magazzino Sud

-- Fornitore 2 rifornisce tutti i magazzini
('2024-01-09', 2, 1), -- Fornitore 2 - Magazzino Nord-Ovest
('2024-01-15', 2, 2), -- Fornitore 2 - Magazzino Nord-Est
('2024-01-20', 2, 3), -- Fornitore 2 - Magazzino Centro
('2024-01-25', 2, 4), -- Fornitore 2 - Magazzino Sud

-- Fornitore 3 rifornisce tutti i magazzini
('2024-01-10', 3, 1), -- Fornitore 3 - Magazzino Nord-Ovest
('2024-01-17', 3, 2), -- Fornitore 3 - Magazzino Nord-Est
('2024-01-21', 3, 3), -- Fornitore 3 - Magazzino Centro
('2024-01-24', 3, 4), -- Fornitore 3 - Magazzino Sud

-- Fornitore 4 rifornisce tutti i magazzini
('2024-01-08', 4, 1), -- Fornitore 4 - Magazzino Nord-Ovest
('2024-01-14', 4, 2), -- Fornitore 4 - Magazzino Nord-Est
('2024-01-23', 4, 3), -- Fornitore 4 - Magazzino Centro
('2024-01-29', 4, 4); -- Fornitore 4 - Magazzino Sud





-- Popolamento della tabella riassortimento_fornitore
INSERT INTO riassortimento_fornitore (quantita_riassortita, ddt_fornitoreID, prodottoID) VALUES
-- Fornitore 1 - Magazzino Nord-Ovest (ddt_fornitoreID = 1)
-- Alimentari
(85, 1, 1),  -- Pasta Barilla
(72, 1, 2),  -- Riso Basmati
(63, 1, 3),  -- Olio Extra Vergine d'Oliva
(91, 1, 4),  -- Sugo al Pomodoro
(45, 1, 5),  -- Caffè in Grani
(38, 1, 6),  -- Cioccolato Fondente
(77, 1, 7),  -- Biscotti Integrali
(92, 1, 8),  -- Acqua Minerale
(54, 1, 9),  -- Yogurt Greco
(29, 1, 10), -- Miele Biologico
(81, 1, 11), -- Farina 00
(98, 1, 12), -- Zucchero
(87, 1, 13), -- Sale
(76, 1, 14), -- Pomodori Pelati
(66, 1, 15), -- Tonno in Scatola

-- Fornitore 1 - Magazzino Nord-Est (ddt_fornitoreID = 2)
-- Altri Alimentari
(82, 2, 16), -- Fagioli in Scatola
(47, 2, 17), -- Pesto alla Genovese
(59, 2, 18), -- Cereali Integrali
(94, 2, 19), -- Latte UHT
(36, 2, 20), -- Burro
(28, 2, 21), -- Formaggio Parmigiano
(67, 2, 22), -- Mozzarella
(85, 2, 23), -- Pane Integrale
(42, 2, 24), -- Salmone Affumicato
(51, 2, 25), -- Prosciutto Crudo
(73, 2, 26), -- Salsiccia
(88, 2, 27), -- Pizza Surgelata
(64, 2, 28), -- Gelato alla Vaniglia
(79, 2, 29), -- Succhi di Frutta
(33, 2, 30), -- Vino Rosso

-- Fornitore 1 - Magazzino Centro (ddt_fornitoreID = 3)
-- Altri Alimentari e Abbigliamento
(56, 3, 31), -- Birra Artigianale
(92, 3, 32), -- Patatine Fritte
(78, 3, 33), -- Crackers Integrali
(43, 3, 34), -- Marmellata di Frutta
(69, 3, 35), -- Passata di Pomodoro
(52, 3, 36), -- Couscous
(31, 3, 37), -- Quinoa
(67, 3, 38), -- Lenticchie
(83, 3, 39), -- Ceci in Scatola
(96, 3, 40), -- Piselli
(87, 3, 41), -- Carote
(75, 3, 42), -- Zucchine
(62, 3, 43), -- Mele
(81, 3, 44), -- Banane
(93, 3, 45), -- Arance

-- Fornitore 1 - Magazzino Sud (ddt_fornitoreID = 4)
-- Altri prodotti alimentari e categorie diverse
(48, 4, 46), -- Uva
(37, 4, 47), -- Fragole
(58, 4, 48), -- Pesche
(69, 4, 49), -- Kiwi
(86, 4, 50), -- Ananas
(43, 4, 51), -- Mango
(74, 4, 52), -- Avocado
(91, 4, 53), -- Spinaci
(67, 4, 54), -- Broccoli
(53, 4, 55), -- Cavolfiore
(82, 4, 56), -- Funghi
(76, 4, 57), -- Peperoni
(89, 4, 58), -- Pomodori
(94, 4, 59), -- Cetrioli
(68, 4, 60), -- Insalata

-- Abbigliamento distribuito tra i 4 magazzini
(42, 1, 61), -- Maglietta Uomo
(55, 2, 62), -- Maglietta Donna
(39, 3, 63), -- Jeans Uomo
(47, 4, 64), -- Jeans Donna
(33, 1, 65), -- Felpa con Cappuccio
(28, 2, 66), -- Giacca a Vento
(51, 3, 67), -- Scarpe da Ginnastica
(44, 4, 68), -- Cappello
(63, 1, 69), -- Sciarpa
(29, 2, 70), -- Cintura

-- Casa e Giardino distribuito tra i 4 magazzini
(38, 3, 71), -- Vaso per Piante
(46, 4, 72), -- Lampada da Tavolo
(27, 1, 73), -- Tappeto
(32, 2, 74), -- Set di Pentole
(58, 3, 75), -- Tovaglia
(47, 4, 76), -- Cuscini Decorativi
(35, 1, 77), -- Tenda per Esterno
(22, 2, 78), -- Tagliaerba Elettrico
(41, 3, 79), -- Set di Utensili da Giardino
(53, 4, 80), -- Sedia da Giardino

-- Cosmetica distribuito tra i 4 magazzini
(77, 1, 81), -- Crema Viso
(83, 2, 82), -- Shampoo
(68, 3, 83), -- Balsamo
(92, 4, 84), -- Dentifricio
(75, 1, 85), -- Sapone Liquido
(61, 2, 86), -- Deodorante
(43, 3, 87), -- Profumo
(57, 4, 88), -- Crema Mani
(69, 1, 89), -- Maschera Viso
(74, 2, 90), -- Olio per Capelli

-- Elettronica distribuito tra i 4 magazzini
(19, 3, 91), -- Smartphone
(25, 4, 92), -- Tablet
(15, 1, 93), -- Laptop
(32, 2, 94), -- Cuffie Wireless
(27, 3, 95), -- Smartwatch

-- Sport distribuito tra i 4 magazzini
(48, 4, 96), -- Palla da Calcio
(56, 1, 97), -- Palla da Basket
(72, 2, 98), -- Palla da Tennis
(39, 3, 99), -- Racchetta da Tennis
(43, 4, 100), -- Set di Pesi

-- Fornitore 2 - Magazzino Nord-Ovest (ddt_fornitoreID = 5)
(67, 5, 1),   -- Pasta Barilla
(53, 5, 2),   -- Riso Basmati
(78, 5, 3),   -- Olio Extra Vergine d'Oliva
(84, 5, 4),   -- Sugo al Pomodoro
(59, 5, 5),   -- Caffè in Grani
(46, 5, 6),   -- Cioccolato Fondente
(73, 5, 7),   -- Biscotti Integrali
(97, 5, 8),   -- Acqua Minerale
(63, 5, 9),   -- Yogurt Greco
(41, 5, 10),  -- Miele Biologico
(88, 5, 61),  -- Maglietta Uomo
(53, 5, 71),  -- Vaso per Piante
(29, 5, 81),  -- Crema Viso
(18, 5, 91),  -- Smartphone
(45, 5, 96),  -- Palla da Calcio

-- Fornitore 2 - Magazzino Nord-Est (ddt_fornitoreID = 6)
(79, 6, 11),  -- Farina 00
(93, 6, 12),  -- Zucchero
(86, 6, 13),  -- Sale
(62, 6, 14),  -- Pomodori Pelati
(51, 6, 15),  -- Tonno in Scatola
(70, 6, 16),  -- Fagioli in Scatola
(37, 6, 17),  -- Pesto alla Genovese
(65, 6, 18),  -- Cereali Integrali
(82, 6, 19),  -- Latte UHT
(44, 6, 20),  -- Burro
(69, 6, 62),  -- Maglietta Donna
(48, 6, 72),  -- Lampada da Tavolo
(76, 6, 82),  -- Shampoo
(33, 6, 92),  -- Tablet
(61, 6, 97),  -- Palla da Basket

-- Fornitore 2 - Magazzino Centro (ddt_fornitoreID = 7)
(38, 7, 21),  -- Formaggio Parmigiano
(75, 7, 22),  -- Mozzarella
(90, 7, 23),  -- Pane Integrale
(47, 7, 24),  -- Salmone Affumicato
(56, 7, 25),  -- Prosciutto Crudo
(68, 7, 26),  -- Salsiccia
(83, 7, 27),  -- Pizza Surgelata
(71, 7, 28),  -- Gelato alla Vaniglia
(42, 7, 29),  -- Succhi di Frutta
(24, 7, 30),  -- Vino Rosso
(51, 7, 63),  -- Jeans Uomo
(64, 7, 73),  -- Tappeto
(39, 7, 83),  -- Balsamo
(21, 7, 93),  -- Laptop
(54, 7, 98),  -- Palla da Tennis

-- Fornitore 2 - Magazzino Sud (ddt_fornitoreID = 8)
(49, 8, 31),  -- Birra Artigianale
(87, 8, 32),  -- Patatine Fritte
(74, 8, 33),  -- Crackers Integrali
(59, 8, 34),  -- Marmellata di Frutta
(66, 8, 35),  -- Passata di Pomodoro
(42, 8, 36),  -- Couscous
(27, 8, 37),  -- Quinoa
(58, 8, 38),  -- Lenticchie
(79, 8, 39),  -- Ceci in Scatola
(91, 8, 40),  -- Piselli
(64, 8, 64),  -- Jeans Donna
(57, 8, 74),  -- Set di Pentole
(85, 8, 84),  -- Dentifricio
(37, 8, 94),  -- Cuffie Wireless
(48, 8, 99),  -- Racchetta da Tennis

-- Fornitore 3 (DDT 9-12)
-- Fornitore 3 - Magazzino Nord-Ovest (ddt_fornitoreID = 9)
(83, 9, 41),  -- Carote
(72, 9, 42),  -- Zucchine
(65, 9, 43),  -- Mele
(94, 9, 44),  -- Banane
(80, 9, 45),  -- Arance
(57, 9, 46),  -- Uva
(43, 9, 47),  -- Fragole
(35, 9, 48),  -- Pesche
(68, 9, 49),  -- Kiwi
(75, 9, 50),  -- Ananas
(44, 9, 65),  -- Felpa con Cappuccio
(36, 9, 75),  -- Tovaglia
(63, 9, 85),  -- Sapone Liquido
(23, 9, 95),  -- Smartwatch
(52, 9, 100), -- Set di Pesi

-- Fornitore 3 - Magazzino Nord-Est (ddt_fornitoreID = 10)
(51, 10, 51), -- Mango
(67, 10, 52), -- Avocado
(88, 10, 53), -- Spinaci
(73, 10, 54), -- Broccoli
(58, 10, 55), -- Cavolfiore
(81, 10, 56), -- Funghi
(69, 10, 57), -- Peperoni
(93, 10, 58), -- Pomodori
(85, 10, 59), -- Cetrioli
(76, 10, 60), -- Insalata
(31, 10, 66), -- Giacca a Vento
(45, 10, 76), -- Cuscini Decorativi
(72, 10, 86), -- Deodorante
(26, 10, 91), -- Smartphone (secondo stock)
(36, 10, 96), -- Palla da Calcio (secondo stock)

-- Fornitore 3 - Magazzino Centro (ddt_fornitoreID = 11)
(77, 11, 1),  -- Pasta Barilla (secondo stock)
(62, 11, 11), -- Farina 00 (secondo stock)
(83, 11, 21), -- Formaggio Parmigiano (secondo stock)
(56, 11, 31), -- Birra Artigianale (secondo stock)
(69, 11, 41), -- Carote (secondo stock)
(43, 11, 51), -- Mango (secondo stock)
(78, 11, 61), -- Maglietta Uomo (secondo stock)
(53, 11, 67), -- Scarpe da Ginnastica
(42, 11, 77), -- Tenda per Esterno
(32, 11, 79), -- Set di Utensili da Giardino
(61, 11, 87), -- Profumo
(47, 11, 92), -- Tablet (secondo stock)
(59, 11, 97), -- Palla da Basket (secondo stock)
(36, 11, 99), -- Racchetta da Tennis (secondo stock)
(28, 11, 90), -- Olio per Capelli

-- Fornitore 3 - Magazzino Sud (ddt_fornitoreID = 12)
(59, 12, 2),  -- Riso Basmati (secondo stock)
(71, 12, 12), -- Zucchero (secondo stock)
(86, 12, 22), -- Mozzarella (secondo stock)
(63, 12, 32), -- Patatine Fritte (secondo stock)
(49, 12, 42), -- Zucchine (secondo stock)
(74, 12, 52), -- Avocado (secondo stock)
(57, 12, 62), -- Maglietta Donna (secondo stock)
(39, 12, 68), -- Cappello
(58, 12, 72), -- Lampada da Tavolo (secondo stock)
(64, 12, 78), -- Tagliaerba Elettrico
(46, 12, 80), -- Sedia da Giardino
(73, 12, 88), -- Crema Mani
(52, 12, 93), -- Laptop (secondo stock)
(28, 12, 98), -- Palla da Tennis (secondo stock)
(35, 12, 100), -- Set di Pesi (secondo stock)

-- Fornitore 4 (DDT 13-16)
-- Fornitore 4 - Magazzino Nord-Ovest (ddt_fornitoreID = 13)
(68, 13, 3),  -- Olio Extra Vergine d'Oliva (secondo stock)
(59, 13, 13), -- Sale (secondo stock)
(73, 13, 23), -- Pane Integrale (secondo stock)
(66, 13, 33), -- Crackers Integrali (secondo stock)
(82, 13, 43), -- Mele (secondo stock)
(74, 13, 53), -- Spinaci (secondo stock)
(48, 13, 63), -- Jeans Uomo (secondo stock)
(58, 13, 69), -- Sciarpa
(39, 13, 73), -- Tappeto (secondo stock)
(67, 13, 81), -- Crema Viso (secondo stock)
(55, 13, 82), -- Shampoo (secondo stock)
(41, 13, 83), -- Balsamo (secondo stock)
(62, 13, 84), -- Dentifricio (secondo stock)
(73, 13, 89), -- Maschera Viso
(34, 13, 94), -- Cuffie Wireless (secondo stock)

-- Fornitore 4 - Magazzino Nord-Est (ddt_fornitoreID = 14)
(85, 14, 4),  -- Sugo al Pomodoro (secondo stock)
(69, 14, 14), -- Pomodori Pelati (secondo stock)
(54, 14, 24), -- Salmone Affumicato (secondo stock)
(79, 14, 34), -- Marmellata di Frutta (secondo stock)
(61, 14, 44), -- Banane (secondo stock)
(87, 14, 54), -- Broccoli (secondo stock)
(52, 14, 64), -- Jeans Donna (secondo stock)
(36, 14, 70), -- Cintura
(41, 14, 74), -- Set di Pentole (secondo stock)
(77, 14, 75), -- Tovaglia (secondo stock)
(59, 14, 76), -- Cuscini Decorativi (secondo stock)
(46, 14, 77), -- Tenda per Esterno (secondo stock)
(62, 14, 85), -- Sapone Liquido (secondo stock)
(68, 14, 90), -- Olio per Capelli (secondo stock)
(24, 14, 95), -- Smartwatch (secondo stock)

-- Fornitore 4 - Magazzino Centro (ddt_fornitoreID = 15)
(58, 15, 5),  -- Caffè in Grani (secondo stock)
(62, 15, 15), -- Tonno in Scatola (secondo stock)
(75, 15, 25), -- Prosciutto Crudo (secondo stock)
(83, 15, 35), -- Passata di Pomodoro (secondo stock)
(47, 15, 45), -- Arance (secondo stock)
(69, 15, 55), -- Cavolfiore (secondo stock)
(56, 15, 65), -- Felpa con Cappuccio (secondo stock)
(31, 15, 66), -- Giacca a Vento (secondo stock)
(29, 15, 67), -- Scarpe da Ginnastica (secondo stock)
(44, 15, 68), -- Cappello (secondo stock)
(58, 15, 69), -- Sciarpa (secondo stock)
(41, 15, 70), -- Cintura (secondo stock)
(37, 15, 86), -- Deodorante (secondo stock)
(49, 15, 87), -- Profumo (secondo stock)
(19, 15, 91), -- Smartphone (terzo stock)

-- Fornitore 4 - Magazzino Sud (ddt_fornitoreID = 16)
(43, 16, 6),  -- Cioccolato Fondente (secondo stock)
(69, 16, 16), -- Fagioli in Scatola (secondo stock)
(82, 16, 26), -- Salsiccia (secondo stock)
(58, 16, 36), -- Couscous (secondo stock)
(39, 16, 46), -- Uva (secondo stock)
(74, 16, 56), -- Funghi (secondo stock)
(61, 16, 57), -- Peperoni (secondo stock)
(93, 16, 58), -- Pomodori (secondo stock)
(79, 16, 59), -- Cetrioli (secondo stock)
(86, 16, 60), -- Insalata (secondo stock)
(25, 16, 71), -- Vaso per Piante (secondo stock)
(37, 16, 79), -- Set di Utensili da Giardino (secondo stock)
(51, 16, 88), -- Crema Mani (secondo stock)
(64, 16, 89), -- Maschera Viso (secondo stock)
(49, 16, 100); -- Set di Pesi (terzo stock)






-- Popolamento della tabella restock_soglie_magazzino
INSERT INTO restock_soglie_magazzino (quantita_soglia, magazzinoID, prodottoID) VALUES
-- Magazzino 1 (Nord-Ovest)
-- Alimentari essenziali
(30, 1, 1),   -- Pasta Barilla
(25, 1, 2),   -- Riso Basmati
(20, 1, 3),   -- Olio Extra Vergine d'Oliva
(35, 1, 4),   -- Sugo al Pomodoro
(20, 1, 5),   -- Caffè in Grani
(15, 1, 6),   -- Cioccolato Fondente
(30, 1, 7),   -- Biscotti Integrali
(40, 1, 8),   -- Acqua Minerale
(20, 1, 9),   -- Yogurt Greco
(10, 1, 10),  -- Miele Biologico
(30, 1, 11),  -- Farina 00
(35, 1, 12),  -- Zucchero
(30, 1, 13),  -- Sale

-- Frutta e verdura per Magazzino Nord-Ovest (alta rotazione)
(25, 1, 41),  -- Carote
(20, 1, 42),  -- Zucchine
(30, 1, 43),  -- Mele
(35, 1, 44),  -- Banane
(30, 1, 45),  -- Arance
(20, 1, 46),  -- Uva
(15, 1, 47),  -- Fragole

-- Abbigliamento per Magazzino Nord-Ovest
(15, 1, 61),  -- Maglietta Uomo
(15, 1, 65),  -- Felpa con Cappuccio
(20, 1, 69),  -- Sciarpa

-- Casa e Giardino per Magazzino Nord-Ovest
(10, 1, 73),  -- Tappeto
(12, 1, 77),  -- Tenda per Esterno

-- Cosmetica per Magazzino Nord-Ovest
(25, 1, 81),  -- Crema Viso
(25, 1, 85),  -- Sapone Liquido
(20, 1, 89),  -- Maschera Viso

-- Elettronica per Magazzino Nord-Ovest
(5, 1, 93),   -- Laptop

-- Sport per Magazzino Nord-Ovest
(20, 1, 97),  -- Palla da Basket

-- Magazzino 2 (Nord-Est)
-- Alimentari essenziali
(30, 2, 14),  -- Pomodori Pelati
(25, 2, 15),  -- Tonno in Scatola
(20, 2, 16),  -- Fagioli in Scatola
(15, 2, 17),  -- Pesto alla Genovese
(25, 2, 18),  -- Cereali Integrali
(35, 2, 19),  -- Latte UHT
(15, 2, 20),  -- Burro
(10, 2, 21),  -- Formaggio Parmigiano
(25, 2, 22),  -- Mozzarella
(30, 2, 23),  -- Pane Integrale

-- Frutta e verdura per Magazzino Nord-Est
(20, 2, 48),  -- Pesche
(25, 2, 49),  -- Kiwi
(30, 2, 50),  -- Ananas
(15, 2, 51),  -- Mango
(20, 2, 52),  -- Avocado
(30, 2, 53),  -- Spinaci
(25, 2, 54),  -- Broccoli

-- Abbigliamento per Magazzino Nord-Est
(20, 2, 62),  -- Maglietta Donna
(10, 2, 66),  -- Giacca a Vento
(10, 2, 70),  -- Cintura

-- Casa e Giardino per Magazzino Nord-Est
(15, 2, 72),  -- Lampada da Tavolo
(10, 2, 74),  -- Set di Pentole
(15, 2, 78),  -- Tagliaerba Elettrico

-- Cosmetica per Magazzino Nord-Est
(30, 2, 82),  -- Shampoo
(20, 2, 86),  -- Deodorante
(25, 2, 90),  -- Olio per Capelli

-- Elettronica per Magazzino Nord-Est
(10, 2, 94),  -- Cuffie Wireless

-- Sport per Magazzino Nord-Est
(25, 2, 98),  -- Palla da Tennis

-- Magazzino 3 (Centro)
-- Alimentari essenziali
(20, 3, 24),  -- Salmone Affumicato
(20, 3, 25),  -- Prosciutto Crudo
(25, 3, 26),  -- Salsiccia
(30, 3, 27),  -- Pizza Surgelata
(25, 3, 28),  -- Gelato alla Vaniglia
(30, 3, 29),  -- Succhi di Frutta
(15, 3, 30),  -- Vino Rosso
(20, 3, 31),  -- Birra Artigianale
(35, 3, 32),  -- Patatine Fritte
(30, 3, 33),  -- Crackers Integrali

-- Frutta e verdura per Magazzino Centro
(20, 3, 55),  -- Cavolfiore
(25, 3, 56),  -- Funghi
(30, 3, 57),  -- Peperoni
(35, 3, 58),  -- Pomodori
(30, 3, 59),  -- Cetrioli
(25, 3, 60),  -- Insalata

-- Abbigliamento per Magazzino Centro
(15, 3, 63),  -- Jeans Uomo
(20, 3, 67),  -- Scarpe da Ginnastica

-- Casa e Giardino per Magazzino Centro
(15, 3, 71),  -- Vaso per Piante
(20, 3, 75),  -- Tovaglia
(15, 3, 79),  -- Set di Utensili da Giardino

-- Cosmetica per Magazzino Centro
(25, 3, 83),  -- Balsamo
(15, 3, 87),  -- Profumo

-- Elettronica per Magazzino Centro
(8, 3, 91),   -- Smartphone
(10, 3, 95),  -- Smartwatch

-- Sport per Magazzino Centro
(15, 3, 99),  -- Racchetta da Tennis

-- Magazzino 4 (Sud)
-- Alimentari essenziali
(25, 4, 34),  -- Marmellata di Frutta
(20, 4, 35),  -- Passata di Pomodoro
(15, 4, 36),  -- Couscous
(10, 4, 37),  -- Quinoa
(20, 4, 38),  -- Lenticchie
(30, 4, 39),  -- Ceci in Scatola
(35, 4, 40),  -- Piselli

-- Frutta e verdura per Magazzino Sud
(30, 4, 41),  -- Carote (secondo magazzino per rotazione)
(25, 4, 43),  -- Mele (secondo magazzino per rotazione)
(20, 4, 45),  -- Arance (secondo magazzino per rotazione)
(15, 4, 47),  -- Fragole (secondo magazzino per rotazione)
(30, 4, 49),  -- Kiwi (secondo magazzino per rotazione)
(25, 4, 51),  -- Mango (secondo magazzino per rotazione)

-- Abbigliamento per Magazzino Sud
(15, 4, 64),  -- Jeans Donna
(20, 4, 68),  -- Cappello

-- Casa e Giardino per Magazzino Sud
(15, 4, 76),  -- Cuscini Decorativi
(20, 4, 80),  -- Sedia da Giardino

-- Cosmetica per Magazzino Sud
(30, 4, 84),  -- Dentifricio
(20, 4, 88),  -- Crema Mani

-- Elettronica per Magazzino Sud
(10, 4, 92),  -- Tablet

-- Sport per Magazzino Sud
(20, 4, 96),  -- Palla da Calcio
(15, 4, 100); -- Set di Pesi










-- Popolamento della tabella ddt_magazzino
INSERT INTO ddt_magazzino (data_riassortimento, magazzinoID, negozioID) VALUES
-- Magazzino 1 (Nord-Ovest) rifornisce i negozi dell'area Nord-Ovest
('2024-02-03', 1, 1),  -- Magazzino Nord-Ovest -> Negozio Milano Centro
('2024-02-04', 1, 2),  -- Magazzino Nord-Ovest -> Negozio Milano Nord
('2024-02-05', 1, 3),  -- Magazzino Nord-Ovest -> Negozio Torino Centro
('2024-02-06', 1, 4),  -- Magazzino Nord-Ovest -> Negozio Genova Centro
('2024-02-07', 1, 5),  -- Magazzino Nord-Ovest -> Negozio Asti Centro

-- Magazzino 2 (Nord-Est) rifornisce i negozi dell'area Nord-Est
('2024-02-08', 2, 6),  -- Magazzino Nord-Est -> Negozio Venezia Centro
('2024-02-09', 2, 7),  -- Magazzino Nord-Est -> Negozio Bologna Centro
('2024-02-10', 2, 8),  -- Magazzino Nord-Est -> Negozio Padova Centro
('2024-02-11', 2, 9),  -- Magazzino Nord-Est -> Negozio Verona Centro

-- Magazzino 3 (Centro) rifornisce i negozi dell'area Centro
('2024-02-12', 3, 10), -- Magazzino Centro -> Negozio Roma Centro
('2024-02-13', 3, 11), -- Magazzino Centro -> Negozio Roma Sud
('2024-02-14', 3, 12), -- Magazzino Centro -> Negozio Firenze Centro
('2024-02-15', 3, 13), -- Magazzino Centro -> Negozio Perugia Centro
('2024-02-16', 3, 14), -- Magazzino Centro -> Negozio Pesaro Centro

-- Magazzino 4 (Sud) rifornisce i negozi dell'area Sud
('2024-02-17', 4, 15), -- Magazzino Sud -> Negozio Napoli Centro
('2024-02-18', 4, 16), -- Magazzino Sud -> Negozio Palermo Centro
('2024-02-19', 4, 17), -- Magazzino Sud -> Negozio Bari Centro
('2024-02-20', 4, 18), -- Magazzino Sud -> Negozio Catania Centro

-- Secondo giro di rifornimenti (fine Febbraio)
('2024-02-24', 1, 1),  -- Magazzino Nord-Ovest -> Negozio Milano Centro
('2024-02-25', 1, 2),  -- Magazzino Nord-Ovest -> Negozio Milano Nord
('2024-02-26', 2, 6),  -- Magazzino Nord-Est -> Negozio Venezia Centro
('2024-02-27', 2, 7),  -- Magazzino Nord-Est -> Negozio Bologna Centro
('2024-02-28', 3, 10), -- Magazzino Centro -> Negozio Roma Centro
('2024-02-29', 3, 11), -- Magazzino Centro -> Negozio Roma Sud
('2024-03-01', 4, 15), -- Magazzino Sud -> Negozio Napoli Centro
('2024-03-02', 4, 16), -- Magazzino Sud -> Negozio Palermo Centro

-- Casi speciali (rifornimenti incrociati per necessità particolari)
('2024-02-21', 1, 6),  -- Magazzino Nord-Ovest -> Negozio Venezia Centro (caso speciale)
('2024-02-22', 2, 10), -- Magazzino Nord-Est -> Negozio Roma Centro (caso speciale)
('2024-02-23', 3, 15), -- Magazzino Centro -> Negozio Napoli Centro (caso speciale)
('2024-03-03', 4, 3);  -- Magazzino Sud -> Negozio Torino Centro (caso speciale)









-- Popolamento della tabella riassortimento_magazzino
INSERT INTO riassortimento_magazzino (quantita_riassortita, ddt_magazzinoID, prodottoID) VALUES
-- DDT 1: Magazzino Nord-Ovest -> Negozio Milano Centro (2024-02-03)
(35, 1, 1),   -- Pasta Barilla
(28, 1, 2),   -- Riso Basmati
(15, 1, 3),   -- Olio Extra Vergine d'Oliva
(42, 1, 4),   -- Sugo al Pomodoro
(18, 1, 5),   -- Caffè in Grani
(12, 1, 6),   -- Cioccolato Fondente
(32, 1, 7),   -- Biscotti Integrali
(48, 1, 8),   -- Acqua Minerale
(22, 1, 9),   -- Yogurt Greco
(8, 1, 10),   -- Miele Biologico
(25, 1, 61),  -- Maglietta Uomo
(8, 1, 73),   -- Tappeto
(20, 1, 81),  -- Crema Viso
(4, 1, 93),   -- Laptop

-- DDT 2: Magazzino Nord-Ovest -> Negozio Milano Nord (2024-02-04)
(30, 2, 1),   -- Pasta Barilla
(22, 2, 2),   -- Riso Basmati
(12, 2, 3),   -- Olio Extra Vergine d'Oliva
(38, 2, 4),   -- Sugo al Pomodoro
(15, 2, 5),   -- Caffè in Grani
(10, 2, 6),   -- Cioccolato Fondente
(28, 2, 7),   -- Biscotti Integrali
(44, 2, 8),   -- Acqua Minerale
(18, 2, 9),   -- Yogurt Greco
(6, 2, 10),   -- Miele Biologico
(15, 2, 43),  -- Mele
(18, 2, 44),  -- Banane
(22, 2, 65),  -- Felpa con Cappuccio
(15, 2, 85),  -- Sapone Liquido

-- DDT 3: Magazzino Nord-Ovest -> Negozio Torino Centro (2024-02-05)
(32, 3, 1),   -- Pasta Barilla
(25, 3, 2),   -- Riso Basmati
(14, 3, 3),   -- Olio Extra Vergine d'Oliva
(35, 3, 4),   -- Sugo al Pomodoro
(16, 3, 11),  -- Farina 00
(22, 3, 12),  -- Zucchero
(20, 3, 13),  -- Sale
(24, 3, 41),  -- Carote
(20, 3, 42),  -- Zucchine
(28, 3, 43),  -- Mele
(20, 3, 69),  -- Sciarpa
(18, 3, 97),  -- Palla da Basket

-- DDT 4: Magazzino Nord-Ovest -> Negozio Genova Centro (2024-02-06)
(25, 4, 1),   -- Pasta Barilla
(20, 4, 2),   -- Riso Basmati
(10, 4, 3),   -- Olio Extra Vergine d'Oliva
(30, 4, 4),   -- Sugo al Pomodoro
(12, 4, 11),  -- Farina 00
(18, 4, 12),  -- Zucchero
(16, 4, 13),  -- Sale
(18, 4, 45),  -- Arance
(14, 4, 46),  -- Uva
(10, 4, 47),  -- Fragole
(12, 4, 77),  -- Tenda per Esterno
(15, 4, 89),  -- Maschera Viso

-- DDT 5: Magazzino Nord-Ovest -> Negozio Asti Centro (2024-02-07)
(20, 5, 1),   -- Pasta Barilla
(15, 5, 2),   -- Riso Basmati
(8, 5, 3),    -- Olio Extra Vergine d'Oliva
(25, 5, 4),   -- Sugo al Pomodoro
(10, 5, 5),   -- Caffè in Grani
(8, 5, 6),    -- Cioccolato Fondente
(18, 5, 7),   -- Biscotti Integrali
(30, 5, 8),   -- Acqua Minerale
(15, 5, 9),   -- Yogurt Greco
(5, 5, 10),   -- Miele Biologico
(10, 5, 61),  -- Maglietta Uomo
(12, 5, 65),  -- Felpa con Cappuccio

-- DDT 6: Magazzino Nord-Est -> Negozio Venezia Centro (2024-02-08)
(25, 6, 14),  -- Pomodori Pelati
(20, 6, 15),  -- Tonno in Scatola
(15, 6, 16),  -- Fagioli in Scatola
(10, 6, 17),  -- Pesto alla Genovese
(18, 6, 18),  -- Cereali Integrali
(30, 6, 19),  -- Latte UHT
(12, 6, 20),  -- Burro
(6, 6, 21),   -- Formaggio Parmigiano
(18, 6, 22),  -- Mozzarella
(22, 6, 23),  -- Pane Integrale
(15, 6, 62),  -- Maglietta Donna
(8, 6, 72),   -- Lampada da Tavolo
(22, 6, 82),  -- Shampoo

-- DDT 7: Magazzino Nord-Est -> Negozio Bologna Centro (2024-02-09)
(22, 7, 14),  -- Pomodori Pelati
(18, 7, 15),  -- Tonno in Scatola
(14, 7, 16),  -- Fagioli in Scatola
(8, 7, 17),   -- Pesto alla Genovese
(16, 7, 18),  -- Cereali Integrali
(28, 7, 19),  -- Latte UHT
(10, 7, 20),  -- Burro
(5, 7, 21),   -- Formaggio Parmigiano
(16, 7, 22),  -- Mozzarella
(20, 7, 23),  -- Pane Integrale
(15, 7, 48),  -- Pesche
(18, 7, 49),  -- Kiwi
(7, 7, 94),   -- Cuffie Wireless

-- DDT 8: Magazzino Nord-Est -> Negozio Padova Centro (2024-02-10)
(20, 8, 14),  -- Pomodori Pelati
(16, 8, 15),  -- Tonno in Scatola
(12, 8, 16),  -- Fagioli in Scatola
(8, 8, 17),   -- Pesto alla Genovese
(15, 8, 18),  -- Cereali Integrali
(25, 8, 19),  -- Latte UHT
(8, 8, 20),   -- Burro
(4, 8, 21),   -- Formaggio Parmigiano
(15, 8, 22),  -- Mozzarella
(18, 8, 23),  -- Pane Integrale
(18, 8, 50),  -- Ananas
(12, 8, 51),  -- Mango
(15, 8, 52),  -- Avocado
(12, 8, 66),  -- Giacca a Vento
(20, 8, 86),  -- Deodorante

-- DDT 9: Magazzino Nord-Est -> Negozio Verona Centro (2024-02-11)
(18, 9, 14),  -- Pomodori Pelati
(15, 9, 15),  -- Tonno in Scatola
(10, 9, 16),  -- Fagioli in Scatola
(7, 9, 17),   -- Pesto alla Genovese
(12, 9, 18),  -- Cereali Integrali
(22, 9, 19),  -- Latte UHT
(7, 9, 20),   -- Burro
(3, 9, 21),   -- Formaggio Parmigiano
(12, 9, 22),  -- Mozzarella
(15, 9, 23),  -- Pane Integrale
(20, 9, 53),  -- Spinaci
(18, 9, 54),  -- Broccoli
(8, 9, 70),   -- Cintura
(8, 9, 74),   -- Set di Pentole
(18, 9, 90),  -- Olio per Capelli
(20, 9, 98),  -- Palla da Tennis

-- DDT 10: Magazzino Centro -> Negozio Roma Centro (2024-02-12)
(15, 10, 24), -- Salmone Affumicato
(15, 10, 25), -- Prosciutto Crudo
(20, 10, 26), -- Salsiccia
(25, 10, 27), -- Pizza Surgelata
(20, 10, 28), -- Gelato alla Vaniglia
(25, 10, 29), -- Succhi di Frutta
(12, 10, 30), -- Vino Rosso
(15, 10, 31), -- Birra Artigianale
(28, 10, 32), -- Patatine Fritte
(22, 10, 33), -- Crackers Integrali
(12, 10, 63), -- Jeans Uomo
(10, 10, 79), -- Set di Utensili da Giardino
(6, 10, 91),  -- Smartphone

-- DDT 11: Magazzino Centro -> Negozio Roma Sud (2024-02-13)
(12, 11, 24), -- Salmone Affumicato
(12, 11, 25), -- Prosciutto Crudo
(18, 11, 26), -- Salsiccia
(22, 11, 27), -- Pizza Surgelata
(18, 11, 28), -- Gelato alla Vaniglia
(22, 11, 29), -- Succhi di Frutta
(10, 11, 30), -- Vino Rosso
(12, 11, 31), -- Birra Artigianale
(25, 11, 32), -- Patatine Fritte
(20, 11, 33), -- Crackers Integrali
(15, 11, 55), -- Cavolfiore
(18, 11, 56), -- Funghi
(22, 11, 57), -- Peperoni
(25, 11, 58), -- Pomodori
(20, 11, 59), -- Cetrioli
(18, 11, 60), -- Insalata
(15, 11, 67), -- Scarpe da Ginnastica
(8, 11, 95),  -- Smartwatch

-- DDT 12: Magazzino Centro -> Negozio Firenze Centro (2024-02-14)
(10, 12, 24), -- Salmone Affumicato
(10, 12, 25), -- Prosciutto Crudo
(15, 12, 26), -- Salsiccia
(20, 12, 27), -- Pizza Surgelata
(15, 12, 28), -- Gelato alla Vaniglia
(20, 12, 29), -- Succhi di Frutta
(8, 12, 30),  -- Vino Rosso
(10, 12, 31), -- Birra Artigianale
(22, 12, 32), -- Patatine Fritte
(18, 12, 33), -- Crackers Integrali
(10, 12, 71), -- Vaso per Piante
(15, 12, 75), -- Tovaglia
(18, 12, 83), -- Balsamo
(10, 12, 87), -- Profumo
(12, 12, 99), -- Racchetta da Tennis

-- DDT 13: Magazzino Centro -> Negozio Perugia Centro (2024-02-15)
(8, 13, 24),  -- Salmone Affumicato
(8, 13, 25),  -- Prosciutto Crudo
(12, 13, 26), -- Salsiccia
(18, 13, 27), -- Pizza Surgelata
(12, 13, 28), -- Gelato alla Vaniglia
(18, 13, 29), -- Succhi di Frutta
(7, 13, 30),  -- Vino Rosso
(8, 13, 31),  -- Birra Artigianale
(20, 13, 32), -- Patatine Fritte
(15, 13, 33), -- Crackers Integrali
(12, 13, 55), -- Cavolfiore
(15, 13, 56), -- Funghi
(18, 13, 57), -- Peperoni
(20, 13, 58), -- Pomodori
(18, 13, 59), -- Cetrioli
(15, 13, 60), -- Insalata

-- DDT 14: Magazzino Centro -> Negozio Pesaro Centro (2024-02-16)
(7, 14, 24),  -- Salmone Affumicato
(7, 14, 25),  -- Prosciutto Crudo
(10, 14, 26), -- Salsiccia
(15, 14, 27), -- Pizza Surgelata
(10, 14, 28), -- Gelato alla Vaniglia
(15, 14, 29), -- Succhi di Frutta
(6, 14, 30),  -- Vino Rosso
(7, 14, 31),  -- Birra Artigianale
(18, 14, 32), -- Patatine Fritte
(12, 14, 33), -- Crackers Integrali
(8, 14, 63),  -- Jeans Uomo
(12, 14, 67), -- Scarpe da Ginnastica
(8, 14, 71),  -- Vaso per Piante
(10, 14, 83), -- Balsamo

-- DDT 15: Magazzino Sud -> Negozio Napoli Centro (2024-02-17)
(20, 15, 34), -- Marmellata di Frutta
(18, 15, 35), -- Passata di Pomodoro
(12, 15, 36), -- Couscous
(8, 15, 37),  -- Quinoa
(15, 15, 38), -- Lenticchie
(25, 15, 39), -- Ceci in Scatola
(30, 15, 40), -- Piselli
(25, 15, 41), -- Carote (secondo magazzino per rotazione)
(20, 15, 43), -- Mele (secondo magazzino per rotazione)
(12, 15, 64), -- Jeans Donna
(15, 15, 84), -- Dentifricio
(8, 15, 92),  -- Tablet
(15, 15, 96), -- Palla da Calcio

-- DDT 16: Magazzino Sud -> Negozio Palermo Centro (2024-02-18)
(18, 16, 34), -- Marmellata di Frutta
(15, 16, 35), -- Passata di Pomodoro
(10, 16, 36), -- Couscous
(6, 16, 37),  -- Quinoa
(12, 16, 38), -- Lenticchie
(20, 16, 39), -- Ceci in Scatola
(25, 16, 40), -- Piselli
(15, 16, 45), -- Arance (secondo magazzino per rotazione)
(10, 16, 47), -- Fragole (secondo magazzino per rotazione)
(22, 16, 49), -- Kiwi (secondo magazzino per rotazione)
(10, 16, 68), -- Cappello
(15, 16, 76), -- Cuscini Decorativi
(18, 16, 88), -- Crema Mani
(12, 16, 100), -- Set di Pesi

-- DDT 17: Magazzino Sud -> Negozio Bari Centro (2024-02-19)
(15, 17, 34), -- Marmellata di Frutta
(12, 17, 35), -- Passata di Pomodoro
(8, 17, 36),  -- Couscous
(5, 17, 37),  -- Quinoa
(10, 17, 38), -- Lenticchie
(18, 17, 39), -- Ceci in Scatola
(20, 17, 40), -- Piselli
(20, 17, 51), -- Mango (secondo magazzino per rotazione)
(15, 17, 64), -- Jeans Donna
(12, 17, 80), -- Sedia da Giardino
(25, 17, 84), -- Dentifricio
(15, 17, 88), -- Crema Mani

-- DDT 18: Magazzino Sud -> Negozio Catania Centro (2024-02-20)
(12, 18, 34), -- Marmellata di Frutta
(10, 18, 35), -- Passata di Pomodoro
(7, 18, 36),  -- Couscous
(4, 18, 37),  -- Quinoa
(8, 18, 38),  -- Lenticchie
(15, 18, 39), -- Ceci in Scatola
(18, 18, 40), -- Piselli
(10, 18, 68), -- Cappello
(15, 18, 80), -- Sedia da Giardino
(20, 18, 84), -- Dentifricio
(15, 18, 96), -- Palla da Calcio
(10, 18, 100), -- Set di Pesi

-- DDT 19: Magazzino Nord-Ovest -> Negozio Milano Centro (secondo rifornimento) (2024-02-24)
(30, 19, 1),  -- Pasta Barilla
(25, 19, 2),  -- Riso Basmati
(12, 19, 3),  -- Olio Extra Vergine d'Oliva
(35, 19, 4),  -- Sugo al Pomodoro
(15, 19, 5),  -- Caffè in Grani
(10, 19, 6),  -- Cioccolato Fondente
(30, 19, 7),  -- Biscotti Integrali
(45, 19, 8),  -- Acqua Minerale
(20, 19, 9),  -- Yogurt Greco
(7, 19, 10),  -- Miele Biologico
(18, 19, 43), -- Mele
(20, 19, 44), -- Banane
(15, 19, 61), -- Maglietta Uomo
(10, 19, 81), -- Crema Viso
(3, 19, 93),  -- Laptop

-- DDT 20: Magazzino Nord-Ovest -> Negozio Milano Nord (secondo rifornimento) (2024-02-25)
(25, 20, 1),  -- Pasta Barilla
(20, 20, 2),  -- Riso Basmati
(10, 20, 3),  -- Olio Extra Vergine d'Oliva
(30, 20, 4),  -- Sugo al Pomodoro
(12, 20, 5),  -- Caffè in Grani
(8, 20, 6),   -- Cioccolato Fondente
(25, 20, 7),  -- Biscotti Integrali
(40, 20, 8),  -- Acqua Minerale
(18, 20, 9),  -- Yogurt Greco
(6, 20, 10),  -- Miele Biologico
(15, 20, 65), -- Felpa con Cappuccio
(12, 20, 85), -- Sapone Liquido
(10, 20, 97), -- Palla da Basket

-- DDT 21: Magazzino Nord-Est -> Negozio Venezia Centro (secondo rifornimento) (2024-02-26)
(20, 21, 14), -- Pomodori Pelati
(18, 21, 15), -- Tonno in Scatola
(12, 21, 16), -- Fagioli in Scatola
(8, 21, 17),  -- Pesto alla Genovese
(15, 21, 18), -- Cereali Integrali
(25, 21, 19), -- Latte UHT
(10, 21, 20), -- Burro
(5, 21, 21),  -- Formaggio Parmigiano
(15, 21, 22), -- Mozzarella
(20, 21, 23), -- Pane Integrale
(18, 21, 53), -- Spinaci
(15, 21, 62), -- Maglietta Donna
(20, 21, 82), -- Shampoo

-- DDT 22: Magazzino Nord-Est -> Negozio Bologna Centro (secondo rifornimento) (2024-02-27)
(18, 22, 14), -- Pomodori Pelati
(15, 22, 15), -- Tonno in Scatola
(10, 22, 16), -- Fagioli in Scatola
(7, 22, 17),  -- Pesto alla Genovese
(12, 22, 18), -- Cereali Integrali
(22, 22, 19), -- Latte UHT
(8, 22, 20),  -- Burro
(4, 22, 21),  -- Formaggio Parmigiano
(12, 22, 22), -- Mozzarella
(18, 22, 23), -- Pane Integrale
(15, 22, 54), -- Broccoli
(8, 22, 74),  -- Set di Pentole
(6, 22, 94),  -- Cuffie Wireless

-- DDT 23: Magazzino Centro -> Negozio Roma Centro (secondo rifornimento) (2024-02-28)
(12, 23, 24), -- Salmone Affumicato
(12, 23, 25), -- Prosciutto Crudo
(18, 23, 26), -- Salsiccia
(22, 23, 27), -- Pizza Surgelata
(15, 23, 28), -- Gelato alla Vaniglia
(20, 23, 29), -- Succhi di Frutta
(10, 23, 30), -- Vino Rosso
(12, 23, 31), -- Birra Artigianale
(25, 23, 32), -- Patatine Fritte
(20, 23, 33), -- Crackers Integrali
(20, 23, 58), -- Pomodori
(18, 23, 59), -- Cetrioli
(15, 23, 60), -- Insalata
(10, 23, 63), -- Jeans Uomo
(5, 23, 91),  -- Smartphone

-- DDT 24: Magazzino Centro -> Negozio Roma Sud (secondo rifornimento) (2024-02-29)
(10, 24, 24), -- Salmone Affumicato
(10, 24, 25), -- Prosciutto Crudo
(15, 24, 26), -- Salsiccia
(20, 24, 27), -- Pizza Surgelata
(12, 24, 28), -- Gelato alla Vaniglia
(18, 24, 29), -- Succhi di Frutta
(8, 24, 30),  -- Vino Rosso
(10, 24, 31), -- Birra Artigianale
(22, 24, 32), -- Patatine Fritte
(18, 24, 33), -- Crackers Integrali
(15, 24, 55), -- Cavolfiore
(12, 24, 67), -- Scarpe da Ginnastica
(12, 24, 83), -- Balsamo
(7, 24, 95),  -- Smartwatch

-- DDT 25: Magazzino Sud -> Negozio Napoli Centro (secondo rifornimento) (2024-03-01)
(18, 25, 34), -- Marmellata di Frutta
(15, 25, 35), -- Passata di Pomodoro
(10, 25, 36), -- Couscous
(6, 25, 37),  -- Quinoa
(12, 25, 38), -- Lenticchie
(20, 25, 39), -- Ceci in Scatola
(25, 25, 40), -- Piselli
(20, 25, 41), -- Carote
(10, 25, 64), -- Jeans Donna
(6, 25, 92),  -- Tablet
(12, 25, 96), -- Palla da Calcio

-- DDT 26: Magazzino Sud -> Negozio Palermo Centro (secondo rifornimento) (2024-03-02)
(15, 26, 34), -- Marmellata di Frutta
(12, 26, 35), -- Passata di Pomodoro
(8, 26, 36),  -- Couscous
(5, 26, 37),  -- Quinoa
(10, 26, 38), -- Lenticchie
(18, 26, 39), -- Ceci in Scatola
(22, 26, 40), -- Piselli
(18, 26, 45), -- Arance
(15, 26, 68), -- Cappello
(15, 26, 88), -- Crema Mani
(10, 26, 100), -- Set di Pesi

-- DDT 27: Magazzino Nord-Ovest -> Negozio Venezia Centro (caso speciale) (2024-02-21)
(20, 27, 1),  -- Pasta Barilla
(15, 27, 4),  -- Sugo al Pomodoro
(25, 27, 8),  -- Acqua Minerale
(15, 27, 11), -- Farina 00
(20, 27, 12), -- Zucchero
(15, 27, 13), -- Sale
(10, 27, 61), -- Maglietta Uomo

-- DDT 28: Magazzino Nord-Est -> Negozio Roma Centro (caso speciale) (2024-02-22)
(15, 28, 14), -- Pomodori Pelati
(10, 28, 19), -- Latte UHT
(12, 28, 22), -- Mozzarella
(15, 28, 23), -- Pane Integrale
(12, 28, 48), -- Pesche
(15, 28, 49), -- Kiwi
(12, 28, 50), -- Ananas
(10, 28, 62), -- Maglietta Donna
(5, 28, 66),  -- Giacca a Vento

-- DDT 29: Magazzino Centro -> Negozio Napoli Centro (caso speciale) (2024-02-23)
(18, 29, 24), -- Salmone Affumicato
(15, 29, 27), -- Pizza Surgelata
(20, 29, 32), -- Patatine Fritte
(15, 29, 33), -- Crackers Integrali
(18, 29, 55), -- Cavolfiore
(20, 29, 58), -- Pomodori
(15, 29, 60), -- Insalata
(8, 29, 63),  -- Jeans Uomo
(10, 29, 67), -- Scarpe da Ginnastica

-- DDT 30: Magazzino Sud -> Negozio Torino Centro (caso speciale) (2024-03-03)
(15, 30, 34), -- Marmellata di Frutta
(12, 30, 35), -- Passata di Pomodoro
(20, 30, 39), -- Ceci in Scatola
(22, 30, 40), -- Piselli
(15, 30, 41), -- Carote
(12, 30, 43), -- Mele
(10, 30, 64), -- Jeans Donna
(8, 30, 68),  -- Cappello
(15, 30, 84), -- Dentifricio
(10, 30, 96); -- Palla da Calcio









-- Popolamento della tabella restock_soglie_negozio
INSERT INTO restock_soglie_negozio (quantita_soglia, negozioID, prodottoID) VALUES
-- Negozio 1: Milano Centro (negozio grande in città importante)
-- Alimentari di base (alta rotazione)
(20, 1, 1),  -- Pasta Barilla
(15, 1, 2),  -- Riso Basmati
(8, 1, 3),   -- Olio Extra Vergine d'Oliva
(20, 1, 4),  -- Sugo al Pomodoro
(10, 1, 5),  -- Caffè in Grani
(8, 1, 6),   -- Cioccolato Fondente
(15, 1, 7),  -- Biscotti Integrali
(25, 1, 8),  -- Acqua Minerale
(12, 1, 9),  -- Yogurt Greco
(6, 1, 10),  -- Miele Biologico
(15, 1, 11), -- Farina 00
(20, 1, 12), -- Zucchero
(15, 1, 13), -- Sale
-- Frutta e verdura
(12, 1, 43), -- Mele
(15, 1, 44), -- Banane
-- Abbigliamento
(10, 1, 61), -- Maglietta Uomo
-- Cosmetica
(12, 1, 81), -- Crema Viso
-- Elettronica
(3, 1, 93),  -- Laptop

-- Negozio 2: Milano Nord
-- Alimentari di base
(18, 2, 1),  -- Pasta Barilla
(12, 2, 2),  -- Riso Basmati
(6, 2, 3),   -- Olio Extra Vergine d'Oliva
(18, 2, 4),  -- Sugo al Pomodoro
(8, 2, 5),   -- Caffè in Grani
(6, 2, 6),   -- Cioccolato Fondente
(12, 2, 7),  -- Biscotti Integrali
(20, 2, 8),  -- Acqua Minerale
(10, 2, 9),  -- Yogurt Greco
(4, 2, 10),  -- Miele Biologico
-- Abbigliamento
(10, 2, 65), -- Felpa con Cappuccio
-- Cosmetica
(10, 2, 85), -- Sapone Liquido
-- Sport
(8, 2, 97),  -- Palla da Basket

-- Negozio 3: Torino Centro
-- Alimentari di base
(15, 3, 1),  -- Pasta Barilla
(12, 3, 2),  -- Riso Basmati
(7, 3, 3),   -- Olio Extra Vergine d'Oliva
(18, 3, 4),  -- Sugo al Pomodoro
(10, 3, 11), -- Farina 00
(15, 3, 12), -- Zucchero
(12, 3, 13), -- Sale
-- Frutta e verdura
(12, 3, 41), -- Carote
(10, 3, 42), -- Zucchine
(15, 3, 43), -- Mele
-- Abbigliamento
(12, 3, 69), -- Sciarpa

-- Negozio 4: Genova Centro
-- Alimentari
(12, 4, 1),  -- Pasta Barilla
(10, 4, 2),  -- Riso Basmati
(5, 4, 3),   -- Olio Extra Vergine d'Oliva
(15, 4, 4),  -- Sugo al Pomodoro
(8, 4, 11),  -- Farina 00
(12, 4, 12), -- Zucchero
(10, 4, 13), -- Sale
-- Frutta e verdura
(10, 4, 45), -- Arance
(8, 4, 46),  -- Uva
(6, 4, 47),  -- Fragole
-- Casa e Giardino
(8, 4, 77),  -- Tenda per Esterno
-- Cosmetica
(10, 4, 89), -- Maschera Viso

-- Negozio 5: Asti Centro (città più piccola)
-- Alimentari (quantità minori)
(10, 5, 1),  -- Pasta Barilla
(8, 5, 2),   -- Riso Basmati
(4, 5, 3),   -- Olio Extra Vergine d'Oliva
(12, 5, 4),  -- Sugo al Pomodoro
(6, 5, 5),   -- Caffè in Grani
(4, 5, 6),   -- Cioccolato Fondente
(10, 5, 7),  -- Biscotti Integrali
(15, 5, 8),  -- Acqua Minerale
(8, 5, 9),   -- Yogurt Greco
(3, 5, 10),  -- Miele Biologico
-- Abbigliamento
(5, 5, 61),  -- Maglietta Uomo
(6, 5, 65),  -- Felpa con Cappuccio

-- Negozio 6: Venezia Centro
-- Alimentari
(15, 6, 14), -- Pomodori Pelati
(12, 6, 15), -- Tonno in Scatola
(10, 6, 16), -- Fagioli in Scatola
(6, 6, 17),  -- Pesto alla Genovese
(10, 6, 18), -- Cereali Integrali
(18, 6, 19), -- Latte UHT
(6, 6, 20),  -- Burro
(3, 6, 21),  -- Formaggio Parmigiano
(10, 6, 22), -- Mozzarella
(12, 6, 23), -- Pane Integrale
-- Abbigliamento
(10, 6, 62), -- Maglietta Donna
-- Casa e Giardino
(5, 6, 72),  -- Lampada da Tavolo
-- Cosmetica
(15, 6, 82), -- Shampoo

-- Negozio 7: Bologna Centro
-- Alimentari
(12, 7, 14), -- Pomodori Pelati
(10, 7, 15), -- Tonno in Scatola
(8, 7, 16),  -- Fagioli in Scatola
(4, 7, 17),  -- Pesto alla Genovese
(8, 7, 18),  -- Cereali Integrali
(15, 7, 19), -- Latte UHT
(5, 7, 20),  -- Burro
(3, 7, 21),  -- Formaggio Parmigiano
(8, 7, 22),  -- Mozzarella
(10, 7, 23), -- Pane Integrale
-- Frutta e verdura
(8, 7, 48),  -- Pesche
(10, 7, 49), -- Kiwi
-- Elettronica
(4, 7, 94),  -- Cuffie Wireless

-- Negozio 8: Padova Centro
-- Alimentari
(10, 8, 14), -- Pomodori Pelati
(8, 8, 15),  -- Tonno in Scatola
(6, 8, 16),  -- Fagioli in Scatola
(4, 8, 17),  -- Pesto alla Genovese
(8, 8, 18),  -- Cereali Integrali
(12, 8, 19), -- Latte UHT
(4, 8, 20),  -- Burro
(2, 8, 21),  -- Formaggio Parmigiano
(8, 8, 22),  -- Mozzarella
(10, 8, 23), -- Pane Integrale
-- Frutta e verdura
(10, 8, 50), -- Ananas
(6, 8, 51),  -- Mango
(8, 8, 52),  -- Avocado
-- Abbigliamento
(6, 8, 66),  -- Giacca a Vento
-- Cosmetica
(12, 8, 86), -- Deodorante

-- Negozio 9: Verona Centro
-- Alimentari
(10, 9, 14), -- Pomodori Pelati
(8, 9, 15),  -- Tonno in Scatola
(5, 9, 16),  -- Fagioli in Scatola
(3, 9, 17),  -- Pesto alla Genovese
(6, 9, 18),  -- Cereali Integrali
(12, 9, 19), -- Latte UHT
(4, 9, 20),  -- Burro
(2, 9, 21),  -- Formaggio Parmigiano
(6, 9, 22),  -- Mozzarella
(8, 9, 23),  -- Pane Integrale
-- Frutta e verdura
(12, 9, 53), -- Spinaci
(10, 9, 54), -- Broccoli
-- Abbigliamento
(4, 9, 70),  -- Cintura
-- Casa e Giardino
(4, 9, 74),  -- Set di Pentole
-- Cosmetica
(10, 9, 90), -- Olio per Capelli
-- Sport
(10, 9, 98), -- Palla da Tennis

-- Negozio 10: Roma Centro (negozio grande in città importante)
-- Alimentari
(10, 10, 24), -- Salmone Affumicato
(10, 10, 25), -- Prosciutto Crudo
(12, 10, 26), -- Salsiccia
(15, 10, 27), -- Pizza Surgelata
(12, 10, 28), -- Gelato alla Vaniglia
(15, 10, 29), -- Succhi di Frutta
(8, 10, 30),  -- Vino Rosso
(10, 10, 31), -- Birra Artigianale
(18, 10, 32), -- Patatine Fritte
(15, 10, 33), -- Crackers Integrali
-- Abbigliamento
(8, 10, 63),  -- Jeans Uomo
-- Casa e Giardino
(6, 10, 79),  -- Set di Utensili da Giardino
-- Elettronica
(4, 10, 91),  -- Smartphone

-- Negozio 11: Roma Sud
-- Alimentari
(8, 11, 24),  -- Salmone Affumicato
(8, 11, 25),  -- Prosciutto Crudo
(10, 11, 26), -- Salsiccia
(12, 11, 27), -- Pizza Surgelata
(10, 11, 28), -- Gelato alla Vaniglia
(12, 11, 29), -- Succhi di Frutta
(6, 11, 30),  -- Vino Rosso
(8, 11, 31),  -- Birra Artigianale
(15, 11, 32), -- Patatine Fritte
(12, 11, 33), -- Crackers Integrali
-- Frutta e verdura
(8, 11, 55),  -- Cavolfiore
(10, 11, 56), -- Funghi
(12, 11, 57), -- Peperoni
(15, 11, 58), -- Pomodori
(12, 11, 59), -- Cetrioli
(10, 11, 60), -- Insalata
-- Abbigliamento
(8, 11, 67),  -- Scarpe da Ginnastica
-- Elettronica
(5, 11, 95),  -- Smartwatch

-- Negozio 12: Firenze Centro
-- Alimentari
(6, 12, 24),  -- Salmone Affumicato
(6, 12, 25),  -- Prosciutto Crudo
(8, 12, 26),  -- Salsiccia
(12, 12, 27), -- Pizza Surgelata
(8, 12, 28),  -- Gelato alla Vaniglia
(12, 12, 29), -- Succhi di Frutta
(5, 12, 30),  -- Vino Rosso
(6, 12, 31),  -- Birra Artigianale
(12, 12, 32), -- Patatine Fritte
(10, 12, 33), -- Crackers Integrali
-- Casa e Giardino
(6, 12, 71),  -- Vaso per Piante
(8, 12, 75),  -- Tovaglia
-- Cosmetica
(10, 12, 83), -- Balsamo
(5, 12, 87),  -- Profumo
-- Sport
(6, 12, 99),  -- Racchetta da Tennis

-- Negozio 13: Perugia Centro
-- Alimentari
(5, 13, 24),  -- Salmone Affumicato
(5, 13, 25),  -- Prosciutto Crudo
(7, 13, 26),  -- Salsiccia
(10, 13, 27), -- Pizza Surgelata
(7, 13, 28),  -- Gelato alla Vaniglia
(10, 13, 29), -- Succhi di Frutta
(4, 13, 30),  -- Vino Rosso
(5, 13, 31),  -- Birra Artigianale
(10, 13, 32), -- Patatine Fritte
(8, 13, 33),  -- Crackers Integrali
-- Frutta e verdura
(6, 13, 55),  -- Cavolfiore
(8, 13, 56),  -- Funghi
(10, 13, 57), -- Peperoni
(12, 13, 58), -- Pomodori
(10, 13, 59), -- Cetrioli
(8, 13, 60),  -- Insalata

-- Negozio 14: Pesaro Centro
-- Alimentari
(4, 14, 24),  -- Salmone Affumicato
(4, 14, 25),  -- Prosciutto Crudo
(6, 14, 26),  -- Salsiccia
(8, 14, 27),  -- Pizza Surgelata
(6, 14, 28),  -- Gelato alla Vaniglia
(8, 14, 29),  -- Succhi di Frutta
(3, 14, 30),  -- Vino Rosso
(4, 14, 31),  -- Birra Artigianale
(10, 14, 32), -- Patatine Fritte
(7, 14, 33),  -- Crackers Integrali
-- Abbigliamento
(5, 14, 63),  -- Jeans Uomo
(6, 14, 67),  -- Scarpe da Ginnastica
-- Casa e Giardino
(4, 14, 71),  -- Vaso per Piante
-- Cosmetica
(6, 14, 83),  -- Balsamo

-- Negozio 15: Napoli Centro
-- Alimentari
(12, 15, 34), -- Marmellata di Frutta
(10, 15, 35), -- Passata di Pomodoro
(7, 15, 36),  -- Couscous
(5, 15, 37),  -- Quinoa
(8, 15, 38),  -- Lenticchie
(15, 15, 39), -- Ceci in Scatola
(18, 15, 40), -- Piselli
-- Frutta e verdura
(15, 15, 41), -- Carote
(12, 15, 43), -- Mele
-- Abbigliamento
(8, 15, 64),  -- Jeans Donna
-- Cosmetica
(10, 15, 84), -- Dentifricio
-- Elettronica
(5, 15, 92),  -- Tablet
-- Sport
(8, 15, 96),  -- Palla da Calcio

-- Negozio 16: Palermo Centro
-- Alimentari
(10, 16, 34), -- Marmellata di Frutta
(8, 16, 35),  -- Passata di Pomodoro
(6, 16, 36),  -- Couscous
(3, 16, 37),  -- Quinoa
(7, 16, 38),  -- Lenticchie
(12, 16, 39), -- Ceci in Scatola
(15, 16, 40), -- Piselli
-- Frutta e verdura
(10, 16, 45), -- Arance
(6, 16, 47),  -- Fragole
(12, 16, 49), -- Kiwi
-- Abbigliamento
(6, 16, 68),  -- Cappello
-- Casa e Giardino
(8, 16, 76),  -- Cuscini Decorativi
-- Cosmetica
(10, 16, 88), -- Crema Mani
-- Sport
(8, 16, 100), -- Set di Pesi

-- Negozio 17: Bari Centro
-- Alimentari
(8, 17, 34),  -- Marmellata di Frutta
(7, 17, 35),  -- Passata di Pomodoro
(5, 17, 36),  -- Couscous
(2, 17, 37),  -- Quinoa
(6, 17, 38),  -- Lenticchie
(10, 17, 39), -- Ceci in Scatola
(12, 17, 40), -- Piselli
-- Frutta e verdura
(12, 17, 51), -- Mango
-- Abbigliamento
(8, 17, 64),  -- Jeans Donna
-- Casa e Giardino
(7, 17, 80),  -- Sedia da Giardino
-- Cosmetica
(15, 17, 84), -- Dentifricio
(8, 17, 88),  -- Crema Mani

-- Negozio 18: Catania Centro
-- Alimentari
(7, 18, 34),  -- Marmellata di Frutta
(6, 18, 35),  -- Passata di Pomodoro
(4, 18, 36),  -- Couscous
(2, 18, 37),  -- Quinoa
(5, 18, 38),  -- Lenticchie
(8, 18, 39),  -- Ceci in Scatola
(10, 18, 40), -- Piselli
-- Abbigliamento
(6, 18, 68),  -- Cappello
-- Casa e Giardino
(8, 18, 80),  -- Sedia da Giardino
-- Cosmetica
(12, 18, 84), -- Dentifricio
-- Sport
(8, 18, 96),  -- Palla da Calcio
(6, 18, 100); -- Set di Pesi














-- Popolamento della tabella scontrino
INSERT INTO scontrino (data_vendita, negozioID) VALUES
-- Negozio 1: Milano Centro (negozio con alto volume di vendite)
('2024-02-05', 1), -- Scontrino 1
('2024-02-05', 1), -- Scontrino 2
('2024-02-05', 1), -- Scontrino 3
('2024-02-06', 1), -- Scontrino 4
('2024-02-06', 1), -- Scontrino 5
('2024-02-07', 1), -- Scontrino 6
('2024-02-07', 1), -- Scontrino 7
('2024-02-08', 1), -- Scontrino 8
('2024-02-08', 1), -- Scontrino 9
('2024-02-09', 1), -- Scontrino 10
('2024-02-10', 1), -- Scontrino 11
('2024-02-10', 1), -- Scontrino 12
('2024-02-26', 1), -- Scontrino 13
('2024-02-26', 1), -- Scontrino 14
('2024-02-27', 1), -- Scontrino 15
('2024-02-27', 1), -- Scontrino 16
('2024-02-28', 1), -- Scontrino 17
('2024-02-29', 1), -- Scontrino 18

-- Negozio 2: Milano Nord (secondo negozio importante)
('2024-02-05', 2), -- Scontrino 19
('2024-02-06', 2), -- Scontrino 20
('2024-02-07', 2), -- Scontrino 21
('2024-02-08', 2), -- Scontrino 22
('2024-02-09', 2), -- Scontrino 23
('2024-02-10', 2), -- Scontrino 24
('2024-02-26', 2), -- Scontrino 25
('2024-02-27', 2), -- Scontrino 26
('2024-02-28', 2), -- Scontrino 27
('2024-02-29', 2), -- Scontrino 28

-- Negozio 3: Torino Centro
('2024-02-06', 3), -- Scontrino 29
('2024-02-07', 3), -- Scontrino 30
('2024-02-08', 3), -- Scontrino 31
('2024-02-09', 3), -- Scontrino 32
('2024-02-10', 3), -- Scontrino 33
('2024-03-04', 3), -- Scontrino 34 (dopo il riassortimento speciale)

-- Negozio 4: Genova Centro
('2024-02-07', 4), -- Scontrino 35
('2024-02-08', 4), -- Scontrino 36
('2024-02-09', 4), -- Scontrino 37
('2024-02-10', 4), -- Scontrino 38

-- Negozio 5: Asti Centro (città più piccola, meno vendite)
('2024-02-08', 5), -- Scontrino 39
('2024-02-09', 5), -- Scontrino 40
('2024-02-10', 5), -- Scontrino 41

-- Negozio 6: Venezia Centro
('2024-02-09', 6), -- Scontrino 42
('2024-02-10', 6), -- Scontrino 43
('2024-02-11', 6), -- Scontrino 44
('2024-02-12', 6), -- Scontrino 45
('2024-02-22', 6), -- Scontrino 46 (dopo il riassortimento speciale)
('2024-02-27', 6), -- Scontrino 47 (dopo il secondo riassortimento)
('2024-02-28', 6), -- Scontrino 48

-- Negozio 7: Bologna Centro
('2024-02-10', 7), -- Scontrino 49
('2024-02-11', 7), -- Scontrino 50
('2024-02-12', 7), -- Scontrino 51
('2024-02-13', 7), -- Scontrino 52
('2024-02-28', 7), -- Scontrino 53 (dopo il secondo riassortimento)
('2024-03-01', 7), -- Scontrino 54

-- Negozio 8: Padova Centro
('2024-02-11', 8), -- Scontrino 55
('2024-02-12', 8), -- Scontrino 56
('2024-02-13', 8), -- Scontrino 57

-- Negozio 9: Verona Centro
('2024-02-12', 9), -- Scontrino 58
('2024-02-13', 9), -- Scontrino 59
('2024-02-14', 9), -- Scontrino 60

-- Negozio 10: Roma Centro (negozio con alto volume di vendite)
('2024-02-13', 10), -- Scontrino 61
('2024-02-13', 10), -- Scontrino 62
('2024-02-14', 10), -- Scontrino 63
('2024-02-14', 10), -- Scontrino 64
('2024-02-15', 10), -- Scontrino 65
('2024-02-15', 10), -- Scontrino 66
('2024-02-16', 10), -- Scontrino 67
('2024-02-23', 10), -- Scontrino 68 (dopo il riassortimento speciale)
('2024-02-29', 10), -- Scontrino 69 (dopo il secondo riassortimento)
('2024-03-01', 10), -- Scontrino 70

-- Negozio 11: Roma Sud
('2024-02-14', 11), -- Scontrino 71
('2024-02-15', 11), -- Scontrino 72
('2024-02-16', 11), -- Scontrino 73
('2024-02-17', 11), -- Scontrino 74
('2024-03-01', 11), -- Scontrino 75 (dopo il secondo riassortimento)
('2024-03-02', 11), -- Scontrino 76

-- Negozio 12: Firenze Centro
('2024-02-15', 12), -- Scontrino 77
('2024-02-16', 12), -- Scontrino 78
('2024-02-17', 12), -- Scontrino 79
('2024-02-18', 12), -- Scontrino 80

-- Negozio 13: Perugia Centro
('2024-02-16', 13), -- Scontrino 81
('2024-02-17', 13), -- Scontrino 82
('2024-02-18', 13), -- Scontrino 83

-- Negozio 14: Pesaro Centro (città più piccola, meno vendite)
('2024-02-17', 14), -- Scontrino 84
('2024-02-18', 14), -- Scontrino 85

-- Negozio 15: Napoli Centro
('2024-02-18', 15), -- Scontrino 86
('2024-02-19', 15), -- Scontrino 87
('2024-02-20', 15), -- Scontrino 88
('2024-02-21', 15), -- Scontrino 89
('2024-02-24', 15), -- Scontrino 90 (dopo il riassortimento speciale)
('2024-03-02', 15), -- Scontrino 91 (dopo il secondo riassortimento)
('2024-03-03', 15), -- Scontrino 92

-- Negozio 16: Palermo Centro
('2024-02-19', 16), -- Scontrino 93
('2024-02-20', 16), -- Scontrino 94
('2024-02-21', 16), -- Scontrino 95
('2024-03-03', 16), -- Scontrino 96 (dopo il secondo riassortimento)
('2024-03-04', 16), -- Scontrino 97

-- Negozio 17: Bari Centro
('2024-02-20', 17), -- Scontrino 98
('2024-02-21', 17), -- Scontrino 99
('2024-02-22', 17), -- Scontrino 100

-- Negozio 18: Catania Centro
('2024-02-21', 18), -- Scontrino 101
('2024-02-22', 18), -- Scontrino 102
('2024-02-23', 18); -- Scontrino 103







-- Popolamento della tabella carrello
INSERT INTO carrello (quantita_venduta, scontrinoID, prodottoID) VALUES
-- Scontrino 1: Milano Centro (2024-02-05)
(3, 1, 1),   -- Pasta Barilla
(2, 1, 2),   -- Riso Basmati
(1, 1, 3),   -- Olio Extra Vergine d'Oliva
(2, 1, 4),   -- Sugo al Pomodoro
(1, 1, 8),   -- Acqua Minerale
(1, 1, 61),  -- Maglietta Uomo

-- Scontrino 2: Milano Centro (2024-02-05)
(2, 2, 1),   -- Pasta Barilla
(1, 2, 5),   -- Caffè in Grani
(1, 2, 7),   -- Biscotti Integrali
(4, 2, 8),   -- Acqua Minerale
(2, 2, 9),   -- Yogurt Greco
(1, 2, 43),  -- Mele
(1, 2, 44),  -- Banane

-- Scontrino 3: Milano Centro (2024-02-05)
(1, 3, 3),   -- Olio Extra Vergine d'Oliva
(2, 3, 4),   -- Sugo al Pomodoro
(1, 3, 6),   -- Cioccolato Fondente
(3, 3, 9),   -- Yogurt Greco
(1, 3, 81),  -- Crema Viso

-- Scontrino 4: Milano Centro (2024-02-06)
(3, 4, 1),   -- Pasta Barilla
(2, 4, 7),   -- Biscotti Integrali
(2, 4, 8),   -- Acqua Minerale
(1, 4, 10),  -- Miele Biologico
(1, 4, 93),  -- Laptop

-- Scontrino 5: Milano Centro (2024-02-06)
(1, 5, 2),   -- Riso Basmati
(1, 5, 4),   -- Sugo al Pomodoro
(1, 5, 5),   -- Caffè in Grani
(2, 5, 43),  -- Mele
(3, 5, 44),  -- Banane

-- Scontrino 6: Milano Centro (2024-02-07)
(2, 6, 1),   -- Pasta Barilla
(1, 6, 3),   -- Olio Extra Vergine d'Oliva
(2, 6, 9),   -- Yogurt Greco
(1, 6, 43),  -- Mele
(1, 6, 61),  -- Maglietta Uomo

-- Scontrino 7: Milano Centro (2024-02-07)
(1, 7, 4),   -- Sugo al Pomodoro
(1, 7, 5),   -- Caffè in Grani
(1, 7, 6),   -- Cioccolato Fondente
(3, 7, 8),   -- Acqua Minerale
(1, 7, 10),  -- Miele Biologico
(1, 7, 81),  -- Crema Viso

-- Scontrino 8: Milano Centro (2024-02-08)
(3, 8, 1),   -- Pasta Barilla
(2, 8, 2),   -- Riso Basmati
(2, 8, 7),   -- Biscotti Integrali
(2, 8, 9),   -- Yogurt Greco
(2, 8, 44),  -- Banane

-- Scontrino 9: Milano Centro (2024-02-08)
(1, 9, 3),   -- Olio Extra Vergine d'Oliva
(2, 9, 4),   -- Sugo al Pomodoro
(1, 9, 5),   -- Caffè in Grani
(2, 9, 8),   -- Acqua Minerale
(1, 9, 43),  -- Mele

-- Scontrino 10: Milano Centro (2024-02-09)
(2, 10, 1),  -- Pasta Barilla
(1, 10, 6),  -- Cioccolato Fondente
(1, 10, 7),  -- Biscotti Integrali
(3, 10, 8),  -- Acqua Minerale
(1, 10, 61), -- Maglietta Uomo

-- Scontrini 11-103 seguono lo stesso pattern con distribuzioni diverse...
-- Scontrino 11: Milano Centro (2024-02-10)
(1, 11, 2),  -- Riso Basmati
(1, 11, 3),  -- Olio Extra Vergine d'Oliva
(2, 11, 4),  -- Sugo al Pomodoro
(1, 11, 9),  -- Yogurt Greco
(2, 11, 43), -- Mele
(2, 11, 44), -- Banane

-- Scontrino 12: Milano Centro (2024-02-10)
(3, 12, 1),  -- Pasta Barilla
(1, 12, 5),  -- Caffè in Grani
(2, 12, 7),  -- Biscotti Integrali
(3, 12, 8),  -- Acqua Minerale
(1, 12, 81), -- Crema Viso

-- Scontrino 13: Milano Centro (2024-02-26) - Dopo secondo rifornimento
(2, 13, 1),  -- Pasta Barilla
(1, 13, 2),  -- Riso Basmati
(1, 13, 3),  -- Olio Extra Vergine d'Oliva
(2, 13, 4),  -- Sugo al Pomodoro
(1, 13, 44), -- Banane
(1, 13, 61), -- Maglietta Uomo

-- Scontrino 14: Milano Centro (2024-02-26)
(1, 14, 5),  -- Caffè in Grani
(1, 14, 6),  -- Cioccolato Fondente
(2, 14, 7),  -- Biscotti Integrali
(3, 14, 8),  -- Acqua Minerale
(2, 14, 9),  -- Yogurt Greco
(1, 14, 43), -- Mele

-- Scontrino 15: Milano Centro (2024-02-27)
(3, 15, 1),  -- Pasta Barilla
(1, 15, 3),  -- Olio Extra Vergine d'Oliva
(2, 15, 4),  -- Sugo al Pomodoro
(2, 15, 9),  -- Yogurt Greco
(1, 15, 81), -- Crema Viso

-- Scontrino 16: Milano Centro (2024-02-27)
(2, 16, 2),  -- Riso Basmati
(1, 16, 5),  -- Caffè in Grani
(1, 16, 7),  -- Biscotti Integrali
(4, 16, 8),  -- Acqua Minerale
(2, 16, 43), -- Mele
(2, 16, 44), -- Banane

-- Scontrino 17: Milano Centro (2024-02-28)
(2, 17, 1),  -- Pasta Barilla
(1, 17, 4),  -- Sugo al Pomodoro
(1, 17, 6),  -- Cioccolato Fondente
(2, 17, 7),  -- Biscotti Integrali
(1, 17, 10), -- Miele Biologico
(1, 17, 61), -- Maglietta Uomo

-- Scontrino 18: Milano Centro (2024-02-29)
(1, 18, 3),  -- Olio Extra Vergine d'Oliva
(1, 18, 5),  -- Caffè in Grani
(3, 18, 8),  -- Acqua Minerale
(2, 18, 9),  -- Yogurt Greco
(1, 18, 43), -- Mele
(2, 18, 44), -- Banane
(1, 18, 93), -- Laptop

-- Scontrino 19: Milano Nord (2024-02-05)
(2, 19, 1),  -- Pasta Barilla
(1, 19, 2),  -- Riso Basmati
(1, 19, 3),  -- Olio Extra Vergine d'Oliva
(2, 19, 4),  -- Sugo al Pomodoro
(1, 19, 8),  -- Acqua Minerale
(1, 19, 65), -- Felpa con Cappuccio

-- Scontrino 20: Milano Nord (2024-02-06)
(3, 20, 1),  -- Pasta Barilla
(1, 20, 5),  -- Caffè in Grani
(2, 20, 7),  -- Biscotti Integrali
(3, 20, 8),  -- Acqua Minerale
(2, 20, 9),  -- Yogurt Greco
(1, 20, 85), -- Sapone Liquido

-- Scontrino 21: Milano Nord (2024-02-07)
(1, 21, 3),  -- Olio Extra Vergine d'Oliva
(2, 21, 4),  -- Sugo al Pomodoro
(1, 21, 6),  -- Cioccolato Fondente
(1, 21, 10), -- Miele Biologico
(1, 21, 97), -- Palla da Basket

-- Scontrino 22: Milano Nord (2024-02-08)
(2, 22, 1),  -- Pasta Barilla
(1, 22, 2),  -- Riso Basmati
(1, 22, 5),  -- Caffè in Grani
(2, 22, 7),  -- Biscotti Integrali
(2, 22, 9),  -- Yogurt Greco
(1, 22, 65), -- Felpa con Cappuccio

-- Scontrino 23: Milano Nord (2024-02-09)
(1, 23, 3),  -- Olio Extra Vergine d'Oliva
(2, 23, 4),  -- Sugo al Pomodoro
(3, 23, 8),  -- Acqua Minerale
(1, 23, 85), -- Sapone Liquido

-- Scontrino 24: Milano Nord (2024-02-10)
(3, 24, 1),  -- Pasta Barilla
(1, 24, 6),  -- Cioccolato Fondente
(2, 24, 7),  -- Biscotti Integrali
(2, 24, 8),  -- Acqua Minerale
(1, 24, 10), -- Miele Biologico

-- Scontrino 25: Milano Nord (2024-02-26) - Dopo secondo rifornimento
(2, 25, 1),  -- Pasta Barilla
(1, 25, 2),  -- Riso Basmati
(1, 25, 3),  -- Olio Extra Vergine d'Oliva
(2, 25, 4),  -- Sugo al Pomodoro
(1, 25, 65), -- Felpa con Cappuccio

-- Scontrino 26: Milano Nord (2024-02-27)
(2, 26, 5),  -- Caffè in Grani
(1, 26, 6),  -- Cioccolato Fondente
(2, 26, 7),  -- Biscotti Integrali
(3, 26, 8),  -- Acqua Minerale
(1, 26, 85), -- Sapone Liquido
(1, 26, 97), -- Palla da Basket

-- Scontrino 27: Milano Nord (2024-02-28)
(3, 27, 1),  -- Pasta Barilla
(1, 27, 3),  -- Olio Extra Vergine d'Oliva
(2, 27, 4),  -- Sugo al Pomodoro
(2, 27, 9),  -- Yogurt Greco

-- Scontrino 28: Milano Nord (2024-02-29)
(2, 28, 2),  -- Riso Basmati
(1, 28, 5),  -- Caffè in Grani
(1, 28, 7),  -- Biscotti Integrali
(3, 28, 8),  -- Acqua Minerale
(1, 28, 10), -- Miele Biologico

-- Scontrino 29: Torino Centro (2024-02-06)
(2, 29, 1),  -- Pasta Barilla
(1, 29, 2),  -- Riso Basmati
(1, 29, 3),  -- Olio Extra Vergine d'Oliva
(2, 29, 4),  -- Sugo al Pomodoro
(1, 29, 11), -- Farina 00
(1, 29, 43), -- Mele

-- Scontrino 30: Torino Centro (2024-02-07)
(1, 30, 12), -- Zucchero
(1, 30, 13), -- Sale
(2, 30, 41), -- Carote
(2, 30, 42), -- Zucchine
(1, 30, 69), -- Sciarpa

-- Continuazione del popolamento della tabella carrello (scontrini 31-60)

-- Scontrino 31: Torino Centro (2024-02-08)
(3, 31, 1),   -- Pasta Barilla
(2, 31, 2),   -- Riso Basmati
(1, 31, 3),   -- Olio Extra Vergine d'Oliva
(2, 31, 4),   -- Sugo al Pomodoro
(1, 31, 43),  -- Mele
(1, 31, 97),  -- Palla da Basket

-- Scontrino 32: Torino Centro (2024-02-09)
(1, 32, 11),  -- Farina 00
(1, 32, 12),  -- Zucchero
(1, 32, 13),  -- Sale
(2, 32, 41),  -- Carote
(2, 32, 42),  -- Zucchine
(1, 32, 69),  -- Sciarpa

-- Scontrino 33: Torino Centro (2024-02-10)
(2, 33, 1),   -- Pasta Barilla
(1, 33, 3),   -- Olio Extra Vergine d'Oliva
(2, 33, 4),   -- Sugo al Pomodoro
(1, 33, 11),  -- Farina 00
(2, 33, 43),  -- Mele

-- Scontrino 34: Torino Centro (2024-03-04) - Dopo il riassortimento speciale
(1, 34, 34),  -- Marmellata di Frutta (dal rifornimento speciale)
(1, 34, 35),  -- Passata di Pomodoro (dal rifornimento speciale)
(2, 34, 39),  -- Ceci in Scatola (dal rifornimento speciale)
(1, 34, 41),  -- Carote (dal rifornimento speciale)
(1, 34, 43),  -- Mele (dal rifornimento speciale)
(1, 34, 96),  -- Palla da Calcio (dal rifornimento speciale)

-- Scontrino 35: Genova Centro (2024-02-07)
(2, 35, 1),   -- Pasta Barilla
(1, 35, 2),   -- Riso Basmati
(1, 35, 3),   -- Olio Extra Vergine d'Oliva
(2, 35, 4),   -- Sugo al Pomodoro
(1, 35, 45),  -- Arance

-- Scontrino 36: Genova Centro (2024-02-08)
(1, 36, 11),  -- Farina 00
(1, 36, 12),  -- Zucchero
(1, 36, 13),  -- Sale
(2, 36, 46),  -- Uva
(1, 36, 77),  -- Tenda per Esterno

-- Scontrino 37: Genova Centro (2024-02-09)
(2, 37, 1),   -- Pasta Barilla
(1, 37, 3),   -- Olio Extra Vergine d'Oliva
(1, 37, 45),  -- Arance
(1, 37, 47),  -- Fragole
(1, 37, 89),  -- Maschera Viso

-- Scontrino 38: Genova Centro (2024-02-10)
(1, 38, 2),   -- Riso Basmati
(2, 38, 4),   -- Sugo al Pomodoro
(1, 38, 11),  -- Farina 00
(1, 38, 12),  -- Zucchero
(1, 38, 45),  -- Arance

-- Scontrino 39: Asti Centro (2024-02-08)
(2, 39, 1),   -- Pasta Barilla
(1, 39, 2),   -- Riso Basmati
(1, 39, 3),   -- Olio Extra Vergine d'Oliva
(1, 39, 7),   -- Biscotti Integrali
(2, 39, 8),   -- Acqua Minerale
(1, 39, 65),  -- Felpa con Cappuccio

-- Scontrino 40: Asti Centro (2024-02-09)
(1, 40, 4),   -- Sugo al Pomodoro
(1, 40, 5),   -- Caffè in Grani
(1, 40, 6),   -- Cioccolato Fondente
(2, 40, 8),   -- Acqua Minerale
(1, 40, 9),   -- Yogurt Greco

-- Scontrino 41: Asti Centro (2024-02-10)
(1, 41, 1),   -- Pasta Barilla
(1, 41, 3),   -- Olio Extra Vergine d'Oliva
(1, 41, 5),   -- Caffè in Grani
(2, 41, 7),   -- Biscotti Integrali
(2, 41, 8),   -- Acqua Minerale
(1, 41, 61),  -- Maglietta Uomo

-- Scontrino 42: Venezia Centro (2024-02-09)
(2, 42, 14),  -- Pomodori Pelati
(1, 42, 15),  -- Tonno in Scatola
(1, 42, 16),  -- Fagioli in Scatola
(1, 42, 19),  -- Latte UHT
(1, 42, 22),  -- Mozzarella
(1, 42, 62),  -- Maglietta Donna

-- Scontrino 43: Venezia Centro (2024-02-10)
(1, 43, 17),  -- Pesto alla Genovese
(1, 43, 18),  -- Cereali Integrali
(2, 43, 19),  -- Latte UHT
(1, 43, 20),  -- Burro
(1, 43, 21),  -- Formaggio Parmigiano
(1, 43, 82),  -- Shampoo

-- Scontrino 44: Venezia Centro (2024-02-11)
(2, 44, 14),  -- Pomodori Pelati
(1, 44, 15),  -- Tonno in Scatola
(1, 44, 22),  -- Mozzarella
(2, 44, 23),  -- Pane Integrale
(1, 44, 72),  -- Lampada da Tavolo

-- Scontrino 45: Venezia Centro (2024-02-12)
(1, 45, 16),  -- Fagioli in Scatola
(1, 45, 18),  -- Cereali Integrali
(2, 45, 19),  -- Latte UHT
(1, 45, 23),  -- Pane Integrale
(1, 45, 62),  -- Maglietta Donna

-- Scontrino 46: Venezia Centro (2024-02-22) - Dopo il riassortimento speciale
(2, 46, 1),   -- Pasta Barilla (dal rifornimento speciale)
(1, 46, 4),   -- Sugo al Pomodoro (dal rifornimento speciale)
(2, 46, 8),   -- Acqua Minerale (dal rifornimento speciale)
(1, 46, 12),  -- Zucchero (dal rifornimento speciale)
(1, 46, 61),  -- Maglietta Uomo (dal rifornimento speciale)

-- Scontrino 47: Venezia Centro (2024-02-27) - Dopo il secondo riassortimento
(1, 47, 14),  -- Pomodori Pelati
(1, 47, 16),  -- Fagioli in Scatola
(2, 47, 19),  -- Latte UHT
(1, 47, 22),  -- Mozzarella
(1, 47, 53),  -- Spinaci
(1, 47, 82),  -- Shampoo

-- Scontrino 48: Venezia Centro (2024-02-28)
(2, 48, 15),  -- Tonno in Scatola
(1, 48, 17),  -- Pesto alla Genovese
(1, 48, 20),  -- Burro
(1, 48, 23),  -- Pane Integrale
(1, 48, 53),  -- Spinaci
(1, 48, 62),  -- Maglietta Donna

-- Scontrino 49: Bologna Centro (2024-02-10)
(2, 49, 14),  -- Pomodori Pelati
(1, 49, 15),  -- Tonno in Scatola
(1, 49, 16),  -- Fagioli in Scatola
(1, 49, 19),  -- Latte UHT
(1, 49, 22),  -- Mozzarella
(2, 49, 23),  -- Pane Integrale

-- Scontrino 50: Bologna Centro (2024-02-11)
(1, 50, 17),  -- Pesto alla Genovese
(1, 50, 18),  -- Cereali Integrali
(2, 50, 19),  -- Latte UHT
(1, 50, 21),  -- Formaggio Parmigiano
(2, 50, 48),  -- Pesche
(1, 50, 49),  -- Kiwi

-- Scontrino 51: Bologna Centro (2024-02-12)
(1, 51, 14),  -- Pomodori Pelati
(1, 51, 15),  -- Tonno in Scatola
(1, 51, 20),  -- Burro
(1, 51, 22),  -- Mozzarella
(2, 51, 23),  -- Pane Integrale
(1, 51, 94),  -- Cuffie Wireless

-- Scontrino 52: Bologna Centro (2024-02-13)
(1, 52, 16),  -- Fagioli in Scatola
(1, 52, 17),  -- Pesto alla Genovese
(1, 52, 18),  -- Cereali Integrali
(2, 52, 19),  -- Latte UHT
(1, 52, 48),  -- Pesche
(2, 52, 49),  -- Kiwi

-- Scontrino 53: Bologna Centro (2024-02-28) - Dopo il secondo riassortimento
(2, 53, 14),  -- Pomodori Pelati
(1, 53, 15),  -- Tonno in Scatola
(1, 53, 16),  -- Fagioli in Scatola
(2, 53, 19),  -- Latte UHT
(1, 53, 22),  -- Mozzarella
(1, 53, 54),  -- Broccoli
(1, 53, 94),  -- Cuffie Wireless

-- Scontrino 54: Bologna Centro (2024-03-01)
(1, 54, 17),  -- Pesto alla Genovese
(1, 54, 18),  -- Cereali Integrali
(1, 54, 20),  -- Burro
(2, 54, 23),  -- Pane Integrale
(1, 54, 54),  -- Broccoli
(1, 54, 74),  -- Set di Pentole

-- Scontrino 55: Padova Centro (2024-02-11)
(2, 55, 14),  -- Pomodori Pelati
(1, 55, 15),  -- Tonno in Scatola
(1, 55, 16),  -- Fagioli in Scatola
(1, 55, 19),  -- Latte UHT
(1, 55, 22),  -- Mozzarella
(1, 55, 50),  -- Ananas

-- Scontrino 56: Padova Centro (2024-02-12)
(1, 56, 17),  -- Pesto alla Genovese
(1, 56, 18),  -- Cereali Integrali
(2, 56, 19),  -- Latte UHT
(1, 56, 20),  -- Burro
(1, 56, 51),  -- Mango
(1, 56, 52),  -- Avocado
(1, 56, 66),  -- Giacca a Vento

-- Scontrino 57: Padova Centro (2024-02-13)
(1, 57, 15),  -- Tonno in Scatola
(1, 57, 16),  -- Fagioli in Scatola
(1, 57, 22),  -- Mozzarella
(2, 57, 23),  -- Pane Integrale
(1, 57, 50),  -- Ananas
(1, 57, 86),  -- Deodorante

-- Scontrino 58: Verona Centro (2024-02-12)
(2, 58, 14),  -- Pomodori Pelati
(1, 58, 15),  -- Tonno in Scatola
(1, 58, 16),  -- Fagioli in Scatola
(1, 58, 19),  -- Latte UHT
(1, 58, 22),  -- Mozzarella
(1, 58, 53),  -- Spinaci
(1, 58, 98),  -- Palla da Tennis

-- Scontrino 59: Verona Centro (2024-02-13)
(1, 59, 17),  -- Pesto alla Genovese
(1, 59, 18),  -- Cereali Integrali
(1, 59, 20),  -- Burro
(1, 59, 21),  -- Formaggio Parmigiano
(2, 59, 54),  -- Broccoli
(1, 59, 70),  -- Cintura

-- Scontrino 60: Verona Centro (2024-02-14)
(1, 60, 15),  -- Tonno in Scatola
(1, 60, 19),  -- Latte UHT
(2, 60, 23),  -- Pane Integrale
(1, 60, 74),  -- Set di Pentole
(1, 60, 90),  -- Olio per Capelli


-- Continuazione del popolamento della tabella carrello (scontrini 61-103)

-- Scontrino 61: Roma Centro (2024-02-13)
(1, 61, 24),  -- Salmone Affumicato
(1, 61, 25),  -- Prosciutto Crudo
(2, 61, 26),  -- Salsiccia
(1, 61, 27),  -- Pizza Surgelata
(2, 61, 32),  -- Patatine Fritte
(1, 61, 63),  -- Jeans Uomo

-- Scontrino 62: Roma Centro (2024-02-13)
(2, 62, 26),  -- Salsiccia
(1, 62, 28),  -- Gelato alla Vaniglia
(2, 62, 29),  -- Succhi di Frutta
(1, 62, 30),  -- Vino Rosso
(1, 62, 91),  -- Smartphone

-- Scontrino 63: Roma Centro (2024-02-14)
(1, 63, 24),  -- Salmone Affumicato
(1, 63, 25),  -- Prosciutto Crudo
(1, 63, 27),  -- Pizza Surgelata
(2, 63, 31),  -- Birra Artigianale
(3, 63, 32),  -- Patatine Fritte
(2, 63, 33),  -- Crackers Integrali

-- Scontrino 64: Roma Centro (2024-02-14)
(1, 64, 26),  -- Salsiccia
(2, 64, 27),  -- Pizza Surgelata
(1, 64, 28),  -- Gelato alla Vaniglia
(2, 64, 29),  -- Succhi di Frutta
(1, 64, 79),  -- Set di Utensili da Giardino

-- Scontrino 65: Roma Centro (2024-02-15)
(1, 65, 24),  -- Salmone Affumicato
(2, 65, 26),  -- Salsiccia
(1, 65, 30),  -- Vino Rosso
(2, 65, 32),  -- Patatine Fritte
(1, 65, 33),  -- Crackers Integrali
(1, 65, 63),  -- Jeans Uomo

-- Scontrino 66: Roma Centro (2024-02-15)
(1, 66, 25),  -- Prosciutto Crudo
(2, 66, 27),  -- Pizza Surgelata
(1, 66, 28),  -- Gelato alla Vaniglia
(2, 66, 29),  -- Succhi di Frutta
(1, 66, 31),  -- Birra Artigianale

-- Scontrino 67: Roma Centro (2024-02-16)
(1, 67, 24),  -- Salmone Affumicato
(1, 67, 26),  -- Salsiccia
(1, 67, 27),  -- Pizza Surgelata
(1, 67, 28),  -- Gelato alla Vaniglia
(2, 67, 32),  -- Patatine Fritte
(2, 67, 33),  -- Crackers Integrali
(1, 67, 79),  -- Set di Utensili da Giardino

-- Scontrino 68: Roma Centro (2024-02-23) - Dopo il riassortimento speciale
(1, 68, 14),  -- Pomodori Pelati (dal rifornimento speciale)
(1, 68, 19),  -- Latte UHT (dal rifornimento speciale)
(1, 68, 22),  -- Mozzarella (dal rifornimento speciale)
(1, 68, 23),  -- Pane Integrale (dal rifornimento speciale)
(1, 68, 48),  -- Pesche (dal rifornimento speciale)
(1, 68, 49),  -- Kiwi (dal rifornimento speciale)
(1, 68, 50),  -- Ananas (dal rifornimento speciale)

-- Scontrino 69: Roma Centro (2024-02-29) - Dopo il secondo riassortimento
(1, 69, 24),  -- Salmone Affumicato
(1, 69, 25),  -- Prosciutto Crudo
(2, 69, 26),  -- Salsiccia
(1, 69, 28),  -- Gelato alla Vaniglia
(2, 69, 32),  -- Patatine Fritte
(2, 69, 58),  -- Pomodori
(1, 69, 59),  -- Cetrioli
(1, 69, 63),  -- Jeans Uomo

-- Scontrino 70: Roma Centro (2024-03-01)
(1, 70, 27),  -- Pizza Surgelata
(1, 70, 29),  -- Succhi di Frutta
(1, 70, 30),  -- Vino Rosso
(1, 70, 31),  -- Birra Artigianale
(1, 70, 58),  -- Pomodori
(2, 70, 59),  -- Cetrioli
(1, 70, 60),  -- Insalata
(1, 70, 91),  -- Smartphone

-- Scontrino 71: Roma Sud (2024-02-14)
(1, 71, 24),  -- Salmone Affumicato
(1, 71, 25),  -- Prosciutto Crudo
(2, 71, 26),  -- Salsiccia
(1, 71, 27),  -- Pizza Surgelata
(1, 71, 55),  -- Cavolfiore
(1, 71, 56),  -- Funghi
(1, 71, 57),  -- Peperoni
(1, 71, 67),  -- Scarpe da Ginnastica

-- Scontrino 72: Roma Sud (2024-02-15)
(1, 72, 28),  -- Gelato alla Vaniglia
(2, 72, 29),  -- Succhi di Frutta
(1, 72, 30),  -- Vino Rosso
(1, 72, 31),  -- Birra Artigianale
(2, 72, 32),  -- Patatine Fritte
(1, 72, 33),  -- Crackers Integrali
(2, 72, 58),  -- Pomodori

-- Scontrino 73: Roma Sud (2024-02-16)
(1, 73, 24),  -- Salmone Affumicato
(1, 73, 26),  -- Salsiccia
(2, 73, 27),  -- Pizza Surgelata
(2, 73, 32),  -- Patatine Fritte
(1, 73, 56),  -- Funghi
(2, 73, 59),  -- Cetrioli
(1, 73, 60),  -- Insalata

-- Scontrino 74: Roma Sud (2024-02-17)
(1, 74, 25),  -- Prosciutto Crudo
(1, 74, 28),  -- Gelato alla Vaniglia
(2, 74, 29),  -- Succhi di Frutta
(1, 74, 31),  -- Birra Artigianale
(1, 74, 55),  -- Cavolfiore
(1, 74, 57),  -- Peperoni
(1, 74, 95),  -- Smartwatch

-- Scontrino 75: Roma Sud (2024-03-01) - Dopo il secondo riassortimento
(1, 75, 24),  -- Salmone Affumicato
(1, 75, 25),  -- Prosciutto Crudo
(1, 75, 26),  -- Salsiccia
(2, 75, 27),  -- Pizza Surgelata
(1, 75, 28),  -- Gelato alla Vaniglia
(1, 75, 55),  -- Cavolfiore
(1, 75, 67),  -- Scarpe da Ginnastica

-- Scontrino 76: Roma Sud (2024-03-02)
(1, 76, 29),  -- Succhi di Frutta
(1, 76, 30),  -- Vino Rosso
(1, 76, 32),  -- Patatine Fritte
(2, 76, 33),  -- Crackers Integrali
(1, 76, 83),  -- Balsamo
(1, 76, 95),  -- Smartwatch

-- Scontrino 77: Firenze Centro (2024-02-15)
(1, 77, 24),  -- Salmone Affumicato
(1, 77, 25),  -- Prosciutto Crudo
(1, 77, 26),  -- Salsiccia
(2, 77, 27),  -- Pizza Surgelata
(1, 77, 28),  -- Gelato alla Vaniglia
(1, 77, 87),  -- Profumo

-- Scontrino 78: Firenze Centro (2024-02-16)
(1, 78, 29),  -- Succhi di Frutta
(1, 78, 30),  -- Vino Rosso
(1, 78, 31),  -- Birra Artigianale
(2, 78, 32),  -- Patatine Fritte
(1, 78, 33),  -- Crackers Integrali
(1, 78, 71),  -- Vaso per Piante
(1, 78, 75),  -- Tovaglia

-- Scontrino 79: Firenze Centro (2024-02-17)
(1, 79, 24),  -- Salmone Affumicato
(1, 79, 26),  -- Salsiccia
(1, 79, 27),  -- Pizza Surgelata
(1, 79, 28),  -- Gelato alla Vaniglia
(2, 79, 29),  -- Succhi di Frutta
(1, 79, 83),  -- Balsamo
(1, 79, 99),  -- Racchetta da Tennis

-- Scontrino 80: Firenze Centro (2024-02-18)
(1, 80, 25),  -- Prosciutto Crudo
(1, 80, 30),  -- Vino Rosso
(1, 80, 31),  -- Birra Artigianale
(2, 80, 32),  -- Patatine Fritte
(2, 80, 33),  -- Crackers Integrali
(1, 80, 75),  -- Tovaglia

-- Scontrino 81: Perugia Centro (2024-02-16)
(1, 81, 24),  -- Salmone Affumicato
(1, 81, 25),  -- Prosciutto Crudo
(1, 81, 26),  -- Salsiccia
(2, 81, 27),  -- Pizza Surgelata
(1, 81, 28),  -- Gelato alla Vaniglia
(1, 81, 55),  -- Cavolfiore
(1, 81, 56),  -- Funghi

-- Scontrino 82: Perugia Centro (2024-02-17)
(1, 82, 29),  -- Succhi di Frutta
(1, 82, 30),  -- Vino Rosso
(1, 82, 31),  -- Birra Artigianale
(2, 82, 32),  -- Patatine Fritte
(1, 82, 33),  -- Crackers Integrali
(2, 82, 57),  -- Peperoni
(1, 82, 58),  -- Pomodori

-- Scontrino 83: Perugia Centro (2024-02-18)
(1, 83, 26),  -- Salsiccia
(1, 83, 27),  -- Pizza Surgelata
(1, 83, 28),  -- Gelato alla Vaniglia
(1, 83, 32),  -- Patatine Fritte
(1, 83, 59),  -- Cetrioli
(1, 83, 60),  -- Insalata

-- Scontrino 84: Pesaro Centro (2024-02-17)
(1, 84, 24),  -- Salmone Affumicato
(1, 84, 25),  -- Prosciutto Crudo
(1, 84, 26),  -- Salsiccia
(2, 84, 27),  -- Pizza Surgelata
(1, 84, 32),  -- Patatine Fritte
(1, 84, 33),  -- Crackers Integrali
(1, 84, 63),  -- Jeans Uomo
(1, 84, 83),  -- Balsamo

-- Scontrino 85: Pesaro Centro (2024-02-18)
(1, 85, 28),  -- Gelato alla Vaniglia
(1, 85, 29),  -- Succhi di Frutta
(1, 85, 30),  -- Vino Rosso
(1, 85, 31),  -- Birra Artigianale
(1, 85, 67),  -- Scarpe da Ginnastica
(1, 85, 71),  -- Vaso per Piante

-- Scontrino 86: Napoli Centro (2024-02-18)
(2, 86, 34),  -- Marmellata di Frutta
(1, 86, 35),  -- Passata di Pomodoro
(1, 86, 36),  -- Couscous
(3, 86, 39),  -- Ceci in Scatola
(2, 86, 41),  -- Carote
(1, 86, 84),  -- Dentifricio

-- Scontrino 87: Napoli Centro (2024-02-19)
(1, 87, 35),  -- Passata di Pomodoro
(1, 87, 36),  -- Couscous
(1, 87, 37),  -- Quinoa
(2, 87, 38),  -- Lenticchie
(2, 87, 40),  -- Piselli
(1, 87, 43),  -- Mele
(1, 87, 64),  -- Jeans Donna

-- Scontrino 88: Napoli Centro (2024-02-20)
(1, 88, 34),  -- Marmellata di Frutta
(1, 88, 35),  -- Passata di Pomodoro
(2, 88, 39),  -- Ceci in Scatola
(2, 88, 40),  -- Piselli
(1, 88, 41),  -- Carote
(1, 88, 92),  -- Tablet

-- Scontrino 89: Napoli Centro (2024-02-21)
(1, 89, 36),  -- Couscous
(1, 89, 37),  -- Quinoa
(1, 89, 38),  -- Lenticchie
(1, 89, 43),  -- Mele
(1, 89, 84),  -- Dentifricio
(1, 89, 96),  -- Palla da Calcio

-- Scontrino 90: Napoli Centro (2024-02-24) - Dopo il riassortimento speciale
(1, 90, 24),  -- Salmone Affumicato (dal rifornimento speciale)
(1, 90, 27),  -- Pizza Surgelata (dal rifornimento speciale)
(2, 90, 32),  -- Patatine Fritte (dal rifornimento speciale)
(1, 90, 58),  -- Pomodori (dal rifornimento speciale)
(1, 90, 67),  -- Scarpe da Ginnastica (dal rifornimento speciale)

-- Scontrino 91: Napoli Centro (2024-03-02) - Dopo il secondo riassortimento
(2, 91, 34),  -- Marmellata di Frutta
(1, 91, 35),  -- Passata di Pomodoro
(1, 91, 36),  -- Couscous
(2, 91, 39),  -- Ceci in Scatola
(2, 91, 40),  -- Piselli
(1, 91, 41),  -- Carote
(1, 91, 64),  -- Jeans Donna

-- Scontrino 92: Napoli Centro (2024-03-03)
(1, 92, 37),  -- Quinoa
(1, 92, 38),  -- Lenticchie
(1, 92, 41),  -- Carote
(1, 92, 84),  -- Dentifricio
(1, 92, 92),  -- Tablet
(1, 92, 96),  -- Palla da Calcio

-- Scontrino 93: Palermo Centro (2024-02-19)
(2, 93, 34),  -- Marmellata di Frutta
(1, 93, 35),  -- Passata di Pomodoro
(1, 93, 36),  -- Couscous
(2, 93, 39),  -- Ceci in Scatola
(2, 93, 40),  -- Piselli
(1, 93, 45),  -- Arance
(1, 93, 88),  -- Crema Mani

-- Scontrino 94: Palermo Centro (2024-02-20)
(1, 94, 35),  -- Passata di Pomodoro
(1, 94, 36),  -- Couscous
(1, 94, 37),  -- Quinoa
(1, 94, 38),  -- Lenticchie
(1, 94, 47),  -- Fragole
(1, 94, 49),  -- Kiwi
(1, 94, 68),  -- Cappello
(1, 94, 76),  -- Cuscini Decorativi

-- Scontrino 95: Palermo Centro (2024-02-21)
(1, 95, 34),  -- Marmellata di Frutta
(1, 95, 39),  -- Ceci in Scatola
(2, 95, 40),  -- Piselli
(1, 95, 45),  -- Arance
(1, 95, 49),  -- Kiwi
(1, 95, 100), -- Set di Pesi

-- Scontrino 96: Palermo Centro (2024-03-03) - Dopo il secondo riassortimento
(1, 96, 34),  -- Marmellata di Frutta
(1, 96, 35),  -- Passata di Pomodoro
(1, 96, 36),  -- Couscous
(2, 96, 39),  -- Ceci in Scatola
(1, 96, 45),  -- Arance
(1, 96, 68),  -- Cappello
(1, 96, 88),  -- Crema Mani

-- Scontrino 97: Palermo Centro (2024-03-04)
(1, 97, 38),  -- Lenticchie
(2, 97, 40),  -- Piselli
(1, 97, 45),  -- Arance
(1, 97, 76),  -- Cuscini Decorativi
(1, 97, 100), -- Set di Pesi

-- Scontrino 98: Bari Centro (2024-02-20)
(1, 98, 34),  -- Marmellata di Frutta
(1, 98, 35),  -- Passata di Pomodoro
(1, 98, 36),  -- Couscous
(2, 98, 39),  -- Ceci in Scatola
(1, 98, 51),  -- Mango
(1, 98, 64),  -- Jeans Donna
(1, 98, 84),  -- Dentifricio

-- Scontrino 99: Bari Centro (2024-02-21)
(1, 99, 37),  -- Quinoa
(1, 99, 38),  -- Lenticchie
(2, 99, 40),  -- Piselli
(1, 99, 51),  -- Mango
(1, 99, 80),  -- Sedia da Giardino
(1, 99, 88),  -- Crema Mani

-- Scontrino 100: Bari Centro (2024-02-22)
(1, 100, 34), -- Marmellata di Frutta
(1, 100, 35), -- Passata di Pomodoro
(1, 100, 39), -- Ceci in Scatola
(1, 100, 51), -- Mango
(1, 100, 64), -- Jeans Donna
(1, 100, 84), -- Dentifricio

-- Scontrino 101: Catania Centro (2024-02-21)
(1, 101, 34), -- Marmellata di Frutta
(1, 101, 35), -- Passata di Pomodoro
(1, 101, 36), -- Couscous
(1, 101, 38), -- Lenticchie
(2, 101, 39), -- Ceci in Scatola
(1, 101, 68), -- Cappello
(1, 101, 84), -- Dentifricio
(1, 101, 96), -- Palla da Calcio

-- Scontrino 102: Catania Centro (2024-02-22)
(1, 102, 37), -- Quinoa
(1, 102, 38), -- Lenticchie
(1, 102, 39), -- Ceci in Scatola
(1, 102, 40), -- Piselli
(1, 102, 80), -- Sedia da Giardino
(1, 102, 100), -- Set di Pesi

-- Scontrino 103: Catania Centro (2024-02-23)
(1, 103, 34), -- Marmellata di Frutta
(1, 103, 35), -- Passata di Pomodoro
(2, 103, 39), -- Ceci in Scatola
(1, 103, 40), -- Piselli
(1, 103, 84), -- Dentifricio
(1, 103, 96); -- Palla da Calcio



























-- DROP DATABASE db_vendicose_spa;


