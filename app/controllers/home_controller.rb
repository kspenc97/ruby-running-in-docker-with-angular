class HomeController < ApplicationController
  def index
    @results = {item_1: "1 test", item_2: "2 test"}
  end
end