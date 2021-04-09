-------------------------------------------------------------------------------
--CLIENT
-------------------------------------------------------------------------------
CREATE PROCEDURE INSERT_cli
	@nom			VARCHAR(20),
	@prenom			VARCHAR(20),
	@date_naissance	DATE,
	@adresse		VARCHAR(40),
	@ville			VARCHAR(40),
	@CP				SMALLINT,
	@mail			VARCHAR(40),
	@tel			SMALLINT,
	@CB				SMALLINT,
	@mod			VARCHAR(6)
AS
BEGIN TRY
	INSERT INTO client(nom,prenom,date_naissance,adresse,ville,CP,mail,tel,CB)
	VALUES(@nom, @prenom, @date_naissance, @adresse, @ville, @CP, @mail, @tel, @CB);
	print('INSERTed');
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS errornumber, ERROR_MESSAGE() AS errormessage;
END CATCH
GO
-------------------------------------------------------------------------------
CREATE PROCEDURE update_cli
	@id_cli			SMALLINT,
	@nom			VARCHAR(20),
	@prenom			VARCHAR(20),
	@date_naissance	DATE,
	@adresse		VARCHAR(40),
	@ville			VARCHAR(40),
	@CP				SMALLINT,
	@mail			VARCHAR(40),
	@tel			SMALLINT,
	@CB				SMALLINT,
	@mod			VARCHAR(6)
AS
BEGIN TRY
	UPDATE client
	SET nom = @nom, prenom = @prenom, DATE_naissance = @date_naissance,
	adresse = @adresse, ville = @ville, CP = @CP, mail = @mail, tel = @tel, CB = @CB
	WHERE id_cli = @id_cli;
	print('updated');
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS errornumber, ERROR_MESSAGE() AS errormessage;
END CATCH
GO 
-------------------------------------------------------------------------------
CREATE PROCEDURE SELECT_delete_cli
	@id		SMALLINT,
	@mod	VARCHAR(6)
AS
BEGIN TRY
	 if @mod = 'Select'
		BEGIN
			SELECT *
			FROM client
			WHERE id_cli = @id;
		END
	else if @mod = 'Delete'  
		BEGIN
			DELETE FROM client WHERE id_cli = @id;
			print('deleted')
		END
	else
		print('error : please SELECT a mod.')
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS errornumber, ERROR_MESSAGE() AS errormessage;
END CATCH
GO
-------------------------------------------------------------------------------
--ABONNEMENT
-------------------------------------------------------------------------------
CREATE PROCEDURE INSERT_abo
	@type_abo	VARCHAR(20),
	@prix		decimal(4,2),
	@nb_loc		SMALLINT,
	@nb_film_g	SMALLINT
AS
BEGIN TRY
	INSERT INTO abonnement(type_abo, prix, nb_loc, nb_film_g)
	VALUES (@type_abo, @prix, @nb_loc, @nb_film_g)
	print('INSERTed');
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS errornumber, ERROR_MESSAGE() AS errormessage;
END CATCH
GO
-------------------------------------------------------------------------------
CREATE PROCEDURE update_abo
	@id			SMALLINT,	
	@type_abo	VARCHAR(20),
	@prix		decimal(4,2),
	@nb_loc		SMALLINT,
	@nb_film_g	SMALLINT
AS
BEGIN TRY
	UPDATE abonnement
	SET type_abo = @type_abo, prix = @prix, nb_loc = @nb_loc, nb_film_g = @nb_film_g
	WHERE id_abo = @id;
	print('updated');
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS errornumber, ERROR_MESSAGE() AS errormessage;
END CATCH
GO
-------------------------------------------------------------------------------
CREATE PROCEDURE SELECT_delete_abo
	@id		SMALLINT,
	@mod	VARCHAR(6)
