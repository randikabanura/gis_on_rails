class Api::V1::SearchController < ApiController

  def sample
    begin
      @secondary_schools = SecondarySchool.order('RANDOM()').limit(100)
      @status = 0
      render template: 'api/v1/sample', status: :ok
    rescue
      @secondary_schools = []
      @status = -1
      render template: 'api/v1/sample', status: :internal_server_error
    end
  end
end
