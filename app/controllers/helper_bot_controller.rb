class HelperBotController < ApplicationController
  def index
    @result = ''
    bot = NanoBot.new(cartridge:  YAML.safe_load(ERB.new(File.read('cartridge.yml')).result))
    @result = bot.eval(params[:question], as: 'repl') if params[:question].present?
    respond_to do |format|
      format.html
      format.js
    end
  end
end
