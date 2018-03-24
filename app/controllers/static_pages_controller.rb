class StaticPagesController < ApplicationController
  def home
  end

  def help
    respond_to { |f| f.js { render partial: 'static_pages/help' } }
  end
end
