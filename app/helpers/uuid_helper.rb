module UuidHelper
  # 账户UUID
  def get_uuid
    uuid_data = Uuid.first
    if uuid_data.nil?
      uuid_data = Uuid.new
      uuid_data.people_url_code = 100000000
      result_uuid = uuid_data.people_url_code
      uuid_data.save
    else
      if uuid_data.people_url_code == 0
        uuid_data.people_url_code = 100000000
        result_uuid = uuid_data.people_url_code
      else
        result_uuid = uuid_data.people_url_code + 1
      end
      uuid_data.update(:people_url_code => result_uuid)
    end

    return result_uuid
  end


  # 获取一条近况的uuidSSS
  def get_life_memory_uuid
    uuid_data = Uuid.first
    if uuid_data.nil?
      uuid_data = Uuid.new
      uuid_data.life_memory_uuid = 100000000
      result_uuid = uuid_data.life_memory_uuid
      uuid_data.save
    else
      if uuid_data.life_memory_uuid == 0
        uuid_data.life_memory_uuid = 100000000
        result_uuid = uuid_data.life_memory_uuid
      else
        result_uuid = uuid_data.life_memory_uuid + 1
      end
      uuid_data.update(:life_memory_uuid=>result_uuid)
    end

    return result_uuid
  end



  def get_project_id

  end


  def get_comment_id

  end

end