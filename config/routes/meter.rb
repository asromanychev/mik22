namespace :meter do
  root 'dashboard#show'
  get 'vah/meterings'
  get 'vah/dashboard'
  get 'components/alert'
  get "components/tabs"
  get 'tables/general'
  get "tables/data"
  get 'charts/chartjs'
  get 'charts/apexcharts'
  get 'charts/echarts'
end
