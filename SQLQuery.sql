--Sukuriame duomen� baz� "NasdaqBaltic_shares"
CREATE DATABASE NasdaqBaltic_shares;

--sukuriame�lentel� "shares"
CREATE TABLE shares (
    List_segment VARCHAR(255),
    Ticker VARCHAR(50),
    Company VARCHAR(255),
    Market VARCHAR(50),
    ISIN VARCHAR(50),
    Currency VARCHAR(10),
    Open_price DECIMAL(10,2),
    Last_price DECIMAL(10,2),
    Last_price_date DATE,
    Change_percent DECIMAL(5,2),
    Trades INT,
    Volume INT,
    Turnover DECIMAL(15,2),
    High_price DECIMAL(10,2),
    Low_price DECIMAL(10,2),
    Last_yield DECIMAL(5,2),
    Open_yield DECIMAL(5,2),
    High_yield DECIMAL(5,2),
    Low_yield DECIMAL(5,2),
    Open_price_clean DECIMAL(10,2),
    Last_price_clean DECIMAL(10,2),
    High_price_clean DECIMAL(10,2),
    Low_price_clean DECIMAL(10,2),
    Nominal INT,
    Best_Bid DECIMAL(10,2),
    Best_Offer DECIMAL(10,2),
    Average DECIMAL(10,2)
);

--sukuriame lentel� "stock_info"
CREATE TABLE StockInfo (
    Ticker VARCHAR(10),
    Name VARCHAR(255),
    ISIN VARCHAR(20),
    Currency VARCHAR(10),
    MarketPlace VARCHAR(255),
    List_segment VARCHAR(255),
    Average_Price DECIMAL(10, 2),
    Open_Price DECIMAL(10, 2),
    High_Price DECIMAL(10, 2),
    Low_Price DECIMAL(10, 2),
    Last_close_Price DECIMAL(10, 2),
    Last_Price DECIMAL(10, 2),
    Price_Change_Percent DECIMAL(5, 2),
    Best_bid DECIMAL(10, 2),
    Best_ask DECIMAL(10, 2),
    Trades INT,
    Volume INT,
    Turnover DECIMAL(15, 2),
    Industry VARCHAR(255),
    Supersector VARCHAR(255)
);

--�keliame duomenis � lenteles "shares"
INSERT INTO shares (
    List_segment, Ticker, Company, Market, ISIN, Currency,
    Open_price, Last_price, Last_price_date, Change_percent, Trades,
    Volume, Turnover, High_price, Low_price, Last_yield, Open_yield,
    High_yield, Low_yield, Open_price_clean, Last_price_clean,
    High_price_clean, Low_price_clean, Nominal, Best_Bid, Best_Offer, Average
)
VALUES 
(
    'Baltic Bond List', 'ADMB080027A', 'Admiral Markets AS', 'TLN', 'EE3300111251', 'EUR',
    108.933333, 103.022222, '2024-05-10', NULL, 3,
    12, 1244.599998, 107.777778, 103.022222, NULL, NULL,
    NULL, NULL, 106.622222, 103.022222,
    109.377778, 100, 100, 103.022222, 109.377778, NULL
),
(
    'Baltic Main List', 'AUG1L', 'AUGA group', 'VLN', 'LT0000127466', 'EUR',
    0.293, 0.288, '2024-05-10', -2.37, 1155,
    379873, 109152.969, 0.296, 0.28, NULL, NULL,
    NULL, NULL, 0.296, 0.296,
    0.296, 0.28, 1000, NULL, NULL, NULL
);

--�keliame duomenis � lenteles "stockinfo"
INSERT INTO stockinfo
(Ticker, Name, ISIN, Currency, MarketPlace, List_segment, Last_close_Price, Last_Price, Industry, Supersector)
VALUES
('AMG1L', 'Amber Grid', 'LT0000128696', 'EUR', 'VLN', 'Baltijos Papildomasis s�ra�as', 1.18, 1.18, 'Energija', 'Energija'),
('APG1L', 'Apranga', 'LT0000102337', 'EUR', 'VLN', 'Baltijos Oficialusis s�ra�as', 3.01, 3.01, 'Diskrecinis vartojimas', 'Ma�menin� prekyba'),
('ARC1T', 'Arco Vara', 'EE3100034653', 'EUR', 'TLN', 'Baltijos Oficialusis s�ra�as', 1.47, 1.47, 'Nekilnojamasis turtas', 'Nekilnojamasis turtas'),
('AUG1L', 'AUGA group', 'LT0000127466', 'EUR', 'VLN', 'Baltijos Oficialusis s�ra�as', 0.288, 0.288, 'Kasdieninio vartojimo prek�s', 'Maistas, g�rimai ir tabakas'),
('BAL1R', 'Amber Latvijas balzams', 'LV0000100808', 'EUR', 'RIG', 'Baltijos Papildomasis s�ra�as', 8.85, 8.85, 'Kasdieninio vartojimo prek�s', 'Maistas, g�rimai ir tabakas'),
('BERCM', 'Bercman Technologies', 'EE3100076407', 'EUR', 'TLN', 'Baltijos First North akcij� s�ra�as', 1.39, 1.39, 'Pramoniniai gaminiai', 'Pramonin�s prek�s ir paslaugos');

--sukuriame duomen� rinkin�
CREATE VIEW CombinedStockData AS
SELECT
    s.Ticker,
    s.Company,
    s.ISIN,
    s.Currency,
    s.Market AS MarketPlace,
    s.List_segment,
    s.Last_price AS LastPriceFromShares,
    i.Last_Price AS LastPriceFromStockInfo,
    s.Volume AS VolumeFromShares,
    i.Volume AS VolumeFromStockInfo,
    s.Turnover AS TurnoverFromShares,
    i.Turnover AS TurnoverFromStockInfo,
    s.Open_price,
    s.High_price,
    s.Low_price,
    s.Last_yield,
    s.Open_yield,
    s.High_yield,
    s.Low_yield,
    i.Industry,
    i.Supersector
FROM
    shares s
    JOIN stockinfo i ON s.Ticker = i.Ticker;

-- Per�i�rime visus duomenis i� sukurto duomen� rinkinio
SELECT *
FROM CombinedStockData;  
