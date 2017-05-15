class Furiten::Api

  BASE_URI = "http://api.furiten.ru/"

  class << self
    def get_user(params)
      params.symbolize_keys!
      return false unless
      begin
        response = JSON.parse(self.post('getPlayer', params || {}).body.to_s)
      rescue => e
        Rails.env.production? ? Rollbar.error(e) : puts(e.message, e.backtrace)
        return false
      end
      success?(response)
    end

  protected

    def post(method, params = {})
      response = HTTP[:accept => 'application/json'].post(Furiten::Api::BASE_URI, :json => {jsonrpc: '2.0', method: method, params:params, id: 1})
      response
    end

    def get(method, params = {})
      response = HTTP[:accept => 'application/json'].get(Furiten::Api::BASE_URI, :json => {jsonrpc: '2.0', method: method, params:params, id: 1})
      response
    end

  private

    def success?(response)
      unless response['error'].present?
        puts "Success", response.to_s if Rails.env.development?
        true
      else
        puts "Error", response['message'] if Rails.env.development?
        false
      end
    end

  end
end
