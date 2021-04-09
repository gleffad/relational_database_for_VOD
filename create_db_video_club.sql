--make trigger retard + procedures

DROP TABLE realise_f;
DROP TABLE realise_s;
DROP TABLE recoit_act;
DROP TABLE recoit_rea;
DROP TABLE recoit_solo_rea;
DROP TABLE recoit_solo_act;
DROP TABLE joue_dans_s;
DROP TABLE joue_dans_f;
DROP TABLE achat_p_f;
DROP TABLE achat_p_s;
DROP TABLE achat_n_f;
DROP TABLE achat_n_s;
DROP TABLE location_p_f;
DROP TABLE location_p_s;
DROP TABLE location_n_f;
DROP TABLE location_n_s;
DROP TABLE souscrit;
DROP TABLE retard_s;
DROP TABLE retard_f;
DROP TABLE sous_titre_s;
DROP TABLE sous_titre_f;
DROP TABLE voix_s;
DROP TABLE voix_f;
DROP TABLE stock_pl_f;
DROP TABLE stock_pa_f;
DROP TABLE stock_n_f;
DROP TABLE stock_f;
DROP TABLE stock_pl_s;
DROP TABLE stock_pa_s;
DROP TABLE stock_n_s;
DROP TABLE stock_s;
DROP TABLE edition_f;
DROP TABLE film;
DROP TABLE edition_s;
DROP TABLE episode;
DROP TABLE saison;
DROP TABLE serie;
DROP TABLE langue;
DROP TABLE distinction;
DROP TABLE realisateur;
DROP TABLE acteur;
DROP TABLE abonnement;
DROP TABLE client;

DROP PROCEDURE insert_cli;
DROP PROCEDURE update_cli;
DROP PROCEDURE select_delete_cli;
DROP PROCEDURE insert_abo;
DROP PROCEDURE update_abo;
DROP PROCEDURE select_delete_abo;
DROP PROCEDURE insert_act;
DROP PROCEDURE update_act;
DROP PROCEDURE select_delete_act;
DROP PROCEDURE insert_rea;
DROP PROCEDURE update_rea;
DROP PROCEDURE select_delete_rea;
DROP PROCEDURE insert_distinct;
DROP PROCEDURE update_distinct;
DROP PROCEDURE select_delete_distinct;
DROP PROCEDURE insert_lang;
DROP PROCEDURE update_lang;
DROP PROCEDURE select_delete_lang;
DROP PROCEDURE insert_serie;
DROP PROCEDURE update_serie;
DROP PROCEDURE select_delete_serie;
DROP PROCEDURE insert_saison;
DROP PROCEDURE update_saison;
DROP PROCEDURE select_delete_saison;
DROP PROCEDURE insert_episode;
DROP PROCEDURE update_episode;
DROP PROCEDURE select_delete_episode;
DROP PROCEDURE insert_edition_s;
DROP PROCEDURE update_edition_s;
DROP PROCEDURE select_delete_edition_s;
DROP PROCEDURE insert_film;
DROP PROCEDURE update_film;
DROP PROCEDURE select_delete_film;
DROP PROCEDURE insert_edition_f;
DROP PROCEDURE update_edition_f;
DROP PROCEDURE select_delete_edition_f;
DROP PROCEDURE insert_stock_f;
DROP PROCEDURE update_stock_f;
DROP PROCEDURE select_delete_stock_f;
DROP PROCEDURE achat_num_f;
DROP PROCEDURE achat_phy_f;
DROP PROCEDURE achat_num_s;
DROP PROCEDURE achat_phy_s;

CREATE TABLE client
(
	id_cli				SMALLINT			IDENTITY PRIMARY KEY,
	nom					VARCHAR(20)			NOT NULL,
	prenom				VARCHAR(20)			NOT NULL,
	date_naissance		DATE				NOT NULL,
	adresse				VARCHAR(40)			NOT NULL,
	ville				VARCHAR(40)			NOT NULL,
	CP					SMALLINT			NOT NULL,
	mail				VARCHAR(40)			NOT NULL,
	tel					SMALLINT			NOT NULL,
	CB					SMALLINT			NOT NULL
);

CREATE TABLE abonnement
(
	id_abo				SMALLINT			IDENTITY PRIMARY KEY,
	type_abo			VARCHAR(15)			NOT NULL,
	prix				DECIMAL(7,2)		NOT NULL,
	nb_loc				SMALLINT			NOT NULL,
	nb_film_g			SMALLINT			NOT NULL
);

