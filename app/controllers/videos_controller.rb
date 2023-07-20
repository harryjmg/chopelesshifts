class VideosController < ApplicationController

    def index
        @videos = Video.all
        @user_videos = UserVideo.where(user: current_user)
        @uncompleted_video = current_user.user_videos.where(is_complete: false).first
    end

    def complete
        user_video = UserVideo.find_by(user: current_user, video_id: params[:id])
        if user_video
            user_video.update(is_complete: true)
            flash[:success] = "Vidéo complétée avec succès!"
        else
            flash[:error] = "Vidéo non trouvée ou non accessible"
        end
        redirect_to videos_path
    end
end
