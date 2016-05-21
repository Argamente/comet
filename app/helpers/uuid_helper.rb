module UuidHelper
  def get_uuid
    uuid_data = Uuid.first
    if uuid_data.nil?
      uuid_data = Uuid.new
      uuid_data.people_url_code = 100000000
      result_uuid = uuid_data.people_url_code
      uuid_data.save
    else
      result_uuid = uuid_data.people_url_code + 1
      uuid_data.update(:people_url_code => result_uuid)
    end

    return result_uuid
  end


  def get_project_id

  end


  def get_comment_id

  end

end