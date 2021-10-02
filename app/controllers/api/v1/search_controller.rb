class Api::V1::SearchController < ApiController

  def sample
    begin
      @secondary_schools = SecondarySchool.order('RANDOM()').limit(100)
      @status = 0
      render template: 'api/v1/search/sample', status: :ok
    rescue StandardError
      @secondary_schools = []
      @status = -1
      render template: 'api/v1/search/sample', status: :internal_server_error
    end
  end

  def within
    begin
      latitude = within_params[:latitude] || '42.345573'
      longitude = within_params[:longitude] || '42.345573'
      distance_in_km = begin
                         (within_params[:distance_in_km].to_i * 1000)
                       rescue StandardError
                         1000
                       end

      @secondary_schools = SecondarySchool.within(longitude, latitude, distance_in_km)
      @status = 0
      render template: 'api/v1/search/within', status: :ok
    rescue StandardError
      @secondary_schools = []
      @status = -1
      render template: 'api/v1/search/within', status: :internal_server_error
    end
  end

  def by_unit_id
    begin
      unit_id = by_unit_id_params[:unit_id]

      if unit_id.present?
        @secondary_school = SecondarySchool.find_by(unit_id: unit_id)
        @status = 0
        render template: 'api/v1/search/by_unit_id', status: :ok
      else
        @secondary_school = nil
        @status = -1
        render template: 'api/v1/search/by_unit_id', status: :bad_request
      end
    rescue StandardError
      @secondary_school = nil
      @status = -1
      render template: 'api/v1/search/by_unit_id', status: :internal_server_error
    end
  end

  def by_name
    begin
      query = by_name_params[:query]
      limit = by_name_params[:limit] || SecondarySchool.count

      if query.present?
        @secondary_schools = SecondarySchool.where('lower(name) LIKE ?', "%#{query.downcase}%").limit(limit)
        @status = 0
        render template: 'api/v1/search/by_name', status: :ok
      else
        @secondary_schools = []
        @status = -1
        render template: 'api/v1/search/by_name', status: :bad_request
      end
    rescue StandardError
      @secondary_schools = []
      @status = -1
      render template: 'api/v1/search/by_name', status: :internal_server_error
    end
  end


  private

  def within_params
    params.permit(:latitude, :longitude, :distance_in_km)
  end

  def by_name_params
    params.permit(:query, :limit)
  end

  def by_unit_id_params
    params.permit(:unit_id)
  end
end
