achievements_data = [
    {
        name: "Il est des nôtres",
        description: "Activer son compte sur la plateforme Shift Heroes.",
        icon: "fa-users",
        key: "account_activation"
    },
    {
        name: "T’as capté !",
        description: "Réserver un premier créneau dans un planning d’entraînement (daily ou permanent).",
        icon: "fa-calendar-check",
        key: "first_booking"
    },
    {
        name: "C’est mignon !",
        description: "Réussir à réserver un créneau hebdomadaire via l’interface du site.",
        icon: "fa-smile-beam",
        key: "first_weekly_booking"
    },
    {
        name: "La clé des champs",
        description: "Obtenir un token pour accéder l’API",
        icon: "fa-key",
        key: "first_api_token"
    },
    {
        name: "C’est émouvant non ?",
        description: "Faire une première requête API qui fonctionne (code 2XX)",
        icon: "fa-heart",
        key: "first_successful_api_call"
    },
    {
        name: "Tu deviens quelqu’un ici !",
        description: "Réserver un premier créneau via API sur un planning d’entraînement (daily ou permanent).",
        icon: "fa-user-check",
        key: "first_api_booking"
    },
    {
        name: "Il l’a fait !",
        description: "Réussir à réserver un créneau sur un planning daily ou weekly via l’API.",
        icon: "fa-trophy",
        key: "first_weekly_api_booking"
    },
    {
        name: "Listeur de plannings Python",
        description: "Réussir à lister les plannings disponibles en utilisant Python.",
        icon: "fa-list",
        key: "list_plannings_with_python"
    },
    {
        name: "Listeur de créneaux Python",
        description: "Réussir à lister les créneaux disponibles sur un planning daily ou weekly en utilisant Python.",
        icon: "fa-list",
        key: "list_shifts_with_python"
    },
    {
        name: "Réserveur de créneaux Python",
        description: "Réussir à réserver un créneau sur un planning daily ou weekly en utilisant Python.",
        icon: "fa-calendar-check",
        key: "book_shift_with_python"
    },
    {
        name: "Chaîne de requêtes",
        description: "Enchaîner les requêtes `lister les plannings`, `lister les créneaux` et `réserver un créneau` en moins de 2 secondes en utilisant Python.",
        icon: "fa-link",
        key: "chained_api_calls_without_curl"
    },
    {
        name: "Rapide comme l’éclair",
        description: "Réussir à lister les créneaux disponibles sur un planning daily ou weekly moins de 5 secondes après sa publication.",
        icon: "fa-bolt",
        key: "fast_listing_without_curl"
    },
    {
        name: "La boucle",
        description: "Faire 20 appels API en moins de 10 secondes.",
        icon: "fa-infinity",
        key: "20_api_calls_in_10_seconds"
    },
    {
        name: "Tu forces",
        description: "Atteindre la limite maximum des appels API.",
        icon: "fa-bomb",
        key: "api_limit_reached"
    },
    {
        name: "Lucky luke",
        description: "Réussir à réserver un créneau sur un planning daily ou weekly moins de 5 secondes après sa publication.",
        icon: "fa-horse",
        key: "fast_booking_without_curl"
    },
    {
        name: "Vice élu",
        description: "Réussir à réserver 7 créneaux sur un planning daily ou weekly via l’API dans les 10 secondes après publication.",
        icon: "fa-star-half-alt",
        key: "booked_7_slots_via_api"
    },
    {
        name: "L’élu",
        description: "Réussir à réserver 14 créneaux sur un planning daily ou weekly via l’API dans les 10 secondes après publication.",
        icon: "fa-star",
        key: "booked_14_slots_via_api"
    },
    {
        name: "Il ira loin",
        description: "Envoyer sa candidature pour tenter de rejoindre le programme Coding Accelerator.",
        icon: "fa-rocket",
        key: "apply_for_coding_accelerator"
    }
]