CREATE TABLE acteur
(
	id_act				SMALLINT			IDENTITY PRIMARY KEY,
	nom					VARCHAR(20)			NOT NULL,
	prenom				VARCHAR(20)			NOT NULL,
	date_naissance		DATE				NOT NULL
);

CREATE TABLE realisateur
(
	id_rea				SMALLINT			IDENTITY PRIMARY KEY,
	nom					VARCHAR(20)			NOT NULL,
	prenom				VARCHAR(20)			NOT NULL,
	date_naissance		DATE				NOT NULL
);

CREATE TABLE distinction
(
	id_distinct			SMALLINT			IDENTITY PRIMARY KEY,
	type_d				VARCHAR(20)			NOT NULL,
	categorie			VARCHAR(20)			NOT NULL
);

CREATE TABLE langue
(
	id_langue			SMALLINT			IDENTITY PRIMARY KEY,
	langue				VARCHAR(20)			NOT NULL
);

CREATE TABLE serie
(
	id_serie			SMALLINT			IDENTITY PRIMARY KEY,
	date_sortie			DATE				NOT NULL,
	genre				VARCHAR(40)			NOT NULL,
	id_langue			SMALLINT			REFERENCES langue(id_langue)
						ON UPDATE CASCADE
						ON DELETE CASCADE
); 

CREATE TABLE saison
(
	id_saison			SMALLINT			NOT NULL IDENTITY,
	id_serie			SMALLINT			REFERENCES serie(id_serie)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	synopsis			VARCHAR(300)		NOT NULL,
	nom					VARCHAR(40)			NOT NULL,
	date_sortie			DATE				NOT NULL,
	CONSTRAINT			pk_saison			PRIMARY KEY(id_saison, id_serie)
);

CREATE TABLE episode
(
	id_episode			SMALLINT			NOT NULL IDENTITY,
	id_saison			SMALLINT			NOT NULL,
	id_serie			SMALLINT			NOT NULL,
	synopsis			VARCHAR(300)		NOT NULL,
	duree				TIME				NOT NULL,
	nom					VARCHAR(40)			NOT NULL,
	CONSTRAINT			fk_episode			FOREIGN KEY(id_saison, id_serie) REFERENCES saison(id_saison, id_serie)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	CONSTRAINT			pk_episode			PRIMARY KEY(id_episode, id_saison, id_serie)
);

CREATE TABLE edition_s
(
	id_edition			SMALLINT			NOT NULL IDENTITY,
	id_saison			SMALLINT			NOT NULL,
	id_serie			SMALLINT			NOT NULL,
	nom					VARCHAR(40)			NOT NULL,
	date_sortie			DATE				NOT NULL,
	version_s			VARCHAR(20)			NOT NULL,
	CONSTRAINT			fk_edition_s		FOREIGN KEY(id_saison, id_serie) REFERENCES saison(id_saison, id_serie)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	CONSTRAINT			pk_edition_s		PRIMARY KEY(id_edition, id_saison, id_serie)
);

CREATE TABLE film
(
	id_film				SMALLINT			IDENTITY PRIMARY KEY,
	genre				VARCHAR(20)			NOT NULL,
	date_sortie			DATE				NOT NULL,
	synopsis			VARCHAR(500)		NOT NULL,
	duree				TIME				NOT NULL,
	titre				VARCHAR(40)			NOT NULL,
	id_langue			SMALLINT			REFERENCES langue(id_langue)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	CONSTRAINT			c_genre_in			CHECK(lower(genre) in ('action', 'comedie', 'drame', 'horreur', 'thriller', 's-f', 'bof'))
);

CREATE TABLE edition_f
(
	id_edition			SMALLINT			NOT NULL IDENTITY,
	id_film				SMALLINT			REFERENCES film(id_film)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	nom					VARCHAR(50)			NOT NULL,
	version_f			VARCHAR(20)			NOT NULL,
	date_sortie			DATE				NOT NULL,
	CONSTRAINT			pk_edition_f		PRIMARY KEY(id_edition, id_film)
);

CREATE TABLE stock_f
(
	id_product_f		SMALLINT			NOT NULL IDENTITY,
	id_edition			SMALLINT			NOT NULL,
	id_film				SMALLINT			NOT NULL,
	format				VARCHAR(20)			NOT NULL,
	CONSTRAINT			format_f			CHECK(lower(format) in ('hd','dvd','4k','1080p','720p', '244p', 'potato')),
	CONSTRAINT			fk_stock_f			FOREIGN KEY(id_edition, id_film) REFERENCES edition_f(id_edition, id_film)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	CONSTRAINT			pk_stock_f			PRIMARY KEY(id_product_f, id_edition, id_film)
);

