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
      if uuid_data.people_url_code == 0 || uuid_data.people_url_code.nil?
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
      if uuid_data.life_memory_uuid == 0 || uuid_data.life_memory_uuid.nil?
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

  def get_education_id

  end

  # type: 0-account 1-people 2-education 3-life_memory 4-project 5-comment 6-work_experience_uuid 7-ability
  def get_uuid_by_type(type)
    default_uuid = 100000000
    uuid_data = Uuid.first
    if uuid_data.nil?
      uuid_data = Uuid.new
      uuid_data.people_url_code = default_uuid
      uuid_data.life_memory_uuid = default_uuid
      uuid_data.project_uuid = default_uuid
      uuid_data.comment_uuid = default_uuid
      uuid_data.education_uuid = default_uuid
      uuid_data.work_experience_uuid = default_uuid
      uuid_data.ability_uuid = default_uuid
      result_uuid = default_uuid
      return result_uuid
    end

    result_uuid = default_uuid
    case type
      when 0 #people_url_code   account_id
        if uuid_data.people_url_code == 0 || uuid_data.people_url_code.nil?
          result_uuid = default_uuid
        else
          result_uuid = uuid_data.people_url_code + 1
        end
        uuid_data.update(:people_url_code=>result_uuid)
      when 1

      when 2 # education_uuid
        if uuid_data.education_uuid == 0 || uuid_data.education_uuid.nil?
          result_uuid = default_uuid
        else
          result_uuid = uuid_data.education_uuid + 1
        end
        uuid_data.update(:education_uuid=>result_uuid)
      when 3 # life_memory_uuid
        if !uuid_data.life_memory_uuid.nil? && uuid_data.life_memory_uuid > 0
          result_uuid = uuid_data.life_memory_uuid + 1
        end
        uuid_data.update(:life_memory_uuid=>result_uuid)
      when 4 # project_uuid
        if !uuid_data.project_uuid.nil? && uuid_data.project_uuid > 0
          result_uuid = uuid_data.project_uuid + 1
        end
        uuid_data.update(:project_uuid=>result_uuid)
      when 5 # comment_uuid
        if !uuid_data.comment_uuid.nil? && uuid_data.comment_uuid > 0
          result_uuid = uuid_data.comment_uuid + 1
        end
        uuid_data.update(:comment_uuid=>result_uuid)
      when 6
        if !uuid_data.work_experience_uuid.nil? && uuid_data.work_experience_uuid > 0
          result_uuid = uuid_data.work_experience_uuid + 1
        end
        uuid_data.update(:work_experience_uuid=>result_uuid)
      when 7
        if !uuid_data.ability_uuid.nil? && uuid_data.ability_uuid > 0
          result_uuid = uuid_data.ability_uuid + 1
        end
          uuid_data.update(:ability_uuid=>result_uuid);
      else

    end

    return result_uuid
  end

end