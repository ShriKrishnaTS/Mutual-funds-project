class CreateSchemeDetailsFulls < ActiveRecord::Migration
  def change
    create_table :scheme_details_fulls do |t|
      t.integer :schemecode, index: true, primary_key: true
      t.integer :amfi_code
      t.string :cmas_code, limit: 15
      t.integer :amc_code
      t.string :s_name, limit: 225
      t.string :amfi_name, limit: 225
      t.string :isin_code
      t.integer :type_code
      t.integer :opt_code
      t.integer :classcode
      t.integer :theme_code
      t.integer :rt_code
      t.integer :plan
      t.integer :cust_code
      t.integer :cust_code2
      t.integer :price_freg
      t.decimal :init_price
      t.decimal :offerprice
      t.datetime :nfo_open
      t.datetime :nfo_close
      t.datetime :reopen_dt
      t.string :elf, limit: 1
      t.string :etf, limit: 1
      t.string :stp, limit: 1
      t.string :primary_fund, limit: 1
      t.integer :primary_fd_code
      t.string :sip, limit: 1
      t.string :swp, limit: 1
      t.string :switch, limit: 1
      t.decimal :mininvt
      t.integer :multiples
      t.decimal :inc_invest
      t.decimal :adnmultiples
      t.string :fund_mgr1, limit: 100
      t.string :fund_mgr2, limit: 100
      t.string :fund_mgr3, limit: 100
      t.string :fund_mgr4, limit: 100
      t.datetime :since
      t.string :status, limit: 50
      t.string :cutsub, limit: 10
      t.string :cutred, limit: 10
      t.string :red, limit: 10
      t.string :mob_name, limit: 100
      t.integer :div_freq
      t.string :scheme_symbol, limit: 1
      t.integer :fund_mgr_code1
      t.integer :fund_mgr_code2
      t.integer :fund_mgr_code3
      t.integer :fund_mgr_code4
      t.datetime :redemption_date
      t.datetime :dateofallot
      t.decimal :div_code
      t.string :legalnames, limit: 1
      t.string :amfitype, limit: 1
      t.string :nontxnday
      t.string :schemebank, limit: 1
      t.string :schemebankaccountnumber, limit: 1
      t.string :schemebankbranch, limit: 1
      t.string :dividendoptionflag, limit: 1
      t.string :lockinperiod, limit: 1
      t.string :ispurchaseavailable, limit: 1
      t.string :isredeemavailable, limit: 1
      t.decimal :minredemptionamount
      t.decimal :redemptionmultipleamount
      t.decimal :minredemptionunits
      t.decimal :redemptionmultiplesunits
      t.decimal :minswitchamount
      t.decimal :switchmultipleamount
      t.decimal :minswitchunits
      t.decimal :switchmultiplesunits
      t.string :securitycode, limit: 50
      t.string :unit, limit: 50
      t.string :switchout, limit: 1
      t.decimal :minswitchoutamount
      t.decimal :switchoutmultipleamount
      t.decimal :minswitchoutunits
      t.decimal :switchoutmultiplesunits
      t.datetime :incept_date
      t.decimal :incept_nav
      t.string :defaultopt, limit: 50
      t.string :defaultplan, limit: 50
      t.integer :lockperiod
      t.datetime :oddraftdate
      t.string :upd_flag, limit: 1

      t.timestamps null: false
    end
  end
end