videos_data = [
    {
        title: "Hello, API 👋",
        description: "Tranquilou. On fait juste connaissance avec la notion d'API dans le contexte de notre objectif. Et pourquoi utiliser l'API finalement ?",
        url: "https://www.loom.com/share/592b4639f79f450db93fab24d2926132",
        objectives: ["first_api_token"],
        resources: [],
        custom_id: "environment_and_api"
    },
    {
        title: "Rencontrer Curl",
        description: "Ça y est, vos premières requêtes API sont arrivées. On va voir comment vous pouver utiliser la commande Curl pour ça.",
        url: "https://www.loom.com/share/66abca1de10445b8a31e30c2cf1eca05",
        objectives: ["first_successful_api_call"],
        resources: [
            {title: "Curl Converter", url: "https://curlconverter.com"}
        ],
        custom_id: "curl_introduction"
    },
    {
        title: "Passer par l'API",
        description: "Dans cette vidéo, nous allons voir comment réserver un créneau en passant uniquement par l’API.",
        url: "https://www.loom.com/share/03aec0f53e05471581a5da961bb5d17c",
        objectives: ["first_api_booking"],
        resources: [
            {title: "JSON formatter", url: "https://jsonformatter.curiousconcept.com"}
        ],
        custom_id: "first_api_booking"
    },
    {
        title: "Charmer le Python",
        description: "Dans cette vidéo, on va voir comment passer de Curl à un langage de programmation et utiliser les variables.",
        url: "https://www.loom.com/share/72f70b7703614cb98538831faf86df23",
        objectives: ["chained_api_calls_without_curl"],
        resources: [],
        custom_id: "curl_to_python"
    },
    {
        title: "Détecter les changements",
        description: "Dans cette vidéo, on va voir comment détecter la sortie d’un planning.",
        url: "https://www.loom.com/share/9e90305ae1144c29b4e2a452691bf8f5",
        objectives: ["fast_listing_without_curl"],
        resources: [
            {title: "Cours complet sur Python", url: "https://www.youtube.com/watch?v=LamjAFnybo0"}
        ],
        custom_id: "detect_planning_release"
    },
    {
        title: "800€ par semaine",
        description: "Dans cette vidéo, on va voir comment tout relier pour prendre tous les créneaux de la semaine.",
        url: "https://www.loom.com/share/5b728c749615422d9e988d618d3fc84d",
        objectives: ["booked_14_slots_via_api"],
        resources: [],
        custom_id: "book_all_slots"
    },
    {
        title: "Félicitations 🎉",
        description: "Dans cette vidéo, on va fêter tes résultats ensemble et parler de ce qui t'attend pour la suite.",
        url: "https://www.loom.com/share/538981e65d674fd5808cabf924c749ad",
        objectives: ["apply_for_coding_accelerator"],
        resources: [
            {title: "Candidater pour Coding Accelerator", url: "https://tally.so/r/w7LbZz"}
        ],
        custom_id: "congratulations"
    }
]

puts "Creating achievements..."
achievements_data.each do |achievement_data|
    achievement = Achievement.find_or_initialize_by(key: achievement_data[:key])
    achievement.update(
        name: achievement_data[:name],
        description: achievement_data[:description],
        icon: achievement_data[:icon]
    )
end

puts "Creating videos..."
videos_data.each_with_index do |video_data, index|
    video = Video.find_or_initialize_by(custom_id: video_data[:custom_id])
    video.update(
        description: video_data[:description],
        url: video_data[:url],
        custom_id: video_data[:custom_id],
        title: video_data[:title],
        resources: video_data[:resources]
    )

    # Set achievements
    video.achievements = video_data[:objectives].map { |objective| Achievement.find_by(key: objective) }
end

puts "Add previous and next video to all videos..."
videos_data.each_with_index do |video_data, index|
    video = Video.find_or_initialize_by(custom_id: video_data[:custom_id])
    video.update(
        previous_video: (index > 0) ? Video.find_by(custom_id: videos_data[index - 1][:custom_id]) : nil,
        next_video: (index < videos_data.length - 1) ? Video.find_by(custom_id: videos_data[index + 1][:custom_id]) : nil
    )
end

puts "Set user videos based on achievements of users..."
User.all.each do |user|
    Video.all.each do |video|
        if user.has_all_achievements_for(video)
            user_video = UserVideo.find_or_initialize_by(user: user, video: video)
        end
    end

    user.update(current_level: user.user_videos.where(is_complete: true).count)
end