SET FOREIGN_KEY_CHECKS=0;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
CREATE TABLE customers(
    customer_id int(11) NOT NULL AUTO_INCREMENT,
	fname varchar(255) NOT NULL,
	lname varchar(255) NOT NULL,
	phone bigint(10) NOT NULL,
	PRIMARY KEY (customer_id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

--
-- Table structure for table `order_status`
--

DROP TABLE IF EXISTS `order_status`;
CREATE TABLE order_status(
    status_id int(11) NOT NULL AUTO_INCREMENT,
	name varchar(255) NOT NULL,
	PRIMARY KEY (status_id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
CREATE TABLE orders(
    order_id int(11) NOT NULL AUTO_INCREMENT,
	customer_id int,
	status_id int,
	order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (order_id),
    CONSTRAINT FK_Customer FOREIGN KEY (customer_id)
	REFERENCES customers(customer_id)
	ON DELETE SET NULL
	ON UPDATE CASCADE,
	FOREIGN KEY (status_id)
	REFERENCES order_status(status_id)
	ON DELETE SET NULL
	ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

--
-- Table structure for table `beer_types`
--

DROP TABLE IF EXISTS `beer_types`;
CREATE TABLE beer_types (
	type_id int(11) NOT NULL AUTO_INCREMENT,
	name varchar(255) NOT NULL,
	origin varchar(255),
	family varchar(255) NOT NULL,
	inactive smallint DEFAULT 0,
	PRIMARY KEY (type_id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

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
	inactive smallint DEFAULT 0,
	PRIMARY KEY (brewer_id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

--
-- Table structure for table `beers`
--

DROP TABLE IF EXISTS `beers`;
CREATE TABLE beers (
	beer_id int(11) NOT NULL AUTO_INCREMENT,
	name varchar(255) NOT NULL,
	type_id int(11),
	brewer_id int(11),
	abv decimal(5,2) NOT NULL,
	price decimal(11,2) NOT NULL,
	inactive smallint DEFAULT 0,
	PRIMARY KEY (beer_id),
	CONSTRAINT FK_BeerType FOREIGN KEY (type_id)
	REFERENCES beer_types(type_id)
	ON DELETE SET NULL
	ON UPDATE CASCADE,
	CONSTRAINT FK_Brewer FOREIGN KEY (brewer_id)
	REFERENCES brewers(brewer_id)
	ON DELETE SET NULL
	ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
CREATE TABLE order_items(
    order_id int,
    beer_id int,
    quantity int(11) NOT NULL,
	PRIMARY KEY (order_id, beer_id),
	CONSTRAINT FK_CustomerOrder FOREIGN KEY(order_id) 
	REFERENCES orders(order_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	CONSTRAINT FK_Beer FOREIGN KEY(beer_id)
	REFERENCES beers(beer_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `beer_types`
--

INSERT INTO beer_types
(name,origin,family)
VALUES
('American Light Lager','United States','Pale Lager'),
('American Lager','United States','Pale Lager'),
('Cream Ale','United States','Pale Ale'),
('American Wheat Beer','United States','Wheat Beer'),
('International Pale Lager','International','Pale Lager'),
('International Amber Lager','International','Amber Lager'),
('International Dark Lager','International','Dark Lager'),
('Czech Pale Lager','Czech Republic','Pale Lager'),
('Czech Premium Pale Lager','Czech Republic','Pilsner'),
('Czech Amber Lager','Czech Republic','Amber Lager'),
('Czech Dark Lager','Czech Republic','Dark Lager'),
('Munich Helles','Germany','Pale Lager'),
('Festbier','Germany','Pale Lager'),
('Helles Bock','Germany','Bock'),
('German Leichtbier','Germany','Pale Lager'),
('Kölsch','Germany','Pale Ale'),
('German Helles Exportbier','Germany','Pale Lager'),
('German Pils','Germany','Pilsner'),
('Märzen','Germany','Amber Lager'),
('Rauchbier','Germany','Amber Lager'),
('Dunkles Bock','Germany','Bock'),
('Vienna Lager','Austria','Amber Lager'),
('Altbier','Germany','Amber Ale'),
('Pale Kellerbier','Germany','Pale Lager'),
('Amber Kellerbier','Germany','Amber Lager'),
('Munich Dunkel','Germany','Dark Lager'),
('Schwarzbier','Germany','Dark Lager'),
('Doppelbock','Germany','Bock'),
('Eisbock','Germany','Bock'),
('Baltic Porter','Scandinavia','Porter'),
('Weissbier','Germany','Wheat Beer'),
('Dunkles Weissbier','Germany','Wheat Beer'),
('Weizenbock','Germany','Wheat Beer'),
('Ordinary Bitter','England','Amber Ale'),
('Best Bitter','England','Amber Ale'),
('Strong Bitter','England','Amber Ale'),
('British Golden Ale','England','Pale Ale'),
('Australian Sparkling Ale','Australian','Pale Ale'),
('English IPA','England','IPA'),
('Dark Mild','England','Brown Ale'),
('British Brown Ale','England','Brown Ale'),
('English Porter','England','Porter'),
('Scottish Light','Scotland','Amber Ale'),
('Scottish Heavy','Scotland','Amber Ale'),
('Scottish Export','Scotland','Amber Ale'),
('Irish Red Ale','Ireland','Amber Ale'),
('Irish Stout','Ireland','Stout'),
('Irish Extra Stout','Ireland','Stout'),
('Sweet (Milk) Stout','England','Stout'),
('Oatmeal Stout','England','Stout'),
('Tropical Stout','England','Stout'),
('Foreign Extra Stout','England','Stout'),
('British Strong Ale','England','Strong Ale'),
('Old Ale','England','Strong Ale'),
('Wee Heavy','Scotland','Strong Ale'),
('English Barleywine','England','Strong Ale'),
('Blonde Ale','United States','Pale Ale'),
('American Pale Ale','United States','Pale Ale'),
('American Amber Ale','United States','Amber Ale'),
('California Common','United States','Amber Lager'),
('American Brown Ale','United States','Brown Ale'),
('American Porter','United States','Porter'),
('American Stout','United States','Stout'),
('Imperial Stout','England','Stout'),
('American IPA','United States','IPA'),
('Specialty IPA - Belgian IPA','United States','IPA'),
('Specialty IPA - Black IPA','United States','IPA'),
('Specialty IPA - Brown IPA','United States','IPA'),
('Specialty IPA - Red IPA','United States','IPA'),
('Specialty IPA - Rye IPA','United States','IPA'),
('Specialty IPA - White IPA','United States','IPA'),
('Double IPA','United States','IPA'),
('American Strong Ale','United States','Strong Ale'),
('American Barleywine','United States','Strong Ale'),
('Wheatwine','United States','Strong Ale'),
('Berliner Weisse','Germany','Wheat Beer'),
('Flanders Red Ale','Belgium','Sour Ale'),
('Oud Bruin','Belgium','Sour Ale'),
('Lambic','Belgium','Wheat Beer'),
('Gueuze','Belgium','Wheat Beer'),
('Fruit Lambic','Belgium','Wheat Beer'),
('Witbier','Belgium','Wheat Beer'),
('Belgian Pale Ale','Belgium','Pale Ale'),
('Bière de Garde','France','Amber Ale'),
('Belgian Blond Ale','Belgium','Pale Ale'),
('Saison','Belgium','Pale Ale'),
('Belgian Golden Strong Ale','Belgium','Strong Ale'),
('Trappist Single','Belgium','Pale Ale'),
('Belgian Dubbel','Belgium','Amber Ale'),
('Belgian Tripel','Belgium','Strong Ale'),
('Belgian Dark Strong Ale','Belgium','Strong Ale'),
('Gose','Germany','Wheat Beer'),
('Kentucky Common','United States','Amber Ale'),
('Lichtenhainer','Germany','Wheat Beer'),
('London Brown Ale','England','Brown Ale'),
('Piwo Grodziskie','Poland','Wheat Beer'),
('Pre-Prohibition Lager','United States','Pilsner'),
('Pre-Prohibition Porter','United States','Porter'),
('Roggenbier','Germany','Wheat Beer'),
('Sahti','Scandinavia','Wheat Beer'),
('Brett Beer',NULL,'Specialty Beer'),
('Mixed-Fermentation Sour Beer',NULL,'Specialty Beer'),
('Wild Specialty Beer',NULL,'Specialty Beer'),
('Fruit Beer',NULL,'Specialty Beer'),
('Fruit and Spice Beer',NULL,'Specialty Beer'),
('Specialty Fruit Beer',NULL,'Specialty Beer'),
('Spice, Herb, or Vegetable Beer',NULL,'Specialty Beer'),
('Autumn Seasonal Beer',NULL,'Specialty Beer'),
('Winter Seasonal Beer',NULL,'Specialty Beer'),
('Alternative Grain Beer',NULL,'Specialty Beer'),
('Alternative Sugar Beer',NULL,'Specialty Beer'),
('Classic Style Smoked Beer',NULL,'Specialty Beer'),
('Specialty Smoked Beer',NULL,'Specialty Beer'),
('Wood-Aged Beer',NULL,'Specialty Beer'),
('Specialty Wood-Aged Beer',NULL,'Specialty Beer'),
('Clone Beer',NULL,'Specialty Beer'),
('Mixed-Style Beer',NULL,'Specialty Beer'),
('Experimental Beer',NULL,'Specialty Beer'),
('American Imperial Stout','United States','Stout'),
('American Imperial IPA','United States','IPA'),
('American Imperial Porter','United States','Porter'),
('American Wild Ale','United States','Specialty Beer'),
('Belgian Quadrupel (Quad)','Belgium','Strong Ale'),
('Bière de Champagne (Bière Brut)','Belgium','Strong Ale'),
('New England IPA','United States','IPA'),
('Russian Imperial Stout','United States','Stout'),
('Hefeweizen','Germany','Wheat Beer');


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
('Cigar City Brewing','Tampa','Florida','United States'),
('AleSmith Brewing Company','San Diego','California','United States'),
('Founders Brewing Company','Grand Rapids','Michigan','United States'),
('Cloudwater Brew Co','Manchester','Greater Manchester','England'),
('Sante Adairius Rustic Ales','Capitola','California','United States'),
('Firestone Walker Brewing Co.','Paso Robles','California','United States'),
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
('Goose Island Beer Co.','Chicago','Illinois','United States'),
('Verdant Brewing Co','Falmouth','Cornwall','England'),
('Maine Beer Company','Freeport','Maine','United States'),
('Mikkeller San Diego','San Diego','California','United States'),
('Buxton Brewery','Buxton','Derbyshire','England'),
('Jack\'s Abby Brewing','Framingham','Massachusetts','United States'),
('Alpine Beer Company','Alpine','California','United States'),
('Brouwerij 3 Fonteinen','Lot','Beersel','Belgium'),
('Fuller\'s Brewery','Chiswick','Greater London','England'),
('Brasserie Dunham','Dunham','Quebec','Canada'),
('Allagash Brewing Company','Portland','Maine','United States'),
('Monkish Brewing Company','Torrance','California','United States'),
('Stone Brewing','Escondido','California','United States'),
('Russian River Brewing Company','Santa Rosa','California','United States'),
('Three Floyds Brewing Company','Munster','Indiana','United States'),
('Other Half Brewing Company','Brooklyn','New York','United States'),
('Funky Buddha Brewery','Oakland Park','Florida','United States'),
('To Ol','Copenhagen N',NULL,'Denmark'),
('Brewery Ommegang (Duvel-Moortgat)','Cooperstown','New York','United States'),
('Evil Twin Brewing','Queens','New York','United States'),
('Wylam Brewery','Newcastle upon Tyne','Tyne &amp; Wear','England'),
('Magic Rock Brewing','Huddersfield','West Yorkshire','England'),
('Sierra Nevada Brewing Company','Chico','California','United States'),
('Abdij St. Sixtus - Westvleteren','Westvleteren',NULL,'Belgium'),
('Browar PINTA','Żywiec',NULL,'Poland'),
('Deschutes Brewery','Bend','Oregon','United States'),
('Cellarmaker Brewing Company','San Francisco','California','United States'),
('Brasserie de la Senne','Brussels',NULL,'Belgium'),
('Kuhnhenn Brewing Company','Warren','Michigan','United States'),
('Boulevard Brewing Company','Kansas City','Missouri','United States'),
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
('Ballast Point Brewing Company','San Diego','California','United States'),
('Bottle Logic Brewing','Anaheim','California','United States'),
('Siren Craft Brew','Finchampstead','Berkshire','England'),
('Bellwoods Brewery','Toronto','Ontario','Canada'),
('Fremont Brewing Company','Seattle','Washington','United States'),
('Avery Brewing Company','Boulder','Colorado','United States'),
('Half Acre Beer Company','Chicago','Illinois','United States'),
('Wicked Weed Brewing','Asheville','North Carolina','United States'),
('LTM - Les Trois Mousquetaires','Brossard','Quebec','Canada'),
('Angry Chair Brewing','Tampa','Florida','United States'),
('Drakes Brewing Company','San Leandro','California','United States'),
('De Dolle Brouwers','Diksmuide',NULL,'Belgium'),
('New Glarus Brewing Company','New Glarus','Wisconsin','United States'),
('Almanac Beer Company','San Francisco','California','United States'),
('Jolly Pumpkin Artisan Ales','Dexter','Michigan','United States'),
('Põhjala','Tallinn',NULL,'Estonia'),
('The Veil Brewing Company','Richmond','Virginia','United States'),
('Brasserie de Rochefort','Rochefort',NULL,'Belgium'),
('Lagunitas Brewing Company','Petaluma','California','United States'),
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
('Lervig Aktiebryggeri','Stavanger',NULL,'Norway'),
('3 Floyds Brewing Co.','Hammond','Indiana','United States'),
('Aslin Beer Company','Herndon','Virginia','United States'),
('Bayerische Staatsbrauerei Weihenstephan','Freising','Bavaria','Germany'),
('Bissell Brothers Brewing Co.','Portland','Maine','United States'),
('Boneyard Beer Company','Bend','Oregon','United States'),
('Boston Beer Company (Samuel Adams)','Boston','Massachusetts','United States'),
('Brasserie Cantillon','Anderlecht',NULL,'Belgium'),
('Brouwerij Rodenbach','Roeselare',NULL,'Belgium'),
('Brouwerij St. Bernardus','Watou',NULL,'Belgium'),
('Brouwerij Westvleteren','Vleteren',NULL,'Belgium'),
('Cascade Brewing','Portland','Oregon','United States'),
('Central Waters Brewing Co.','Amherst','Wisconsin','United States'),
('Columbus Brewing Company','Columbus','Ohio','United States'),
('Dark Horse Brewing Company','Marshall','Michigan','United States'),
('Fat Head\'s Brewery & Saloon','North Olmsted','Ohio','United States'),
('Fiddlehead Brewing Company','Shelburne','Vermont','United States'),
('FiftyFifty Brewing Co.','Truckee','California','United States'),
('Great Notion Brewing','Portland','Oregon','United States'),
('Hangar 24 Brewing','Redlands','California','United States'),
('Haymarket Beer Co. Pub & Brewery','Chicago','Illinois','United States'),
('Heist Brewery','Charlotte','North Carolina','United States'),
('Hoof Hearted Brewing','Marengo','Ohio','United States'),
('Kane Brewing Company','Ocean Township','New Jersey','United States'),
('Kern River Brewing Company','Kernville','California','United States'),
('Lift Bridge Brewery','Stillwater','Minnesota','United States'),
('Logsdon Farmhouse Ales','Washougal','Washington','United States'),
('Närke Kulturbryggeri AB','Örebro',NULL,'Sweden'),
('New England Brewing Co.','Woodbridge','Connecticut','United States'),
('Oskar Blues Grill & Brew','Colorado Springs','Colorado','United States'),
('Ozark Beer Co.','Rogers','Arkansas','United States'),
('Parish Brewing Company','Broussard','Louisiana','United States'),
('Pelican Pub & Brewery','Pacific City','Oregon','United States'),
('Perennial Artisan Ales','St. Louis','Missouri','United States'),
('Perrin Brewing Co.','Comstock Park','Michigan','United States'),
('Pipeworks Brewing Company','Chicago','Illinois','United States'),
('Revolution Brewing','Chicago','Illinois','United States'),
('Shared Brewing','Maplewood','Missouri','United States'),
('The Alchemist','Stowe','Vermont','United States'),
('The Lost Abbey','San Marcos','California','United States'),
('Voodoo Brewery','Meadville','Pennsylvania','United States'),
('WeldWerks Brewing Co.','Greeley','Colorado','United States'),
('Westbrook Brewing Co.','Mt. Pleasant','South Carolina','United States');


--
-- Dumping data for table `beers`
--

INSERT INTO beers
(name,type_id,brewer_id,abv,price)
VALUES
('Lush IPA',65,73,0.07,9.00),
('Black Butte Porter',62,49,0.052,8.00),
('Arrogant Bastard',73,36,0.072,13.00),
('Kentucky Brunch Brand Stout',119,14,0.12,9.00),
('Marshmallow Handjee',126,101,0.15,12.00),
('Hunahpu\'s Imperial Stout - Double Barrel Aged',119,5,0.11,11.00),
('Barrel-Aged Abraxas',119,135,0.11,13.00),
('Heady Topper',125,140,0.08,12.00),
('Mornin\' Delight',119,14,0.128,12.00),
('Pliny The Younger',120,37,0.1025,14.00),
('King Julius',125,4,0.083,7.00),
('King JJJuliusss',125,4,0.084,11.00),
('Very Hazy',125,4,0.086,11.00),
('SR-71',119,14,0.14,8.00),
('Fundamental Observation',119,70,0.143,8.00),
('CBS (Canadian Breakfast Stout)',119,7,0.113,8.00),
('Pliny The Elder',120,37,0.08,10.00),
('Juice Machine',125,4,0.082,13.00),
('Fou\' Foune',81,107,0.055,11.00),
('Assassin',119,14,0.12,11.00),
('Very Green',125,4,0.086,13.00),
('Julius',125,4,0.068,11.00),
('Zenne Y Frontera',79,31,0.07,7.00),
('Double Sunshine',120,88,0.08,8.00),
('Abner',125,1,0.082,14.00),
('Bourbon County Brand Stout',119,24,0.147,10.00),
('Trappist Westvleteren 12 (XII)',123,111,0.102,15.00),
('Dinner',120,26,0.082,11.00),
('Barrel Aged Imperial German Chocolate Cupcake Stout',119,78,0.11,12.00),
('KBS (Kentucky Breakfast Stout)',119,7,0.123,8.00),
('JJJuliusss',125,4,0.068,12.00),
('Parabola',126,10,0.13,15.00),
('Duck Duck Gooze',80,141,0.07,11.00),
('Speedway Stout - Vietnamese Coffee - Bourbon-Barrel Aged',119,6,0.12,14.00),
('Morning Wood',121,40,0.12,13.00),
('Lou Pepe - Kriek',81,107,0.05,12.00),
('Zombie Dust',58,101,0.062,12.00),
('Bourbon County Brand Vanilla Stout',119,24,0.149,8.00),
('Westly',122,9,0.085,13.00),
('Fuzzy',122,2,0.08,10.00),
('Ann',86,1,0.065,10.00),
('Doubleganger',125,4,0.082,11.00),
('Hunahpu\'s Imperial Stout',119,5,0.102,10.00),
('King Sue',125,14,0.078,7.00),
('Very GGGreennn',125,4,0.083,14.00),
('Double Citra®',125,1,0.08,12.00),
('Atrial Rubicite',122,90,0.058,13.00),
('Headroom',125,3,0.08,13.00),
('Double Galaxy',125,1,0.08,10.00),
('Framboise Du Fermier',86,2,0.08,11.00),
('Cable Car',122,141,0.07,9.00),
('Supplication',122,37,0.0775,10.00),
('Citra',120,126,0.08,14.00),
('Focal Banger',125,140,0.07,11.00),
('Maman',119,135,0.115,11.00),
('Green',125,4,0.076,15.00),
('Lou Pepe - Framboise',81,107,0.055,11.00),
('Aaron',56,1,0.09,14.00),
('Oude Geuze Vintage',80,31,0.06,10.00),
('Chemtrailmix',126,101,0.15,13.00),
('Sip Of Sunshine',120,88,0.08,15.00),
('Anabasis',74,2,0.14,14.00),
('Swish',125,104,0.08,9.00),
('Double Dry Hopped Congress Street',125,3,0.072,8.00),
('Black Tuesday',119,56,0.195,9.00),
('BBADL (Bourbon Barrel Aged Dark Lord Imperial Stout)',126,101,0.15,10.00),
('Society & Solitude #4',125,1,0.08,8.00),
('Chocolate Rain',119,56,0.196,12.00),
('Beatification',122,37,0.06,9.00),
('Nectarine Premiere',86,12,0.071,11.00),
('Fourth Dementia - Bourbon Barrel-Aged',54,52,0.135,11.00),
('Doppelganger',125,4,0.082,13.00),
('Ephraim',125,1,0.1,9.00),
('Triple Sunshine',120,88,0.105,15.00),
('Double Dry Hopped Fort Point Pale Ale',58,3,0.066,7.00),
('V.S.O.J.',56,138,0.14,7.00),
('Haze',125,4,0.082,15.00),
('Grande Negro Voodoo Papi - Bourbon Barrel-Aged',119,142,0.125,9.00),
('Triple Shot',119,4,0.09,13.00),
('It Was All A Dream',119,66,0.17,14.00),
('Black Note Stout',119,23,0.112,13.00),
('Keene Idea',120,30,0.0888,7.00),
('Saint Lamvinus',81,107,0.07,7.00),
('The Broken Truck',122,12,0.05,13.00),
('Galaxy Dry Hopped Fort Point Pale Ale',58,3,0.066,10.00),
('Beer Geek Vanilla Shake - Bourbon Barrel-Aged',119,16,0.13,12.00),
('Abricot Du Fermier',86,2,0.08,10.00),
('Flora Plum',86,1,0.05,7.00),
('Bourbon Paradise',119,89,0.137,8.00),
('Saison Du Fermier',86,2,0.07,13.00),
('West Ashley',122,9,0.073,7.00),
('Breakfast Stout',50,7,0.083,15.00),
('A Deal With The Devil',74,57,0.173,9.00),
('Trappistes Rochefort 10',123,86,0.113,9.00),
('Coffee Cinnamon B-Bomb',73,73,0.13,13.00),
('Ghost In The Machine - Double Dry-Hopped',125,133,0.08,12.00),
('§ucaba',56,10,0.125,8.00),
('Bourbon Barrel Aged Plead The 5th',126,116,0.12,15.00),
('Notorious Triple IPA',120,105,0.12,14.00),
('Sunday Brunch',121,125,0.092,9.00),
('Black Gold',119,114,0.11,7.00),
('Alter Ego',125,4,0.068,7.00),
('Pseudo Sue - Double Dry-Hopped',58,14,0.068,15.00),
('Beyond Good And Evil',119,1,0.1,8.00),
('Miami Madness',76,66,0.055,12.00),
('Society & Solitude #5',125,1,0.081,8.00),
('Pirate Paradise',119,89,0.13,13.00),
('The Rusty Nail',50,73,0.145,13.00),
('Last Buffalo In The Park',121,40,0.115,7.00),
('Cutting Tiles (Mosaic)',125,3,0.085,7.00),
('Blåbær Lambik',81,107,0.05,8.00),
('Samuel Adams Utopias',73,106,0.28,10.00),
('Pirate Bomb!',119,89,0.15,9.00),
('Double Shot',63,4,0.076,9.00),
('Speedway Stout - Bourbon Barrel-Aged',119,6,0.12,11.00),
('Mexican Brunch',121,125,0.092,7.00),
('Great',74,30,0.14,15.00),
('Grey Monday',119,56,0.199,13.00),
('Black Tuesday - Reserve',119,56,0.205,10.00),
('The Peach',122,12,0.073,15.00),
('Bomb!',119,89,0.13,14.00),
('Wide Awake It\'s Morning',121,40,0.1,15.00),
('Consecration',122,37,0.1,8.00),
('A Deal With The Devil - Double Oak-Aged',74,57,0.17,10.00),
('Framboos',81,31,0.05,7.00),
('Pugachev Royale',126,121,0.148,12.00),
('Hommage',81,31,0.06,14.00),
('In Perpetuity',125,4,0.067,11.00),
('Scaled Way Up',125,3,0.08,8.00),
('Pseudo Sue',58,14,0.058,15.00),
('Abrasive Ale',120,64,0.092,14.00),
('Parabajava',126,10,0.14,10.00),
('Mocha Wednesday',119,56,0.199,8.00),
('Permanent Funeral',120,101,0.105,11.00),
('Double Dry Hopped Double Mosaic Dream',125,39,0.085,15.00),
('Moment Of Clarity',49,4,0.077,12.00),
('Gggreennn!',125,4,0.075,14.00),
('4th Anniversary',125,39,0.1,9.00),
('3rd Anniversary Imperial IPA',125,39,0.1,14.00),
('Kaggen! Stormaktsporter',126,129,0.1,15.00),
('Imperial Biscotti Break - Bourbon Barrel-Aged',119,43,0.115,13.00),
('Montmorency Vs Balaton',122,90,0.061,7.00),
('Darkness',126,64,0.12,15.00),
('No Rules',121,136,0.15,15.00),
('Double Dry Hopped Mylar Bags',125,39,0.085,7.00),
('Double Stack',119,120,0.11,7.00),
('Everett Porter',62,1,0.075,10.00),
('Lou Pepe - Gueuze',80,107,0.05,11.00),
('Heavy Mettle',125,3,0.093,15.00),
('Congress Street IPA',125,3,0.072,14.00),
('Susan',125,1,0.062,15.00),
('Speedway Stout - Vietnamese Coffee',119,6,0.12,9.00),
('Abt 12',123,110,0.1,12.00),
('Upper Case',125,3,0.09,12.00),
('Society & Solitude #6',125,1,0.081,13.00),
('The Abyss',119,49,0.114,9.00),
('Hold On To Sunshine',49,4,0.076,12.00),
('Bourbon Barrel Aged Dark Star: Coffee Edition',50,73,0.136,13.00),
('Double Dry Hopped Melcher Street',125,3,0.072,9.00),
('Mosaic Dry Hopped Fort Point',58,3,0.066,11.00),
('Abraxas',119,135,0.1,10.00),
('Cutting Tiles (Galaxy)',125,3,0.085,8.00),
('Oude Geuze Golden Blend',80,31,0.075,15.00),
('Trappist Westvleteren 8 (VIII)',89,111,0.08,11.00),
('Last Snow',62,40,0.064,14.00),
('Hopslam Ale',120,23,0.1,9.00),
('Saison Bernice',86,9,0.065,13.00),
('Double Dry Hopped Double Mosaic Daydream',125,39,0.085,7.00),
('Genealogy Of Morals - Bourbon Barrel-Aged',119,1,0.107,14.00),
('Apple Brandy Barrel Noir',119,89,0.12,12.00),
('Double Nelson',125,1,0.08,8.00),
('Ground State',119,70,0.134,14.00),
('Oude Geuze Cuvée Armand & Gaston',80,31,0.065,10.00),
('Damon (Bourbon Barrel Aged)',126,1,0.105,9.00),
('Bad Boy',120,30,0.09,8.00),
('Double Barrel Jesus',119,43,0.12,7.00),
('La Fosse',122,2,0.08,8.00),
('Stickee Monkee',123,10,0.125,8.00),
('Impermanence',49,4,0.09,13.00),
('DFPF',76,66,0.035,15.00),
('Aurelian Lure',122,90,0.054,15.00),
('Crusher',125,140,0.08,14.00),
('Maple Bacon Coffee Porter',62,40,0.064,9.00),
('Fuzzy Baby Ducks',125,130,0.062,11.00),
('Adam From The Wood',54,61,0.12,11.00),
('Sosus',125,14,0.08,9.00),
('Barrel-Aged Silhouette',126,127,0.11,7.00),
('BDCS',119,132,0.102,11.00),
('Art',86,1,0.065,9.00),
('Imperial German Chocolate Cupcake Stout',119,78,0.115,7.00),
('Mexican Cake - Maple Bourbon Barrel-Aged',119,144,0.102,14.00),
('Matt',73,61,0.115,14.00),
('Leaner',86,62,0.08,11.00),
('Gueuze 100% Lambic',80,107,0.05,7.00),
('Temptation',122,37,0.075,9.00),
('Fundamental Forces',119,70,0.162,11.00),
('Barrel Aged Bomb!',119,89,0.147,10.00),
('Leche Borracho',119,70,0.11,15.00),
('Clare\'s Thirsty Ale',119,122,0.125,11.00),
('Ten FIDY - Bourbon Barrel Aged',119,131,0.125,8.00),
('Mother Of All Storms',56,134,0.14,11.00),
('Coffee Abraxas',119,135,0.1,10.00),
('Citraquench\'l',125,123,0.071,12.00),
('Bodhi',120,115,0.085,11.00),
('Double Dry Hopped All Citra Everything',125,39,0.085,11.00),
('Kiwi Herman',122,30,0.07,12.00),
('Rodenbach Caractère Rouge',77,109,0.07,13.00),
('Emerald Grouper',120,137,0.095,14.00),
('Somewhere, Something Incredible Is Waiting To Be Known',49,4,0.079,7.00),
('Birth Of Tragedy',121,1,0.09,13.00),
('Flora',86,1,0.048,15.00),
('Caffè Americano',119,5,0.12,14.00),
('Bourbon Barrel Oro Negro',119,91,0.121,15.00),
('Tweak',119,74,0.16,15.00),
('Hop JuJu Imperial IPA',120,117,0.09,8.00),
('Bourbon Barrel Black Maple',121,91,0.11,14.00),
('Second Fiddle',120,118,0.082,9.00),
('Juicy',86,1,0.074,7.00),
('Fort Point Pale Ale',58,3,0.066,14.00),
('Ghost In The Machine',125,133,0.085,13.00),
('Expedition Stout - Bourbon Barrel-Aged',126,23,0.134,10.00),
('Imperial Eclipse Stout - Elijah Craig (12 Year)',119,119,0.119,11.00),
('Sang Noir',122,112,0.093,11.00),
('Vicinity',125,3,0.08,9.00),
('Bourbon Barrel Champion Ground',119,91,0.12,7.00),
('Medianoche - Coconut',119,143,0.141,11.00),
('Coconut B-Bomb',73,73,0.13,11.00),
('Hunahpu\'s Imperial Stout - Bourbon Barrel-Aged',119,5,0.146,7.00),
('Schaerbeekse Kriek',81,31,0.06,10.00),
('Peche \'n Brett',86,128,0.1,7.00),
('Fyodor',126,36,0.131,9.00),
('Appervation',119,91,0.15,13.00),
('Space Trace',119,70,0.111,12.00),
('Coolship Red',81,34,0.057,10.00),
('Thicket',122,2,0.06,13.00),
('Cellarman Barrel Aged Saison',86,9,0.065,13.00),
('All That Is And All That Ever Will Be',49,4,0.065,15.00),
('Dorothy (Wine Barrel Aged)',86,1,0.07,13.00),
('Darkstar November',126,70,0.137,7.00),
('Black & Wild',122,2,0.1,9.00),
('Hefeweissbier',127,103,0.054,13.00),
('Coconut Vibes',126,139,0.13,8.00),
('Mastermind',125,118,0.081,7.00),
('Nelson',65,30,0.07,13.00),
('Flora - Blueberry',86,1,0.05,12.00),
('Blanc De Blancs',124,2,0.1,11.00),
('Axe Man',65,64,0.072,8.00),
('Double Dry Hopped Sleeper Street',125,3,0.072,10.00),
('Dragonsaddle',125,124,0.115,12.00),
('Double Orange Starfish',125,102,0.083,10.00),
('Enjoy By IPA',120,36,0.094,11.00),
('Scaled Up',125,3,0.08,13.00),
('Sure Bet',120,137,0.095,10.00);


--
-- Dumping data for table `customers`
--

INSERT INTO customers
(fname,lname,phone) 
VALUES
('Aidan','Lindsay','7092524546'),
('Porter','Sullivan','5843380473'),
('Denton','Gonzalez','5864610316'),
('Sara','Gordon','1619141443'),
('Anjolie','Calhoun','3744861810'),
('Nichole','Hardin','1717893982'),
('Ivor','Kim','7444693995'),
('Rama','Fischer','5025787725'),
('Alfonso','Curtis','5218790121'),
('Aidan','Ortega','6447012765'),
('Carson','Mayo','3071988131'),
('Xantha','Espinoza','7558860676'),
('Merritt','Fisher','3645218198'),
('Raven','Larsen','1043901280'),
('Danielle','Ramos','3368258799'),
('Upton','Murray','1344165436'),
('Slade','Michael','8284262555'),
('Alfonso','Abbott','7302824390'),
('Olympia','Randolph','6555676961'),
('Vaughan','Hopper','1225091884'),
('Melyssa','Ellison','2664887831'),
('Zena','Mckay','6482409470'),
('Benedict','Kline','3775190971'),
('Kylynn','Puckett','1612629922'),
('Gil','Jackson','6682340988'),
('David','Foley','2885077787'),
('Noel','Greer','8661022834'),
('Eleanor','Hinton','2814519888'),
('Sonia','Schwartz','5555120944'),
('Britanney','Maddox','3717524412'),
('Ivor','Franklin','3555650766'),
('Ivor','Kinney','8466229029'),
('Olivia','Cortez','9119630848'),
('Ethan','Cash','5062999619'),
('Lysandra','Maynard','3892878967'),
('Lars','Barron','8702583083'),
('Leandra','Perkins','1451957116'),
('Tashya','Anderson','5173748053'),
('Hermione','Pierce','6668665775'),
('Harding','Mcmillan','7766419105'),
('Laith','Hull','2975923555'),
('Evelyn','Trevino','3277886136'),
('Yoshi','Fulton','4475834208'),
('Judith','Bell','8521277042'),
('Kameko','Monroe','2896593757'),
('Zachary','Burt','8755544797'),
('Bo','Raymond','9976522388'),
('Jin','Murray','8636013502'),
('Elliott','Logan','3717204161'),
('Barclay','Delacruz','8398289342'),
('Merritt','Newton','5705872447'),
('Herrod','Maynard','1657499628'),
('Prescott','Ashley','4472512630'),
('Kellie','Day','8269437426'),
('Adrian','Dawson','9644843083'),
('Murphy','Hendrix','2286863560'),
('Justine','Green','4971706433'),
('Christen','Contreras','2847399973'),
('Pandora','Herman','1188915951'),
('Abel','Waller','4711799913'),
('Delilah','Benton','3735668910'),
('Rowan','Marsh','1189097998'),
('Clinton','Coleman','7946922343'),
('Matthew','Fleming','6973192256'),
('Hall','Weber','6092105246'),
('Lysandra','York','2695342982'),
('Roth','Massey','7632517536'),
('Carter','Riley','9304906276'),
('Jacqueline','Shields','6875386337'),
('Denise','Stevens','8723504247'),
('Joan','Webb','6644869040'),
('Neve','Charles','6584931776'),
('Valentine','Sparks','7172613823'),
('Hannah','Savage','8173178178'),
('Zahir','Warren','9473964804'),
('Bo','Woodard','1533621813'),
('Ariel','Howell','3977880467'),
('Leila','Wright','2261965514'),
('Patrick','Chapman','9306048672'),
('Noble','Whitehead','9296770533'),
('Yoshio','Meyers','9041942556'),
('Lucian','Frazier','4563812876'),
('Hashim','Sears','6227300343'),
('Kimberley','Fox','7139904629'),
('Mallory','Thornton','1504178165'),
('Brooke','Douglas','8317828920'),
('Grant','Berg','7577395592'),
('Azalia','Cooper','3591934253'),
('Griffith','Hutchinson','3561146215'),
('Amaya','Mcfadden','2004168792'),
('Xandra','Davis','7271412880'),
('Ivor','Clements','6268521726'),
('Jacob','Hancock','2577013204'),
('Irma','Bates','8018376943'),
('Taylor','Haley','7576953426'),
('Astra','Shannon','5106342896'),
('Herman','Brennan','6397209540'),
('Caldwell','Roth','7323557708'),
('Amber','Gates','4901669530'),
('Oleg','James','4518486626');



--
-- Dumping data for table `orders`
--

INSERT INTO order_status
(name)
VALUES
('OPEN'),
('PLACED'),
('SHIPPED'),
('DELIVERED');


--
-- Dumping data for table `orders`
--

INSERT INTO orders 
 (customer_id, status_id) 
 VALUES
 (1, 1),
 (2, 1),
 (1, 3),
 (2, 2),
 (1, 4);


--
-- Dumping data for table `order_items`
--

 INSERT INTO order_items 
 (order_id, beer_id, quantity) 
 VALUES
 (1,1,1),
 (1,2,99);


--
-- Dumping data for table `beer_ratings`
--

INSERT IGNORE INTO beer_ratings 
(customer_id, beer_id, rating) 
VALUES
(90,196,1),(28,131,2),(4,237,3),(68,89,5),(5,111,1),(57,5,4),(11,16,1),(41,141,4),(73,175,1),(51,211,4),(14,115,3),(99,193,1),(13,132,2),(69,224,2),(14,203,4),(16,123,5),(18,72,4),(39,104,5),(69,131,1),(89,34,4),(74,115,4),(44,154,3),(78,137,3),(49,2,3),(65,135,5),(9,70,2),(71,16,5),(54,214,4),(62,197,4),(32,217,3),(29,179,2),(46,148,2),(68,130,1),(66,226,1),(58,116,4),(8,9,4),(31,20,1),(34,89,2),(81,204,5),(97,27,1),(16,113,1),(33,258,1),(99,7,5),(34,73,5),(67,115,5),(96,24,3),(27,28,2),(10,193,2),(4,73,2),(55,137,5),(60,86,3),(6,215,1),(49,42,2),(58,204,1),(96,89,4),(39,140,1),(84,197,3),(52,9,3),(30,73,2),(65,168,5),(77,141,3),(11,50,3),(65,211,5),(34,3,4),(80,128,4),(100,158,3),(11,31,5),(55,172,1),(92,29,3),(100,54,4),(6,227,1),(98,153,1),(33,187,4),(28,180,4),(33,20,5),(24,130,2),(15,74,2),(20,12,3),(26,174,1),(19,30,4),(73,120,1),(75,148,5),(84,244,3),(1,48,3),(22,218,5),(52,33,4),(60,210,4),(37,92,3),(24,242,4),(44,158,1),(37,214,5),(78,25,1),(52,210,3),(83,219,5),(18,249,2),(63,184,3),(5,222,5),(70,176,4),(82,83,2),(80,18,4),(59,164,5),(16,95,5),(11,30,5),(80,44,4),(15,67,1),(75,25,5),(29,123,4),(82,30,4),(37,91,5),(40,241,1),(59,17,1),(40,53,4),(40,178,5),(12,225,4),(27,89,4),(68,105,5),(95,22,1),(39,12,3),(48,242,4),(20,103,5),(38,125,5),(70,104,5),(70,166,3),(60,127,3),(47,252,5),(11,83,2),(61,216,2),(82,36,5),(24,40,4),(1,79,4),(77,237,5),(56,197,2),(39,152,2),(40,33,2),(18,20,5),(91,154,2),(78,201,1),(70,71,3),(60,244,4),(23,140,1),(10,112,5),(8,216,2),(89,130,4),(9,148,2),(26,83,5),(78,233,1),(90,184,2),(94,102,1),(83,104,5),(18,105,4),(33,7,5),(9,90,3),(63,220,1),(15,210,3),(4,159,2),(54,242,1),(55,41,3),(86,82,4),(46,176,1),(23,34,4),(85,121,1),(83,32,2),(6,18,1),(79,145,5),(38,171,5),(47,79,1),(95,145,4),(9,113,5),(39,156,2),(51,248,2),(5,129,4),(64,25,4),(63,179,2),(36,11,4),(55,203,3),(95,119,1),(91,36,4),(32,98,5),(80,212,3),(59,46,5),(55,158,4),(19,15,1),(73,80,3),(36,179,2),(65,245,5),(71,52,4),(81,48,4),(63,113,1),(98,134,3),(67,187,1),(92,168,5),(89,192,1),(19,239,2),(66,191,3),(50,64,3),(57,254,3),(62,162,4),(67,200,1),(92,238,5),(46,89,5),(7,112,1),(42,226,4),(38,57,2),(100,54,5),(83,258,4),(89,212,5),(27,115,4),(48,121,2),(37,221,1),(3,250,5),(4,11,2),(97,13,3),(14,189,5),(54,53,5),(19,73,1),(11,151,3),(42,174,1),(72,194,3),(54,216,3),(71,112,5),(14,114,4),(100,190,2),(86,75,3),(89,77,4),(91,150,5),(51,137,3),(51,208,1),(75,150,2),(20,61,5),(66,223,3),(92,92,3),(18,65,4),(21,161,1),(54,215,2),(17,195,5),(45,79,2),(41,183,3),(17,80,3),(2,129,5),(13,210,3),(99,72,4),(98,129,2),(83,220,5),(5,247,4),(30,153,2),(84,111,3),(96,70,3),(25,74,1),(46,257,3),(20,191,3),(15,91,3),(72,207,4),(81,195,2),(42,210,5),(87,216,4),(73,61,1),(41,124,4),(89,181,1),(86,155,2),(50,126,2),(98,114,5),(18,23,3),(24,118,5),(7,159,1),(55,144,2),(100,50,2),(28,7,2),(34,73,3),(11,247,4),(94,165,1),(3,194,5),(62,69,5),(66,55,1),(15,229,4),(63,54,5),(53,132,3),(76,120,5),(12,126,4),(70,39,5),(23,14,5),(37,39,2),(79,85,2),(43,37,3),(91,200,2),(93,126,3),(7,210,4),(11,203,5),(38,201,3),(15,29,2),(42,72,1),(71,78,5),(84,117,2),(41,37,1),(10,7,3),(19,184,1),(76,202,5),(39,121,2),(82,62,4),(7,26,5),(18,21,1),(2,78,3),(96,100,4),(21,242,3),(76,1,3),(57,190,5),(33,233,4),(68,17,3),(47,113,3),(37,78,5),(32,230,1),(91,253,5),(81,165,1),(55,2,5),(44,24,4),(52,165,3),(86,75,4),(50,257,5),(77,40,3),(72,4,5),(11,48,4),(78,24,5),(76,241,2),(40,98,3),(40,165,4),(86,225,2),(11,44,3),(52,247,3),(21,105,2),(30,253,1),(37,128,4),(43,75,2),(13,258,2),(100,196,3),(89,158,1),(43,218,4),(15,129,4),(38,200,3),(40,175,4),(90,33,3),(96,55,1),(92,39,3),(87,109,5),(55,77,1),(49,154,3),(34,176,1),(56,104,4),(62,51,1),(7,210,5),(43,246,1),(26,255,2),(12,94,4),(22,240,3),(31,10,3),(33,81,2),(98,224,5),(33,134,5),(35,63,4),(65,1,1),(11,115,1),(24,32,2),(10,186,4),(10,250,1),(54,84,5),(49,70,5),(74,110,5),(13,27,4),(4,107,3),(38,174,2),(94,150,4),(95,76,2),(91,235,4),(49,172,5),(77,217,3),(49,10,3),(90,58,2),(58,131,3),(34,42,3),(61,219,3),(94,251,2),(22,236,5),(96,201,3),(32,218,1),(9,137,5),(8,150,1),(6,188,3),(26,64,5),(8,23,4),(56,114,1),(28,93,5),(16,114,3),(74,143,4),(8,15,3),(8,60,3),(82,175,5),(11,48,4),(71,214,1),(96,19,1),(62,130,2),(87,213,4),(82,97,4),(89,120,5),(62,44,1),(95,29,1),(48,57,3),(23,49,3),(90,74,4),(9,162,3),(23,4,3),(93,158,5),(3,167,5),(34,13,5),(73,182,4),(61,183,4),(73,162,4),(12,1,4),(64,128,2),(55,52,4),(68,36,1),(6,10,3),(76,224,1),(57,214,4),(40,38,5),(24,126,5),(54,45,1),(64,59,4),(55,95,4),(97,32,4),(28,12,5),(97,107,4),(19,92,5),(51,161,5),(52,236,5),(72,222,2),(94,68,4),(43,219,5),(25,124,1),(28,204,3),(22,101,3),(98,204,4),(78,201,2),(55,52,4),(1,96,1),(38,213,3),(40,193,5),(66,164,3),(65,92,3),(22,138,2),(62,206,2),(26,222,2),(90,43,3),(2,19,4),(83,246,5),(80,73,1),(55,238,2),(49,56,2),(88,58,2),(20,59,3),(53,28,5),(96,237,3),(25,240,2),(7,32,3),(35,126,4),(59,150,2),(3,90,4),(38,161,3),(58,86,4),(55,204,4),(84,111,5),(81,211,5),(3,234,2),(23,4,2),(80,25,5),(77,50,3),(11,93,4),(28,190,1),(49,85,3),(10,46,2),(2,224,4),(68,38,3),(16,88,1),(96,221,5),(8,89,5),(10,66,1),(71,236,3),(91,240,4),(62,114,2),(9,2,5),(98,199,3),(90,136,4),(32,129,3),(91,23,3),(52,76,5),(27,91,5),(55,220,1),(14,38,5),(48,210,2),(61,251,5),(91,34,4),(68,157,1),(92,180,4);


SET FOREIGN_KEY_CHECKS=1;