
# Block requests from same IP address if they make more than 5 requests in 10 seconds
Rack::Attack.throttle('req/ip', limit: 20, period: 10) do |request| 
    request.ip
end