CREATE TABLE stock_n_f
(
	id_product_f		SMALLINT			NOT NULL,
	id_edition			SMALLINT			NOT NULL,
	id_film				SMALLINT			NOT NULL,
	prix_loc			DECIMAL(7,2)		NOT NULL,
	prix_achat			DECIMAL(7,2)		NOT NULL,
	CONSTRAINT			fk_stock_n_f		FOREIGN KEY(id_product_f, id_edition, id_film) REFERENCES stock_f(id_product_f, id_edition, id_film)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	CONSTRAINT			pk_stock_n_f		PRIMARY KEY(id_product_f, id_edition, id_film)
);

CREATE TABLE stock_pa_f
(
	id_product_f		SMALLINT			NOT NULL,
	id_edition			SMALLINT			NOT NULL,
	id_film				SMALLINT			NOT NULL,
	usure				SMALLINT			CHECK(usure between 0 and 100),
	prix				DECIMAL(7,2)		NOT NULL,
	CONSTRAINT			fk_stock_pa_f		FOREIGN KEY(id_product_f, id_edition, id_film) REFERENCES stock_f(id_product_f, id_edition, id_film)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	CONSTRAINT			pk_stock_pa_f		PRIMARY KEY(id_product_f, id_edition, id_film)
);

CREATE TABLE stock_pl_f
(
	id_product_f		SMALLINT			NOT NULL,
	id_edition			SMALLINT			NOT NULL,
	id_film				SMALLINT			NOT NULL,
	usure				SMALLINT			CHECK(usure between 0 and 100),
	prix				DECIMAL(7,2)		NOT NULL,
	dispo				VARCHAR(3)			CHECK(lower(dispo) in ('yes', 'no')),
	reserve				VARCHAR(4)			CHECK(lower(reserve) in ('res', 'dispo')),
	CONSTRAINT			fk_stock_pl_f		FOREIGN KEY(id_product_f, id_edition, id_film) REFERENCES stock_f(id_product_f, id_edition, id_film)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	CONSTRAINT			pk_stock_pl_f		PRIMARY KEY(id_product_f, id_edition, id_film)
);

CREATE TABLE stock_s
(
	id_product_s		SMALLINT			NOT NULL IDENTITY,
	id_edition			SMALLINT			NOT NULL,
	id_saison			SMALLINT			NOT NULL,
	id_serie			SMALLINT			NOT NULL,
	format				VARCHAR(20)			NOT NULL,
	CONSTRAINT			format_s			CHECK(lower(format) in ('hd','dvd','4k','1080p','720p', '244p', 'potato')),
	CONSTRAINT			fk_stock_s			FOREIGN KEY(id_edition, id_saison, id_serie) REFERENCES edition_s(id_edition, id_saison, id_serie)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	CONSTRAINT			pk_stock_s			PRIMARY KEY(id_product_s, id_edition, id_saison, id_serie)
);

CREATE TABLE stock_n_s
(
	id_product_s		SMALLINT			NOT NULL,
	id_edition			SMALLINT			NOT NULL,
	id_saison			SMALLINT			NOT NULL,
	id_serie			SMALLINT			NOT NULL,
	prix_loc			DECIMAL(7,2)		NOT NULL,
	prix_achat			DECIMAL(7,2)		NOT NULL,
	CONSTRAINT			fk_stock_n_s		FOREIGN KEY(id_product_s, id_edition, id_saison, id_serie) REFERENCES stock_s(id_product_s, id_edition, id_saison, id_serie)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	CONSTRAINT			pk_stock_n_s		PRIMARY KEY(id_product_s, id_edition, id_saison, id_serie)
);

CREATE TABLE stock_pa_s
(
	id_product_s		SMALLINT			NOT NULL,
	id_edition			SMALLINT			NOT NULL,
	id_saison			SMALLINT			NOT NULL,
	id_serie			SMALLINT			NOT NULL,
	usure				SMALLINT			CHECK(usure between 0 and 100),
	prix				DECIMAL(7,2)		NOT NULL,
	CONSTRAINT			fk_stock_pa_s		FOREIGN KEY(id_product_s, id_edition, id_saison, id_serie) REFERENCES stock_s(id_product_s, id_edition, id_saison, id_serie)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	CONSTRAINT			pk_stock_pa_s		PRIMARY KEY(id_product_s, id_edition, id_saison, id_serie)
);

