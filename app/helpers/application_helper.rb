module ApplicationHelper
    def button_active_to(name = nil, options = nil, html_options = nil, &block)
        html_options = {} if html_options.nil?
        if current_page?(options)
            html_options[:class] = "#{html_options[:class]} active"
        end
        button_to(name, options, html_options, &block)
    end

    def evaluate_performance(count)
        comments = [
            ["(nul)", "(bouuh)", "(claqué)", "(à chier)", "(pitoyable)", "(nullos)", "(la honte)"],
            ["(pas terrible)", "(bof)", "(moyen)", "(pas fou)", "(pas top)", "(passable)"],
            ["(presque!)", "(respectable!)", "(c'est ton max ?)"],
            ["(tu es l'élu)", "(t'as géré)", "(tu triches ?)", "(génie)", "(exceptionnel)", "(wow)", "(godlike)", "(incroyable)"]
        ]

        case count
        when 0..4
            comments[0].sample
        when 5..9
            comments[1].sample
        when 10..12
            comments[2].sample
        else
            comments[3].sample
        end
    end
end
