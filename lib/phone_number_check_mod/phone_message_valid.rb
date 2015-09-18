module PhoneNumberCheckMod
  class PhoneMessageValid
    class << self
      def set_accountsid(str)
        @@accountsid = str
      end

      def set_authtoken(str)
        @@authtoken  = str
      end

      def set_base_url(str)
        @@base_url = str
      end
    end

    def initialize(phone_num)
      @phone_num = phone_num
      @accountsid = @@accountsid
      @authtoken = @@authtoken
      @base_url = @@base_url
      @date = Time.now.strftime("%Y%m%d%H%M%S")
      @valid_code = rand(999999)
    end

    def valid
      request_uri = URI.parse(_build_request_url)
      https = Net::HTTP.new(request_uri.host,request_uri.port)
      https.set_debug_output $stderr
      https.use_ssl = true
      req = Net::HTTP::Post.new(request_uri,initheader = _build_headers)
      req.body = _build_body
      body = https.request(req).body

      ValidInfo.new(
        :phone_num   => @phone_num,
        :valid_code  => @valid_code,
        :response    => body
      )
    end

    def _build_request_url
      before_encrypted_code = "#{@accountsid}#{@authtoken}#{@date}"
      sig_parameter = Digest::MD5.hexdigest(before_encrypted_code).upcase
      File.join(@base_url, "/2013-12-26/Accounts/#{@accountsid}/SMS/TemplateSMS?sig=#{sig_parameter}")
    end

    def _build_headers
      authorization = Base64.strict_encode64("#{@accountsid}:#{@date}")
      return {
      "Accept" => "application/json",
      "Content-Type" => "application/json;charset=utf-8",
      "Authorization" => authorization
      }
    end

    def _build_body
      return {
        'to'=> @phone_num,
        'appId'=>'8a48b5514fac9535014fb0229bdd067b',
        'templateId'=>'1',
        'datas'=>[@valid_code,"1"]
       }.to_json
    end

    class ValidInfo
      attr_reader :phone_num, :valid_code, :response_json
      def initialize(options)
        @phone_num = options[:phone_num]
        @valid_code = options[:valid_code]
        _build_status(options[:response])
        @response_json = options[:response]
      end

      def _build_status(response)
        hash = JSON.parse(response)
        @status_msg  = hash['statusMsg']
        @status_code = hash['statusCode']
      end

      def success?
        @status_code == '000000'
      end
    end

  end
end
