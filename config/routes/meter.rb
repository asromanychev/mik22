namespace :meter do
  root 'dashboard#show'
  get 'vah_mets/index'
  get 'vah_mets/dashboard'
  post 'vah_mets/search'

  get 'components/alert'
  get "components/tabs"
  get 'tables/general'
  get "tables/data"
  get 'charts/chartjs'
  get 'charts/apexcharts'
  get 'charts/echarts'
end
