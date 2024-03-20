CREATE TABLE Continents 
( 
    ContID INT, 
    Continent VARCHAR(15), 
    PRIMARY KEY(ContID) 
);

CREATE TABLE Countries 
( 
    CountryID INT, 
    CountryName VARCHAR(20), 
    Continent INT, 
    PRIMARY KEY(CountryID), 
    FOREIGN KEY(Continent) REFERENCES Continents(ContID) 
);

CREATE TABLE Car_Makers 
( 
    ID INT, 
    Maker VARCHAR(15), 
    FullName VARCHAR(25), 
    Country INT, 
    PRIMARY KEY(ID), 
    FOREIGN KEY(Country) REFERENCES Countries(CountryID) 
);

CREATE TABLE Model_Details 
( 
    ModelID INT, 
    Maker INT, 
    Model VARCHAR(25), 
    PRIMARY KEY(ModelID), 
    UNIQUE(Model), 
    FOREIGN KEY(Maker) REFERENCES Car_Makers(ID) 
);

CREATE TABLE Car_Names 
(
    ID INT, 
    Model VARCHAR(25), 
    Descr VARCHAR(40), 
    PRIMARY KEY(ID), 
    FOREIGN KEY(Model) REFERENCES Model_Details(Model)
);

-- при использовании Docker образа таблица будет создана автоматически
CREATE TABLE Car_Details 
(
    ID INT, 
    mpg DECIMAL(5,2), 
    cylinders INT, 
    edispl INT, 
    horsepower INT, 
    weight INT, 
    accel DECIMAL(10,2), 
    year INT, 
    PRIMARY KEY(ID), 
    FOREIGN KEY(ID) REFERENCES Car_Names(ID) 
);

-- Отбираем информацю по автомобилям, которые выпущены после 1980 года
SELECT 
    cn.Model,
    cn.Descr,
    cm.Maker,
    cm.FullName,
    c.CountryName,
    ct.Continent
FROM 
    Car_Details cd
JOIN 
    Car_Names cn ON cd.ID = cn.ID
JOIN 
    Model_Details md ON cn.Model = md.Model
JOIN 
    Car_Makers cm ON md.Maker = cm.ID
JOIN 
    Countries c ON cm.Country = c.CountryID
JOIN 
    Continents ct ON c.Continent = ct.ContID
WHERE 
    cd.year > 1980 
GROUP BY 
    cn.Model, cn.Descr, cm.Maker, cm.FullName, c.CountryName, ct.Continent;
	

-- В условиях боевых БД, такие запросы делать не надо. Создано только для демонстрации навыка.
-- Используя подзапросы выберем все страны, в которых есть производители автомобилей, которые производят автомобили с ценным сырьем (edispl больше 200).
SELECT 
    c.CountryName
FROM 
    Countries c
WHERE 
    c.CountryID IN (
        SELECT cm.Country 
        FROM Car_Makers cm
        WHERE cm.ID IN (SELECT md.Maker
                		FROM Model_Details md
                		WHERE md.Model IN (
											SELECT cn.Model
											FROM Car_Names cn
											JOIN Car_Details cd ON cn.ID = cd.ID
											WHERE cd.edispl > 200
                                          )
                        )
);