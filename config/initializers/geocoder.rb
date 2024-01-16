Geocoder.configure(
  # Geocoding options
  timeout: 5,                 # geocoding service timeout (secs)
  lookup: :google,         # name of geocoding service (symbol)
  # ip_lookup: :ipinfo_io,      # name of IP address geocoding service (symbol)
  language: :ja,              # ISO-639 language code
  # use_https: false,           # use HTTPS for lookup requests? (if supported)
  # http_proxy: nil,            # HTTP proxy server (user:pass@host:port)
  # https_proxy: nil,           # HTTPS proxy server (user:pass@host:port)
  api_key: ENV['GOOGLE_MAPS_API_KEY']               # API key for geocoding service
  # cache: nil,                 # cache object (must respond to #[], #[]=, and #del)

  # Exceptions that should not be rescued by default
  # (if you want to implement custom error handling);
  # supports SocketError and Timeout::Error
  # always_raise: [],

  # Calculation options
  # units: :mi,                 # :km for kilometers or :mi for miles
  # distances: :linear          # :spherical or :linear

  # Cache configuration
  # cache_options: {
  #   expiration: 2.days,
  #   prefix: 'geocoder:'
  # }
)

# timeout: ジオコーディングサービスへのリクエストがタイムアウトするまでの秒数を設定します。デフォルトは通常3秒です。

# lookup: 使用するジオコーディングサービスの名称です。例えば :nominatim、:google、:bing などがあります。

# ip_lookup: IPアドレスを地理情報に変換するためのサービスを指定します。例えば :ipinfo_io、:maxmind などがあります。

# language: ジオコーディングリクエストの結果として返される言語をISO-639コードで指定します。

# use_https: ジオコーディングサービスへのリクエストにHTTPSを使用するかどうかを設定します。

# http_proxy / https_proxy: ジオコーディングリクエストを行う際に使用するHTTP/HTTPSプロキシサーバーを指定します。

# api_key: 使用するジオコーディングサービスのAPIキーを設定します。APIキーはサービスによって必要になる場合があります。

# cache: ジオコーディングの結果をキャッシュするオブジェクトを指定します。これにより、同じリクエストの結果を再利用できるようになります。

# always_raise: レスキューしない例外の種類を配列で指定します。エラーハンドリングをカスタマイズしたい場合に使用します。

# units: 距離の単位を指定します。:km でキロメートル、:mi でマイルです。

# distances: 距離の計算方法を指定します。:spherical を使用すると地球を球体と見なして計算し、:linear を使用すると平面上での直線距離を計算します。

# cache_options: キャッシュのオプションを指定します。例えば、キャッシュの有効期限やプレフィックスなどを設定できます。