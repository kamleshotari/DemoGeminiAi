class HelperBotController < ApplicationController
  def index
    @result = ''
    bot = NanoBot.new(cartridge: 'cartridge.yml')
    @result = bot.eval(params[:question], as: 'repl') if params[:question].present?
    respond_to do |format|
      format.html
      format.js
    end
  end
end
