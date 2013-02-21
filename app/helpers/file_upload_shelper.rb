module FileUploadSHelper
  def file_upload(file)
    if file
      file_location = File.join settings.files, random_filename
      tmpfile = file[:tempfile]

      File.open(file_location, 'wb') { |file| file.write tmpfile.read }

      file_location
    else
      nil
    end
  end

  def random_filename
    "#{Time.now.to_i}#{Process.pid}"
  end
end