AS
BEGIN TRY
	 if @mod = 'SELECT'
		BEGIN
			SELECT *
			FROM abonnement
			WHERE id_abo = @id;
		END
	else if @mod = 'delete'  
		BEGIN
			DELETE FROM abonnement WHERE id_abo = @id;
			print('deleted')
		END
	else
		print('error : please SELECT a mod.')
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS errornumber, ERROR_MESSAGE() AS errormessage;
END CATCH
GO
-------------------------------------------------------------------------------
--ACTEUR
-------------------------------------------------------------------------------
CREATE PROCEDURE INSERT_act
	@nom			VARCHAR(50),
	@prenom			VARCHAR(50),
	@date_naissance	DATE
AS
BEGIN TRY
	INSERT INTO acteur(nom, prenom, date_naissance)
	VALUES (@nom, @prenom, @date_naissance)
	print('INSERTed');
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS errornumber, ERROR_MESSAGE() AS errormessage;
END CATCH
GO
-------------------------------------------------------------------------------
CREATE PROCEDURE update_act
	@id				SMALLINT,	
	@nom			VARCHAR(50),
	@prenom			VARCHAR(50),
	@date_naissance	DATE
AS
BEGIN TRY
	UPDATE acteur
	SET nom = @nom, prenom = @prenom, date_naissance = @date_naissance
	WHERE id_act = @id;
	print('updated');
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS errornumber, ERROR_MESSAGE() AS errormessage;
END CATCH
GO
-------------------------------------------------------------------------------
CREATE PROCEDURE SELECT_delete_act
	@id		SMALLINT,
	@mod	VARCHAR(6)
AS
BEGIN TRY
	 if @mod = 'SELECT'
		BEGIN
			SELECT *
			FROM acteur
			WHERE id_act = @id;
		END
	else if @mod = 'delete'  
		BEGIN
			DELETE FROM acteur WHERE id_act = @id;
			print('deleted')
		END
	else
		print('error : please SELECT a mod.')
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS errornumber, ERROR_MESSAGE() AS errormessage;
END CATCH
GO
-------------------------------------------------------------------------------
--REALISATEUR
-------------------------------------------------------------------------------
CREATE PROCEDURE INSERT_rea
	@nom			VARCHAR(50),
	@prenom			VARCHAR(50),
	@date_naissance DATE
AS
BEGIN TRY
	INSERT INTO realisateur(nom, prenom, date_naissance)
	VALUES (@nom, @prenom, @date_naissance)
	print('INSERTed');
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS errornumber, ERROR_MESSAGE() AS errormessage;
END CATCH
GO
-------------------------------------------------------------------------------
CREATE PROCEDURE update_rea
	@id				SMALLINT,	
	@nom			VARCHAR(50),
	@prenom			VARCHAR(50),
	@date_naissance	DATE
AS
BEGIN TRY
	UPDATE realisateur
	SET nom = @nom, prenom = @prenom, date_naissance = @date_naissance
	WHERE id_rea = @id;
	print('updated');
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS errornumber, ERROR_MESSAGE() AS errormessage;
END CATCH
GO
-------------------------------------------------------------------------------
CREATE PROCEDURE SELECT_delete_rea
	@id		SMALLINT,
	@mod	VARCHAR(6)
AS
BEGIN TRY
	 if @mod = 'SELECT'
		BEGIN
			SELECT *
			FROM realisateur
			WHERE id_rea = @id;
		END
	else if @mod = 'delete'  
		BEGIN
			DELETE FROM realisateur WHERE id_rea = @id;
			print('deleted')
		END
	else
		print('error : please SELECT a mod.')
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS errornumber, ERROR_MESSAGE() AS errormessage;
END CATCH
GO
-------------------------------------------------------------------------------
--DISTINCTION
-------------------------------------------------------------------------------
CREATE PROCEDURE INSERT_distinct
	@type_d		VARCHAR(20),
	@categorie	VARCHAR(20)
