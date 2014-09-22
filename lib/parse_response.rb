class HTTPResponseParser
  def initialize(file)

    @raw_file = file

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

  def header_text
    @raw_file.split("\n\n")[0]
  end

  def header
    header_hash = {}
    header_data = header_text.split("\n")
    header_data.shift
    header_data.each do |item|
      array = item.split()
      array[0].gsub(":", "")
      header_hash[array[0]] = array[1..-1].join(" ")
    end
    header_hash
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
end