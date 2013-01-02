module InventoryV0
  class API < Grape::API
    version 'v0', :using => :path
    format :json

    resource :units do
      resource :blah do
        desc "Get All Units"
        get "/" do
          Unit.limit(5)
        end

        desc "Return a unit"
        params do
          requires :id, :type => Integer
        end
        get ':id' do
          Unit.find(params[:id]) rescue "There is no unit with id of #{params[:id]}"
        end
      end
    end
  end
end
