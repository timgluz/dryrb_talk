# Helper to generate AWS Lambda response from Dry Result monad
module DryResponse
  def dry_response(res, &block)
    if res.is_a?(Exception)
      { statusCode: 500, message: res.message.to_s, backtrace: backtrace_text(res) }
    elsif res.is_a?(String)
      { statusCode: 200, message: res.to_s }
    elsif res.respond_to(:success?)
      res = res.value!
      res = yield(res) if block_given?

      { statusCode: 200, message: 'OK', body: res.to_json }
    elsif res.respond_to(:failure?)
      error = res.failure
      { statusCode: 500, message: error.to_s, backtrace: backtrace_text(error) }
    else
      { statusCode: 200, message: '' }
    end
  end

  def backtrace_text(error)
    if error.respond_to?(:backtrace)
      error.backtrace.to_a.join('\n')
    else
      error.to_s
    end
  end
end
