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
(fname, lname, phone) 
VALUES
('Ryan', 'Suter', 5555445454),
('Pavel', 'Gordeyev', 9995555454),
('Dingo', 'Baby', 9995555453),
('T', 'Rex', 9995555452),
('Sir', 'Mix-a-lot', 9995555457),
('Crocodile', 'Dundee', 9995555458);


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

INSERT INTO beer_ratings 
(customer_id, beer_id, rating) 
VALUES
(1,1,5),
(2,1,1),
(2,2,4);

SET FOREIGN_KEY_CHECKS=1;