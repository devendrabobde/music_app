class Api::V1::VersionsController < ApplicationController
  
  # This method is responsible for verifying application up and runining status, DB status
  # and returns Hash of version_message, status, api_version
  def index
    status = 'ok'
    version_message ='%s version %s is up and running at %s:%s.' % [
      'UPSC App', ServerConfiguration::CONFIG["code_version"], request.host, request.port ]
    render json: { version_message: version_message, status: status, api_version: ServerConfiguration::CONFIG["code_version"], server_instance_name: ServerConfiguration::CONFIG['server_instance_name'] }
  end

end