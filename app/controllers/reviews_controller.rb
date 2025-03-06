class ReviewsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def analyze
    text = params[:text]
    gemini_service = GeminiSentimentService.new
    sentiment = gemini_service.analyze_sentiment(text)

    if sentiment
      render json: { sentiment: sentiment}
    else
      render json: { error: 'Sentiment analysis failed', models: models }, status: :unprocessable_entity
    end
  end
end