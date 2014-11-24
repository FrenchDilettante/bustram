module V1
  class Root < Grape::API
    mount V1::StopsApi
  end
end
