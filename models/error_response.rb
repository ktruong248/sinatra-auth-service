class ErrorResponse
  def initialize(error_code, description)
    @error_code = error_code
    @description = description
  end

  def error_code
    @error_code
  end

  def description
    @description
  end

  def to_json(*a)
    {
      "error_code" => error_code,
      "description" => description
    }.to_json(*a)
  end
end