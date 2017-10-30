$(document).ready(function(){
	$(document).on('click','#main-tabs li.nav-menu a',function(){
		if($(this).closest('li').hasClass('active')){
			$(this).closest('li').removeClass('active');
		}
	});
	$(document).on('click','.ui-autocomplete li',function(){
		//alert();
		// setvalue_schemename()
	});
});

function setvalue(obj)
{
	$.ajax({
			type:'post',
			url: '/home/index',
			data :{schemecode:obj},
			datatype:'json',
			success:function(scheme_code, textStatus, jqXHR) {
			console.log(scheme_code);
			window.location = "/home/index_latest?";//redirect_url(scheme_code.schemecode);
			},
			error:function(jqXHR, textStatus, errorThrown) {
				alert("AJAX Error:" + textStatus);
			  }

			  })
}

function setvalue_schemename()
{
	var obj = document.getElementById("fund_names").value;
	$.ajax({
			type:'post',
			url: '/home/index_search',
			data :{schemename:obj},
			datatype:'json',
			success:function(scheme_code, textStatus, jqXHR) {
			console.log(scheme_code);
			window.location = "/home/index_latest?";//redirect_url(scheme_code.schemecode);
			},
			error:function(jqXHR, textStatus, errorThrown) {
				alert("AJAX Error:" + textStatus);
			  }

			  })
}
function redirect_url()
{
	$.ajax({
			type: "POST",
			url: '/home/index_latest?',
			//data :{schemecode:schemecode},
			datatype:'json',
			success:function(scheme_data, textStatus, jqXHR) {
				console.log(scheme_data);
				var scheme_item = scheme_data.schemedata[0]
				var s_name = scheme_item.s_name;
				var fund_manager = scheme_item.fund_manager;
				var navdate = "Nav as on " + scheme_item.navdate;
				var navrs = scheme_item.navrs;
				var navchange = scheme_item.navchange + "%";
				var inception_date = scheme_item.inception_date;
				var inception_return = scheme_item.inception_return;
				var exitload = scheme_item.exitload;
				var expenceratio = scheme_item.expenceratio;
				var turnover_ratio = scheme_item.turnover_ratio;
				var minimum_investment = scheme_item.minimum_investment;
				var lockperiod = scheme_item.lockperiod;
				var index_name = scheme_item.index_name;
				var redemption_period = scheme_item.redemption_period;
				var aumtotal = scheme_item.aumtotal;
				var aumdate = scheme_item.aumdate;
				var portfolio_attributes = scheme_item.portfolio_attributes;
				var cost_factor = scheme_item.cost_factor;
				var risk = scheme_item.risk;
				var consistency_of_return = scheme_item.consistency_of_return;
				var total_return = scheme_item.total_return;
				var fund_house = scheme_item.fund_house;
				var index_name = scheme_item.index_name;
				var classification = scheme_item.classification;
				var navrs_gp = scheme_item.navrs_gp;
				var type = scheme_item.type;
				$("#s_name").html(s_name);
				$("#fund_manager").html(fund_manager);
				$("#navrs").html(navrs);
				$("#navchange").html(navchange);
				$("#navdate").html(navdate);
				$("#inception_date").html(inception_date);
				$("#inception_return").html(inception_return);
				$("#exitload").html(exitload);
				$("#expenceratio").html(expenceratio);
				$("#turnover_ratio").html(turnover_ratio);
				$("#minimum_investment").html(minimum_investment);
				$("#index_name").html(index_name);
				$("#lockperiod").html(lockperiod);
				$("#redemption_period").html(redemption_period);
				$("#portfolio_attributes").html(portfolio_attributes);
				$("#cost_factor").html(cost_factor);
				$("#risk").html(risk);
				$("#consistency_of_return").html(consistency_of_return);
				$("#total_return").html(total_return);
				$("#aumtotal").html(aumtotal);
				$("#aumdate").html(aumdate);
				$("#fund_house").html(fund_house);
				$("#index_name").html(index_name);
				$("#classification").html(classification);
				$("#growth").html(navrs_gp);
				$("#type").html(type);
				alert('calling commonjs')
				get_growth_plan();
				get_return_data();
				get_risk_measures();
				get_peer_comparision();
				concentration_values();
				get_portfolio_holdings();
				get_dividend_data();
				get_hold_asset();
				get_portfolio_markettable();
				get_portfolio_markettable_avgmcap();
				get_portfolio_markettable_allcapavgs();
				get_recent_updates();
				rupeevest_rating();
				/*get_risk_measures();


				port_avgcap();*/
			},
			error:function(jqXHR, textStatus, errorThrown) {
				alert("AJAX Error:" + textStatus);
			}
		});
}

function add_compare()
{
	// location.href = 'http://localhost:3000/home/comparison';
	var checkboxId;
	var chkbox_counter = 0;
	var chkboxes = document.getElementsByName("chkCompare");
	//alert(chkboxes.length);
	for(var i=0;i<=chkboxes.length-1;i++)
	{
		if(chkboxes[i].checked == true)
		{

			if(chkbox_counter >= 4)

			{
				alert("only maximum of 4 funds can be selected");
				break;
			}
			else
			{

				if(chkbox_counter == 0)
				{
					checkboxId = chkboxes[i].id;
				}
				else
				{
					checkboxId = checkboxId + "," + chkboxes[i].id;
				}
				chkbox_counter = chkbox_counter + 1;
			}
		}
	}
	// alert(''+chkbox_counter);
	// localStorage.setItem('selectedFunds',checkboxId);
	if(chkbox_counter < 2)
	{
		alert("select atleast 2 funds");
	}
	else
	{
		alert(checkboxId);
		 window.location="/home/comparison?ids="+checkboxId
	}
}

function fundname_search()
{
	$.ajax({
		type:'GET',
		url: '/home/get_search_data',
		datatype:'json',
		success:function(searchdata, textStatus, jqXHR) {
		 console.log(searchdata);
		 var schemename = [];

		 for(var i =0;i <= searchdata.search_data.length-1;i++)
		 {
			var item1 = searchdata.search_data[i];
			var scheme_code = item1.scheme_code;
			var s_name = item1.s_name;
			schemename.push(item1.s_name);

		 }
		    $("#fund_names").autocomplete({
				source: schemename
			});
		//$("#scheme_code").html(scheme_code);
		//$("#s_name").html(s_name);
		console.log(schemename);
		},
		 error:function(jqXHR, textStatus, errorThrown) {
		   alert("AJAX Error:" + textStatus);
		 }
 })
}

function add_fundname_search()
{
	$.ajax({
		type:'GET',
		url: '/home/get_search_data',
		datatype:'json',
		success:function(searchdata, textStatus, jqXHR) {
		 console.log(searchdata);
		 var schemename = [];

		 for(var i =0;i <= searchdata.search_data.length-1;i++)
		 {
			var item1 = searchdata.search_data[i];
			var scheme_code = item1.scheme_code;
			var s_name = item1.s_name;
			schemename.push(item1.s_name);

		 }
		    $("#srch-term").autocomplete({
				source: schemename
			});
		//$("#scheme_code").html(scheme_code);
		//$("#s_name").html(s_name);
		console.log(schemename);
		},
		 error:function(jqXHR, textStatus, errorThrown) {
		   alert("AJAX Error:" + textStatus);
		 }
 })
}
