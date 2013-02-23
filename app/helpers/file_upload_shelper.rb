module FileUploadSHelper
  def file_upload(file)
    if file
      rand_file_name = Rucomasy::FileHelper(rand_file_with_ext(file[:filename]))
      file_location = File.join settings.submissions, rand_file_name
      tmpfile = file[:tempfile]

      File.open(file_location, 'wb') { |file| file.write tmpfile.read }

      file_location
    else
      nil
    end
  end

end