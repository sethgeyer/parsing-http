class HTTPResponseParser
  def initialize(file)
    @raw_file = file
    @header_hash = {}
  end

  def response_code
    @raw_file.split(' ')[1].to_i
  end

  def version
    @raw_file.split(' ')[0]
  end

  def body
    @raw_file.split("\n\n")[1].delete("\n")
  end

  def header
    header_data = header_text.split("\n")
    symbolize(header_data)
  end

  def content_type
    header["Content-Type:"]
  end

  def server
    header["Server:"]
  end

  def location
    header["Location:"]
  end

  private

  def header_text
    @raw_file.split("\n\n")[0]
  end

  def symbolize(header_data)
    header_data[1..-1].collect do |item|
      array = item.split()
      @header_hash[array[0]] = array[1..-1].join(" ")
    end
    @header_hash
  end
end