AS
BEGIN TRY
	INSERT INTO distinction(type_d, categorie)
	VALUES (@type_d, @categorie)
	print('INSERTed');
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS errornumber, ERROR_MESSAGE() AS errormessage;
END CATCH
GO
-------------------------------------------------------------------------------
CREATE PROCEDURE update_distinct
	@id			SMALLINT,	
	@type_d		VARCHAR(20),
	@categorie	VARCHAR(20)
AS
BEGIN TRY
	UPDATE distinction
	SET type_d = @type_d, categorie = @categorie
	WHERE id_distinct = @id;
	print('updated');
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS errornumber, ERROR_MESSAGE() AS errormessage;
END CATCH
GO
-------------------------------------------------------------------------------
CREATE PROCEDURE SELECT_delete_distinct
	@id		SMALLINT,
	@mod	VARCHAR(6)
AS
BEGIN TRY
	 if @mod = 'SELECT'
		BEGIN
			SELECT *
			FROM distinction
			WHERE id_distinct = @id;
		END
	else if @mod = 'delete'  
		BEGIN
			DELETE FROM distinction WHERE id_distinct = @id;
			print('deleted')
		END
	else
		print('error : please SELECT a mod.')
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS errornumber, ERROR_MESSAGE() AS errormessage;
END CATCH
GO
-------------------------------------------------------------------------------
--LANGUE
-------------------------------------------------------------------------------
CREATE PROCEDURE INSERT_lang
	@lang	VARCHAR(20)
AS
BEGIN TRY
	INSERT INTO langue(langue)
	VALUES (@lang)
	print('INSERTed');
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS errornumber, ERROR_MESSAGE() AS errormessage;
END CATCH
GO
-------------------------------------------------------------------------------
CREATE PROCEDURE update_lang
	@id		SMALLINT,	
	@lang	VARCHAR(20)
AS
BEGIN TRY
	UPDATE langue
	SET langue = @lang 
	WHERE id_langue = @id;
	print('updated');
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS errornumber, ERROR_MESSAGE() AS errormessage;
END CATCH
GO
-------------------------------------------------------------------------------
CREATE PROCEDURE SELECT_delete_lang
	@id		SMALLINT,
	@mod	VARCHAR(6)
AS
BEGIN TRY
	 if @mod = 'SELECT'
		BEGIN
			SELECT *
			FROM langue
			WHERE id_langue = @id;
		END
	else if @mod = 'delete'  
		BEGIN
			DELETE FROM langue WHERE id_langue = @id;
			print('deleted')
		END
	else
		print('error : please SELECT a mod.')
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS errornumber, ERROR_MESSAGE() AS errormessage;
END CATCH
GO
-------------------------------------------------------------------------------
--SERIE
-------------------------------------------------------------------------------
CREATE PROCEDURE INSERT_serie
	@date_sortie	DATE,
	@genre			VARCHAR(20),
	@id_langue 		SMALLINT
AS
BEGIN TRY
	INSERT INTO serie(date_sortie, genre, id_langue)
	VALUES (@date_sortie, @genre, @id_langue);
	print('INSERTed')
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS errornumber, ERROR_MESSAGE() AS errormessage;
END CATCH
GO
-------------------------------------------------------------------------------
CREATE PROCEDURE update_serie
	@id				SMALLINT,
	@date_sortie	DATE,
	@genre			VARCHAR(20),
	@id_langue 		SMALLINT
AS
BEGIN TRY
	UPDATE serie
	SET date_sortie = @date_sortie, genre = @genre, id_langue = @id_langue
	WHERE id_serie = @id;
	print('updated');
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS errornumber, ERROR_MESSAGE() AS errormessage;
END CATCH
GO
-------------------------------------------------------------------------------
CREATE PROCEDURE SELECT_delete_serie
	@id		SMALLINT,
	@mod	VARCHAR(6)
