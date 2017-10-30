Rails.application.routes.draw do

  get 'readamcmst/messages'
  get 'readamcmst/read_amc_mst' # 1. AMC MASTER
  get 'amc_keyperson/read_amc_keyperson' # 2. AMC KEY PERSON
  get 'asset_alloc_mast/read_asset_alloc_mast' # 3. ASSET ALLOCATION MASTER – NEW MASTER
  get 'currentnav/read_currentnav' # 4. DAILY NAV
  get 'custodian_master/read_cust_mast' # 5. CUSTODIAN MASTER
  get 'dividend_master/read_div_mast' # 6. DIVIDEND MASTER
  get 'dividend_details/read_div_details' # 7. DIVIDEND DETAILS
  get 'loadtype_mast/read_loadtype_mast' # 8. LOAD TYPE MASTER
  get 'absolute_return/read_absolute_return' # 9. ABSOLUTE RETURN
  get 'annual_return/read_annual_return' # 10. ANNUALIZED RETURN
  get 'nav_history/read_nav_history' #11. HISTORICAL NAV FULL------------------------------------------------
  get 'navhistfull_adjnav/read_nav_history' #11. HISTORICAL NAV FULL Latest ------------------------------------------
  get 'option_mast/read_option_mast' # 12. OPTION MASTER
  get 'plan_mast/read_plan_master' # 13. PLAN MASTER
  get 'reg_mst/read_registrar_mst' # 14. REGISTRAR MASTER
  get 'scheme_asset/read_scheme_ass' # 15. SCHEME ASSET ALLOCATION
  get 'scheme_full/read_scheme_full'  # 16. SCHEME DETAILS FULL-----------------------------------------------
  get 'scheme_master/read_scheme_mstr' # 17. SCHEME MASTER
  get 'scheme_obj/read_scheme_obj' # 18. SCHEME OBJECTIVE----------------------------------------------------
  get 'schemeload/read_schemeload' # 19. SCHEME LOAD
  get 'sclassmaster/read_sclassmaster' # 20. SCHEME CLASS MASTER
  get 'sector_allocation/read_sector_allocation' # 21. SECTOR ALLOCATION
  get 'sect_mst/read_sector_mast' # 22. SECTOR MASTER
  get 'theme_mastr/read_theme_mast' # 23. THEME MASTER
  get 'type_mastr/read_type_mast' # 24. TYPE MASTER
  get 'expense_rat/read_expense_ratio' # 25. EXPENSE RATIO
  get 'mf_indexmst/read_mfindex_mstr' # 26. MF INDEX MASTER
  get 'all_funds/read_allfund_mst'  # 27. ALL FUNDS - WH AT’S IN - WHAT’ S O UT
  get 'avg_maturity/read_avg_maturity' # 28. AVERAGE MATURITY
  get 'mufu_ratios/read_mufu_rat' # 29. MUTUAL FUND RATIOS
  get 'scheme_index/read_scheme_index' # 30. SCHEME INDEX
  get 'pepb_ratio/read_pepb_ratio' # 31. PE / PB RATIO
  get 'benchmark_history/read_bm_indices'# 32. BENCHMARK HIST DATA
  get 'weekhigh_low/read_week_high' # 33. 52 WEEK HIGH LOW
  get 'scheme_return/read_scheme_return' # 34. SCHEME RETURN
  get 'scheme_aum/read_scheme_aum' # 35. SCHEME AUM
  get 'amc_aum/read_amc_aum' # 36. AMC AUM
  get 'fundmanager/read_fundmanager'  # 37. FUNDMANAGER MASTER ----------------------------------------------
  get 'mf_sip/read_sip'  # 38. MF_SIP
  get 'mf_swpc/read_mf_swp'  # 39. MF_SWP
  get 'mf_stps/read_mf_stp'  # 40. MF_STP
  get 'portfolio/read_portfolio' # 41. PORTFOLIO
  get 'mutual_fundcompany/read_mutual_fund'  # 42. COMPANY MASTER NEW
  get 'industry_master/read_indus_master'   # 43. INDUSTRY MASTER --------------------------------------------
  get 'fmp_yielddetials/read_fmp_yielddetials' # 44. FMP DETAILS
  get 'scheme_avgaum/read_scheme_avgaum'  # 45. SCHEME AVG AUM
  get 'avg_amc/read_avg_amc'   # 46. AVG AMC AUM
  get 'sipswpdetails/read_sipswpdetails' # 47. SIP/SWP DETAILS -----------------------------------------------
  get 'fvchange/read_fvchange'  # 48. FACE VALUE CHANGE
  get 'marketcap/read_marketcap'     # 49. MARKET CAP  ---   Ftp_Techdoc_MCap_1.0
  get 'avg_amc_aum/read_avg_amc_aum'  # 50. AVG AMC AUM NEW
  get 'rupeevest_ratings/read_rupeevest_rating'  # Reading Rupeevest Data from csv file and inserting into database
  get 'home/index'
  post 'home/index1_latest'
  post 'home/index_latest'
  get 'home/index_latest'
  get 'home/index2_latest'
  post 'home/index'
  post 'home/index_search'
  get 'home/snapshot_final'
  get 'home/index1_latest'
  get 'home/get_search_data'
  get 'home/stock_page'
  get 'home/sector_page'
  get 'home/get_sector_search'
  post 'home/get_sector_data'
  post 'home/get_stock_data'
  get 'home/get_stock_search'
  get 'home/get_holding_asset'
  get 'home/get_landing_index'
  get 'home/get_landing_amc'
  get 'home/get_landing_fundmanager'
  get 'functionalities/get_amc_msts'
  get 'functionalities/get_current_nav_value'
  get 'functionalities/get_fund_manager'
  get 'functionalities/get_aum_totalvalue'
  get 'functionalities/get_scheme_name'
  get 'functionalities/get_inception_date'
  get 'home/filters_values'

  get 'functionalities/get_fund_data'

  get 'functionalities/get_exit_load'
  get 'functionalities/get_expense_ratio'
  get 'functionalities/get_inception_return'
  get 'functionalities/get_turnover_ratio'
  get 'functionalities/get_minimum_investment'
  get 'functionalities/get_onemonth_return'
  get 'functionalities/get_threemonth_return'
  get 'functionalities/get_sixmonth_return'
  get 'functionalities/get_oneyear_return'
  get 'functionalities/get_twoyear_return'
  get 'functionalities/get_threeyear_return'
  get 'functionalities/get_fiveyear_return'
  get 'functionalities/get_standard_deviation'
  get 'functionalities/get_beta_scheme'
  get 'functionalities/get_sharp_ratio'
  get 'functionalities/get_alpha_scheme'
  get 'functionalities/get_sortino_ratio'
  get 'functionalities/get_protfolio_graph'

  get 'mcap_classification/get_mcap_classification'
  get 'mcap_classification/get_scheme_classification'
  get 'mcap_classification/avg_maturity_calc'
  get 'functionalities/schemedata_landing'
  get 'functionalities/get_recent_updates'
  get 'functionalities/star_rating'

  get 'home/get_search_data'
  post 'functionalities/globalvar'
  post 'functionalities/asset_class_section'


  get 'mutual_news/read_mutual_news'

  get 'avg_scheme_aum/read_avg_scheme_aum'
  get 'functionalities/get_growth_plan'
  get 'functionalities/asect_allocation_chart'
  get 'functionalities/get_concentration_value'
  get 'functionalities/get_dividend_data'
  get 'functionalities/get_peer_comparision'
  get 'functionalities/get_return_data'
  get 'functionalities/get_risk_measures'
  get 'functionalities/portfolio_holdings'
  get 'functionalities/get_protfolio_avgmarketcap'
  get 'functionalities/get_returns_year'
  get 'functionalities/sector'
  get 'functionalities/stock'
  get 'ftpdownloader/filesdownloader'
  get 'portfolio_holdings/portfolio_holdings'
  get 'sector/sector'
  get 'stock/stock'
  get 'landing_page/homedata'
  get 'landing_page/rupeevest_category_returns'
  get 'landing_page/rupeevest_category_riskmeasures'
  get 'landing_page/annual_returns_10years'
  get 'landing_page/annual_returns_10months'
  get 'landing_page/annual_returns_10quarters'
  get 'landing_page/aqm_returns_year_ranking'
  get 'landing_page/aqm_returns_quarter_ranking'
  get 'landing_page/aqm_returns_month_ranking'
  get 'landing_page/aqm_returns_average'
  get 'sect_allocation_catavg/sect_alloc_catavg'
  get 'sect_allocation_catavg/rupeevest_sector_category_average'
  get 'sect_allocation_catavg/sector_holdperc'
  get 'sect_allocation_catavg/sector_holdperc_quarterly'
  get 'fund_comparision/get_compare_value'
  get 'home/comparison'
  get 'home/get_landing_returns'
  get 'functionalities/portfolio_markettable'
  get 'functionalities/portfolio_markettable_avgmcap'
  get 'functionalities/portfolio_markettable_allcapavgs'
  get 'functionalities/navgraph'
  get 'landing_page/navgraph'
  get 'home/yrs'
  get 'functionalities/credit_rating'
  get 'landing_page/credit_rating_logic'
  get 'landing_page/credit_rating_logic_group'

 # patch 'read_file_split_data' => 'readamcmst#read_file_split_data',:as => 'read_file_split_data'
  resources :products
	# get 'welcome/index'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'home#index1_latest'
   resources :readamcmst
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
