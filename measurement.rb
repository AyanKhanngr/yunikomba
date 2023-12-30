class Measurement
  SUPPORTED_UNITS = {
    'length' => [
      # Metric
      %w[millimeters centimeters meters kilometers],

      # Imperial
      %w[inches feet yards miles]
    ].flatten,

    'weight' => [
      # Metric
      %w[grams milligrams kilograms],

      # Imperial
      %w[ounces pounds tons]
    ].flatten,

    'temperature' => [
      %w[celsius fahrenheit kelvin]
    ].flatten,

    'volume' => [
      # Metric
      %w[milliliters liters],

      # Imperial
      %w[fluid_ounces pints quarts gallons]
    ].flatten
  }.freeze

  attr_accessor :source_value, :source_unit, :target_unit

  def initialize(source_value, source_unit)
    @source_value = source_value
    @source_unit = source_unit
  end

  def convert_to(target_unit)
    case
    when @source_unit == target_unit
      target_value = source_value

    # Length

    ## Inches

    when @source_unit == "inches" && target_unit == "millimeters"
      target_value = source_value * 25.4
    when @source_unit == "inches" && target_unit == "centimeters"
      target_value = source_value * 2.54
    when @source_unit == "inches" && target_unit == "meters"
      target_value = source_value * 0.0254
    when @source_unit == "inches" && target_unit == "kilometers"
      target_value = source_value * 0.0000254
    when @source_unit == "inches" && target_unit == "feet"
      target_value = source_value / 12.0
    when @source_unit == "inches" && target_unit == "yards"
      target_value = source_value / 36.0
    when @source_unit == "inches" && target_unit == "miles"
      target_value = source_value / 63360.0

    ## Feet

    when @source_unit == "feet" && target_unit == "millimeters"
      target_value = source_value * 304.8
    when @source_unit == "feet" && target_unit == "centimeters"
      target_value = source_value * 30.48
    when @source_unit == "feet" && target_unit == "meters"
      target_value = source_value * 0.3048
    when @source_unit == "feet" && target_unit == "kilometers"
      target_value = source_value / 3280.84
    when @source_unit == "feet" && target_unit == "inches"
      target_value = source_value * 12.0
    when @source_unit == "feet" && target_unit == "yards"
      target_value = source_value / 3.0
    when @source_unit == "feet" && target_unit == "miles"
      target_value = source_value / 5280.0

    ## Yards

    when @source_unit == "yards" && target_unit == "millimeters"
      target_value = source_value * 914.4
    when @source_unit == "yards" && target_unit == "centimeters"
      target_value = source_value * 91.44
    when @source_unit == "yards" && target_unit == "meters"
      target_value = source_value * 0.9144
    when @source_unit == "yards" && target_unit == "kilometers"
      target_value = source_value / 1094.0
    when @source_unit == "yards" && target_unit == "inches"
      target_value = source_value * 36.0
    when @source_unit == "yards" && target_unit == "feet"
      target_value = source_value * 3.0
    when @source_unit == "yards" && target_unit == "miles"
      target_value = source_value / 0.9144

    ## Miles

    when @source_unit == "miles" && target_unit == "millimeters"
      target_value = source_value * 1609344.0
    when @source_unit == "miles" && target_unit == "centimeters"
      target_value = source_value * 160934.4
    when @source_unit == "miles" && target_unit == "meters"
      target_value = source_value * 1609.344
    when @source_unit == "miles" && target_unit == "kilometers"
      target_value = source_value / 1.609344
    when @source_unit == "miles" && target_unit == "inches"
      target_value = source_value * 63360.0
    when @source_unit == "miles" && target_unit == "feet"
      target_value = source_value * 5280.0
    when @source_unit == "miles" && target_unit == "yards"
      target_value = source_value * 1760.0

    ## Millimeters

    when @source_unit == "millimeters" && target_unit == "centimeters"
      target_value = source_value / 10.0
    when @source_unit == "millimeters" && target_unit == "meters"
      target_value = source_value / 1000.0
    when @source_unit == "millimeters" && target_unit == "kilometers"
      target_value = source_value / 1000000.0
    when @source_unit == "millimeters" && target_unit == "inches"
      target_value = source_value / 25.4
    when @source_unit == "millimeters" && target_unit == "feet"
      target_value = source_value / 304.8
    when @source_unit == "millimeters" && target_unit == "yards"
      target_value = source_value / 914.4
    when @source_unit == "millimeters" && target_unit == "miles"
      target_value = source_value / 1609344.0

    ## Centimeters

    when @source_unit == "centimeters" && target_unit == "millimeters"
      target_value = source_value * 10.0
    when @source_unit == "centimeters" && target_unit == "meters"
      target_value = source_value / 100.0
    when @source_unit == "centimeters" && target_unit == "kilometers"
      target_value = source_value / 100000.0
    when @source_unit == "centimeters" && target_unit == "inches"
      target_value = source_value / 2.54
    when @source_unit == "centimeters" && target_unit == "feet"
      target_value = source_value / 30.48
    when @source_unit == "centimeters" && target_unit == "yards"
      target_value = source_value / 91.44
    when @source_unit == "centimeters" && target_unit == "miles"
      target_value = source_value / 160934.4

    ## Meters

    when @source_unit == "meters" && target_unit == "millimeters"
      target_value = source_value * 1000.0
    when @source_unit == "meters" && target_unit == "centimeters"
      target_value = source_value * 100.00
    when @source_unit == "meters" && target_unit == "kilometers"
      target_value = source_value * 0.001
    when @source_unit == "meters" && target_unit == "inches"
      target_value = source_value * 39.3701
    when @source_unit == "meters" && target_unit == "feet"
      target_value = source_value / 3.28084
    when @source_unit == "meters" && target_unit == "yards"
      target_value = source_value / 1.09361
    when @source_unit == "meters" && target_unit == "miles"
      target_value = source_value / 0.000621371

    ## Kilometers

    when @source_unit == "kilometers" && target_unit == "millimeters"
      target_value = source_value * 1000000.0
    when @source_unit == "kilometers" && target_unit == "centimeters"
      target_value = source_value * 10000.0
    when @source_unit == "kilometers" && target_unit == "meters"
      target_value = source_value * 1000.0
    when @source_unit == "kilometers" && target_unit == "inches"
      target_value = source_value * 39370.1
    when @source_unit == "kilometers" && target_unit == "feet"
      target_value = source_value / 3280.84
    when @source_unit == "kilometers" && target_unit == "yards"
      target_value = source_value / 1093.61
    when @source_unit == "kilometers" && target_unit == "miles"
      target_value = source_value / 0.621371

    # Weight

    ## Ounces

    when @source_unit == "ounces" && target_unit == "milligrams"
      target_value = source_value * 28349.5
    when @source_unit == "ounces" && target_unit == "grams"
      target_value = source_value * 28.3495
    when @source_unit == "ounces" && target_unit == "kilograms"
      target_value = source_value * 0.0283495
    when @source_unit == "ounces" && target_unit == "pounds"
      target_value = source_value * 0.0625
    when @source_unit == "ounces" && target_unit == "tons"
      target_value = source_value / 35840

    ## Pounds

    when @source_unit == "pounds" && target_unit == "milligrams"
      target_value = source_value * 453592.37
    when @source_unit == "pounds" && target_unit == "grams"
      target_value = source_value * 453.592
    when @source_unit == "pounds" && target_unit == "kilograms"
      target_value = source_value * 0.45359237
    when @source_unit == "pounds" && target_unit == "ounces"
      target_value = source_value * 16.0
    when @source_unit == "pounds" && target_unit == "tons"
      target_value = source_value / 2240

    ## Tons

    when @source_unit == "tons" && target_unit == "milligrams"
      target_value = source_value * 1000000000.0
    when @source_unit == "tons" && target_unit == "grams"
      target_value = source_value * 1000000.0
    when @source_unit == "tons" && target_unit == "kilograms"
      target_value = source_value * 1000.0
    when @source_unit == "tons" && target_unit == "ounces"
      target_value = source_value * 35273.96
    when @source_unit == "tons" && target_unit == "pounds"
      target_value = source_value * 2204.62

    ## Milligrams

    when @source_unit == "milligrams" && target_unit == "grams"
      target_value = source_value / 1000.0
    when @source_unit == "milligrams" && target_unit == "kilograms"
      target_value = source_value / 1000000.0
    when @source_unit == "milligrams" && target_unit == "ounces"
      target_value = source_value / 28349.5
    when @source_unit == "milligrams" && target_unit == "pounds"
      target_value = source_value / 453592.37
    when @source_unit == "milligrams" && target_unit == "tons"
      target_value = source_value / 1016046919.17

    ## Grams

    when @source_unit == "grams" && target_unit == "milligrams"
      target_value = source_value * 1000.0
    when @source_unit == "grams" && target_unit == "kilograms"
      target_value = source_value / 1000.0
    when @source_unit == "grams" && target_unit == "ounces"
      target_value = source_value / 28.3495
    when @source_unit == "grams" && target_unit == "pounds"
      target_value = source_value / 453.592
    when @source_unit == "grams" && target_unit == "tons"
      target_value = source_value / 1016046.91

    ## Kilograms

    when @source_unit == "kilograms" && target_unit == "milligrams"
      target_value = source_value * 1000000.0
    when @source_unit == "kilograms" && target_unit == "grams"
      target_value = source_value * 1000.0
    when @source_unit == "kilograms" && target_unit == "ounces"
      target_value = source_value * 35.27396
    when @source_unit == "kilograms" && target_unit == "pounds"
      target_value = source_value * 2.20462
    when @source_unit == "kilograms" && target_unit == "tons"
      target_value = source_value / 1016.05

    # Temperature

    when @source_unit == "celsius" && target_unit == "fahrenheit"
      target_value = (9.0 / 5.0) * source_value + 32.0
    when @source_unit == "celsius" && target_unit == "kelvin"
      target_value = source_value + 273.15
    when @source_unit == "fahrenheit" && target_unit == "celsius"
      target_value = (5.0 / 9.0) * (source_value - 32.0)
    when @source_unit == "fahrenheit" && target_unit == "kelvin"
      target_value = (5.0 / 9.0) * (source_value - 32.0) + 273.15
    when @source_unit == "kelvin" && target_unit == "celsius"
      target_value = source_value - 273.15
    when @source_unit == "kelvin" && target_unit == "fahrenheit"
      target_value = (9.0 / 5.0) * (source_value - 273.15) + 32.0

    # Volume

    ## Fluid ounces

    when @source_unit == "fluid_ounces" && target_unit == "pints"
      target_value = source_value / 16.0
    when @source_unit == "fluid_ounces" && target_unit == "quarts"
      target_value = source_value / 32.0
    when @source_unit == "fluid_ounces" && target_unit == "gallons"
      target_value = source_value / 128.0
    when @source_unit == "fluid_ounces" && target_unit == "milliliters"
      target_value = source_value * 29.5735
    when @source_unit == "fluid_ounces" && target_unit == "liters"
      target_value = source_value * 0.0295735

    ## Pints

    when @source_unit == "pints" && target_unit == "fluid_ounces"
      target_value = source_value * 16.0
    when @source_unit == "pints" && target_unit == "quarts"
      target_value = source_value / 2.0
    when @source_unit == "pints" && target_unit == "gallons"
      target_value = source_value / 8.0
    when @source_unit == "pints" && target_unit == "milliliters"
      target_value = source_value * 473.176
    when @source_unit == "pints" && target_unit == "liters"
      target_value = source_value * 0.473176

    ## Quarts

    when @source_unit == "quarts" && target_unit == "fluid_ounces"
      target_value = source_value * 32.0
    when @source_unit == "quarts" && target_unit == "pints"
      target_value = source_value * 2.0
    when @source_unit == "quarts" && target_unit == "gallons"
      target_value = source_value / 4.0
    when @source_unit == "quarts" && target_unit == "milliliters"
      target_value = source_value * 946.353
    when @source_unit == "quarts" && target_unit == "liters"
      target_value = source_value * 0.946353

    ## Gallons

    when @source_unit == "gallons" && target_unit == "fluid_ounces"
      target_value = source_value * 128.0
    when @source_unit == "gallons" && target_unit == "pints"
      target_value = source_value * 8.0
    when @source_unit == "gallons" && target_unit == "quarts"
      target_value = source_value * 4.0
    when @source_unit == "gallons" && target_unit == "milliliters"
      target_value = source_value * 3785.41
    when @source_unit == "gallons" && target_unit == "liters"
      target_value = source_value * 3.78541

    ## Milliliters

    when @source_unit == "milliliters" && target_unit == "fluid_ounces"
      target_value = source_value / 29.5735
    when @source_unit == "milliliters" && target_unit == "pints"
      target_value = source_value / 473.176
    when @source_unit == "milliliters" && target_unit == "quarts"
      target_value = source_value / 946.353
    when @source_unit == "milliliters" && target_unit == "gallons"
      target_value = source_value / 3785.41
    when @source_unit == "milliliters" && target_unit == "liters"
      target_value = source_value / 1000.0

    ## Liters

    when @source_unit == "liters" && target_unit == "fluid_ounces"
      target_value = source_value * 33.814
    when @source_unit == "liters" && target_unit == "pints"
      target_value = source_value * 1.75975
    when @source_unit == "liters" && target_unit == "quarts"
      target_value = source_value * 0.879877
    when @source_unit == "liters" && target_unit == "gallons"
      target_value = source_value * 0.219969
    when @source_unit == "liters" && target_unit == "milliliters"
      target_value = source_value * 1000.0

    end

    target_value.to_s.sub(/\.?0+$/, '')
  end
end