AS
BEGIN TRY
	 if @mod = 'SELECT'
		BEGIN
			SELECT *
			FROM serie
			WHERE id_serie = @id;
		END
	else if @mod = 'delete'  
		BEGIN
			DELETE FROM serie WHERE id_serie = @id;
			print('deleted')
		END
	else
		print('error : please SELECT a mod.')
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS errornumber, ERROR_MESSAGE() AS errormessage;
END CATCH
GO
-------------------------------------------------------------------------------
--SAISON
-------------------------------------------------------------------------------
CREATE PROCEDURE INSERT_saison
	@id_serie		SMALLINT,
	@synopsis		VARCHAR(300),
	@nom			VARCHAR(20),
	@date_sortie 	DATE
AS
BEGIN TRY
	INSERT INTO saison(id_serie, synopsis, nom, date_sortie)
	VALUES (@id_serie, @synopsis, @nom, @date_sortie);
	print ('INSERTed')
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS errornumber, ERROR_MESSAGE() AS errormessage;
END CATCH
GO
-------------------------------------------------------------------------------
CREATE PROCEDURE update_saison
	@id_saison		SMALLINT,
	@id_serie		SMALLINT,
	@synopsis		VARCHAR(300),
	@nom			VARCHAR(20),
	@date_sortie 	DATE
AS
BEGIN TRY
	UPDATE saison
	SET id_serie = @id_serie, synopsis = @synopsis, nom = @nom, date_sortie = @date_sortie 
	WHERE id_saison = @id_saison;
	print('updated');
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS errornumber, ERROR_MESSAGE() AS errormessage;
END CATCH
GO
-------------------------------------------------------------------------------
CREATE PROCEDURE SELECT_delete_saison
	@id		SMALLINT,
	@mod	VARCHAR(6)
AS
BEGIN TRY
	 if @mod = 'SELECT'
		BEGIN
			SELECT *
			FROM saison
			WHERE id_saison = @id;
		END
	else if @mod = 'delete'  
		BEGIN
			DELETE FROM saison WHERE id_saison = @id;
			print('deleted')
		END
	else
		print('error : please SELECT a mod.')
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS errornumber, ERROR_MESSAGE() AS errormessage;
END CATCH
GO
-------------------------------------------------------------------------------
--EPISODE
-------------------------------------------------------------------------------
CREATE PROCEDURE INSERT_episode
	@id_saison	SMALLINT,
	@id_serie	SMALLINT,
	@synopsis	VARCHAR(300),
	@duree		TIME,
	@nom		VARCHAR(20)
AS
BEGIN TRY
	INSERT INTO episode(id_saison, id_serie, synopsis, duree, nom)
	VALUES (@id_saison, @id_serie, @synopsis, @duree, @nom);
	print ('INSERTed')
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS errornumber, ERROR_MESSAGE() AS errormessage;
END CATCH
GO
-------------------------------------------------------------------------------
CREATE PROCEDURE update_episode
	@id_episode	SMALLINT,
	@id_saison	SMALLINT,
	@id_serie	SMALLINT,
	@synopsis	VARCHAR(300),
	@duree		TIME,
	@nom		VARCHAR(20)
AS
BEGIN TRY
	UPDATE episode
	SET id_saison = @id_saison, id_serie = @id_serie, synopsis = @synopsis, duree = @duree, nom = @nom
	WHERE id_episode = @id_episode;
	print('updated');
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS errornumber, ERROR_MESSAGE() AS errormessage;
END CATCH
GO
-------------------------------------------------------------------------------
CREATE PROCEDURE SELECT_delete_episode
	@id		SMALLINT,
	@mod	VARCHAR(6)
AS
BEGIN TRY
	 if @mod = 'SELECT'
		BEGIN
			SELECT *
			FROM episode
			WHERE id_episode = @id;
		END
	else if @mod = 'delete'  
		BEGIN
			DELETE FROM episode WHERE id_episode = @id;
			print('deleted')
		END
	else
		print('error : please SELECT a mod.')
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS errornumber, ERROR_MESSAGE() AS errormessage;
END CATCH
GO
-------------------------------------------------------------------------------
--EDITION_S
-------------------------------------------------------------------------------
CREATE PROCEDURE INSERT_edition_s
	@id_saison		SMALLINT,
	@id_serie		SMALLINT,
	@nom			VARCHAR(20),
	@date_sortie	DATE,
	@version_s		VARCHAR(20)
