class Api::V1::SearchController < ApiController

  def sample
    begin
      @secondary_schools = SecondarySchool.order('RANDOM()').limit(100)
      @status = 0
      render template: 'api/v1/sample', status: :ok
    rescue StandardError
      @secondary_schools = []
      @status = -1
      render template: 'api/v1/sample', status: :internal_server_error
    end
  end

  def search_within
    begin
      latitude = search_within_params[:latitude] || '42.345573'
      longitude = search_within_params[:longitude] || '42.345573'
      distance_in_km = begin
                         (search_within_params[:distance_in_km].to_i * 1000)
                       rescue StandardError
                         1000
                       end

      @secondary_schools = SecondarySchool.within(longitude, latitude, distance_in_km)
      @status = 0
      render template: 'api/v1/search_within', status: :ok
    rescue StandardError
      @secondary_schools = []
      @status = -1
      render template: 'api/v1/search_within', status: :internal_server_error
    end
  end


  private

  def search_within_params
    params.permit(:latitude, :longitude, :distance_in_km)
  end
end
