module ApplicationHelper
    def button_active_to(name = nil, options = nil, html_options = nil, &block)
        html_options = {} if html_options.nil?
        if current_page?(options)
            html_options[:class] = "#{html_options[:class]} active"
        end
        button_to(name, options, html_options, &block)
    end

    def evaluate_performance(count)
        case count
        when 0..4
            "(bouuh nul)"
        when 5..9
            "(peux mieux faire)"
        when 10..12
            "(pas mal)"
        else
            "(bravo, champion!)"
        end
    end
end