AS
BEGIN TRY
	INSERT INTO edition_s(id_saison, id_serie, nom, date_sortie, version_s)
	VALUES (@id_saison, @id_serie, @nom, @date_sortie, @version_s);
	print ('INSERTed')
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS errornumber, ERROR_MESSAGE() AS errormessage;
END CATCH
GO
-------------------------------------------------------------------------------
CREATE PROCEDURE update_edition_s
	@id_edition		SMALLINT,
	@id_saison		SMALLINT,
	@id_serie		SMALLINT,
	@nom			VARCHAR(20),
	@date_sortie	DATE,
	@version_s		VARCHAR(20)
AS
BEGIN TRY
	UPDATE edition_s
	SET id_saison = @id_saison, id_serie = @id_serie, nom = @nom,
	date_sortie = @date_sortie, version_s = @version_s
	WHERE id_edition = @id_edition;
	print('updated');
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS errornumber, ERROR_MESSAGE() AS errormessage;
END CATCH
GO
-------------------------------------------------------------------------------
CREATE PROCEDURE SELECT_delete_edition_s
	@id		SMALLINT,
	@mod	VARCHAR(6)
AS
BEGIN TRY
	 if @mod = 'SELECT'
		BEGIN
			SELECT *
			FROM edition_s
			WHERE id_edition = @id;
		END
	else if @mod = 'delete'  
		BEGIN
			DELETE FROM edition_s WHERE id_edition = @id;
			print('deleted')
		END
	else
		print('error : please SELECT a mod.')
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS errornumber, ERROR_MESSAGE() AS errormessage;
END CATCH
GO
-------------------------------------------------------------------------------
--FILM
-------------------------------------------------------------------------------
CREATE PROCEDURE INSERT_film
	@genre			VARCHAR(20),
	@date_sortie	DATE,
	@synopsis		VARCHAR(500),
	@duree			TIME,
	@titre			VARCHAR(40),
	@id_langue		SMALLINT
AS
BEGIN TRY
	INSERT INTO film(genre, date_sortie, synopsis, duree, titre, id_langue)
	VALUES (@genre, @date_sortie, @synopsis, @duree, @titre, @id_langue);
	print ('INSERTed')
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS errornumber, ERROR_MESSAGE() AS errormessage;
END CATCH
GO
-------------------------------------------------------------------------------
CREATE PROCEDURE update_film
	@id_film		SMALLINT,
	@genre			VARCHAR(20),
	@date_sortie	DATE,
	@synopsis		VARCHAR(500),
	@duree			TIME,
	@titre			VARCHAR(40),
	@id_langue		SMALLINT
AS
BEGIN TRY
	UPDATE film
	SET genre = @genre, date_sortie = @date_sortie, synopsis = @synopsis,
	duree = @duree, titre = @titre, id_langue = @id_langue
	WHERE id_film = @id_film;
	print('updated');
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS errornumber, ERROR_MESSAGE() AS errormessage;
END CATCH
GO
-------------------------------------------------------------------------------
CREATE PROCEDURE SELECT_delete_film
	@id		SMALLINT,
	@mod	VARCHAR(6)
AS
BEGIN TRY
	 if @mod = 'SELECT'
		BEGIN
			SELECT *
			FROM film
			WHERE id_film = @id;
		END
	else if @mod = 'delete'  
		BEGIN
			DELETE FROM film WHERE id_film = @id;
			print('deleted')
		END
	else
		print('error : please SELECT a mod.')
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS errornumber, ERROR_MESSAGE() AS errormessage;
END CATCH
GO
-------------------------------------------------------------------------------
--EDITION_F
-------------------------------------------------------------------------------
CREATE PROCEDURE INSERT_edition_f
	@id_film		SMALLINT,
	@nom			VARCHAR(50),
	@version_f		VARCHAR(20),
	@date_sortie	DATE