CREATE TABLE stock_pl_s
(
	id_product_s		SMALLINT			NOT NULL,
	id_edition			SMALLINT			NOT NULL,
	id_saison			SMALLINT			NOT NULL,
	id_serie			SMALLINT			NOT NULL,
	usure				SMALLINT			CHECK(usure between 0 and 100),
	prix				DECIMAL(7,2)		NOT NULL,
	dispo				VARCHAR(3)			CHECK(lower(dispo) in ('yes', 'no')),
	reserve				VARCHAR(4)			CHECK(lower(reserve) in ('res', 'dispo')),
	CONSTRAINT			fk_stock_pl_s		FOREIGN KEY(id_product_s, id_edition, id_saison, id_serie) REFERENCES stock_s(id_product_s, id_edition, id_saison, id_serie)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	CONSTRAINT			pk_stock_pl_s		PRIMARY KEY(id_product_s, id_edition, id_saison, id_serie)
);

CREATE TABLE voix_f
(
	id_product_f		SMALLINT			NOT NULL,
	id_edition			SMALLINT			NOT NULL,
	id_film				SMALLINT			NOT NULL,
	id_langue			SMALLINT			REFERENCES langue(id_langue)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	CONSTRAINT			fk_voix_f			FOREIGN KEY(id_product_f, id_edition, id_film) REFERENCES stock_f(id_product_f, id_edition, id_film),
	CONSTRAINT			pk_voix_f			PRIMARY KEY(id_product_f, id_edition, id_film, id_langue)
);

CREATE TABLE voix_s
(
	id_product_s		SMALLINT			NOT NULL,
	id_edition			SMALLINT			NOT NULL,
	id_saison			SMALLINT			NOT NULL,
	id_serie			SMALLINT			NOT NULL,
	id_langue			SMALLINT			REFERENCES langue(id_langue)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	CONSTRAINT			fk_voix_s			FOREIGN KEY(id_product_s, id_edition, id_saison, id_serie) REFERENCES stock_s(id_product_s, id_edition, id_saison, id_serie),
	CONSTRAINT			pk_voix_s			PRIMARY KEY(id_product_s, id_edition, id_saison, id_serie, id_langue)
);

CREATE TABLE sous_titre_f
(
	id_product_f		SMALLINT			NOT NULL,
	id_edition			SMALLINT			NOT NULL,
	id_film				SMALLINT			NOT NULL,
	id_langue			SMALLINT			REFERENCES langue(id_langue)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	CONSTRAINT			fk_sous_titre_f		FOREIGN KEY(id_product_f, id_edition, id_film) REFERENCES stock_f(id_product_f, id_edition, id_film),
	CONSTRAINT			pk_sous_titre_f		PRIMARY KEY(id_product_f, id_edition, id_film, id_langue)
);

CREATE TABLE sous_titre_s
(
	id_product_s		SMALLINT			NOT NULL,
	id_edition			SMALLINT			NOT NULL,
	id_saison			SMALLINT			NOT NULL,
	id_serie			SMALLINT			NOT NULL,
	id_langue			SMALLINT			REFERENCES langue(id_langue)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	CONSTRAINT			fk_sous_titre_s		FOREIGN KEY(id_product_s, id_edition, id_saison, id_serie) REFERENCES stock_s(id_product_s, id_edition, id_saison, id_serie),
	CONSTRAINT			pk_sous_titre_s		PRIMARY KEY(id_product_s, id_edition, id_saison, id_serie, id_langue)
);

CREATE TABLE retard_s
(
	id_product_s		SMALLINT			NOT NULL,
	id_edition			SMALLINT			NOT NULL,
	id_saison			SMALLINT			NOT NULL,
	id_serie			SMALLINT			NOT NULL,
	id_cli				SMALLINT			REFERENCES client(id_cli)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	grade				SMALLINT			CHECK(grade between 1 and 10),
	CONSTRAINT			fk_retard_s			FOREIGN KEY(id_product_s, id_edition, id_saison, id_serie) REFERENCES stock_s(id_product_s, id_edition, id_saison, id_serie)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	CONSTRAINT			pk_retard_s			PRIMARY KEY(id_product_s, id_edition, id_serie, id_cli)
);
CREATE TABLE retard_f
(
	id_product_f		SMALLINT			NOT NULL,
	id_film				SMALLINT			NOT NULL,
	id_edition			SMALLINT			NOT NULL,
	id_cli				SMALLINT			REFERENCES client(id_cli)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	grade				SMALLINT			CHECK(grade between 1 and 10),
	CONSTRAINT			fk_retard_f			FOREIGN KEY(id_product_f, id_edition, id_film) REFERENCES stock_f(id_product_f, id_edition, id_film)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	CONSTRAINT			pk_retard_f			PRIMARY KEY(id_product_f, id_edition, id_film, id_cli)
);

