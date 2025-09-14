class DramasController < ApplicationController
  def index
    @dramas = Drama.all
    @dramas = @dramas.title_search(params[:title])
    @dramas = @dramas.cast_search(params[:cast])
    @dramas = @dramas.emotion_search(params[:emotion])
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def recommend
    emotion_counts current_user.watched_dramas
                               .joins(:tags)
                               .group("tags.name")
                               .count
    
    emotions = ["笑い", "胸キュン", "癒し", "共感"]
    emotion_counts = emotions.map { |e| [e, emotion_counts[e] || 0] }.to_h

    @lacking_emotion = emotion_counts.min_by { |_, count| count }.first
    @recommend_dramas = Drama.joins(:tags)
                             .where(tags: { name: @lacking_emotion})
                             .limit(5)
  end
end
