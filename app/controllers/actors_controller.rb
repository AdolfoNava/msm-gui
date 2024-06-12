class ActorsController < ApplicationController
  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end

  def create
    @actor = Actor.new
    @actor.name  = params["name"]
    @actor.dob = params["dob"]
    @actor.bio = params["bio"]
    @actor.image = params["image_url"]

    if @actor.valid?
      @actor.save 
      redirect_to("/actors", {:notice => "Actor created successfully."})
    else
      redirect_to("/actors", {:notice => "Actor failed to create successfully."})
    end
  end
  def update
    id = params.fetch("path_id")
    @actor = Actor.where({ :id => id }).at(0)

    @actor.name  = params["name"]
    @actor.dob = params["dob"]
    @actor.bio = params["bio"]
    @actor.image = params["image_url"]

    if @actor.valid?
      @actor.save
      redirect_to("/actors/#{@actor.id}", { :notice => "Actor updated successfully."} )
    else
      redirect_to("/actors/#{@actor.id}", { :alert => "Actor failed to update successfully." })
    end
  end
  def destroy 
    path_id = params["path_id"]
    actor = Actor.where({:id => path_id}).at(0)

    actor.destroy

    redirect_to("/actors", {:notice => "Actor deleted successfully."} )
  end
end
