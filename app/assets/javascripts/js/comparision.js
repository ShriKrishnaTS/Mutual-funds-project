function compare_value()
{
	   $.ajax({
						type:'GET',
						url: '/fund_comparision/get_compare_value'+window.location.search,
						datatype:'json',
						success:function(data1, textStatus, jqXHR) {
  console.log(data1);
  alert(data1.comp.length);
	for (var i = data1.comp.length+1; i < 5; i++) {
		 closecomaparevalue("Section"+i);
	}
  for(var i =0;i <= data1.comp.length-1;i++)
  {
	var item1 = data1.comp[i];
	var schemecode = item1.schemecode;
	var s_name = item1.s_name;
	var lockperiod = item1.lockperiod;
	var exitload = item1.exitload;
	var expenceratio = item1.expenceratio;
	var inception_date = item1.inception_date;
	var inception_return = item1.inception_return;
	var turnover_ratio = item1.turnover_ratio;
	var navdate  = item1.navdate ;
	var navrs = item1.navrs;
	var navchange = item1.navchange;
	var minimum_investment = item1.minimum_investment;
	var sdx_returns = item1.sdx_returns;
	var betax_returns = item1.betax_returns;
	var sharpex_returns = item1.sharpex_returns;
	var alphax_returns = item1.alphax_returns;
	var sotinox_returns = item1.sotinox_returns;
	var total_return = item1.total_return;
	var consistency_of_return = item1.consistency_of_return;
	var risk = item1.risk;
	var cost_factor = item1.cost_factor;
	var portfolio_attributes = item1.portfolio_attributes;
	var fund_manager = item1.fund_manager;
	var aumtotal = item1.aumtotal;
	var redemption_period = item1.redemption_period;
	var classification = item1.classification;
	var index_name = item1.index_name;
	var lcap = item1.lcap;
	var mcap = item1.mcap;
	var scap = item1.scap;
	var ppmcap = item1.ppmcap;
	var one_y = item1.one_y;
	var two_y = item1.two_y;
	var three_y = item1.three_y;
	var six_m = item1.six_m;
	var pe = item1.pe;
	var pb = item1.pb;
	var rupeevest_rating = item1.rupeevest_rating;
	alert('rupeevest_rating');

	$("#lockperiod"+i).html(lockperiod);
	$("#exitload"+i).html(exitload);
	$("#expenceratio"+i).html(expenceratio);
	$("#inception_date"+i).html(inception_date);
	$("#inception_return"+i).html(inception_return);
	$("#turnover_ratio"+i).html(turnover_ratio);
	$("#navdate"+i).html(navdate);
	$("#navrs"+i).html(navrs);
	$("#minimum_investment"+i).html(minimum_investment);
	$("#navchange"+i).html(navchange);
	$("#sdx_returns"+i).html(sdx_returns);
	$("#betax_returns"+i).html(betax_returns);
	$("#sharpex_returns"+i).html(sharpex_returns);
	$("#alphax_returns"+i).html(alphax_returns);
	$("#sotinox_returns"+i).html(sotinox_returns);
	$("#total_return"+i).html(total_return);
	$("#consistency_of_return"+i).html(consistency_of_return);
	$("#risk"+i).html(risk);
	$("#cost_factor"+i).html(cost_factor);
	$("#portfolio_attributes"+i).html(portfolio_attributes);
	$("#s_name"+i).html(s_name);
	$("#fund_manager"+i).html(fund_manager);
	$("#redemption_period"+i).html(redemption_period);
	$("#classification"+i).html(classification);
	$("#aumtotal"+i).html(aumtotal);
	$("#index_name"+i).html(index_name);
	$("#lcap"+i).html(lcap);
	$("#mcap"+i).html(mcap);
	$("#scap"+i).html(scap);
	$("#ppmcap"+i).html(ppmcap);
	$("#pe"+i).html(pe);
	$("#pb"+i).html(pb);
	$("#one_y"+i).html(one_y);
	$("#two_y"+i).html(two_y);
	$("#three_y"+i).html(three_y);
	$("#six_m"+i).html(six_m);
	$("#rupeevest_rating"+i).html(rupeevest_rating);
	$(".displayStars").html(rupeevest_rating).stars();
}

 },
  error:function(jqXHR, textStatus, errorThrown) {
    alert("AJAX Error:" + textStatus);
  }

  })
}