AS
BEGIN TRY
	INSERT INTO edition_f(id_film, nom, version_f, date_sortie)
	VALUES (@id_film, @nom, @version_f, @date_sortie);
	print ('INSERTed')
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS errornumber, ERROR_MESSAGE() AS errormessage;
END CATCH
GO
-------------------------------------------------------------------------------
CREATE PROCEDURE update_edition_f
	@id_edition		SMALLINT,
	@id_film		SMALLINT,
	@nom			VARCHAR(50),
	@version_f		VARCHAR(20),
	@date_sortie	DATE
AS
BEGIN TRY
	UPDATE edition_f
	SET id_film = @id_film, nom = @nom, version_f = @version_f, date_sortie = @date_sortie
	WHERE  id_edition = @id_edition;
	print('updated');
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS errornumber, ERROR_MESSAGE() AS errormessage;
END CATCH
GO
-------------------------------------------------------------------------------
CREATE PROCEDURE SELECT_delete_edition_f
	@id		SMALLINT,
	@mod	VARCHAR(6)
AS
BEGIN TRY
	 if @mod = 'SELECT'
		BEGIN
			SELECT *
			FROM edition_f
			WHERE id_edition = @id;
		END
	else if @mod = 'delete'  
		BEGIN
			DELETE FROM edition_f WHERE id_edition = @id;
			print('deleted')
		END
	else
		print('error : please SELECT a mod.')
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS errornumber, ERROR_MESSAGE() AS errormessage;
END CATCH
GO
-------------------------------------------------------------------------------
--STOCK_F
-------------------------------------------------------------------------------
CREATE PROCEDURE INSERT_stock_f
	@id_edition		SMALLINT,
	@id_film		SMALLINT,
	@format			VARCHAR(20)
AS
BEGIN TRY
	INSERT INTO stock_f(id_edition, id_film, format)
	VALUES (@id_edition, @id_film, @format);
	print ('INSERTed')
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS errornumber, ERROR_MESSAGE() AS errormessage;
END CATCH
GO
-------------------------------------------------------------------------------
CREATE PROCEDURE update_stock_f
	@id_product_f	SMALLINT,
	@id_edition		SMALLINT,
	@id_film		SMALLINT,
	@format			VARCHAR(20)
AS
BEGIN TRY
	UPDATE stock_f
	SET id_edition = @id_edition, id_film = @id_film, format = @format
	WHERE  id_product_f = @id_product_f;
	print('updated');
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS errornumber, ERROR_MESSAGE() AS errormessage;
END CATCH
GO
-------------------------------------------------------------------------------
CREATE PROCEDURE SELECT_delete_stock_f
	@id		SMALLINT,
	@mod	VARCHAR(6)
AS
BEGIN TRY
	 if @mod = 'SELECT'
		BEGIN
			SELECT *
			FROM stock_f
			WHERE id_product_f = @id;
		END
	else if @mod = 'delete'  
		BEGIN
			DELETE FROM stock_f WHERE id_product_f = @id;
			print('deleted')
		END
	else
		print('error : please SELECT a mod.')
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS errornumber, ERROR_MESSAGE() AS errormessage;
END CATCH
GO
-------------------------------------------------------------------------------
--STOCK_N_F
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--STOCK_PA_F
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--STOCK_PL_F
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--STOCK_S
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--STOCK_N_S
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--STOCK_PA_S
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--STOCK_PL_S
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--VOIX_F
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--VOIX_S
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--SOUS_TITRE_F
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--SOUS_TITRE_S
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--ACHAT_NUM_F
-------------------------------------------------------------------------------
CREATE PROCEDURE  achat_num_f
	@id_product	SMALLINT,
	@id_edition	SMALLINT,
	@id_film	SMALLINT,
	@id_cli		SMALLINT
AS
	DECLARE @date DATE