CREATE TABLE souscrit
(
	id_cli				SMALLINT			REFERENCES client(id_cli)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	id_abo				SMALLINT			REFERENCES abonnement(id_abo)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	date_debut			DATE				NOT NULL,
	date_fin			DATE				NOT NULL,
	CONSTRAINT			pk_souscrit			PRIMARY KEY(id_cli, id_abo, date_debut)
);

CREATE TABLE location_n_f
(
	id_product_f		SMALLINT			NOT NULL,
	id_edition			SMALLINT			NOT NULL,
	id_film				SMALLINT			NOT NULL,
	id_cli				SMALLINT			REFERENCES client(id_cli)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	date_debut			DATE				NOT NULL,
	date_fin			DATE				NOT NULL,
	CONSTRAINT			fk_location_n_f		FOREIGN KEY(id_product_f, id_edition, id_film) REFERENCES stock_n_f(id_product_f, id_edition, id_film)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	CONSTRAINT			pk_location_n_f		PRIMARY KEY(id_product_f, id_edition, id_film, id_cli, date_debut)
);

CREATE TABLE location_n_s
(
	id_product_s		SMALLINT			NOT NULL,
	id_edition			SMALLINT			NOT NULL,
	id_saison			SMALLINT			NOT NULL,
	id_serie			SMALLINT			NOT NULL,
	id_cli				SMALLINT			REFERENCES client(id_cli)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	date_debut			DATE				NOT NULL,
	date_fin			DATE				NOT NULL,
	CONSTRAINT			fk_location_n_s 	FOREIGN KEY(id_product_s, id_edition, id_saison, id_serie) REFERENCES stock_n_s(id_product_s, id_edition, id_saison, id_serie)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	CONSTRAINT			pk_location_n_s		PRIMARY KEY(id_product_s, id_edition, id_saison, id_serie, id_cli, date_debut)
);

CREATE TABLE location_p_f
(
	id_product_f		SMALLINT			NOT NULL,
	id_edition			SMALLINT			NOT NULL,
	id_film				SMALLINT			NOT NULL,
	id_cli				SMALLINT			REFERENCES client(id_cli)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	date_debut			DATE				NOT NULL,
	date_fin			DATE				NOT NULL,
	CONSTRAINT			fk_location_p_f		FOREIGN KEY(id_product_f, id_edition, id_film) REFERENCES stock_pl_f(id_product_f, id_edition, id_film)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	CONSTRAINT			pk_location_p_f		PRIMARY KEY(id_product_f, id_edition, id_film, id_cli, date_debut)
);

CREATE TABLE location_p_s
(
	id_product_s		SMALLINT			NOT NULL,
	id_edition			SMALLINT			NOT NULL,
	id_saison			SMALLINT			NOT NULL,
	id_serie			SMALLINT			NOT NULL,
	id_cli				SMALLINT			REFERENCES client(id_cli)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	date_debut			DATE				NOT NULL,
	date_fin			DATE				NOT NULL,
	CONSTRAINT			fk_location_p_s		FOREIGN KEY(id_product_s, id_edition, id_saison, id_serie) REFERENCES stock_pl_s(id_product_s, id_edition, id_saison, id_serie)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	CONSTRAINT			pk_location_p_s		PRIMARY KEY(id_product_s, id_edition, id_saison, id_serie, id_cli, date_debut)
);

CREATE TABLE achat_n_f
(
	id_product_f		SMALLINT			NOT NULL,
	id_edition			SMALLINT			NOT NULL,
	id_film				SMALLINT			NOT NULL,
	id_cli				SMALLINT			REFERENCES client(id_cli)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	date_achat			DATE				NOT NULL,
	CONSTRAINT			fk_achat_n_f		FOREIGN KEY(id_product_f, id_edition, id_film) REFERENCES stock_n_f(id_product_f, id_edition, id_film)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	CONSTRAINT			pk_achat_n_f		PRIMARY KEY(id_product_f, id_edition, id_film, id_cli, date_achat)
);

