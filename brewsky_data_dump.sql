--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
CREATE TABLE customers(
    customer_id int(11) NOT NULL AUTO_INCREMENT,
	fname varchar(255) NOT NULL,
	lname varchar(255) NOT NULL,
	phone int(11) NOT NULL,
	PRIMARY KEY (customer_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
CREATE TABLE orders(
    order_id int(11) NOT NULL AUTO_INCREMENT,
	customer_id int(11) NOT NULL,
	status varchar(255) NOT NULL,
	order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (order_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `beer_types`
--

DROP TABLE IF EXISTS `beer_types`;
CREATE TABLE beer_types (
	type_id int(11) NOT NULL AUTO_INCREMENT,
	name varchar(255) NOT NULL,
	origin varchar(255) NOT NULL,
	family varchar(255) NOT NULL,
	inactive bit DEFAULT 0,
	PRIMARY KEY (type_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `brewers`
--

DROP TABLE IF EXISTS `brewers`;
CREATE TABLE brewers (
	brewer_id int(11) NOT NULL AUTO_INCREMENT,
	name varchar(255) NOT NULL,
	city varchar(255) NOT NULL,
	state varchar(255),
	country varchar(255) NOT NULL,
	inactive bit DEFAULT 0,
	PRIMARY KEY (brewer_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `beers`
--

DROP TABLE IF EXISTS `beers`;
CREATE TABLE beers (
	beer_id int(11) NOT NULL AUTO_INCREMENT,
	name varchar(255) NOT NULL,
	type_id int(11),
	brewer_id int(11),
	inactive bit DEFAULT 0,
	PRIMARY KEY (beer_id),
	FOREIGN KEY (type_id)
	REFERENCES beer_types(type_id)
	ON DELETE SET NULL
	ON UPDATE CASCADE,
	FOREIGN KEY (brewer_id)
	REFERENCES brewers(brewer_id)
	ON DELETE SET NULL
	ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
CREATE TABLE order_items(
    order_id int NOT NULL,
	FOREIGN KEY(order_id) 
	REFERENCES orders(order_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	beer_id int NOT NULL,
	FOREIGN KEY(beer_id) 
	REFERENCES beers(beer_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	quantity int(11) NOT NULL,
	price int(11) NOT NULL,
    PRIMARY KEY (order_id, beer_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `beer_ratings`
--

DROP TABLE IF EXISTS `beer_ratings`;
CREATE TABLE beer_ratings (
	beer_id int,
	customer_id int,
	rating int(11) NOT NULL,
	PRIMARY KEY (beer_id, customer_id),
	FOREIGN KEY (beer_id) 
	REFERENCES beers(beer_id) 
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY (customer_id) 
	REFERENCES customers(customer_id) 
	ON DELETE CASCADE
	ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `beer_types`
--

INSERT INTO beer_types
(name,family,origin)
VALUES
('American Light Lager','Pale Lager','United States'),
('American Lager','Pale Lager','United States'),
('Cream Ale','Pale Ale','United States'),
('American Wheat Beer','Wheat Beer','United States'),
('International Pale Lager','Pale Lager','International'),
('International Amber Lager','Amber Lager','International'),
('International Dark Lager','Dark Lager','International'),
('Czech Pale Lager','Pale Lager','Czech Republic'),
('Czech Premium Pale Lager','Pilsner','Czech Republic'),
('Czech Amber Lager','Amber Lager','Czech Republic'),
('Czech Dark Lager','Dark Lager','Czech Republic'),
('Munich Helles','Pale Lager','Germany'),
('Festbier','Pale Lager','Germany'),
('Helles Bock','Bock','Germany'),
('German Leichtbier','Pale Lager','Germany'),
('Kölsch','Pale Ale','Germany'),
('German Helles Exportbier','Pale Lager','Germany'),
('German Pils','Pilsner','Germany'),
('Märzen','Amber Lager','Germany'),
('Rauchbier','Amber Lager','Germany'),
('Dunkles Bock','Bock','Germany'),
('Vienna Lager','Amber Lager','Austria'),
('Altbier','Amber Ale','Germany'),
('Pale Kellerbier','Pale Lager','Germany'),
('Amber Kellerbier','Amber Lager','Germany'),
('Munich Dunkel','Dark Lager','Germany'),
('Schwarzbier','Dark Lager','Germany'),
('Doppelbock','Bock','Germany'),
('Eisbock','Bock','Germany'),
('Baltic Porter','Porter','Scandinavia'),
('Weissbier','Wheat Beer','Germany'),
('Dunkles Weissbier','Wheat Beer','Germany'),
('Weizenbock','Wheat Beer','Germany'),
('Ordinary Bitter','Amber Ale','England'),
('Best Bitter','Amber Ale','England'),
('Strong Bitter','Amber Ale','England'),
('British Golden Ale','Pale Ale','England'),
('Australian Sparkling Ale','Pale Ale','Australian'),
('English IPA','IPA','England'),
('Dark Mild','Brown Ale','England'),
('British Brown Ale','Brown Ale','England'),
('English Porter','Porter','England'),
('Scottish Light','Amber Ale','Scotland'),
('Scottish Heavy','Amber Ale','Scotland'),
('Scottish Export','Amber Ale','Scotland'),
('Irish Red Ale','Amber Ale','Ireland'),
('Irish Stout','Stout','Ireland'),
('Irish Extra Stout','Stout','Ireland'),
('Sweet Stout','Stout','England'),
('Oatmeal Stout','Stout','England'),
('Tropical Stout','Stout','England'),
('Foreign Extra Stout','Stout','England'),
('British Strong Ale','Strong Ale','England'),
('Old Ale','Strong Ale','England'),
('Wee Heavy','Strong Ale','Scotland'),
('English Barleywine','Strong Ale','England'),
('Blonde Ale','Pale Ale','United States'),
('American Pale Ale','Pale Ale','United States'),
('American Amber Ale','Amber Ale','United States'),
('California Common ','Amber Lager','United States'),
('American Brown Ale','Brown Ale','United States'),
('American Porter','Porter','United States'),
('American Stout','Stout','United States'),
('Imperial Stout','Stout','England'),
('American IPA','IPA','United States'),
('Specialty IPA - Belgian IPA','IPA','United States'),
('Specialty IPA - Black IPA','IPA','United States'),
('Specialty IPA - Brown IPA','IPA','United States'),
('Specialty IPA - Red IPA','IPA','United States'),
('Specialty IPA - Rye IPA','IPA','United States'),
('Specialty IPA - White IPA','IPA','United States'),
('Double IPA','IPA','United States'),
('American Strong Ale','Strong Ale','United States'),
('American Barleywine','Strong Ale','United States'),
('Wheatwine','Strong Ale','United States'),
('Berliner Weisse','Wheat Beer','Germany'),
('Flanders Red Ale','Sour Ale','Belgium'),
('Oud Bruin','Sour Ale','Belgium'),
('Lambic','Wheat Beer','Belgium'),
('Gueuze ','Wheat Beer','Belgium'),
('Fruit Lambic','Wheat Beer','Belgium'),
('Witbier','Wheat Beer','Belgium'),
('Belgian Pale Ale','Pale Ale','Belgium'),
('Bière de Garde','Amber Ale','France'),
('Belgian Blond Ale','Pale Ale','Belgium'),
('Saison','Pale Ale','Belgium'),
('Belgian Golden Strong Ale','Strong Ale','Belgium'),
('Trappist Single','Pale Ale','Belgium'),
('Belgian Dubbel','Amber Ale','Belgium'),
('Belgian Tripel','Strong Ale','Belgium'),
('Belgian Dark Strong Ale','Strong Ale','Belgium'),
('Gose','Wheat Beer','Germany'),
('Kentucky Common','Amber Ale','United States'),
('Lichtenhainer','Wheat Beer','Germany'),
('London Brown Ale','Brown Ale','England'),
('Piwo Grodziskie','Wheat Beer','Poland'),
('Pre-Prohibition Lager','Pilsner','United States'),
('Pre-Prohibition Porter','Porter','United States'),
('Roggenbier','Wheat Beer','Germany'),
('Sahti','Wheat Beer','Scandinavia'),
('Brett Beer','Specialty Beer','Specialty Beer'),
('Mixed-Fermentation Sour Beer','Specialty Beer','Specialty Beer'),
('Wild Specialty Beer','Specialty Beer','Specialty Beer'),
('Fruit Beer','Specialty Beer','Specialty Beer'),
('Fruit and Spice Beer','Specialty Beer','Specialty Beer'),
('Specialty Fruit Beer','Specialty Beer','Specialty Beer'),
('Spice, Herb, or Vegetable Beer','Specialty Beer','Specialty Beer'),
('Autumn Seasonal Beer','Specialty Beer','Specialty Beer'),
('Winter Seasonal Beer','Specialty Beer','Specialty Beer'),
('Alternative Grain Beer','Specialty Beer','Specialty Beer'),
('Alternative Sugar Beer','Specialty Beer','Specialty Beer'),
('Classic Style Smoked Beer','Specialty Beer','Specialty Beer'),
('Specialty Smoked Beer','Specialty Beer','Specialty Beer'),
('Wood-Aged Beer','Specialty Beer','Specialty Beer'),
('Specialty Wood-Aged Beer','Specialty Beer','Specialty Beer'),
('Clone Beer','Specialty Beer','Specialty Beer'),
('Mixed-Style Beer','Specialty Beer','Specialty Beer'),
('Experimental Beer','Specialty Beer','Specialty Beer');


--
-- Dumping data for table `brewers`
--

INSERT INTO brewers
(name,city,state,country)
VALUES
('Hill Farmstead Brewery','Greensboro','Vermont','United States'),
('Side Project Brewing','Maplewood','Missouri','United States'),
('Trillium Brewing Company','Boston','Massachusetts','United States'),
('Tree House Brewing Company','Charlton','Massachusetts','United States'),
('Cigar City Brewing (CANarchy Craft Brewery Collective)','Tampa','Florida','United States'),
('AleSmith Brewing Company','San Diego','California','United States'),
('Founders Brewing Company (Mahou San Miguel)','Grand Rapids','Michigan','United States'),
('Cloudwater Brew Co','Manchester','Greater Manchester','England'),
('Sante Adairius Rustic Ales','Capitola','California','United States'),
('Firestone Walker Brewing (Duvel-Moortgat)','Paso Robles','California','United States'),
('The Kernel Brewery','Bermondsey','Greater London','England'),
('De Garde Brewing','Tillamook','Oregon','United States'),
('Port Brewing Company / The Lost Abbey','San Marcos','California','United States'),
('Toppling Goliath Brewing Company','Decorah','Iowa','United States'),
('Brouwerij De Molen (Swinkels Family Brewers)','Bodegraven',NULL,'Netherlands'),
('Mikkeller','Copenhagen',NULL,'Denmark'),
('Brasserie Dieu du Ciel!','Montréal','Quebec','Canada'),
('De Struise Brouwers','Oostvleteren',NULL,'Belgium'),
('Cycle Brewing','Saint Petersburg','Florida','United States'),
('Hoppin\' Frog Brewery','Akron','Ohio','United States'),
('Modern Times Beer','San Diego','California','United States'),
('Tired Hands Brewing Company','Ardmore','Pennsylvania','United States'),
('Bell\'s Brewery','Comstock','Michigan','United States'),
('Goose Island Beer Company (AB-InBev)','Chicago','Illinois','United States'),
('Verdant Brewing Co','Falmouth','Cornwall','England'),
('Maine Beer Company','Freeport','Maine','United States'),
('Mikkeller San Diego','San Diego','California','United States'),
('Buxton Brewery','Buxton','Derbyshire','England'),
('Jack\'s Abby Brewing','Framingham','Massachusetts','United States'),
('Alpine Beer Company (CA)','Alpine','California','United States'),
('Brouwerij 3 Fonteinen','Lot','Beersel','Belgium'),
('Fuller\'s Brewery (Asahi)','Chiswick','Greater London','England'),
('Brasserie Dunham','Dunham','Quebec','Canada'),
('Allagash Brewing Company','Portland','Maine','United States'),
('Monkish Brewing Company','Torrance','California','United States'),
('Stone Brewing','Escondido','California','United States'),
('Russian River Brewing','Santa Rosa','California','United States'),
('Three Floyds Brewing Company','Munster','Indiana','United States'),
('Other Half Brewing','Brooklyn','New York','United States'),
('Funky Buddha Brewery (Constellation Brands)','Oakland Park','Florida','United States'),
('To Øl','Copenhagen N',NULL,'Denmark'),
('Brewery Ommegang (Duvel-Moortgat)','Cooperstown','New York','United States'),
('Evil Twin Brewing','Queens','New York','United States'),
('Wylam Brewery','Newcastle upon Tyne','Tyne &amp; Wear','England'),
('Magic Rock Brewing (Lion Co. - Kirin Holdings)','Huddersfield','West Yorkshire','England'),
('Sierra Nevada Brewing Company','Chico','California','United States'),
('Abdij St. Sixtus - Westvleteren','Westvleteren',NULL,'Belgium'),
('Browar PINTA','Żywiec',NULL,'Poland'),
('Deschutes Brewery','Bend','Oregon','United States'),
('Cellarmaker Brewing Company','San Francisco','California','United States'),
('Brasserie de la Senne','Brussels',NULL,'Belgium'),
('Kuhnhenn Brewing','Warren','Michigan','United States'),
('Boulevard Brewing Company (Duvel-Moortgat)','Kansas City','Missouri','United States'),
('Northern Monk Brew Co.','Leeds','West Yorkshire','England'),
('Suarez Family Brewery','Livingston','New York','United States'),
('The Bruery','Placentia','California','United States'),
('Anchorage Brewing Company','Anchorage','Alaska','United States'),
('Cantillon','Brussels',NULL,'Belgium'),
('Garage Project','Wellington',NULL,'New Zealand'),
('Nøgne Ø (Hansa Borg)','Grimstad',NULL,'Norway'),
('Hair of the Dog Brewing Company','Portland','Oregon','United States'),
('Casey Brewing and Blending','Glenwood Springs','Colorado','United States'),
('Omnipollo','Stockholm',NULL,'Sweden'),
('Surly Brewing Company','Minneapolis','Minnesota','United States'),
('Amager Bryghus','Kastrup',NULL,'Denmark'),
('J. Wakefield Brewing','Miami','Florida','United States'),
('Methode Goat','Hasselt',NULL,'Belgium'),
('Crooked Stave Artisan Beer Project','Denver','Colorado','United States'),
('Ballast Point Brewing Company (Kings & Convicts)','San Diego','California','United States'),
('Bottle Logic Brewing','Anaheim','California','United States'),
('Siren Craft Brew','Finchampstead','Berkshire','England'),
('Bellwoods Brewery','Toronto','Ontario','Canada'),
('Fremont Brewing Company','Seattle','Washington','United States'),
('Avery Brewing Company (Mahou San Miguel)','Boulder','Colorado','United States'),
('Half Acre Beer Company','Chicago','Illinois','United States'),
('Wicked Weed Brewing (AB InBev)','Asheville','North Carolina','United States'),
('LTM - Les Trois Mousquetaires','Brossard','Quebec','Canada'),
('Angry Chair Brewing','Tampa','Florida','United States'),
('Drakes Brewing Company','San Leandro','California','United States'),
('De Dolle Brouwers','Diksmuide',NULL,'Belgium'),
('New Glarus Brewing Company','New Glarus','Wisconsin','United States'),
('Almanac Beer Company','San Francisco','California','United States'),
('Jolly Pumpkin Artisan Ales','Dexter','Michigan','United States'),
('Põhjala','Tallinn',NULL,'Estonia'),
('The Veil Brewing Company','Richmond','Virginia','United States'),
('Abbaye Notre-Dame de Saint-Rémy - Brasserie Rochefort','Rochefort',NULL,'Belgium'),
('Lagunitas Brewing Company (Heineken)','Petaluma','California','United States'),
('Lawson\'s Finest Liquids','Waitsfield','Vermont','United States'),
('Prairie Artisan Ales','Tulsa','Oklahoma','United States'),
('Jester King Brewery','Austin','Texas','United States'),
('Jackie O\'s Pub & Brewery','Athens','Ohio','United States'),
('Brauerei Aying','Aying','Bavaria','Germany'),
('Brasserie du Bas-Canada','Gatineau','Quebec','Canada'),
('Brasserie Auval Brewing Co.','Percé','Quebec','Canada'),
('La Cumbre Brewing Company','Albuquerque','New Mexico','United States'),
('Holy Mountain Brewing Company','Seattle','Washington','United States'),
('Arizona Wilderness Brewing Company','Gilbert','Arizona','United States'),
('Dogfish Head Brewery','Milton','Delaware','United States'),
('BrewDog','Ellon','Aberdeenshire','Scotland'),
('Lervig Aktiebryggeri','Stavanger',NULL,'Norway');


--
-- Dumping data for table `beers`
--

INSERT INTO beers
(name,type_id,brewer_id)
VALUES
('Lush IPA',65,73),
('Black Butte Porter',62,49),
('Arrogant Bastard',73,36);


--
-- Dumping data for table `customers`
--

INSERT INTO customers 
(fname, lname, phone) 
VALUES
('Ryan', 'Suter', 5555445454),
('Pavel', 'Gordeyev', 9995555454);


--
-- Dumping data for table `orders`
--

 INSERT INTO orders 
 (customer_id, status) 
 VALUES
 (1, 'OPEN'),
 (2, 'OPEN');


--
-- Dumping data for table `order_items`
--

 INSERT INTO order_items 
 (order_id, beer_id, quantity, price) 
 VALUES
 (3,1,1,5.00);


--
-- Dumping data for table `beer_ratings`
--

INSERT INTO beer_ratings 
(customer_id, beer_id, rating) 
VALUES
(1,1,5);
