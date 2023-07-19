if Rails.env.production?
    Dkim::domain      = 'shiftheroes.fr'
    Dkim::selector    = 'mail'
    Dkim::private_key = ENV.fetch('DKIM_PRIVATE_KEY', nil)
end