CREATE TABLE achat_n_s
(
	id_product_s		SMALLINT			NOT NULL,
	id_edition			SMALLINT			NOT NULL,
	id_saison			SMALLINT			NOT NULL,
	id_serie			SMALLINT			NOT NULL,
	id_cli				SMALLINT			REFERENCES client(id_cli)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	date_achat			DATE				NOT NULL,
	CONSTRAINT			fk_achat_n_s 		FOREIGN KEY(id_product_s, id_edition, id_saison, id_serie) REFERENCES stock_n_s(id_product_s, id_edition, id_saison, id_serie)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	CONSTRAINT			pk_achat_n_s		PRIMARY KEY(id_product_s, id_edition, id_saison, id_serie, id_cli, date_achat)
);

CREATE TABLE achat_p_f
(
	id_product_f		SMALLINT			NOT NULL,
	id_edition			SMALLINT			NOT NULL,
	id_film				SMALLINT			NOT NULL,
	id_cli				SMALLINT			REFERENCES client(id_cli)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	date_achat			DATE				NOT NULL,
	CONSTRAINT			fk_achat_p_f		FOREIGN KEY(id_product_f, id_edition, id_film) REFERENCES stock_pa_f(id_product_f, id_edition, id_film)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	CONSTRAINT			pk_achat_p_f		PRIMARY KEY(id_product_f, id_edition, id_film, id_cli, date_achat)
);

CREATE TABLE achat_p_s
(
	id_product_s		SMALLINT			NOT NULL,
	id_edition			SMALLINT			NOT NULL,
	id_saison			SMALLINT			NOT NULL,
	id_serie			SMALLINT			NOT NULL,
	id_cli				SMALLINT			REFERENCES client(id_cli)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	date_achat			DATE				NOT NULL,
	CONSTRAINT			fk_achat_p_s		FOREIGN KEY(id_product_s, id_edition, id_saison, id_serie) REFERENCES stock_pa_s(id_product_s, id_edition, id_saison, id_serie)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	CONSTRAINT			pk_achat_p_s		PRIMARY KEY(id_product_s, id_edition, id_saison, id_serie, id_cli, date_achat)
);

CREATE TABLE joue_dans_f
(
	id_act				SMALLINT			REFERENCES acteur(id_act)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	id_film				SMALLINT			REFERENCES film(id_film)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	role_act			VARCHAR(20)			NOT NULL,
	CONSTRAINT			pk_joue_dans_f		PRIMARY KEY(id_act, id_film, role_act)
);

CREATE TABLE joue_dans_s
(
	id_act				SMALLINT			REFERENCES acteur(id_act)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	id_episode			SMALLINT			NOT NULL,
	id_saison			SMALLINT			NOT NULL,
	id_serie			SMALLINT			NOT NULL,
	role_act			VARCHAR(20)			NOT NULL,
	CONSTRAINT			fk_joue_dans_s		FOREIGN KEY(id_episode, id_saison, id_serie) REFERENCES episode(id_episode, id_saison, id_serie)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	CONSTRAINT			pk_joue_dans_s		PRIMARY KEY(id_act, id_episode, id_saison, id_serie, role_act)
);

CREATE TABLE recoit_solo_act
(
	id_act				SMALLINT				REFERENCES acteur(id_act)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	id_distinct			SMALLINT				REFERENCES distinction(id_distinct)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	date_reception		DATE					NOT NULL,
	CONSTRAINT			pk_recoit_solo_act		PRIMARY KEY(id_act, id_distinct, date_reception)
);

CREATE TABLE recoit_solo_rea
(
	id_rea				SMALLINT				REFERENCES realisateur(id_rea)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	id_distinct			SMALLINT				REFERENCES distinction(id_distinct)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	date_reception		DATE					NOT NULL,
	CONSTRAINT			pk_recoit_solo_rea		PRIMARY KEY(id_rea, id_distinct, date_reception)
);


CREATE TABLE recoit_rea
(
	id_rea				SMALLINT				REFERENCES realisateur(id_rea)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	id_distinct			SMALLINT				REFERENCES distinction(id_distinct)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	id_film				SMALLINT				REFERENCES film(id_film)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	date_reception		DATE					NOT NULL,
	CONSTRAINT			pk_recoit_rea			PRIMARY KEY(id_rea, id_distinct, id_film, date_reception)
);

CREATE TABLE recoit_act
(
	id_act				SMALLINT				REFERENCES realisateur(id_rea)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	id_distinct			SMALLINT				REFERENCES distinction(id_distinct)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	id_film				SMALLINT				REFERENCES film(id_film)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	date_reception		DATE					NOT NULL,
	CONSTRAINT			pk_recoit_act			PRIMARY KEY(id_act, id_distinct, id_film, date_reception)
);

