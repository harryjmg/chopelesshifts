
Documentation API pour chopelesshifts.fr
=======================

Hey, ici se trouve la documentation de l'**API REST** simplifiée de chopelesshifts.fr.
Elle utilise le **format JSON** dans ses réponses et pour l'authentification c'est du **basique HTTP.**

Faire une requête
----------------

Toutes les requêtes seront faites vers un lien qui commence par `https://chopelesshifts.fr/api/v1`, dans le jargon des API on appelle ça l'url de base ou base url en anglais.

Pour faire une requête, il faut ajouter à cette url de base le chemin de la ressource que tu recherches. 

Si tu veux lire la liste des plannings (une requête GET) :
`curl -u email:password https://chopelesshifts.fr/api/v1/plannings`

Si tu veux réserver un créneau qui a l'id 350 dans le planning 113 c'est un peu plus long mais c'est le même concept (c'est une requête POST) :

```
curl -u email:password \
	-H 'Content-Type: application/json' \
	-d '{ "shift_id": 350 }' \
	https://chopelesshifts.fr/api/v1/plannings/113/reservations
```
Tu vois le truc ?


N'oublie pas de t'identifier
-----------------------

Pas d'identifiants = pas de chocolat. Plus sérieusement toutes les requêtes ont besoin de tes identifiants pour être validées, et pour les envoyer tu dois utiliser l'authentification basique HTTP (comme sur les exemples au dessus).


Tu as des erreurs ?
-----------------------

Si le site web est en galère pour X ou Y raisons, tu verras une erreur 5xx (qui peut aller de 500 à 599). Les erreurs 5xx sont des erreurs du côté serveur, donc de notre côté. Soit ta requête a provoquée une erreur interne, soit le site web a un soucis en ce moment. Dans tous les cas si tu vois une erreur 5XX, tu peux nous le signaler sur support@joincodingnow.com (n'oublie pas de copie coller le code d'erreur).

Pour toutes les autres erreurs, c'est surement toi qui est entrain de faire une connerie, alors vérifie bien ta requête.


Limitations de requêtes
-----------------------
Il existe une limite de 20 requêtes par 10 secondes pour la même adresse IP. Si tu dépasses la limite, tu recevras une erreur 429 "Too many requests".