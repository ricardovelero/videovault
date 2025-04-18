class HomeController < ApplicationController
  layout "home"
  def index
    puts "Postmark token: #{ENV['POSTMARK_API_TOKEN']}"
  end
end