CREATE TABLE realise_f
(
	id_film				SMALLINT				REFERENCES film(id_film)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	id_rea				SMALLINT				REFERENCES realisateur(id_rea)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	CONSTRAINT			pk_realise_f			PRIMARY KEY(id_film, id_rea)
);

CREATE TABLE realise_s
(
	id_rea				SMALLINT			REFERENCES realisateur(id_rea)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	id_episode			SMALLINT			NOT NULL,
	id_saison			SMALLINT			NOT NULL,
	id_serie			SMALLINT			NOT NULL,
	CONSTRAINT			fk_realise_s		FOREIGN KEY(id_episode, id_saison, id_serie) REFERENCES episode(id_episode, id_saison, id_serie)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	CONSTRAINT			pk_realise_s		PRIMARY KEY(id_rea, id_episode, id_saison, id_serie)
);

/*
INSERT INTO client VALUES();
INSERT INTO client VALUES();
INSERT INTO client VALUES();
INSERT INTO client VALUES();
INSERT INTO client VALUES();
INSERT INTO client VALUES();
INSERT INTO client VALUES();
INSERT INTO client VALUES();
INSERT INTO client VALUES();
INSERT INTO client VALUES();
INSERT INTO client VALUES();


INSERT INTO abonnement VALUES();
INSERT INTO abonnement VALUES();
INSERT INTO abonnement VALUES();

INSERT INTO acteur VALUES();
INSERT INTO acteur VALUES();
INSERT INTO acteur VALUES();
INSERT INTO acteur VALUES();
INSERT INTO acteur VALUES();
INSERT INTO acteur VALUES();
INSERT INTO acteur VALUES();
INSERT INTO acteur VALUES();
INSERT INTO acteur VALUES();
INSERT INTO acteur VALUES();
INSERT INTO acteur VALUES();

INSERT INTO realisateur VALUES();
INSERT INTO realisateur VALUES();
INSERT INTO realisateur VALUES();
INSERT INTO realisateur VALUES();
INSERT INTO realisateur VALUES();
INSERT INTO realisateur VALUES();
INSERT INTO realisateur VALUES();
INSERT INTO realisateur VALUES();
INSERT INTO realisateur VALUES();
INSERT INTO realisateur VALUES();
INSERT INTO realisateur VALUES();

INSERT INTO distinction VALUES();
INSERT INTO distinction VALUES();
INSERT INTO distinction VALUES();
INSERT INTO distinction VALUES();
INSERT INTO distinction VALUES();
INSERT INTO distinction VALUES();
INSERT INTO distinction VALUES();
INSERT INTO distinction VALUES();

INSERT INTO langue VALUES();
INSERT INTO langue VALUES();
INSERT INTO langue VALUES();
INSERT INTO langue VALUES();
INSERT INTO langue VALUES();
INSERT INTO langue VALUES();
INSERT INTO langue VALUES();
INSERT INTO langue VALUES();
INSERT INTO langue VALUES();

INSERT INTO serie VALUES();
INSERT INTO serie VALUES();

INSERT INTO saison VALUES();
INSERT INTO saison VALUES();
INSERT INTO saison VALUES();
INSERT INTO saison VALUES();
INSERT INTO saison VALUES();
INSERT INTO saison VALUES();

INSERT INTO episode VALUES();
INSERT INTO episode VALUES();
INSERT INTO episode VALUES();
INSERT INTO episode VALUES();
INSERT INTO episode VALUES();
INSERT INTO episode VALUES();
INSERT INTO episode VALUES();
INSERT INTO episode VALUES();
INSERT INTO episode VALUES();
INSERT INTO episode VALUES();
INSERT INTO episode VALUES();
INSERT INTO episode VALUES();
INSERT INTO episode VALUES();
INSERT INTO episode VALUES();
INSERT INTO episode VALUES();
INSERT INTO episode VALUES();
INSERT INTO episode VALUES();
INSERT INTO episode VALUES();
INSERT INTO episode VALUES();
INSERT INTO episode VALUES();
INSERT INTO episode VALUES();

INSERT INTO edition_s VALUES();
INSERT INTO edition_s VALUES();
INSERT INTO edition_s VALUES();
INSERT INTO edition_s VALUES();
INSERT INTO edition_s VALUES();
INSERT INTO edition_s VALUES();

INSERT INTO film VALUES();
INSERT INTO film VALUES();
INSERT INTO film VALUES();
INSERT INTO film VALUES();
INSERT INTO film VALUES();
INSERT INTO film VALUES();

INSERT INTO edition_f VALUES();
INSERT INTO edition_f VALUES();
INSERT INTO edition_f VALUES();
INSERT INTO edition_f VALUES();
INSERT INTO edition_f VALUES();
INSERT INTO edition_f VALUES();

INSERT INTO stock_f VALUES();
INSERT INTO stock_f VALUES();
INSERT INTO stock_f VALUES();
INSERT INTO stock_f VALUES();
INSERT INTO stock_f VALUES();
INSERT INTO stock_f VALUES();

INSERT INTO stock_n_f VALUES();
INSERT INTO stock_n_f VALUES();
INSERT INTO stock_n_f VALUES();
INSERT INTO stock_n_f VALUES();

INSERT INTO stock_pa_f VALUES();
INSERT INTO stock_pa_f VALUES();
INSERT INTO stock_pa_f VALUES();

INSERT INTO stock_pl_f VALUES();
INSERT INTO stock_pl_f VALUES();
INSERT INTO stock_pl_f VALUES();
INSERT INTO stock_pl_f VALUES();
INSERT INTO stock_pl_f VALUES();
INSERT INTO stock_pl_f VALUES();

INSERT INTO stock_s VALUES();
INSERT INTO stock_s VALUES();

INSERT INTO stock_n_s VALUES();
INSERT INTO stock_n_s VALUES();
INSERT INTO stock_n_s VALUES();
INSERT INTO stock_n_s VALUES();

INSERT INTO stock_pa_s VALUES();
INSERT INTO stock_pa_s VALUES();
INSERT INTO stock_pa_s VALUES();

INSERT INTO stock_pl_s VALUES();
INSERT INTO stock_pl_s VALUES();
INSERT INTO stock_pl_s VALUES();
INSERT INTO stock_pl_s VALUES();
INSERT INTO stock_pl_s VALUES();
INSERT INTO stock_pl_s VALUES();

INSERT INTO voix_f VALUES();
INSERT INTO voix_f VALUES();
INSERT INTO voix_f VALUES();
INSERT INTO voix_f VALUES();
INSERT INTO voix_f VALUES();
INSERT INTO voix_f VALUES();
INSERT INTO voix_f VALUES();
INSERT INTO voix_f VALUES();
INSERT INTO voix_f VALUES();
INSERT INTO voix_f VALUES();
INSERT INTO voix_f VALUES();

INSERT INTO voix_s VALUES();
INSERT INTO voix_s VALUES();
INSERT INTO voix_s VALUES();
INSERT INTO voix_s VALUES();
INSERT INTO voix_s VALUES();
INSERT INTO voix_s VALUES();
INSERT INTO voix_s VALUES();
INSERT INTO voix_s VALUES();
INSERT INTO voix_s VALUES();
INSERT INTO voix_s VALUES();
INSERT INTO voix_s VALUES();
INSERT INTO voix_s VALUES();
INSERT INTO voix_s VALUES();
INSERT INTO voix_s VALUES();
INSERT INTO voix_s VALUES();
INSERT INTO voix_s VALUES();
INSERT INTO voix_s VALUES();
INSERT INTO voix_s VALUES();
INSERT INTO voix_s VALUES();
INSERT INTO voix_s VALUES();
INSERT INTO voix_s VALUES();
INSERT INTO voix_s VALUES();
INSERT INTO voix_s VALUES();

INSERT INTO sous_titre_f VALUES();
INSERT INTO sous_titre_f VALUES();
INSERT INTO sous_titre_f VALUES();
INSERT INTO sous_titre_f VALUES();
INSERT INTO sous_titre_f VALUES();

INSERT INTO sous_titre_s VALUES();
INSERT INTO sous_titre_s VALUES();
INSERT INTO sous_titre_s VALUES();
INSERT INTO sous_titre_s VALUES();
INSERT INTO sous_titre_s VALUES();
INSERT INTO sous_titre_s VALUES();
INSERT INTO sous_titre_s VALUES();
INSERT INTO sous_titre_s VALUES();
INSERT INTO sous_titre_s VALUES();
INSERT INTO sous_titre_s VALUES();
INSERT INTO sous_titre_s VALUES();
INSERT INTO sous_titre_s VALUES();
INSERT INTO sous_titre_s VALUES();

INSERT INTO retard_s VALUES();
INSERT INTO retard_s VALUES();
INSERT INTO retard_s VALUES();

INSERT INTO retard_f VALUES();
INSERT INTO retard_f VALUES();

INSERT INTO souscrit VALUES();
INSERT INTO souscrit VALUES();
INSERT INTO souscrit VALUES();
INSERT INTO souscrit VALUES();
*/
