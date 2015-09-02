require 'nokogiri'
require 'open-uri'

class RadarsController < ApplicationController
  #南極星行車測速高速公路路段網頁
  def index
    @highway = params[:highway]
    highwayId = 0
    case @highway
      when '1'
        highwayId = 0
      when '3'
        highwayId = 16

    end

    url = 'http://www.escortcat.com/speedtrap/s01-highway.html'
    doc = Nokogiri::HTML(open( url ))

    _HTML =  doc.css('table table table table table table tr')[highwayId].text
    _HTML = _HTML.split

    @title = _HTML.shift
    radarList =[]
    northernList = []
    southernList = []
    _HTML.each_with_index do |r,idx|
      r.sub!('Km　','')
      r = r.downcase
      if r[0,2]!= 'km'
        radarList.push(r)
      end
    end
    radarList = radarList.each_slice(2).to_a
    radarList.each do |r|
      if (r[1])[1] == '北'
        northernList.push(
          {
          :km => r[0],
          :title => r[1]
          }
        )
      elsif (r[1])[1] == '南'
        southernList.push(
          {
          :km => r[0],
          :title => r[1]
          }
        )
      elsif (r[1])[1] == '雙'
        northernList.push(
          {
          :km => r[0],
          :title => r[1]
          }
        )
        southernList.push(
          {
          :km => r[0],
          :title => r[1]
          }
        )
      end
    end
    result = {
      :title => @title,
      :northern => northernList,
      :southern => southernList
    }
    @radar = result.to_json
    @northernList = northernList
    @southernList = southernList
    #render :json => result
  end
end

