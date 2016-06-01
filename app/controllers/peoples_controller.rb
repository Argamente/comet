class PeoplesController < ApplicationController
  def show

    account_id = check_and_convert_id(params[:id])

    if account_id < 0
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
      return
    else
      view_user = UserAccount.find_by_account_id(account_id)
      if view_user.nil?
        render file: "#{Rails.root}/public/404.html", layout: false, status: 404
        return
      end
    end
    @current_page_account_id = account_id
    # 获取基础数据
    @basic_information = Person.find_by_account_id(account_id)
    # 获取近况(最新的3条)
    @life_memories = LifeMemory.where(:account_id=>account_id)#.limit(5).order("created_at DESC")
    # 获取加入的项目
    @joined_projects = PersonJoinedProject.where(:account_id=>account_id).all
    # 获取最近的评论
    @project_comments = ProjectComment.where(:account_id=>account_id).all
    # 获取教育数据
    @educations = Education.where(:account_id=>account_id).all
    # 获取技能数据
    @abilities = Ability.where(:account_id=>account_id).all
    # 获取工作经验
    @work_experiences = WorkExperience.where(:account_id=>account_id).all

  end



  def update_head_icon

  end


  # 更新基础资料
  def update_basic_info
    if signed_in?
      current_account_id = current_account.account_id
      @basic_information = Person.find_by_account_id(current_account_id)
      to_update = true
      if @basic_information.nil?
        @basic_information = Person.new
        to_update = false
      end

      @basic_information.account_id = current_account_id

      _username = params[:_username]
      _gender = params[:_gender] == "true" ? 1 : 0
      _occupation = params[:_occupation]
      _birthday = params[:_birthday]
      _location = params[:_location]

      if _username != "" && _username != @basic_information.name
        @basic_information.name = _username
      end

      if _gender != @basic_information.gender
        @basic_information.gender = _gender
      end

      if _occupation != "" && _occupation != @basic_information.occupation
        @basic_information.occupation = _occupation
      end

      if _birthday != "" && _birthday != @basic_information.birthday
        str = _birthday + "-01-01-01-01"
        @basic_information.birthday = DateTime.strptime(str,"%Y-%m-%d-%H-%M-%S")
      end

      if _location != "" && _location != @basic_information.location
        @basic_information.location = _location
      end

      if to_update == true
        @basic_information.update(:name=>@basic_information.name,
                                  :gender=> @basic_information.gender,
                                  :occupation=>@basic_information.occupation,
        :birthday=>@basic_information.birthday,
        :location=>@basic_information.location)
      else
        @basic_information.save
      end

    else
      _account_id =  check_and_convert_id(params[:_account_id])
      if _account_id > 0
        @basic_information = Person.find_by_account_id(_account_id)
      end
      if @basic_information.nil?
        @basic_information = Person.new
      end
    end

    @current_page_account_id = check_and_convert_id(params[:_account_id])

   respond_to do |format|
     format.js
     format.html
   end
  end


  # 更新近况
  # params: arg_content:近况内容，
  # arg_tag:近况标签 1-2-3-4：春-夏-秋-冬,
  # arg_operation:0-1-2 添加-修改-删除
  # arg_life_memory_uuid
  def update_life_memory

    has_error = false

    if !signed_in?
      message = "Hey bro, 登录后才能记录近况的，你是怎么做到不登录就发表近况的？"
      has_error = true
    else
      current_account_id = current_account.account_id
    end


    # 获取近况内容和标签
    ajax_content = params[:arg_content]
    ajax_life_memory_uuid = params[:arg_life_memory_uuid]
    if ajax_content == ""
      message = "近况不能为空"
      has_error = true
    end

    # 获取操作
    ajax_operation = params[:arg_operation].to_i


    if has_error == false
      # 添加新的近况
      if ajax_operation == 0
        ajax_tag = params[:arg_tag].to_i
        life_memory = LifeMemory.new
        life_memory.account_id = current_account_id
        life_memory.content = ajax_content
        life_memory.tag = ajax_tag
        life_memory.life_memory_uuid = get_life_memory_uuid()
        new_life_memory_uuid = life_memory.life_memory_uuid
        if !life_memory.save
          message = "添加近况失败"
          has_error = true
        end

      else
        if ajax_operation == 1
          old_life_memory = LifeMemory.find_by_life_memory_uuid(ajax_life_memory_uuid)
          if old_life_memory.nil? == false && old_life_memory.account_id == current_account_id
            old_life_memory.update(:content=>ajax_content)
          else
            message = "更新操作出错"
            has_error = true
          end
        else
          if ajax_operation == 2
            old_life_memory = LifeMemory.find_by_life_memory_uuid(ajax_life_memory_uuid)
            if old_life_memory.nil? == false && old_life_memory.account_id == current_account_id
              old_life_memory.destroy
            else
              message = "删除操作出错"
              has_error = true
            end
          else
            message = "Fuck you"
            has_error = true
          end
        end
      end
    end

    if has_error
      result = -1
    else
      result = 0
      message = "操作成功"
    end



    render :json=>{
               :arg_content=>ajax_content,
               :result=>result,
               :message=>message,
               :new_life_memory_uuid=>new_life_memory_uuid
           }
  end



  def update_person_joined_project

  end

  def update_project_comment

  end

  def update_education

  end


  def update_ability

  end


  def update_work_experience

  end



end
