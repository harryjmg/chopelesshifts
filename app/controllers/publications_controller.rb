class PublicationsController < ApplicationController

    def check
        last_publication = Publication.last
        is_published = last_publication && last_publication.is_recent

        render json: { published: is_published }, status: :ok
    end

end