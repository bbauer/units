module Inventory
  class API < Grape::API
    version 'v1', :using => :path
    format :json

    resource :units do
      desc "Get All Units"
      get "/" do
        Unit.all
      end

      desc "Return a unit"
      params do
        requires :id, :type => Integer
      end
      get ':id' do
        Unit.find(params[:id]) rescue "There is no unit with id of #{params[:id]}"
      end

      resource :search do
        desc "Return a unit set based on query"
        get ':keywords' do
          keywords = params[:keywords].split("+")
          Unit.where([(['description LIKE ?'] * keywords.size).join(' AND ')] + keywords.map { |k| "%#{k}%" })
        end
      end
    end
  end
end
