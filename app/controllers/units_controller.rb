class UnitsController < ApplicationController
  def index
    @units = Unit.all
    @features = collect_unique_features(@units).reject { |f| f == "Parking" || f == "Wine Storage" }
    @storage_units = @units.select { |u| u.category.blank?  }
    @parking_units = @units.select { |u| u.category == "Parking" }
    @wine_units = @units.select { |u| u.category == "Wine" }
    @sizes = {
      :small     => "0-100",
      :medium    => "100-300",
      :large     => "300-500",
      :warehouse => "501"
    }

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @units }
    end
  end

  def show
    @unit = Unit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @unit }
    end
  end

  def new
    @unit = Unit.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @unit }
    end
  end

  def edit
    @unit = Unit.find(params[:id])
  end

  def create
    @unit = Unit.new(params[:unit])

    respond_to do |format|
      if @unit.save
        format.html { redirect_to @unit, :notice => 'Unit was successfully created.' }
        format.json { render :json => @unit, :status => :created, :location => @unit }
      else
        format.html { render :action => "new" }
        format.json { render :json => @unit.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @unit = Unit.find(params[:id])

    respond_to do |format|
      if @unit.update_attributes(params[:unit])
        format.html { redirect_to @unit, :notice => 'Unit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @unit.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @unit = Unit.find(params[:id])
    @unit.destroy

    respond_to do |format|
      format.html { redirect_to units_url }
      format.json { head :no_content }
    end
  end

  private

  def collect_unique_features(units)
    features = []

    units.each do |unit|
      unit.description.split(", ").each { |f| features << f }
    end

    features.uniq
  end
end
