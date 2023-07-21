class VideosController < ApplicationController
    before_action :set_video, only: %i[ show complete uncomplete ]
    before_action :check_onboarding

    def index
        @videos = Video.all.order(:title => :asc)
        @user_videos = UserVideo.where(user: current_user)

        if params[:id]
            @video = Video.find(params[:id])
            @user_video = UserVideo.find_by(video_id: params[:id], user: current_user)
            if @user_video.nil?
                redirect_to videos_path, alert: "Vous n'avez pas accès à cette vidéo"
            end
        else
            @user_video = @user_videos.find_by(is_complete: false)
            @user_video ||= @user_videos.last
            @video = @user_video.video if @user_video
        end
    end

    def ultimate_advice
    end

    def complete
        user_video = UserVideo.find_by(user: current_user, video_id: @video.id)
        if user_video
            user_video.update(is_complete: true)
            flash[:success] = "Vidéo complétée avec succès!"
        else
            flash[:error] = "Vidéo non trouvée ou non accessible"
        end
        redirect_to videos_path(id: @video.id)
    end

    def uncomplete
        user_video = UserVideo.find_by(user: current_user, video_id: @video.id)
        if user_video
            user_video.update(is_complete: false)
            flash[:success] = "Vidéo décomplétée avec succès!"
        else
            flash[:error] = "Vidéo non trouvée ou non accessible"
        end
        redirect_to videos_path(id: @video.id)
    end

    private

    def set_video
        @video = Video.find(params[:id])
    end
end
