achievements_data = [
    {
        name: "Il est des nôtres",
        description: "Activer son compte sur la plateforme Shift Heroes.",
        points: 30,
        icon: "fa-users",
        key: "account_activation",
        position: 4
    },
    {
        name: "T’as capté !",
        description: "Réserver un premier créneau dans un planning d’entraînement (daily ou permanent).",
        points: 10,
        icon: "fa-calendar-check",
        key: "first_booking",
        position: 5
    },
    {
        name: "C’est mignon !",
        description: "Réussir à réserver un créneau hebdomadaire via l’interface du site.",
        points: 10,
        icon: "fa-smile-beam",
        key: "first_weekly_booking",
        position: 6
    },
    {
        name: "La clé des champs",
        description: "Obtenir son premier token pour l’API.",
        points: 20,
        icon: "fa-key",
        key: "first_api_token",
        position: 7
    },
    {
        name: "C’est émouvant non ?",
        description: "Faire une première requête API qui fonctionne.",
        points: 20,
        icon: "fa-heart",
        key: "first_successful_api_call",
        position: 8
    },
    {
        name: "Tu deviens quelqu’un ici !",
        description: "Réserver un premier créneau via API sur un planning d’entraînement (daily ou permanent).",
        points: 20,
        icon: "fa-user-check",
        key: "first_api_booking",
        position: 10
    },
    {
        name: "Il l’a fait !",
        description: "Réussir à réserver un créneau sur un planning hebdomadaire via l’API.",
        points: 20,
        icon: "fa-trophy",
        key: "first_weekly_api_booking",
        position: 11
    },
    {
        name: "Chaîne de requêtes",
        description: "Réussir à enchaîner 3 requêtes API sans utiliser curl.",
        points: 20,
        icon: "fa-link",
        key: "chained_api_calls_without_curl",
        position: 12
    },
    {
        name: "Rapide comme l’éclair",
        description: "Réussir à lister les créneaux disponibles sur un planning daily ou weekly moins de 5 secondes après sa publication.",
        points: 20,
        icon: "fa-bolt",
        key: "fast_listing_without_curl",
        position: 13
    },
    {
        name: "Tu forces",
        description: "Atteindre la limite maximum des appels API.",
        points: 20,
        icon: "fa-bomb",
        key: "api_limit_reached",
        position: 14
    },
    {
        name: "Lucky luke",
        description: "Réussir à réserver un créneau sur un planning daily ou weekly moins de 5 secondes après sa publication.",
        points: 20,
        icon: "fa-horse",
        key: "fast_booking_without_curl",
        position: 16
    },
    {
        name: "L’élu",
        description: "Réussir à réserver 14 créneaux sur un planning hebdomadaire via l’API.",
        points: 20,
        icon: "fa-star",
        key: "booked_14_slots_via_api",
        position: 20
    }
]


puts "Creating achievements..."
achievements_data.each do |achievement_data|
    achievement = Achievement.find_or_initialize_by(key: achievement_data[:key])
    achievement.update(
        name: achievement_data[:name],
        description: achievement_data[:description],
        points: achievement_data[:points],
        icon: achievement_data[:icon],
        position: achievement_data[:position]
    )
end

puts "Creating videos..."
videos_data = [
    {
        title: "1 - Environnement de travail et API",
        description: "Dans cette vidéo, nous allons voir pourquoi ce projet est intéressant et comment installer votre environnement de travail. Nous allons également voir ce qu’est une API et comment obtenir votre token API.",
        url: "https://www.loom.com/share/cfeba1f6a40e462198d44e0048b055e8?sid=293081b1-c223-4bf6-918d-5fc0d22c3023",
        unlocked_by: "account_activation"
    },
    {
        title: "2 - Introduction aux requêtes via CURL",
        description: "Dans cette vidéo, nous allons voir comment faire des requêtes et lire les réponses.",
        url: "https://www.loom.com/share/714a92de0b614f80bc69f97d387fa85a?sid=c8593912-202c-4a59-83e4-27a3f465ad58",
        unlocked_by: "first_api_token"
    },
    {
        title: "3 - Réserver un créneau via l'API",
        description: "Dans cette vidéo, nous allons voir comment réserver un créneau via l’API.",
        url: "https://www.loom.com/share/77cffc96d5564359b17950a5ea5e3fd7?sid=445803b0-afd4-490e-ac26-0260427f81c8",
        unlocked_by: "first_successful_api_call"
    },
    {
        title: "4 - Passer de Curl à Python",
        description: "Dans cette vidéo, nous allons voir comment passer de Curl à un langage de programmation et utiliser les variables.",
        url: "https://www.loom.com/share/0e8cf2117869429e840dddef7d3d2bb8?sid=529511f3-25ad-41bd-86d8-1612dc65f736",
        unlocked_by: "first_api_booking"
    },
    {
        title: "5 - Détecter la sortie d'un planning",
        description: "Dans cette vidéo, nous allons voir comment détecter la sortie d’un planning.",
        url: "https://www.loom.com/share/e35aaccfb9744a8b994deee254b552f1?sid=995a5946-26a3-4c91-a38f-94c22f9f45ad",
        unlocked_by: "chained_api_calls_without_curl"
    },
    {
        title: "6 - Réservation rapide d'un créneau",
        description: "Dans cette vidéo, nous allons voir comment prendre un créneau dès sa sortie.",
        url: "https://www.loom.com/share/e35aaccfb9744a8b994deee254b552f1?sid=995a5946-26a3-4c91-a38f-94c22f9f45ad",
        unlocked_by: "fast_listing_without_curl"
    },
    {
        title: "7 - Récupérer tous les créneaux instantanément",
        description: "Dans cette vidéo, nous allons voir comment tout relier pour prendre tous les créneaux de la semaine.",
        url: "https://www.loom.com/share/e35aaccfb9744a8b994deee254b552f1?sid=995a5946-26a3-4c91-a38f-94c22f9f45ad",
        unlocked_by: "fast_booking_without_curl"
    },
    {
        title: "8 - Félicitaitons !",
        description: "Dans cette vidéo, on va fêter tes résultats ensemble et parler de la suite.",
        url: "https://www.loom.com/share/e35aaccfb9744a8b994deee254b552f1?sid=995a5946-26a3-4c91-a38f-94c22f9f45ad",
        unlocked_by: "booked_14_slots_via_api"
    }
]

videos_data.each do |video_data|
    video = Video.find_or_initialize_by(unlocked_by: video_data[:unlocked_by])
    video.update(
        title: video_data[:title],
        description: video_data[:description],
        url: video_data[:url]
    )
end

puts "Create user videos..."
# Create user videos for each user that has the achievement linked

User.all.each do |user|
    user.user_achievements.each do |user_achievement|
        video = Video.find_by(unlocked_by: user_achievement.achievement.key)
        if video
            UserVideo.find_or_create_by(user: user, video: video)
        end
    end
end
