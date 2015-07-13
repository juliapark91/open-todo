module TestAPIHelper
  def json( body )
    JSON.parse( response.body, symbolize_names: true )
  end
end
