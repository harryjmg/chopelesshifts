
Documentation API pour chopelesshifts.fr
=======================

Hey, ici se trouve la documentation de l'**API REST** simplifiée de chopelesshifts.fr.


### Authentification

Toutes les requêtes de l'API doivent être authentifiées à l'aide du token d'API généré via l'interface utilisateur. L'authentification doit être effectuée en incluant le header `Authorization: Bearer YOUR_API_TOKEN` dans chaque requête.

### Plannings

- **Liste des plannings disponibles pour un utilisateur**

  - Endpoint: `GET /api/v1/plannings`
  - Requête:
    ```
    curl -X GET "http://localhost:3000/api/v1/plannings" -H "Authorization: Bearer YOUR_API_TOKEN"
    ```
  - Réponse:
    ```json
    [
      {
        "id": "X05fNV",
        "planning_type": "daily",
        "state": "available",
        "published_at": "2023-07-07T08:46:45.215Z"
      },
      {
        "id": "e6bdK2",
        "planning_type": "permanent",
        "state": "available",
        "published_at": "2023-07-07T08:37:54.353Z"
      },
      {
        "id": "j9KDf4",
        "planning_type": "weekly",
        "state": "available",
        "published_at": "2023-07-07T08:47:58.611Z"
      }
    ]
    ```

- **Détails d'un planning spécifique**

  - Endpoint: `GET /api/v1/plannings/:planning_id`
  - Requête:
    ```
    curl -X GET "http://localhost:3000/api/v1/plannings/:planning_id" -H "Authorization: Bearer YOUR_API_TOKEN"
    ```
  - Réponse:
    ```json
    {
      "id": "X05fNV",
      "planning_type": "daily",
      "state": "available",
      "published_at": "2023-07-07T08:46:45.215Z"
      // autres attributs du planning...
    }
    ```

### Shifts

- **Liste des shifts disponibles pour un planning**

  - Endpoint: `GET /api/v1/plannings/:planning_id/shifts`
  - Requête:
    ```
    curl -X GET "http://localhost:3000/api/v1/plannings/:planning_id/shifts" -H "Authorization: Bearer YOUR_API_TOKEN"
    ```
  - Réponse:
    ```json
    [
      {
        "id": "lqQFnY",
        "day": "mardi",
        "start_hour": "2000-01-01T08:00:00.000Z",
        "end_hour": "2000-01-01T14:00:00.000Z",
        "seats": 10,
        "seats_taken": 1
      },
      {
        "id": "x2OFW1",
        "day": "lundi",
        "start_hour": "2000-01-01T08:00:00.000Z",
        "end_hour": "2000-01-01T14:00:00.000Z",
        "seats": 12,
        "seats_taken": 0
      },
      // autres shifts...
    ]
    ```

### Reservations

- **Liste des réservations d'un utilisateur sur un planning**

  - Endpoint: `GET /api/v1/plannings/:planning_id/reservations`
  - Requête:
    ```
    curl -X GET "http://localhost:3000/api/v1/plannings/:planning_id/reservations" -H "Authorization: Bearer YOUR_API_TOKEN"
    ```
  - Réponse:
    ```json
    [
      {
        "id": 103,
        "user_id": 5,
        "shift_id": "lqQFnY",
        // autres attributs de la réservation...
      },
      {
        "id": 104,
        "user_id": 5,
        "shift_id": "x2OFW1",
        // autres attributs de la réservation...
      },
      // autres réservations...
    ]
    ```

- **Créer une réservation sur un shift**

  - Endpoint: `POST /api/v1/plannings/:planning_id/shifts/:shift_id/reservations`
  - Requête:
    ```
    curl -X POST "http://localhost:3000/api/v1/plannings/:planning_id/shifts/:shift_id/reservations" -H "Authorization: Bearer YOUR_API_TOKEN"
    ```
  - Réponse: La réservation est créée avec succès.

- **Supprimer une réservation d'un utilisateur sur un shift**

  - Endpoint: `DELETE /api/v1/plannings/:planning_id/shifts/:shift_id/reservations/:reservation_id`
  - Requête:
    ```
    curl -X DELETE "http://localhost:3000/api/v1/plannings/:planning_id/shifts/:shift_id/reservations/:reservation_id" -H "Authorization: Bearer YOUR_API_TOKEN"
    ```
  - Réponse: La réservation est supprimée avec succès.

N'hésitez pas à ajuster cette documentation en fonction de vos besoins spécifiques et à ajouter d'autres endpoints si nécessaire.