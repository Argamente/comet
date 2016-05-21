class PeoplesController < ApplicationController
  def show
    flash[:message] = params[:id]

    # 得到了id，然后查找数据库，找到对应此id的资料

    @curr_person = Person.find_by_account_id(params[:id])

    if @curr_person.nil?
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
      return
    end

    memory = LifeMemory.new
    memory.date = Time.now
    memory.content = "这是我的第一条记录"
    memory.save

  end
end