BEGIN TRY
	SET @date = GETDATE()
	INSERT INTO achat_n_f(id_product_f, id_edition, id_film, id_cli, date_achat)
	VALUES(@id_product, @id_edition, @id_film, @id_cli, @date);
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS errornumber, ERROR_MESSAGE() AS errormessage;
END CATCH
GO
-------------------------------------------------------------------------------
--ACHAT_NUM_S
-------------------------------------------------------------------------------
CREATE PROCEDURE  achat_num_s 
	@id_product	SMALLINT,
	@id_edition	SMALLINT,
	@id_saison	SMALLINT,
	@id_serie	SMALLINT,
	@id_cli		SMALLINT
AS
DECLARE @date DATE 
BEGIN TRY
	SET @date = GETDATE()
	INSERT INTO achat_n_s(id_product_s, id_edition, id_saison, id_serie, id_cli, date_achat)
	VALUES(@id_product, @id_edition, @id_saison, @id_serie, @id_cli, @date);
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS errornumber, ERROR_MESSAGE() AS errormessage;
END CATCH
GO
-------------------------------------------------------------------------------
--ACHAT_PHY_F
-------------------------------------------------------------------------------
CREATE PROCEDURE  achat_phy_f 
	@id_product_f	SMALLINT,
	@id_edition		SMALLINT,
	@id_film		SMALLINT,
	@id_cli			SMALLINT
AS
DECLARE @date DATE
BEGIN TRY
	SET @date = GETDATE()
	INSERT INTO achat_p_f(id_product_f, id_edition, id_film, id_cli, date_achat)
	VALUES(@id_product_f, @id_edition, @id_film, @id_cli, @date);
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS errornumber, ERROR_MESSAGE() AS errormessage;
END CATCH
GO
-------------------------------------------------------------------------------
--ACHAT_PHY_S
-------------------------------------------------------------------------------
CREATE PROCEDURE  achat_phy_s 
	@id_product_s	SMALLINT,
	@id_edition		SMALLINT,
	@id_saison		SMALLINT,
	@id_serie		SMALLINT,
	@id_cli			SMALLINT
AS
DECLARE @date DATE
BEGIN TRY
	SET @date = GETDATE()
	INSERT INTO achat_p_s(id_product_s, id_edition, id_saison, id_serie, id_cli, date_achat)
	VALUES(@id_product_s, @id_edition, @id_saison, @id_serie, @id_cli, @date);
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS errornumber, ERROR_MESSAGE() AS errormessage;
END CATCH
GO
-------------------------------------------------------------------------------
--LOCATION
--------------------------------------------------------------------------------
/*location_p_sans_abo(nom_X, nom, prenom, date_naissance, X)
	- existance_client
	- interdiction_client_retard
	- liste_edition_from_nom_X
	- edition_louable
	- louer_produit

existance_client(nom, prenom, date_naissance)
	* requete : return (id_client/null)

interdiction_client_retard(id_client)
	*if(count_retard(id_client) > 3 || max_grade_retard(id_client) > 2)
		retrun true
	else
		return false

edition_louable(id_edition_x)
	- recuperer_id_product_from_id_edition_x(id_edition_x)
	- cursor (dispo_location(id_product))

dispo_location(id_produit)
	*if(check stock_pl_X.dispo == 'yes')
		return true
	else
		return false

--on recupere la liste des : [id_edition,film,nom_edition,annee,format], le client choisi, on recupere l'id_edition du choix du client et on l'insere en argumenent de la procedure edition_louable(id_edition).

liste_edition_from_nom_X(nom)
	- liste des : [id_edition,film,nom_edition,annee,format]

louer_produit(id_produit, id_client,X)
	if(X==s)
	*insert value into table location_pl_s
	else if(X==f)
	*insert value into table location_pl_f
	else
	print('probleme serie ou film ??!! erreur de location.')

rendre_product(id_product, X)
	*stock_pl_X.id_produit.dispo = 'yes'*/