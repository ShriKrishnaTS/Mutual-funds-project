# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161014062826) do

  create_table "amc_aums", id: false, force: :cascade do |t|
    t.integer  "amc_code", limit: 4,  default: 0, null: false
    t.datetime "aumdate",                         null: false
    t.float    "totalaum", limit: 53
    t.string   "upd_flag", limit: 1
  end

  add_index "amc_aums", ["amc_code"], name: "index_amc_aums_on_amc_code", using: :btree
  add_index "amc_aums", ["aumdate"], name: "index_amc_aums_on_aumdate", using: :btree

  create_table "amc_keypeople", id: false, force: :cascade do |t|
    t.integer "amc_code", limit: 4,   default: 0, null: false
    t.string  "amc_name", limit: 100
    t.integer "srno",     limit: 4,   default: 0, null: false
    t.string  "name",     limit: 50
    t.string  "desg",     limit: 255
    t.string  "upd_flag", limit: 1
  end

  add_index "amc_keypeople", ["amc_code"], name: "index_amc_keypeople_on_amc_code", using: :btree
  add_index "amc_keypeople", ["srno"], name: "index_amc_keypeople_on_srno", using: :btree

  create_table "amc_msts", primary_key: "amc_code", force: :cascade do |t|
    t.string   "amc",          limit: 100
    t.string   "fund",         limit: 100
    t.integer  "srno",         limit: 4
    t.string   "office_type",  limit: 60
    t.string   "add1",         limit: 100
    t.string   "add2",         limit: 100
    t.string   "add3",         limit: 100
    t.string   "email",        limit: 60
    t.string   "phone",        limit: 50
    t.string   "fax",          limit: 50
    t.string   "website",      limit: 100
    t.datetime "setup_date"
    t.string   "mf_type",      limit: 50
    t.string   "trustee_name", limit: 100
    t.string   "sponsor_name", limit: 255
    t.datetime "amc_inc_date"
    t.string   "upd_flag",     limit: 1
  end

  create_table "amc_paums", id: false, force: :cascade do |t|
    t.integer  "amc_code", limit: 4,  default: 0, null: false
    t.datetime "aumdate",                         null: false
    t.float    "totalaum", limit: 53
    t.string   "upd_flag", limit: 1
  end

  add_index "amc_paums", ["amc_code"], name: "index_amc_paums_on_amc_code", using: :btree

  create_table "asect_mst_news", primary_key: "asect_code", force: :cascade do |t|
    t.string "asect_type",      limit: 100
    t.string "asset",           limit: 25
    t.string "upd_flag",        limit: 1
    t.string "rupeevest_asect", limit: 255
  end

  add_index "asect_mst_news", ["asect_code"], name: "index_asect_mst_news_on_asect_code", using: :btree

  create_table "avg_amc_aums", id: false, force: :cascade do |t|
    t.integer  "amc_code", limit: 4,  default: 0, null: false
    t.datetime "aumdate",                         null: false
    t.float    "totalaum", limit: 53
    t.string   "upd_flag", limit: 1
  end

  add_index "avg_amc_aums", ["amc_code"], name: "index_avg_amc_aums_on_amc_code", using: :btree
  add_index "avg_amc_aums", ["aumdate"], name: "index_avg_amc_aums_on_aumdate", using: :btree

  create_table "avg_maturities", id: false, force: :cascade do |t|
    t.integer  "amc_code",       limit: 4
    t.integer  "schemecode",     limit: 4,  default: 0, null: false
    t.datetime "date",                                  null: false
    t.datetime "invenddate"
    t.float    "avg_mat_num",    limit: 53
    t.string   "avg_mat_days",   limit: 10
    t.float    "mod_dur_num",    limit: 53
    t.string   "mod_dur_days",   limit: 10
    t.float    "ytm",            limit: 53
    t.float    "turnover_ratio", limit: 53
    t.string   "tr_mode",        limit: 10
    t.string   "upd_flag",       limit: 1
  end

  add_index "avg_maturities", ["date"], name: "index_avg_maturities_on_date", using: :btree
  add_index "avg_maturities", ["schemecode"], name: "index_avg_maturities_on_schemecode", using: :btree

  create_table "avg_scheme_aums", id: false, force: :cascade do |t|
    t.integer  "schemecode", limit: 4,  default: 0, null: false
    t.datetime "datetime",                          null: false
    t.float    "exfof",      limit: 53
    t.float    "fof",        limit: 53
    t.float    "total",      limit: 53
    t.string   "upd_flag",   limit: 1
  end

  add_index "avg_scheme_aums", ["datetime"], name: "index_avg_scheme_aums_on_datetime", using: :btree
  add_index "avg_scheme_aums", ["schemecode"], name: "index_avg_scheme_aums_on_schemecode", using: :btree

  create_table "bm_indices_res", id: false, force: :cascade do |t|
    t.integer  "index_code",  limit: 4,   default: 0, null: false
    t.datetime "date",                                null: false
    t.float    "dayret_1",    limit: 53
    t.datetime "weekdate_1"
    t.float    "weekclose_1", limit: 53
    t.float    "weekret_1",   limit: 53
    t.datetime "mthdate_1"
    t.float    "mthclose_1",  limit: 53
    t.float    "monthret_1",  limit: 53
    t.datetime "mthdate_3"
    t.float    "mthclose_3",  limit: 53
    t.float    "monthret_3",  limit: 53
    t.datetime "mthdate_6"
    t.float    "mthclose_6",  limit: 53
    t.float    "monthret_6",  limit: 53
    t.datetime "mthdate_9"
    t.float    "mthclose_9",  limit: 53
    t.float    "monthret_9",  limit: 53
    t.datetime "yrdate_1"
    t.float    "yrclose_1",   limit: 53
    t.float    "yrret_1",     limit: 53
    t.datetime "yrdate_2"
    t.float    "yrclose_2",   limit: 53
    t.float    "yrret_2",     limit: 53
    t.datetime "yrdate_3"
    t.float    "yrclose_3",   limit: 53
    t.float    "yrret_3",     limit: 53
    t.datetime "yrdate_4"
    t.float    "yrclose_4",   limit: 53
    t.float    "yrret_4",     limit: 53
    t.datetime "yrdate_5"
    t.float    "yrclose_5",   limit: 53
    t.float    "yrret_5",     limit: 53
    t.datetime "incdate"
    t.float    "incclose",    limit: 53
    t.float    "incret",      limit: 53
    t.datetime "weekdate_2"
    t.float    "weeknav_2",   limit: 24
    t.float    "weekret_2",   limit: 24
    t.datetime "weekdate_3"
    t.float    "weeknav_3",   limit: 53
    t.float    "weekret_3",   limit: 53
    t.datetime "mthdate_2"
    t.float    "mthnav_2",    limit: 53
    t.datetime "monthret_2"
    t.float    "ytddate",     limit: 53
    t.float    "ytdnav",      limit: 53
    t.float    "ytdret",      limit: 53
    t.string   "upd_flag",    limit: 255
  end

  create_table "classification_masters", primary_key: "classification_id", force: :cascade do |t|
    t.string "classification", limit: 255
    t.string "type",           limit: 255
  end

  create_table "credit_rating_sum_groups", id: false, force: :cascade do |t|
    t.integer "schemecode",      limit: 4
    t.string  "classification",  limit: 255
    t.date    "invdate"
    t.float   "holdpercentage",  limit: 53
    t.string  "rupeevest_group", limit: 255
  end

  create_table "credit_rating_sums", id: false, force: :cascade do |t|
    t.integer "schemecode",             limit: 4
    t.string  "classification",         limit: 255
    t.date    "invdate"
    t.float   "holdpercentage",         limit: 53
    t.string  "rupeevest_display_name", limit: 255
  end

  create_table "credit_ratings", id: false, force: :cascade do |t|
    t.string "accord_display_name",    limit: 255
    t.string "rupeevest_display_name", limit: 255
    t.string "rupeevest_group",        limit: 255
  end

  create_table "currentnavs", id: false, force: :cascade do |t|
    t.integer  "schemecode", limit: 4,  default: 0, null: false
    t.datetime "navdate",                           null: false
    t.float    "navrs",      limit: 53
    t.float    "repurprice", limit: 53
    t.float    "saleprice",  limit: 53
    t.datetime "cldate"
    t.float    "change",     limit: 53
    t.float    "netchange",  limit: 53
    t.float    "prevnav",    limit: 53
    t.datetime "prenavdate"
    t.string   "upd_flag",   limit: 1
  end

  add_index "currentnavs", ["schemecode"], name: "index_currentnavs_on_schemecode", using: :btree

  create_table "cust_msts", primary_key: "cust_code", force: :cascade do |t|
    t.string "cust_name",   limit: 150
    t.string "sebi_reg_no", limit: 50
    t.string "add1",        limit: 150
    t.string "add2",        limit: 150
    t.string "add3",        limit: 150
    t.string "upd_flag",    limit: 1
  end

  add_index "cust_msts", ["cust_code"], name: "index_cust_msts_on_cust_code", using: :btree

  create_table "div_msts", primary_key: "div_code", force: :cascade do |t|
    t.string "div_type", limit: 30
    t.string "upd_flag", limit: 1
  end

  add_index "div_msts", ["div_code"], name: "index_div_msts_on_div_code", using: :btree

  create_table "divdetails", id: false, force: :cascade do |t|
    t.integer  "amc_code",     limit: 4
    t.integer  "schemecode",   limit: 4,  default: 0, null: false
    t.datetime "recorddate",                          null: false
    t.integer  "div_code",     limit: 4
    t.datetime "exdivdate"
    t.float    "bonusrate1",   limit: 53
    t.float    "bonusrate2",   limit: 53
    t.float    "gross",        limit: 53
    t.float    "corporate",    limit: 53
    t.float    "noncorporate", limit: 53
    t.string   "status",       limit: 10
    t.string   "upd_flag",     limit: 1
  end

  add_index "divdetails", ["recorddate"], name: "index_divdetails_on_recorddate", using: :btree
  add_index "divdetails", ["schemecode"], name: "index_divdetails_on_schemecode", using: :btree

  create_table "expenceratios", id: false, force: :cascade do |t|
    t.integer  "amc_code",   limit: 4
    t.integer  "schemecode", limit: 4,  default: 0, null: false
    t.datetime "date",                              null: false
    t.float    "exratio",    limit: 53
    t.string   "upd_flag",   limit: 1
  end

  add_index "expenceratios", ["date"], name: "index_expenceratios_on_date", using: :btree
  add_index "expenceratios", ["schemecode"], name: "index_expenceratios_on_schemecode", using: :btree

  create_table "fmp_yielddetails", primary_key: "schemecode", force: :cascade do |t|
    t.datetime "maturitydate"
    t.float    "tenure_number",         limit: 53
    t.string   "tenure_option",         limit: 10
    t.float    "net_inticative_yield1", limit: 53
    t.float    "net_inticative_yield2", limit: 53
    t.float    "post_taxyield_ind1",    limit: 53
    t.float    "post_taxyield_ind2",    limit: 53
    t.float    "post_taxyield_nonind1", limit: 53
    t.float    "post_taxyield_nonind2", limit: 53
    t.string   "exit_load",             limit: 30
    t.string   "upd_flag",              limit: 1
  end

  add_index "fmp_yielddetails", ["schemecode"], name: "index_fmp_yielddetails_on_schemecode", using: :btree

  create_table "fundmanager_masters", primary_key: "fmid", force: :cascade do |t|
    t.string   "initial",       limit: 10
    t.string   "fundmanager",   limit: 200
    t.string   "qualification", limit: 200
    t.string   "experience",    limit: 200
    t.string   "basicdetails",  limit: 1000
    t.string   "designation",   limit: 100
    t.integer  "age",           limit: 4
    t.datetime "reporteddate"
    t.string   "upd_flag",      limit: 1
  end

  add_index "fundmanager_masters", ["fmid"], name: "index_fundmanager_masters_on_fmid", using: :btree

  create_table "fvchanges", id: false, force: :cascade do |t|
    t.integer  "amc_code",    limit: 4,   default: 0, null: false
    t.integer  "schemecode",  limit: 4,   default: 0, null: false
    t.string   "scheme_name", limit: 255
    t.float    "fvbefore",    limit: 53
    t.float    "fvafter",     limit: 53
    t.datetime "fvdate",                              null: false
    t.string   "upd_flag",    limit: 1
  end

  add_index "fvchanges", ["fvdate"], name: "index_fvchanges_on_fvdate", using: :btree
  add_index "fvchanges", ["schemecode"], name: "index_fvchanges_on_schemecode", using: :btree

  create_table "highest_sector", id: false, force: :cascade do |t|
    t.integer "schemecode",     limit: 4,   default: 0, null: false
    t.float   "holdpercentage", limit: 53
    t.string  "sect_name",      limit: 255
  end

  create_table "highest_sector_allocation", id: false, force: :cascade do |t|
    t.integer "schemecode",     limit: 4,   default: 0, null: false
    t.float   "holdpercentage", limit: 53
    t.string  "sect_name",      limit: 255
  end

  create_table "index_msts", primary_key: "indexcode", force: :cascade do |t|
    t.integer "fincode",   limit: 4
    t.string  "scripcode", limit: 6
    t.string  "indexname", limit: 100
    t.string  "upd_flag",  limit: 1
  end

  add_index "index_msts", ["indexcode"], name: "index_index_msts_on_indexcode", using: :btree

  create_table "industrymasters", primary_key: "ind_code", force: :cascade do |t|
    t.string "industry",      limit: 100
    t.string "ind_shortname", limit: 100
    t.string "sector",        limit: 100
    t.string "upd_flag",      limit: 1
  end

  add_index "industrymasters", ["ind_code"], name: "index_industrymasters_on_ind_code", using: :btree

  create_table "landing_page_data", id: false, force: :cascade do |t|
    t.integer  "schemecode",                limit: 4
    t.string   "fund",                      limit: 255
    t.string   "rating",                    limit: 255
    t.float    "aum",                       limit: 53
    t.float    "yrret_1",                   limit: 53
    t.float    "yearret_2",                 limit: 53
    t.float    "yearret_3",                 limit: 53
    t.float    "yearret_5",                 limit: 53
    t.float    "exratio",                   limit: 53
    t.float    "monthret_1",                limit: 53
    t.float    "monthret_3",                limit: 53
    t.float    "mnthret_9",                 limit: 53
    t.float    "sd_x",                      limit: 53
    t.float    "beta_x",                    limit: 53
    t.float    "sharpe_x",                  limit: 53
    t.float    "jalpha_x",                  limit: 53
    t.float    "sortino_x",                 limit: 53
    t.float    "navrs",                     limit: 53
    t.datetime "incdate"
    t.float    "mininv",                    limit: 53
    t.float    "exitload",                  limit: 53
    t.float    "turnover_ratio",            limit: 53
    t.float    "highrst_sector_allocation", limit: 53
    t.float    "total_return",              limit: 53
    t.string   "consistency_of_return",     limit: 255
    t.string   "risk",                      limit: 255
    t.string   "cost_factors",              limit: 255
    t.string   "portfolio_attributes",      limit: 255
    t.float    "yearret_10",                limit: 53
    t.float    "last_10_annual",            limit: 53
    t.float    "last_10_quaterly",          limit: 53
    t.float    "last_10_monthly",           limit: 53
    t.float    "highest_asset_allcation",   limit: 53
    t.float    "avg_maturity",              limit: 53
    t.float    "mod_duraton",               limit: 53
    t.float    "ytm",                       limit: 53
    t.datetime "max_exitload_date"
    t.string   "exitload_remarks",          limit: 255
    t.datetime "max_incdate_date"
    t.datetime "max_turnoverratio_date"
    t.string   "fund_mgr1",                 limit: 255
    t.string   "fund_mgr2",                 limit: 255
    t.string   "fund_mgr3",                 limit: 255
    t.string   "fund_mgr4",                 limit: 255
    t.string   "s_name",                    limit: 255
    t.datetime "navdate"
    t.float    "navchange",                 limit: 53
    t.float    "total",                     limit: 53
  end

  add_index "landing_page_data", ["schemecode"], name: "index_landing_page_data_on_schemecode", using: :btree

  create_table "loadtype_msts", primary_key: "ltypecode", force: :cascade do |t|
    t.string "load",     limit: 50
    t.string "upd_flag", limit: 1
  end

  add_index "loadtype_msts", ["ltypecode"], name: "index_loadtype_msts_on_ltypecode", using: :btree

  create_table "marketcaps", id: false, force: :cascade do |t|
    t.integer  "ps_code",      limit: 4,  default: 0, null: false
    t.float    "mcap_company", limit: 53
    t.datetime "trade_date",                          null: false
    t.string   "upd_flag",     limit: 1
  end

  add_index "marketcaps", ["ps_code"], name: "index_marketcaps_on_ps_code", using: :btree

  create_table "mcap_classifications", primary_key: "ps_code", force: :cascade do |t|
    t.float  "mcap_company",   limit: 53
    t.string "classification", limit: 5
    t.string "remarks1",       limit: 100
    t.string "remarks2",       limit: 100
    t.string "remarks3",       limit: 100
  end

  create_table "mf_abs_returns", id: false, force: :cascade do |t|
    t.float    "schemecode", limit: 53, null: false
    t.datetime "c_date",                null: false
    t.datetime "p_date"
    t.float    "c_nav",      limit: 53
    t.float    "p_nav",      limit: 53
    t.float    "dayret_1",   limit: 53
    t.datetime "weekdate_1"
    t.float    "weeknav_1",  limit: 53
    t.float    "weekret_1",  limit: 53
    t.datetime "mthdate_1"
    t.float    "mthnav_1",   limit: 53
    t.float    "monthret_1", limit: 53
    t.datetime "mthdate_3"
    t.float    "mthnav_3",   limit: 53
    t.float    "monthret_3", limit: 53
    t.datetime "mntdate_6"
    t.float    "mnthnav_6",  limit: 53
    t.float    "monthret_6", limit: 53
    t.datetime "mnthdate_9"
    t.float    "mnthnav_9",  limit: 53
    t.float    "mnthret_9",  limit: 53
    t.datetime "yrdate_1"
    t.float    "yrnav_1",    limit: 53
    t.float    "yrret_1",    limit: 53
    t.datetime "yrdate_2"
    t.float    "yrnav_2",    limit: 53
    t.float    "yearret_2",  limit: 53
    t.datetime "yrdate_3"
    t.float    "yrnav_3",    limit: 53
    t.float    "yearret_3",  limit: 53
    t.datetime "yrdate_4"
    t.float    "yrnav_4",    limit: 53
    t.float    "yearret_4",  limit: 53
    t.datetime "yrdate_5"
    t.float    "yrnav_5",    limit: 53
    t.float    "yearret_5",  limit: 53
    t.datetime "incdate"
    t.float    "incnav",     limit: 53
    t.float    "incret",     limit: 53
    t.string   "upd_flag",   limit: 1
  end

  add_index "mf_abs_returns", ["schemecode"], name: "index_mf_abs_returns_on_schemecode", using: :btree

  create_table "mf_ans_returns", primary_key: "schemecode", force: :cascade do |t|
    t.datetime "c_date"
    t.datetime "p_date"
    t.float    "c_nav",      limit: 53
    t.float    "p_nav",      limit: 53
    t.float    "dayret_1",   limit: 53
    t.datetime "weekdate_1"
    t.float    "weeknav_1",  limit: 53
    t.float    "weekret_1",  limit: 53
    t.datetime "mthdate_1"
    t.float    "mthnav_1",   limit: 53
    t.float    "monthret_1", limit: 53
    t.datetime "mthdate_3"
    t.float    "mthnav_3",   limit: 53
    t.float    "monthret_3", limit: 53
    t.datetime "mntdate_6"
    t.float    "mnthnav_6",  limit: 53
    t.float    "monthret_6", limit: 53
    t.datetime "mnthdate_9"
    t.float    "mnthnav_9",  limit: 53
    t.float    "mnthret_9",  limit: 53
    t.datetime "yrdate_1"
    t.float    "yrnav_1",    limit: 53
    t.float    "yrret_1",    limit: 53
    t.datetime "yrdate_2"
    t.float    "yrnav_2",    limit: 53
    t.float    "yearret_2",  limit: 53
    t.datetime "yrdate_3"
    t.float    "yrnav_3",    limit: 53
    t.float    "yearret_3",  limit: 53
    t.datetime "yrdate_4"
    t.float    "yrnav_4",    limit: 53
    t.float    "yearret_4",  limit: 53
    t.datetime "yrdate_5"
    t.float    "yrnav_5",    limit: 53
    t.float    "yearret_5",  limit: 53
    t.datetime "incdate"
    t.float    "incnav",     limit: 53
    t.float    "incret",     limit: 53
    t.string   "upd_flag",   limit: 1
  end

  add_index "mf_ans_returns", ["schemecode"], name: "index_mf_ans_returns_on_schemecode", using: :btree

  create_table "mf_companymasters", primary_key: "fincode", force: :cascade do |t|
    t.string  "scripcode", limit: 6
    t.string  "symbol",    limit: 50
    t.string  "compname",  limit: 225
    t.string  "s_name",    limit: 150
    t.integer "ind_code",  limit: 4
    t.string  "ind_name",  limit: 50
    t.string  "isin",      limit: 50
    t.string  "status",    limit: 50
    t.string  "upd_flag",  limit: 1
    t.string  "category",  limit: 255
  end

  add_index "mf_companymasters", ["fincode"], name: "index_mf_companymasters_on_fincode", using: :btree

  create_table "mf_companymasters_old", primary_key: "fincode", force: :cascade do |t|
    t.string  "scripcode", limit: 6
    t.string  "symbol",    limit: 50
    t.string  "compname",  limit: 225
    t.string  "s_name",    limit: 150
    t.integer "ind_code",  limit: 4
    t.string  "ind_name",  limit: 50
    t.string  "isin",      limit: 50
    t.string  "status",    limit: 50
    t.string  "upd_flag",  limit: 1
  end

  add_index "mf_companymasters_old", ["fincode"], name: "index_mf_companymasters_on_fincode", using: :btree

  create_table "mf_portfolios", id: false, force: :cascade do |t|
    t.integer  "schemecode",     limit: 4,   default: 0, null: false
    t.datetime "invdate",                                null: false
    t.datetime "invenddate"
    t.integer  "srno",           limit: 4,   default: 0, null: false
    t.integer  "fincode",        limit: 4
    t.integer  "asect_code",     limit: 4
    t.integer  "sect_code",      limit: 4
    t.integer  "noshares",       limit: 4
    t.float    "mktval",         limit: 53
    t.float    "aum",            limit: 53
    t.float    "holdpercentage", limit: 53
    t.string   "compname",       limit: 255
    t.string   "sect_name",      limit: 255
    t.string   "asect_name",     limit: 255
    t.string   "rating",         limit: 100
    t.string   "upd_flag",       limit: 1
  end

  add_index "mf_portfolios", ["invdate"], name: "index_mf_portfolios_on_invdate", using: :btree
  add_index "mf_portfolios", ["schemecode", "invdate", "fincode", "holdpercentage"], name: "portfolioindex", using: :btree
  add_index "mf_portfolios", ["schemecode"], name: "index_mf_portfolios_on_schemecode", using: :btree
  add_index "mf_portfolios", ["srno"], name: "index_mf_portfolios_on_srno", using: :btree

  create_table "mf_portfolios1", id: false, force: :cascade do |t|
    t.integer  "schemecode",     limit: 4,   default: 0, null: false
    t.datetime "invdate",                                null: false
    t.datetime "invenddate"
    t.integer  "srno",           limit: 4,   default: 0, null: false
    t.integer  "fincode",        limit: 4
    t.integer  "asect_code",     limit: 4
    t.integer  "sect_code",      limit: 4
    t.integer  "noshares",       limit: 4
    t.float    "mktval",         limit: 53
    t.float    "aum",            limit: 53
    t.float    "holdpercentage", limit: 53
    t.string   "compname",       limit: 255
    t.string   "sect_name",      limit: 255
    t.string   "asect_name",     limit: 255
    t.string   "rating",         limit: 100
    t.string   "upd_flag",       limit: 1
  end

  add_index "mf_portfolios1", ["invdate"], name: "index_mf_portfolios_on_invdate", using: :btree
  add_index "mf_portfolios1", ["schemecode"], name: "index_mf_portfolios_on_schemecode", using: :btree
  add_index "mf_portfolios1", ["srno"], name: "index_mf_portfolios_on_srno", using: :btree

  create_table "mf_ratios", id: false, force: :cascade do |t|
    t.integer  "schemecode",   limit: 4,  default: 0, null: false
    t.datetime "upddate",                             null: false
    t.datetime "datefrom"
    t.datetime "dateto"
    t.float    "avg_x",        limit: 53
    t.float    "avg_y",        limit: 53
    t.float    "sd_x",         limit: 53
    t.float    "sd_y",         limit: 53
    t.float    "semisd_x",     limit: 53
    t.float    "semisd_y",     limit: 53
    t.float    "beta_x",       limit: 53
    t.float    "beta_y",       limit: 53
    t.float    "corelation_x", limit: 53
    t.float    "corelation_y", limit: 53
    t.float    "betacor_x",    limit: 53
    t.float    "betacor_y",    limit: 53
    t.float    "treynor_x",    limit: 53
    t.float    "treynor_y",    limit: 53
    t.float    "fama_x",       limit: 53
    t.float    "fama_y",       limit: 53
    t.float    "sharpe_x",     limit: 53
    t.float    "sharpe_y",     limit: 53
    t.float    "jalpha_x",     limit: 53
    t.float    "jalpha_y",     limit: 53
    t.float    "sortino_x",    limit: 53
    t.float    "sortino_y",    limit: 53
    t.string   "upd_flag",     limit: 1
  end

  add_index "mf_ratios", ["schemecode"], name: "index_mf_ratios_on_schemecode", using: :btree

  create_table "mf_returns", id: false, force: :cascade do |t|
    t.float    "schemecode", limit: 53, null: false
    t.datetime "c_date",                null: false
    t.datetime "p_date"
    t.float    "c_nav",      limit: 53
    t.float    "p_nav",      limit: 53
    t.float    "dyaret_1",   limit: 53
    t.datetime "weekdate_1"
    t.float    "weeknav_1",  limit: 53
    t.float    "weekret_1",  limit: 53
    t.datetime "mthdate_1"
    t.float    "mthnav_1",   limit: 53
    t.float    "monthret_1", limit: 53
    t.datetime "mthdate_3"
    t.float    "mthnav_3",   limit: 53
    t.float    "monthret_3", limit: 53
    t.datetime "mntdate_6"
    t.float    "mnthnav_6",  limit: 53
    t.float    "monthret_6", limit: 53
    t.datetime "mnthdate_9"
    t.float    "mnthnav_9",  limit: 53
    t.float    "mnthret_9",  limit: 53
    t.datetime "yrdate_1"
    t.float    "yrnav_1",    limit: 53
    t.float    "yrret_1",    limit: 53
    t.datetime "yrdate_2"
    t.float    "yrnav_2",    limit: 53
    t.float    "yearret_2",  limit: 53
    t.datetime "yrdate_3"
    t.float    "yrnav_3",    limit: 53
    t.float    "yearret_3",  limit: 53
    t.datetime "yrdate_4"
    t.float    "yrnav_4",    limit: 53
    t.float    "yearret_4",  limit: 53
    t.datetime "yrdate_5"
    t.float    "yrnav_5",    limit: 53
    t.float    "yearret_5",  limit: 53
    t.datetime "incdate"
    t.float    "incnav",     limit: 53
    t.float    "incret",     limit: 53
    t.string   "upd_flag",   limit: 1
  end

  add_index "mf_returns", ["schemecode"], name: "index_mf_returns_on_schemecode", using: :btree

  create_table "mf_sips", id: false, force: :cascade do |t|
    t.integer "schemecode",     limit: 4,    default: 0,  null: false
    t.integer "amc_code",       limit: 4
    t.string  "frequency",      limit: 100,  default: "", null: false
    t.string  "sip",            limit: 1
    t.string  "sipdates",       limit: 255
    t.integer "sipdays1",       limit: 4
    t.integer "sipdays2",       limit: 4
    t.integer "sipdays3",       limit: 4
    t.integer "sipdays4",       limit: 4
    t.integer "sipdays5",       limit: 4
    t.integer "sipdays6",       limit: 4
    t.integer "sipdays7",       limit: 4
    t.float   "sipmininvest",   limit: 53
    t.float   "sipaddninvest",  limit: 53
    t.integer "sipfrequencyno", limit: 4
    t.float   "maxentryload",   limit: 53
    t.float   "maxexitload",    limit: 53
    t.string  "entry_remark",   limit: 1000
    t.string  "exit_remark",    limit: 1000
    t.string  "note",           limit: 255
    t.string  "upd_flag",       limit: 1
  end

  add_index "mf_sips", ["frequency"], name: "index_mf_sips_on_frequency", using: :btree
  add_index "mf_sips", ["schemecode"], name: "index_mf_sips_on_schemecode", using: :btree

  create_table "mf_stps", id: false, force: :cascade do |t|
    t.integer "schemecode",     limit: 4,   default: 0,  null: false
    t.integer "amc_code",       limit: 4
    t.string  "frequency",      limit: 100, default: "", null: false
    t.string  "stpinout",       limit: 1,   default: "", null: false
    t.string  "stp",            limit: 1
    t.string  "stpfrequency",   limit: 20
    t.string  "stpdates",       limit: 225
    t.integer "stpdays1",       limit: 4
    t.integer "stpdays2",       limit: 4
    t.integer "stpdays3",       limit: 4
    t.integer "stpdays4",       limit: 4
    t.integer "stpdays5",       limit: 4
    t.integer "stpdays6",       limit: 4
    t.integer "stpdays7",       limit: 4
    t.float   "stpmininvest",   limit: 53
    t.float   "stpaddninvest",  limit: 53
    t.integer "stpfrequencyno", limit: 4
    t.string  "upd_flag",       limit: 1
  end

  add_index "mf_stps", ["frequency"], name: "index_mf_stps_on_frequency", using: :btree
  add_index "mf_stps", ["schemecode"], name: "index_mf_stps_on_schemecode", using: :btree
  add_index "mf_stps", ["stpinout"], name: "index_mf_stps_on_stpinout", using: :btree

  create_table "mf_swps", id: false, force: :cascade do |t|
    t.integer "schemecode",     limit: 4,   default: 0,  null: false
    t.integer "amc_code",       limit: 4
    t.string  "frequency",      limit: 100, default: "", null: false
    t.string  "swp",            limit: 1
    t.string  "swpdates",       limit: 255
    t.integer "swpdays1",       limit: 4
    t.integer "swpdays2",       limit: 4
    t.integer "swpdays3",       limit: 4
    t.integer "swpdays4",       limit: 4
    t.integer "swpdays5",       limit: 4
    t.integer "swpdays6",       limit: 4
    t.integer "swpdays7",       limit: 4
    t.float   "swpmininvest",   limit: 53
    t.float   "swpaddninvest",  limit: 53
    t.integer "swpfrequencyno", limit: 4
    t.string  "upd_flag",       limit: 1
  end

  add_index "mf_swps", ["frequency"], name: "index_mf_swps_on_frequency", using: :btree
  add_index "mf_swps", ["schemecode"], name: "index_mf_swps_on_schemecode", using: :btree

  create_table "mfi_news", id: false, force: :cascade do |t|
    t.integer "news_id",         limit: 4
    t.string  "section_name",    limit: 50
    t.string  "subsection_name", limit: 50
    t.date    "date"
    t.string  "time",            limit: 5
    t.string  "headline",        limit: 150
    t.string  "summary",         limit: 250
    t.string  "details_news",    limit: 1024
    t.string  "amccode",         limit: 100
    t.string  "schemecode",      limit: 100
    t.string  "upd_flag",        limit: 1
  end

  add_index "mfi_news", ["news_id"], name: "index_mfi_news_on_news_id", using: :btree

  create_table "navgraphs", id: false, force: :cascade do |t|
    t.integer  "schemecode",    limit: 4
    t.datetime "navdate"
    t.float    "month6_yvalue", limit: 53
    t.float    "year1_yvalue",  limit: 53
    t.float    "year3_yvalue",  limit: 53
    t.float    "year5_yvalue",  limit: 53
  end

  create_table "navhist_hls", primary_key: "schemecode", force: :cascade do |t|
    t.float    "monthhhigh_3", limit: 53
    t.float    "monthlow_3",   limit: 53
    t.datetime "mhdate_3"
    t.datetime "mldate_3"
    t.float    "monthhhigh_6", limit: 53
    t.float    "monthlow_6",   limit: 53
    t.datetime "mhdate_6"
    t.datetime "mldate_6"
    t.float    "monthhhigh_9", limit: 53
    t.float    "monthlow_9",   limit: 53
    t.datetime "mhdate_9"
    t.datetime "mldate_9"
    t.float    "weekhhigh_52", limit: 53
    t.float    "weeklow_52",   limit: 53
    t.datetime "whdate_52"
    t.datetime "wldate_52"
    t.float    "yrhigh_1",     limit: 53
    t.float    "yrlow_1",      limit: 53
    t.datetime "yhdate_1"
    t.datetime "yldate_1"
    t.float    "yrhigh_2",     limit: 53
    t.float    "yrlow_2",      limit: 53
    t.datetime "yhdate_2"
    t.datetime "yldate_2"
    t.float    "yrhigh_3",     limit: 53
    t.float    "yrlow_3",      limit: 53
    t.datetime "yhdate_3"
    t.datetime "yldate_3"
    t.float    "yrhigh_5",     limit: 53
    t.float    "yrlow_5",      limit: 53
    t.datetime "yhdate_5"
    t.datetime "yldate_5"
    t.float    "ytdhigh",      limit: 53
    t.float    "ytdlow",       limit: 53
    t.datetime "ytdhdate"
    t.datetime "ytdldate"
    t.float    "sihigh",       limit: 53
    t.float    "silow",        limit: 53
    t.datetime "sihdate"
    t.datetime "sildate"
    t.string   "upd_flag",     limit: 1
  end

  add_index "navhist_hls", ["schemecode"], name: "index_navhist_hls_on_schemecode", using: :btree

  create_table "navhistfull1", id: false, force: :cascade do |t|
    t.float    "schemecode",       limit: 53, null: false
    t.datetime "navdate",                     null: false
    t.float    "navrs",            limit: 53
    t.float    "repurprice",       limit: 53
    t.float    "saleprice",        limit: 53
    t.float    "adjustednav_c",    limit: 53
    t.float    "adjustednav_nonc", limit: 53
    t.string   "upd_flag",         limit: 1
  end

  add_index "navhistfull1", ["navdate"], name: "index_navhistfulls_on_navdate", using: :btree
  add_index "navhistfull1", ["schemecode"], name: "index_navhistfulls_on_schemecode", using: :btree

  create_table "navhistfull_adjnav_1", id: false, force: :cascade do |t|
    t.integer "schemecode", limit: 4,   default: 0,  null: false
    t.string  "navdate",    limit: 255, default: "", null: false
    t.float   "navrs",      limit: 53
    t.float   "adjnavrs",   limit: 53
    t.float   "repurprice", limit: 53
    t.float   "saleprice",  limit: 53
    t.string  "upd_flag",   limit: 255
  end

  create_table "navhistfulls", id: false, force: :cascade do |t|
    t.float    "schemecode",       limit: 53, null: false
    t.datetime "navdate",                     null: false
    t.float    "navrs",            limit: 53
    t.float    "repurprice",       limit: 53
    t.float    "saleprice",        limit: 53
    t.float    "adjustednav_c",    limit: 53
    t.float    "adjustednav_nonc", limit: 53
    t.string   "upd_flag",         limit: 1
  end

  add_index "navhistfulls", ["navdate"], name: "index_navhistfulls_on_navdate", using: :btree
  add_index "navhistfulls", ["schemecode"], name: "index_navhistfulls_on_schemecode", using: :btree

  create_table "options_masts", primary_key: "opt_code", force: :cascade do |t|
    t.string "option",   limit: 50
    t.string "upd_flag", limit: 1
  end

  add_index "options_masts", ["opt_code"], name: "index_options_masts_on_opt_code", using: :btree

  create_table "pe_pb_ratios", id: false, force: :cascade do |t|
    t.integer "schemecode", limit: 4,  default: 0, null: false
    t.integer "monthend",   limit: 4,  default: 0, null: false
    t.float   "mcap",       limit: 53
    t.float   "pe",         limit: 53
    t.float   "pb",         limit: 53
    t.string  "upd_flag",   limit: 1
  end

  add_index "pe_pb_ratios", ["schemecode"], name: "index_pe_pb_ratios_on_schemecode", using: :btree

  create_table "plan_msts", primary_key: "plan_code", force: :cascade do |t|
    t.string "plan",     limit: 50
    t.string "upd_flag", limit: 1
  end

  add_index "plan_msts", ["plan_code"], name: "index_plan_msts_on_plan_code", using: :btree

  create_table "portfolio_holdings", primary_key: "schemecode", force: :cascade do |t|
    t.string "sect_name",  limit: 255
    t.string "asect_name", limit: 255
    t.string "rating",     limit: 255
    t.float  "weight",     limit: 53
  end

  add_index "portfolio_holdings", ["schemecode"], name: "index_portfolio_holdings_on_schemecode", using: :btree

  create_table "portfolio_inouts", primary_key: "fincode", force: :cascade do |t|
    t.datetime "invdate"
    t.string   "mode",      limit: 5
    t.string   "compname",  limit: 100
    t.string   "s_name",    limit: 50
    t.float    "mkt_value", limit: 53
    t.float    "noshares",  limit: 53
    t.string   "upd_flag",  limit: 1
  end

  add_index "portfolio_inouts", ["fincode"], name: "index_portfolio_inouts_on_fincode", using: :btree

  create_table "portfolio_marketcaps", id: false, force: :cascade do |t|
    t.integer "schemecode",          limit: 4
    t.string  "portfolio_marketcap", limit: 255
    t.decimal "fund",                            precision: 10
    t.decimal "category_avg",                    precision: 10
  end

  add_index "portfolio_marketcaps", ["schemecode"], name: "index_portfolio_marketcaps_on_schemecode", using: :btree

  create_table "portfolioholding_assets", id: false, force: :cascade do |t|
    t.integer "schemecode",      limit: 4
    t.string  "company",         limit: 255
    t.string  "sector",          limit: 255
    t.string  "credit_rating",   limit: 255
    t.decimal "assets",                      precision: 10
    t.decimal "previous_quater",             precision: 10
  end

  add_index "portfolioholding_assets", ["schemecode"], name: "index_portfolioholding_assets_on_schemecode", using: :btree

  create_table "rt_msts", primary_key: "rt_code", force: :cascade do |t|
    t.string "rt_name",     limit: 100
    t.string "sebi_reg_no", limit: 100
    t.string "address1",    limit: 150
    t.string "address2",    limit: 150
    t.string "address3",    limit: 150
    t.string "state",       limit: 50
    t.string "tel",         limit: 100
    t.string "fax",         limit: 50
    t.string "website",     limit: 100
    t.string "reg_address", limit: 225
    t.string "email",       limit: 255
    t.string "upd_flag",    limit: 1
  end

  add_index "rt_msts", ["rt_code"], name: "index_rt_msts_on_rt_code", using: :btree

  create_table "rupeevest_categories", id: false, force: :cascade do |t|
    t.integer "classification_id",  limit: 4
    t.integer "funds_num_ytd",      limit: 4
    t.integer "funds_num_month1",   limit: 4
    t.integer "funds_num_month3",   limit: 4
    t.integer "funds_num_year1",    limit: 4
    t.integer "funds_num_year3",    limit: 4
    t.integer "funds_num_year5",    limit: 4
    t.float   "ytd_avg",            limit: 53
    t.float   "avg_month1",         limit: 53
    t.float   "avg_month3",         limit: 53
    t.float   "avg_year1",          limit: 53
    t.float   "avg_year3",          limit: 53
    t.float   "avg_year5",          limit: 53
    t.float   "avg_std_dev",        limit: 53
    t.float   "avg_sharpe",         limit: 53
    t.float   "avg_sotino",         limit: 53
    t.float   "avg_beta",           limit: 53
    t.float   "avg_alpha",          limit: 53
    t.float   "avg_treyno",         limit: 53
    t.integer "no_of_funds_total",  limit: 4
    t.float   "avg_stocks_top10",   limit: 53
    t.float   "avg_stocks_top5",    limit: 53
    t.float   "avg_stocks_top3",    limit: 53
    t.float   "avg_num_of_sector",  limit: 53
    t.float   "avg_mod_duration",   limit: 53
    t.float   "avg_mat_avg",        limit: 53
    t.float   "avg_ytm",            limit: 53
    t.float   "avg_10year_return",  limit: 53
    t.float   "avg_9year_return",   limit: 53
    t.float   "avg_8year_return",   limit: 53
    t.float   "avg_7year_return",   limit: 53
    t.float   "avg_6year_return",   limit: 53
    t.float   "avg_5year_return",   limit: 53
    t.float   "avg_4year_return",   limit: 53
    t.float   "avg_3year_return",   limit: 53
    t.float   "avg_2year_return",   limit: 53
    t.float   "avg_1year_return",   limit: 53
    t.float   "avg_martketcap_avg", limit: 53
    t.float   "large_perc_avg",     limit: 53
    t.float   "mid_perc_ave",       limit: 53
    t.float   "small_perc_avg",     limit: 53
  end

  create_table "rupeevest_ratings", primary_key: "schemecode", force: :cascade do |t|
    t.float "total_return",          limit: 53
    t.float "consistency_of_return", limit: 53
    t.float "risk",                  limit: 53
    t.float "cost_factor",           limit: 53
    t.float "portfolio_attributes",  limit: 53
    t.float "rupeevest_rating",      limit: 53
  end

  add_index "rupeevest_ratings", ["schemecode"], name: "index_rupeevest_ratings_on_schemecode", using: :btree

  create_table "rupeevest_returns", id: false, force: :cascade do |t|
    t.integer "schemecode",       limit: 4
    t.float   "return_year1",     limit: 53
    t.float   "return_year2",     limit: 53
    t.float   "return_year3",     limit: 53
    t.float   "return_year4",     limit: 53
    t.float   "return_year5",     limit: 53
    t.float   "return_year6",     limit: 53
    t.float   "return_year7",     limit: 53
    t.float   "return_year8",     limit: 53
    t.float   "return_year9",     limit: 53
    t.float   "return_year10",    limit: 53
    t.integer "rank_year1",       limit: 4
    t.integer "rank_year2",       limit: 4
    t.integer "rank_year3",       limit: 4
    t.integer "rank_year4",       limit: 4
    t.integer "rank_year5",       limit: 4
    t.integer "rank_year6",       limit: 4
    t.integer "rank_year7",       limit: 4
    t.integer "rank_year8",       limit: 4
    t.integer "rank_year9",       limit: 4
    t.integer "rank_year10",      limit: 4
    t.float   "return_month1",    limit: 53
    t.float   "return_month2",    limit: 53
    t.float   "return_month3",    limit: 53
    t.float   "return_month4",    limit: 53
    t.float   "return_month5",    limit: 53
    t.float   "return_month6",    limit: 53
    t.float   "return_month7",    limit: 53
    t.float   "return_month8",    limit: 53
    t.float   "return_month9",    limit: 53
    t.float   "return_month10",   limit: 53
    t.integer "rank_month1",      limit: 4
    t.integer "rank_month2",      limit: 4
    t.integer "rank_month3",      limit: 4
    t.integer "rank_month4",      limit: 4
    t.integer "rank_month5",      limit: 4
    t.integer "rank_month6",      limit: 4
    t.integer "rank_month7",      limit: 4
    t.integer "rank_month8",      limit: 4
    t.integer "rank_month9",      limit: 4
    t.integer "rank_month10",     limit: 4
    t.float   "return_quarter1",  limit: 53
    t.float   "return_quarter2",  limit: 53
    t.float   "return_quarter3",  limit: 53
    t.float   "return_quarter4",  limit: 53
    t.float   "return_quarter5",  limit: 53
    t.float   "return_quarter6",  limit: 53
    t.float   "return_quarter7",  limit: 53
    t.float   "return_quarter8",  limit: 53
    t.float   "return_quarter9",  limit: 53
    t.float   "return_quarter10", limit: 53
    t.integer "rank_quarter1",    limit: 4
    t.integer "rank_quarter2",    limit: 4
    t.integer "rank_quarter3",    limit: 4
    t.integer "rank_quarter4",    limit: 4
    t.integer "rank_quarter5",    limit: 4
    t.integer "rank_quarter6",    limit: 4
    t.integer "rank_quarter7",    limit: 4
    t.integer "rank_quarter8",    limit: 4
    t.integer "rank_quarter9",    limit: 4
    t.integer "rank_quarter10",   limit: 4
  end

  create_table "rupeevest_returns_catavgs", primary_key: "classification_id", force: :cascade do |t|
    t.float "avg_year1",     limit: 53
    t.float "avg_year2",     limit: 53
    t.float "avg_year3",     limit: 53
    t.float "avg_year4",     limit: 53
    t.float "avg_year5",     limit: 53
    t.float "avg_year6",     limit: 53
    t.float "avg_year7",     limit: 53
    t.float "avg_year8",     limit: 53
    t.float "avg_year9",     limit: 53
    t.float "avg_year10",    limit: 53
    t.float "avg_month1",    limit: 53
    t.float "avg_month2",    limit: 53
    t.float "avg_month3",    limit: 53
    t.float "avg_month4",    limit: 53
    t.float "avg_month5",    limit: 53
    t.float "avg_month6",    limit: 53
    t.float "avg_month7",    limit: 53
    t.float "avg_month8",    limit: 53
    t.float "avg_month9",    limit: 53
    t.float "avg_month10",   limit: 53
    t.float "avg_quarter1",  limit: 53
    t.float "avg_quarter2",  limit: 53
    t.float "avg_quarter3",  limit: 53
    t.float "avg_quarter4",  limit: 53
    t.float "avg_quarter5",  limit: 53
    t.float "avg_quarter6",  limit: 53
    t.float "avg_quarter7",  limit: 53
    t.float "avg_quarter8",  limit: 53
    t.float "avg_quarter9",  limit: 53
    t.float "avg_quarter10", limit: 53
  end

  create_table "rupeevest_sect_holdpercs", id: false, force: :cascade do |t|
    t.integer "schemecode",   limit: 4
    t.integer "rv_sect_code", limit: 4
    t.float   "hold_perc",    limit: 53
    t.float   "hold_perc_q1", limit: 53
    t.float   "hold_perc_q2", limit: 53
    t.float   "hold_perc_q3", limit: 53
    t.float   "hold_perc_q4", limit: 53
    t.float   "hold_perc_q5", limit: 53
  end

  create_table "rupeevest_sector_cat_avgs", id: false, force: :cascade do |t|
    t.integer "classification_id", limit: 4
    t.integer "rv_sect_code",      limit: 4
    t.float   "holdpercentage",    limit: 53
    t.float   "cat_avg",           limit: 53
  end

  create_table "rupeevest_sector_industries", id: false, force: :cascade do |t|
    t.integer "rv_sect_code", limit: 4
    t.integer "ind_code",     limit: 4
  end

  create_table "rupeevest_sectors", id: false, force: :cascade do |t|
    t.integer "rv_sect_code", limit: 4
    t.string  "rv_sect_name", limit: 255
  end

  create_table "scheme_assetallocs", id: false, force: :cascade do |t|
    t.integer "schemeinv_id", limit: 4
    t.integer "schemecode",   limit: 4,   default: 0,  null: false
    t.string  "investment",   limit: 700, default: "", null: false
    t.float   "mininv",       limit: 53
    t.float   "maxniv",       limit: 53
    t.string  "upd_flag",     limit: 1
  end

  add_index "scheme_assetallocs", ["investment"], name: "index_scheme_assetallocs_on_investment", using: :btree
  add_index "scheme_assetallocs", ["schemecode"], name: "index_scheme_assetallocs_on_schemecode", using: :btree

  create_table "scheme_aums", id: false, force: :cascade do |t|
    t.integer  "schemecode", limit: 4,  default: 0, null: false
    t.datetime "date",                              null: false
    t.float    "exfof",      limit: 53
    t.float    "fof",        limit: 53
    t.float    "total",      limit: 53
    t.string   "upd_flag",   limit: 1
  end

  add_index "scheme_aums", ["schemecode"], name: "index_scheme_aums_on_schemecode", using: :btree

  create_table "scheme_avg_nums", id: false, force: :cascade do |t|
    t.integer  "schemecode", limit: 4,  default: 0, null: false
    t.datetime "monthend",                          null: false
    t.integer  "amc_code",   limit: 4
    t.float    "avg_aum",    limit: 53
    t.string   "upd_flag",   limit: 1
  end

  add_index "scheme_avg_nums", ["monthend"], name: "index_scheme_avg_nums_on_monthend", using: :btree
  add_index "scheme_avg_nums", ["schemecode"], name: "index_scheme_avg_nums_on_schemecode", using: :btree

  create_table "scheme_classifications", primary_key: "schemecode", force: :cascade do |t|
    t.string  "s_name",              limit: 255
    t.string  "classification",      limit: 255
    t.float   "lcap_holdpercentage", limit: 53
    t.float   "mcap_holdpercentage", limit: 53
    t.float   "scap_holdpercentage", limit: 53
    t.float   "avg_mat_num",         limit: 53
    t.string  "remarks1",            limit: 255
    t.string  "remarks2",            limit: 255
    t.string  "remarks3",            limit: 255
    t.integer "primary_fd_code",     limit: 4
  end

  create_table "scheme_details_fulls", primary_key: "schemecode", force: :cascade do |t|
    t.integer  "amfi_code",                limit: 4
    t.string   "cmas_code",                limit: 15
    t.integer  "amc_code",                 limit: 4
    t.string   "s_name",                   limit: 225
    t.string   "amfi_name",                limit: 225
    t.string   "isin_code",                limit: 255
    t.integer  "type_code",                limit: 4
    t.integer  "opt_code",                 limit: 4
    t.integer  "classcode",                limit: 4
    t.integer  "theme_code",               limit: 4
    t.integer  "rt_code",                  limit: 4
    t.integer  "plan",                     limit: 4
    t.integer  "cust_code",                limit: 4
    t.integer  "cust_code2",               limit: 4
    t.integer  "price_freg",               limit: 4
    t.float    "init_price",               limit: 53
    t.float    "offerprice",               limit: 53
    t.datetime "nfo_open"
    t.datetime "nfo_close"
    t.datetime "reopen_dt"
    t.string   "elf",                      limit: 1
    t.string   "etf",                      limit: 1
    t.string   "stp",                      limit: 1
    t.string   "primary_fund",             limit: 1
    t.integer  "primary_fd_code",          limit: 4
    t.string   "sip",                      limit: 1
    t.string   "swp",                      limit: 1
    t.string   "switch",                   limit: 1
    t.float    "mininvt",                  limit: 53
    t.integer  "multiples",                limit: 4
    t.float    "inc_invest",               limit: 53
    t.float    "adnmultiples",             limit: 53
    t.string   "fund_mgr1",                limit: 100
    t.string   "fund_mgr2",                limit: 100
    t.string   "fund_mgr3",                limit: 100
    t.string   "fund_mgr4",                limit: 100
    t.datetime "since"
    t.string   "status",                   limit: 50
    t.string   "cutsub",                   limit: 100
    t.string   "cutred",                   limit: 100
    t.string   "red",                      limit: 10
    t.string   "mob_name",                 limit: 100
    t.integer  "div_freq",                 limit: 4
    t.string   "scheme_symbol",            limit: 50
    t.integer  "fund_mgr_code1",           limit: 4
    t.integer  "fund_mgr_code2",           limit: 4
    t.integer  "fund_mgr_code3",           limit: 4
    t.integer  "fund_mgr_code4",           limit: 4
    t.datetime "redemption_date"
    t.datetime "dateofallot"
    t.float    "div_code",                 limit: 53
    t.string   "legalnames",               limit: 255
    t.string   "amfitype",                 limit: 255
    t.string   "nontxnday",                limit: 255
    t.string   "schemebank",               limit: 255
    t.string   "schemebankaccountnumber",  limit: 255
    t.string   "schemebankbranch",         limit: 255
    t.string   "dividendoptionflag",       limit: 255
    t.string   "lockinperiod",             limit: 255
    t.string   "ispurchaseavailable",      limit: 255
    t.string   "isredeemavailable",        limit: 255
    t.float    "minredemptionamount",      limit: 53
    t.float    "redemptionmultipleamount", limit: 53
    t.float    "minredemptionunits",       limit: 53
    t.float    "redemptionmultiplesunits", limit: 53
    t.float    "minswitchamount",          limit: 53
    t.float    "switchmultipleamount",     limit: 53
    t.float    "minswitchunits",           limit: 53
    t.float    "switchmultiplesunits",     limit: 53
    t.string   "securitycode",             limit: 255
    t.string   "unit",                     limit: 255
    t.string   "switchout",                limit: 255
    t.float    "minswitchoutamount",       limit: 53
    t.float    "switchoutmultipleamount",  limit: 53
    t.float    "minswitchoutunits",        limit: 53
    t.float    "switchoutmultiplesunits",  limit: 53
    t.datetime "incept_date"
    t.float    "incept_nav",               limit: 53
    t.string   "defaultopt",               limit: 255
    t.string   "defaultplan",              limit: 255
    t.integer  "lockperiod",               limit: 4
    t.datetime "oddraftdate"
    t.string   "upd_flag",                 limit: 1
  end

  add_index "scheme_details_fulls", ["schemecode"], name: "index_scheme_details_fulls_on_schemecode", using: :btree

  create_table "scheme_indices", id: false, force: :cascade do |t|
    t.integer "schemecode", limit: 4, default: 0, null: false
    t.integer "indexcode",  limit: 4, default: 0, null: false
    t.string  "upd_flag",   limit: 1
  end

  add_index "scheme_indices", ["indexcode"], name: "index_scheme_indices_on_indexcode", using: :btree
  add_index "scheme_indices", ["schemecode"], name: "index_scheme_indices_on_schemecode", using: :btree

  create_table "scheme_masters", primary_key: "schemecode", force: :cascade do |t|
    t.integer "amc_code",    limit: 4
    t.string  "scheme_name", limit: 225
    t.string  "upd_flag",    limit: 1
  end

  add_index "scheme_masters", ["schemecode"], name: "index_scheme_masters_on_schemecode", using: :btree

  create_table "scheme_objectives", primary_key: "schemecode", force: :cascade do |t|
    t.text   "objective", limit: 4294967295
    t.string "upd_flag",  limit: 1
  end

  add_index "scheme_objectives", ["schemecode"], name: "index_scheme_objectives_on_schemecode", using: :btree

  create_table "scheme_rupeevests", primary_key: "schemecode", force: :cascade do |t|
    t.datetime "expenceratio_date"
    t.float    "expenceratio",       limit: 53
    t.float    "turnover_ratio",     limit: 53
    t.datetime "turnover_date"
    t.datetime "exitload_date"
    t.float    "exitload",           limit: 53
    t.string   "exitload_remarks",   limit: 255
    t.datetime "inception_date"
    t.float    "inception_return",   limit: 53
    t.float    "lockperiod",         limit: 53
    t.float    "minimum_investment", limit: 53
    t.integer  "redemption_period",  limit: 4
    t.string   "fund_manager",       limit: 255
    t.string   "fund_house",         limit: 255
    t.float    "navrs",              limit: 53
    t.string   "navchange",          limit: 255
    t.datetime "navdate"
    t.datetime "aumdate"
    t.float    "aumtotal",           limit: 53
    t.integer  "index_code",         limit: 4
    t.string   "index_name",         limit: 255
    t.integer  "rank_ytd",           limit: 4
    t.integer  "rank_1month",        limit: 4
    t.integer  "rank_3month",        limit: 4
    t.integer  "rank_1year",         limit: 4
    t.integer  "rank_3year",         limit: 4
    t.integer  "rank_5year",         limit: 4
    t.float    "ytd_returns",        limit: 53
    t.float    "returns_1month",     limit: 53
    t.float    "returns_3month",     limit: 53
    t.float    "returns_1year",      limit: 53
    t.float    "returns_3year",      limit: 53
    t.float    "returns_5year",      limit: 53
    t.integer  "rank_sd",            limit: 4
    t.float    "sdx_returns",        limit: 53
    t.float    "sdy_returns",        limit: 53
    t.integer  "rank_sharpe",        limit: 4
    t.float    "sharpex_returns",    limit: 53
    t.float    "sharpey_returns",    limit: 53
    t.integer  "rank_sotino",        limit: 4
    t.float    "sotinox_returns",    limit: 53
    t.float    "sotinoy_returns",    limit: 53
    t.integer  "rank_beta",          limit: 4
    t.float    "betax_returns",      limit: 53
    t.float    "betay_returns",      limit: 53
    t.integer  "rank_alpha",         limit: 4
    t.float    "alphax_returns",     limit: 53
    t.float    "alphay_returns",     limit: 53
    t.integer  "rank_treynor",       limit: 4
    t.float    "treynorx_returns",   limit: 53
    t.float    "treynory_returns",   limit: 53
    t.string   "highest_sector",     limit: 255
  end

  create_table "schemeloads", id: false, force: :cascade do |t|
    t.integer  "schemecode", limit: 4,    default: 0, null: false
    t.datetime "ldate",                               null: false
    t.integer  "ltypecode",  limit: 4,    default: 0, null: false
    t.integer  "lsrno",      limit: 4,    default: 0, null: false
    t.float    "frmamount",  limit: 53
    t.float    "uptoamount", limit: 53
    t.integer  "minperiod",  limit: 4
    t.integer  "maxperiod",  limit: 4
    t.string   "min",        limit: 20
    t.string   "max",        limit: 20
    t.float    "entryload",  limit: 53
    t.float    "exitload",   limit: 53
    t.string   "remarks",    limit: 1024
    t.string   "upd_flag",   limit: 1
  end

  add_index "schemeloads", ["ldate"], name: "index_schemeloads_on_ldate", using: :btree
  add_index "schemeloads", ["lsrno"], name: "index_schemeloads_on_lsrno", using: :btree
  add_index "schemeloads", ["ltypecode"], name: "index_schemeloads_on_ltypecode", using: :btree
  add_index "schemeloads", ["schemecode"], name: "index_schemeloads_on_schemecode", using: :btree

  create_table "sclass_conditions", primary_key: "cnno", force: :cascade do |t|
    t.string "condition_st", limit: 255
  end

  create_table "sclass_msts", primary_key: "classcode", force: :cascade do |t|
    t.string  "classname",    limit: 100
    t.integer "asset_code",   limit: 4
    t.string  "asset_type",   limit: 100
    t.string  "category",     limit: 100
    t.string  "sub_category", limit: 100
    t.string  "upd_flag",     limit: 1
  end

  add_index "sclass_msts", ["classcode"], name: "index_sclass_msts_on_classcode", using: :btree

  create_table "sect_allocation_catavgs", id: false, force: :cascade do |t|
    t.integer "classification_id", limit: 4,  default: 0, null: false
    t.integer "sect_code",         limit: 4,  default: 0, null: false
    t.float   "sect_cat_avg",      limit: 53
  end

  create_table "sect_allocations", id: false, force: :cascade do |t|
    t.integer  "amc_code",   limit: 4
    t.integer  "schemecode", limit: 4,   default: 0, null: false
    t.datetime "invdate",                            null: false
    t.datetime "invenddate"
    t.integer  "srno",       limit: 4,   default: 0, null: false
    t.integer  "sect_code",  limit: 4
    t.string   "sect_name",  limit: 150
    t.integer  "asect_code", limit: 4
    t.float    "perc_hold",  limit: 53
    t.float    "value",      limit: 53
    t.float    "aum",        limit: 53
    t.string   "upd_flag",   limit: 1
  end

  add_index "sect_allocations", ["invdate"], name: "index_sect_allocations_on_invdate", using: :btree
  add_index "sect_allocations", ["schemecode"], name: "index_sect_allocations_on_schemecode", using: :btree
  add_index "sect_allocations", ["srno"], name: "index_sect_allocations_on_srno", using: :btree

  create_table "sect_msts", primary_key: "sect_code", force: :cascade do |t|
    t.string "sect_name", limit: 255
    t.string "upd_flag",  limit: 1
  end

  add_index "sect_msts", ["sect_code"], name: "index_sect_msts_on_sect_code", using: :btree

  create_table "sectors", primary_key: "schemecode", force: :cascade do |t|
    t.string "fund",   limit: 255
    t.float  "dec_15", limit: 53
    t.float  "sep_15", limit: 53
    t.float  "jun_15", limit: 53
    t.float  "mar_15", limit: 53
  end

  add_index "sectors", ["schemecode"], name: "index_sectors_on_schemecode", using: :btree

  create_table "sip_swp_details", primary_key: "schemecode", force: :cascade do |t|
    t.integer "amc_code",       limit: 4
    t.integer "sipdays1",       limit: 4
    t.integer "sipdays2",       limit: 4
    t.integer "sipdays3",       limit: 4
    t.integer "sipdays4",       limit: 4
    t.integer "sipdays5",       limit: 4
    t.integer "sipdays6",       limit: 4
    t.integer "sipdays7",       limit: 4
    t.string  "sipdaysall",     limit: 20
    t.string  "sipfrequency",   limit: 20
    t.float   "sipmininvest",   limit: 53
    t.float   "sipaddninvest",  limit: 53
    t.integer "sipfrequencyno", limit: 4
    t.integer "swpdays1",       limit: 4
    t.integer "swpdays2",       limit: 4
    t.integer "swpdays3",       limit: 4
    t.integer "swpdays4",       limit: 4
    t.integer "swpdays5",       limit: 4
    t.integer "swpdays6",       limit: 4
    t.integer "swpdays7",       limit: 4
    t.string  "swpdaysall",     limit: 20
    t.string  "swpfrequecy",    limit: 20
    t.float   "swpmininvest",   limit: 53
    t.float   "swpaddninvest",  limit: 53
    t.integer "swpfrequencyno", limit: 4
    t.float   "maxentryload",   limit: 53
    t.float   "maxexitload",    limit: 53
    t.text    "entry_remark",   limit: 65535
    t.text    "exit_remark",    limit: 65535
    t.text    "note",           limit: 65535
    t.string  "upd_flag",       limit: 1
  end

  create_table "stocks", primary_key: "schemecode", force: :cascade do |t|
    t.string "fund",   limit: 255
    t.float  "dec_15", limit: 53
    t.float  "sep_15", limit: 53
    t.float  "jun_15", limit: 53
    t.float  "mar_15", limit: 53
  end

  add_index "stocks", ["schemecode"], name: "index_stocks_on_schemecode", using: :btree

  create_table "theme_msts", primary_key: "theme_code", force: :cascade do |t|
    t.string "theme_type", limit: 100
    t.string "upd_flag",   limit: 1
  end

  add_index "theme_msts", ["theme_code"], name: "index_theme_msts_on_theme_code", using: :btree

  create_table "type_msts", primary_key: "type_code", force: :cascade do |t|
    t.string "type",     limit: 50
    t.string "upd_flag", limit: 1
  end

  add_index "type_msts", ["type_code"], name: "index_type_msts_on_type_code", using: :btree

end
