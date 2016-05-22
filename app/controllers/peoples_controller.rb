class PeoplesController < ApplicationController
  def show

    account_id = check_and_convert_id(params[:id])

    if account_id < 0
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
      return
    end


    # 得到了id，然后查找数据库，找到对应此id的资料

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
end
