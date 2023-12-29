require "sinatra"
require "json"
require_relative "measurement"

set :port, 80

before do
  content_type :json
end

get %w(/ /about) do
  halt 200, {
    information: {
      message: "Yunicomba provides the following endpoints: /about, /convert, /convert/units",
      documentation_url: "https://github.com/mattpollard/yunicomba#endpoints"
    }
  }.to_json
end

get '/convert/units' do
  response = Measurement::SUPPORTED_UNITS.map do |classification, units|
    { classification: classification, units: units }
  end

  halt 200, response.to_json
end

get '/convert' do
  halt 200, {
    information: {
      message: "Use POST /convert to convert units or GET /convert/units to display supported units",
      documentation_url: "https://github.com/mattpollard/yunicomba#endpoints"
    }
  }.to_json
end

post '/convert' do
  begin
    request_body = JSON.parse(request.body.read)
    
    validate_required_keys(['source_value', 'source_unit', 'target_unit'], request_body)
    validate_input_length(request_body)
    source_value = validate_source_value(request_body['source_value'], request_body)

    source_unit = request_body['source_unit'].downcase
    target_unit = request_body['target_unit'].downcase

    validate_unit_names(source_unit, target_unit, request_body)
    validate_convertibility(source_unit, target_unit, request_body)
    convert(source_value, source_unit, target_unit, request_body)
  rescue JSON::ParserError
    halt 400, {
      error: {
        message: "Request body contains invalid JSON",
      }
    }.to_json
  end
end

not_found do
  halt 400, {
    error: {
      message: "#{request.path} not found",
    }
  }.to_json
end

def validate_required_keys(required_keys, request_body)
  missing_keys = required_keys - request_body.keys
  
  if missing_keys.any?
    error_details = {}
  
    missing_keys.each do |key|
      error_details[key] = "Parameter is missing"
    end
  
    halt 400, {
      error: {
        message: "Request body is missing required keys",
        details: error_details
      },
      original_request: request_body
    }.to_json
  end
end

def validate_input_length(request_body)
  maximum_length = 32

  request_body.each do |key, source_value|
    if source_value.to_s.length > maximum_length
      halt 400, {
        error: {
          message: "Value of '#{key}' exceeds #{maximum_length} characters"
        },
        original_request: request_body
      }.to_json
    end
  end
end

def validate_source_value(source_value, request_body)
  begin
    float_source_value = Float(source_value)
  rescue ArgumentError, TypeError
    halt 400, {
      error: {
        message: "Request body contains non-numeric source_value for conversion",
        details: {
          source_value: "'#{source_value}' is not an integer or floating-point number"
        }
      },
      original_request: request_body
    }.to_json
  end
end

def validate_unit_names(source_unit, target_unit, request_body)
  provided_units = {
    'source_unit' => source_unit,
    'target_unit' => target_unit
  }
  
  invalid_units_details = provided_units.each_with_object({}) do |(key, unit), details|
    unless Measurement::SUPPORTED_UNITS.values.flatten.include?(unit)
      details[key] = "'#{unit}' is not a valid unit"
    end
  end
  
  if invalid_units_details.any?
    halt 400, {
      error: {
        message: "Request body contains invalid units",
        details: invalid_units_details
      },
      original_request: request_body
    }.to_json
  end
end

def validate_convertibility(source_unit, target_unit, request_body)
  source_unit_classification = nil
  target_unit_classification = nil
  units_convertible = false

  Measurement::SUPPORTED_UNITS.each do |classification, units|
    if units.include?(source_unit)
      source_unit_classification = classification
    end

    if units.include?(target_unit)
      target_unit_classification = classification
    end
  end

  if source_unit_classification == target_unit_classification
    units_convertible = true
  end

  unless units_convertible
    units = {
      'source_unit' => {
        'classification' => source_unit_classification,
        'unit' => source_unit
      },
      'target_unit' => {
        'classification' => target_unit_classification,
        'unit' => target_unit
      }
    }

    error_details = {}

    units.each do |key, source_values|
      unit_type = key
      classification = source_values['classification']
      unit = source_values['unit']

      error_details[key] = "Unit '#{unit}' describes #{classification}"
    end

    halt 400, {
      error: {
        message: "Body contains inconvertible units",
        details: error_details
      },
      original_request: request_body
    }.to_json
  end
end

def convert(source_value, source_unit, target_unit, request_body)
  measurement = Measurement.new(source_value, source_unit)

  halt 200, {
    source_value: source_value.to_s.sub(/\.?0+$/, ''),
    source_unit: source_unit,
    target_unit: target_unit,
    target_value: measurement.convert_to(target_unit)
  }.to_json
end