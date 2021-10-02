class MainController < ApplicationController
  def home
    @secondary_schools = SecondarySchool.all
  end
end
