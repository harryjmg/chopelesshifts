class VideosController < ApplicationController
    before_action :set_video, only: %i[ show seen unseen complete ]
    before_action :require_login
    before_action :check_onboarding

    def index
        @videos = Video.all.to_a.sort_by { |video| Video::CUSTOM_IDS_IN_ORDER.index(video.custom_id) }
        @user_videos = UserVideo.where(user: current_user)

        if params[:id]
            @video = Video.find(params[:id])
            @user_video = UserVideo.find_by(video_id: params[:id], user: current_user) if @video
            if @user_video.nil? || @video.nil?
                redirect_to videos_path, alert: "Vous n'avez pas accès à cette vidéo"
            else
                @user_video.update(is_seen: true) if @user_video.is_seen == false
            end
        else
            @user_video = @user_videos.where(is_complete: false).first
            @user_video ||= @user_videos.last
            @video = @user_video.video
            @user_video.update(is_seen: true) if @user_video.is_seen == false
        end

        @is_completable = @user_video && !@user_video.is_complete && current_user.has_all_achievements_for(@video)
    end

    def ultimate_advice
    end

    def seen
        user_video = UserVideo.find_by(user: current_user, video_id: @video.id)
        
        if user_video
            user_video.update(is_seen: true)
            flash[:success] = "Vidéo marquée comme vue !"
        else
            flash[:error] = "Vidéo non trouvée ou non accessible"
        end
        redirect_to videos_path(id: @video.id)
    end

    def unseen
        user_video = UserVideo.find_by(user: current_user, video_id: @video.id)
        
        if user_video
            user_video.update(is_seen: false)
        else
            flash[:error] = "Vidéo non trouvée ou non accessible"
        end
        redirect_to videos_path(id: @video.id)
    end

    def complete
        user_video = UserVideo.find_by(user: current_user, video_id: @video.id)

        if current_user.complete_video(@video)
            flash[:success] = "Vidéo marquée comme complétée !"
        else
            flash[:error] = "Apparemment, ce n'est pas possible."
        end

        redirect_to videos_path
    end

    private

    def set_video
        @video = Video.find(params[:id])
    end
end
