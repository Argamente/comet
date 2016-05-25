class PeoplesController < ApplicationController
  def show

    account_id = check_and_convert_id(params[:id])

    if account_id < 0
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
      return
    end

    # 获取基础数据
    @basic_information = Person.find_by_account_id(account_id)

    # 获取近况(最新的3条)
    @life_memories = LifeMemory.where(:account_id=>account_id).limit(5).order("created_at DESC")

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



  def ajaxtest
    respond_to do |format|
      format.js
      format.html
    end
  end


  def update_head_icon

  end

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


    end


   respond_to do |format|
     format.js
     format.html{render root_url}
   end
  end

  def update_life_memory

  end

  def update_person_joined_project

  end

  def update_project_comment

  end

  def update_education

  end

  def update_work_experience

  end



end
