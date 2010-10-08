module FileHelpers

  class << self

    def create_file(filename="ConstellationFile", content="")
      File.open(filename, "w") {|f| f.write(content) }
    end

    def destroy_file(filename="ConstellationFile")
      File.delete(filename) if File.exists?(filename)
    end

  end

end
