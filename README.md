# YUNIKOMBA • ユニコンバ

## Overview

Yunikomba provides a REST API for conversion between common units of measurement. Yunikomba accepts requests with a JSON payload and responds with JSON.

## Prerequisites

Yunikomba is written in the [Ruby programming language](https://ruby-lang.org/) and uses the [Sinatra](https://sinatrarb.com) microframework. The system where you run Yunikomba must provide the following software, as well as any dependencies.

| Software | Version | More information |
| :- | :- | :- |
| Ruby | 2.6.10 or later | [Installing Ruby](https://www.ruby-lang.org/en/documentation/installation/) on the Ruby website |
| Sinatra (gem) | 3.1.0 or later | [README](https://sinatrarb.com/intro.html) on the Sinatra website |

## Getting started

Start Yunikomba by running the following command.

```
ruby yunikomba.rb -e production
```

By default, Yunikomba runs on port 80 and does not implement or require TLS.

## Endpoints

- [`/about`](#about)
- [`/convert/units`](#convertunits)
- [`/convert`](#convert)

### `/about`

- [`GET /about`](#get-about)

#### `GET /about`

Provides a list of Yunikomba's available endpoints. Alternatively, you can submit a `GET` request to `/`.

### `/convert/units`

- [`GET /convert/units`](#get-convertunits)

#### `GET /convert/units`

Provides a list of units that Yunikomba can convert.

### `/convert`

- [`GET /convert`](#get-convert)
- [`POST /convert`](#post-convert)

#### `GET /convert`

Provides information about the expected method for requests to this endpoint.

#### `POST /convert`

Converts a source value from a source unit to a target unit.

Requests require all of the following key-value pairs as JSON data.

| Key | Type | Description |
| :- | :- | :- |
| `source_value` | String or floating-point number | Source value to convert from source unit to target unit. |
| `source_unit` | String | Source unit of source value for conversion to target unit. |
| `target_unit` | String | Target unit for conversion of source value from source unit. |

Yunikomba's response to a well-formed request includes `target_value`, which contains the converted source value.

If you omit a key in your request, Yunikomba responds with a `400`, and `error.details` provides a list of missing keys.

## Example

Convert 32 degrees Fahrenheit to celsius:

```shell
curl --silent \
     --request POST \
     --json \
       '{ "source_value": "32",
          "source_unit": "fahrenheit",
          "target_unit": "celsius"
        }' \
     /convert
```

Response:

```json
{
  "source_value": "32",
  "source_unit": "fahrenheit",
  "target_unit": "celsius",
  "target_value": "0"
}
```
