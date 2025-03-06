# app/services/gemini_sentiment_service.rb

require 'net/http'
require 'uri'
require 'json'
require 'httparty' #if you choose to use httparty
require 'dotenv-rails'

class GeminiSentimentService
  API_KEY = ENV['GEMINI_API_KEY'] # Store your API key in environment variables
  API_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=#{API_KEY}"

  
  def analyze_sentiment(text)
    prompt = "Analyze the sentiment of the following text and return either 'positive', 'negative', or 'neutral':\n\n#{text}"
    payload = {
      "contents": [{
        "parts": [{ "text": prompt }]
      }]
    }.to_json

    begin
      response = HTTParty.post(
        API_URL,
        headers: { 'Content-Type' => 'application/json' },
        body: payload
      )
      if response.success?
        result = JSON.parse(response.body)
        sentiment = result.dig('candidates', 0, 'content', 'parts', 0, 'text')
        return sentiment.downcase.strip if sentiment
      else
        Rails.logger.error("Gemini API Error: #{response.code} - #{response.body}")
        return nil
      end
    rescue StandardError => e
      Rails.logger.error("Gemini API Request Failed: #{e.message}")
      return nil
    end
  end

  #Alternative method using net/http
  def analyze_sentiment_net_http(text)
    prompt = "Analyze the sentiment of the following text and return either 'positive', 'negative', or 'neutral':\n\n#{text}"
    uri = URI.parse(API_URL)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.request_uri, 'Content-Type' => 'application/json')
    request.body = {
      "contents": [{
        "parts": [{ "text": prompt }]
      }]
    }.to_json

    begin
      response = http.request(request)
      if response.is_a?(Net::HTTPSuccess)
        result = JSON.parse(response.body)
        sentiment = result.dig('candidates', 0, 'content', 'parts', 0, 'text')
        return sentiment.downcase.strip if sentiment
      else
        Rails.logger.error("Gemini API Error: #{response.code} - #{response.body}")
        return nil
      end
    rescue StandardError => e
      Rails.logger.error("Gemini API Request Failed: #{e.message}")
      return nil
    end
  end
end