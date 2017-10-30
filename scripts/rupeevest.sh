
#!/bin/sh
HOST='ftpservice.acesphere.com'
USERNAME='rupeevest'
PASSWD='Rup$02F16'
SOURCEDIR='/mutualfund/$CURRDATE'
#SOURCEDIR='/mutualfund/21092016'
#TARGETDIR='../data'
#ARCDIR='../arc'
TARGETDIR='/var/www/MF_Rupeevest/rails/app/assets/files'
ARCDIR='/var/www/MF_Rupeevest/arc'
CWD=`pwd`
CURRDATE=`date +%d%m%Y`
cd $TARGETDIR
for filename in `ls`
do
        fname=`echo $filename`
        fname+=`echo $CURRDATE`
        mv $filename /var/www/MF_Rupeevest/arc/$fname
done

cd $CWD

ftp -in -v $HOST << EOF
user $USERNAME $PASSWD
cd /mutualfund/$CURRDATE
lcd /var/www/MF_Rupeevest/rails/app/assets/files
mget *.*
bye
EOF
#cd ../data
cd /var/www/MF_Rupeevest/rails/app/assets/files
for filename in `ls`
do
        fname=`echo $filename|tr '[:upper:]' '[:lower:]' `
        mv $filename $fname
done
cd $CWD
wget http://rupeevest.langoorqa.net/readamcmst/read_amc_mst
wget http://rupeevest.langoorqa.net/amc_keyperson/read_amc_keyperson
wget http://rupeevest.langoorqa.net/asset_alloc_mast/read_asset_alloc_mast
wget http://rupeevest.langoorqa.net/currentnav/read_currentnav
wget http://rupeevest.langoorqa.net/custodian_master/read_cust_mast
wget http://rupeevest.langoorqa.net/dividend_master/read_div_mast
wget http://rupeevest.langoorqa.net/dividend_details/read_div_details
wget http://rupeevest.langoorqa.net/loadtype_mast/read_loadtype_mast
wget http://rupeevest.langoorqa.net/absolute_return/read_absolute_return
wget http://rupeevest.langoorqa.net/annual_return/read_annual_return
wget http://rupeevest.langoorqa.net/nav_history/read_nav_history
wget http://rupeevest.langoorqa.net/navhistfull_adjnav/read_nav_history
wget http://rupeevest.langoorqa.net/option_mast/read_option_mast
wget http://rupeevest.langoorqa.net/plan_mast/read_plan_master
wget http://rupeevest.langoorqa.net/reg_mst/read_registrar_mst
wget http://rupeevest.langoorqa.net/scheme_asset/read_scheme_ass
wget http://rupeevest.langoorqa.net/scheme_full/read_scheme_full
wget http://rupeevest.langoorqa.net/scheme_master/read_scheme_mstr
wget http://rupeevest.langoorqa.net/scheme_obj/read_scheme_obj
wget http://rupeevest.langoorqa.net/schemeload/read_schemeload
wget http://rupeevest.langoorqa.net/sclassmaster/read_sclassmaster
wget http://rupeevest.langoorqa.net/sector_allocation/read_sector_allocation
wget http://rupeevest.langoorqa.net/sect_mst/read_sector_mast
wget http://rupeevest.langoorqa.net/theme_mastr/read_theme_mast
wget http://rupeevest.langoorqa.net/type_mastr/read_type_mast
wget http://rupeevest.langoorqa.net/expense_rat/read_expense_ratio
wget http://rupeevest.langoorqa.net/mf_indexmst/read_mfindex_mstr
wget http://rupeevest.langoorqa.net/all_funds/read_allfund_mst
wget http://rupeevest.langoorqa.net/avg_maturity/read_avg_maturity
wget http://rupeevest.langoorqa.net/mufu_ratios/read_mufu_rat
wget http://rupeevest.langoorqa.net/scheme_index/read_scheme_index
wget http://rupeevest.langoorqa.net/pepb_ratio/read_pepb_ratio
wget http://rupeevest.langoorqa.net/benchmark_history/read_bm_indices
wget http://rupeevest.langoorqa.net/weekhigh_low/read_week_high
wget http://rupeevest.langoorqa.net/scheme_return/read_scheme_return
wget http://rupeevest.langoorqa.net/scheme_aum/read_scheme_aum
wget http://rupeevest.langoorqa.net/amc_aum/read_amc_aum
wget http://rupeevest.langoorqa.net/fundmanager/read_fundmanager
wget http://rupeevest.langoorqa.net/mf_sip/read_sip
wget http://rupeevest.langoorqa.net/mf_swpc/read_mf_swp
wget http://rupeevest.langoorqa.net/mf_stps/read_mf_stp
wget http://rupeevest.langoorqa.net/portfolio/read_portfolio
wget http://rupeevest.langoorqa.net/mutual_fundcompany/read_mutual_fund
wget http://rupeevest.langoorqa.net/industry_master/read_indus_master
wget http://rupeevest.langoorqa.net/fmp_yielddetials/read_fmp_yielddetials
wget http://rupeevest.langoorqa.net/scheme_avgaum/read_scheme_avgaum
wget http://rupeevest.langoorqa.net/avg_amc/read_avg_amc
wget http://rupeevest.langoorqa.net/fvchange/read_fvchange
wget http://rupeevest.langoorqa.net/marketcap/read_marketcap
wget http://rupeevest.langoorqa.net/avg_amc_aum/read_avg_amc_aum
#wget http://rupeevest.langoorqa.net/rupeevest_ratings/read_rupeevest_rating

wget http://rupeevest.langoorqa.net/landing_page/homedata
wget http://rupeevest.langoorqa.net/landing_page/rupeevest_category_returns
wget http://rupeevest.langoorqa.net/landing_page/rupeevest_category_riskmeasures
wget http://rupeevest.langoorqa.net/landing_page/annual_returns_10years
wget http://rupeevest.langoorqa.net/landing_page/annual_returns_10months
wget http://rupeevest.langoorqa.net/landing_page/annual_returns_10quarters
wget http://rupeevest.langoorqa.net/landing_page/aqm_returns_year_ranking
wget http://rupeevest.langoorqa.net/landing_page/aqm_returns_quarter_ranking
wget http://rupeevest.langoorqa.net/landing_page/aqm_returns_month_ranking
wget http://rupeevest.langoorqa.net/landing_page/aqm_returns_average
#wget http://rupeevest.langoorqa.net/sect_allocation_catavg/sect_alloc_catavg
#wget http://rupeevest.langoorqa.net/sect_allocation_catavg/rupeevest_sector_category_average
#wget http://rupeevest.langoorqa.net/sect_allocation_catavg/sector_holdperc
#wget http://rupeevest.langoorqa.net/sect_allocation_catavg/sector_holdperc_quarterly
#wget http://rupeevest.langoorqa.net/landing_page/navgraph
