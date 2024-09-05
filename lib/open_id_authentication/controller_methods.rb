require_relative "result"

module OpenIdAuthentication
  module ControllerMethods
    protected

    # The parameter name of "openid_identifier" is used rather than
    # the Rails convention "open_id_identifier" because that's what
    # the specification dictates in order to get browser auto-complete
    # working across sites
    def using_open_id?(identifier = nil) # :doc:
      identifier ||= open_id_identifier
      !identifier.blank? || request.env[Rack::OpenID::RESPONSE]
    end

    def authenticate_with_open_id(identifier = nil, options = {}, &block) # :doc:
      identifier ||= open_id_identifier

      if request.env[Rack::OpenID::RESPONSE]
        complete_open_id_authentication(&block)
      else
        begin_open_id_authentication(identifier, options, &block)
      end
    end

    private

    def open_id_identifier
      params[:openid_identifier] || params[:openid_url]
    end

    def begin_open_id_authentication(identifier, options = {})
      options[:identifier] = identifier
      value = Rack::OpenID.build_header(options)
      response.headers[Rack::OpenID::AUTHENTICATE_HEADER] = value
      head(:unauthorized)
    end

    def complete_open_id_authentication
      response = request.env[Rack::OpenID::RESPONSE]
      identifier = response.display_identifier

      case response.status
      when OpenID::Consumer::SUCCESS
        yield Result[:successful], identifier,
          OpenID::SReg::Response.from_success_response(response),
          OpenID::AX::FetchResponse.from_success_response(response)
      when :missing
        yield Result[:missing], identifier, nil
      when :invalid
        yield Result[:invalid], identifier, nil
      when OpenID::Consumer::CANCEL
        yield Result[:canceled], identifier, nil
      when OpenID::Consumer::FAILURE
        yield Result[:failed], identifier, nil
      when OpenID::Consumer::SETUP_NEEDED
        yield Result[:setup_needed], response.setup_url, nil
      end
    end
  end
end
