
##
# Exception for when the response code for a call is not 200
##
class Non200ResponseError < StandardError
	def initialize(response_code, request_url)
		puts("Request: #{request_url}")
		puts("200 response code expected, got " + response_code.to_s + " instead.")
	end
end