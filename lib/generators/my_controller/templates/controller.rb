class <%= controller_class_name %>Controller < ApplicationController
  def index
    @<%= plural_name %> = <%= class_name %>.find(:all)
  end

  def new
    @<%= file_name %> = <%= class_name %>.new
  end

  def create
    @<%= file_name %> = <%= class_name %>.new(params[:<%= file_name %>])
    if @<%= file_name %>.save
      flash[:notice] = 'The <%= class_name %> was created.'
      redirect_to <%= file_name %>_path(@<%= file_name %>)
    else
      render :action => "new"
    end
  end
  
  def edit
    @<%= file_name %> = <%= class_name %>.find(params[:id])
  end

  def update
    @<%= file_name %> = <%= class_name %>.find(params[:id])

    if @<%= file_name %>.update_attributes(params[:<%= file_name %>])
      flash[:notice] = 'The <%= class_name %> was updated.'
      redirect_to <%= file_name %>_path(@<%= file_name %>)
    else
      render :action => "edit"
    end
  end
  
  def show
    @<%= file_name %> = <%= class_name %>.find(params[:id])
  end

  def destroy
    <%= class_name %>.destroy(params[:id])
    flash[:notice] = 'The <%= class_name %> was deleted.'
    redirect_to <%= plural_name %>_path
  end
end
