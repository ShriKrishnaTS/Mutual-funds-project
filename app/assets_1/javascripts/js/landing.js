// $(window).load(function(){
	// alert('mani');schemedata_landing('hai');

// });
//removing active class from bootstrap nav menu
$(document).ready(function(){
	$(document).on('click','#main-tabs li.nav-menu a',function(){
		if($(this).closest('li').hasClass('active')){
			$(this).closest('li').removeClass('active');
		}
	});
});
function schemedata_landing()
{
	$.ajax({
			type:'GET',
			url: 'http://localhost:3000/functionalities/schemedata_landing',
			datatype:'json',
			success:function(data1, textStatus, jqXHR) {
				console.log(data1);
				var tblData;
				var t = document.getElementById("tblData").innerHTML;
				for(var i =0;i <= data1.schemedata.length-1;i++)
				{
					var scheme_data = data1.schemedata[i];
					var scheme_code = scheme_data.schemecode;
					var scheme_name = scheme_data.s_name;
					var scheme_classification = scheme_data.classification;
					var scheme_year1 = scheme_data.yrret_1;
					var scheme_year3 = scheme_data.yearret_3;
					var scheme_year5 = scheme_data.yearret_5;
					var scheme_aum_total = scheme_data.total;
					var exratio = scheme_data.exratio;
					var high_sec_alloc = scheme_data.holdpercentage;
					var rr;
					if (scheme_data.rupeevest_rating)
					{
						rr = scheme_data.rupeevest_rating;
					}
					else
					{
						rr = "-";
					}

					if(i == 0)
					{
						tblData = t + "<tr><td><input id="+scheme_code+" type='checkbox' name='chkCompare'/></td><td><a id="+scheme_code+" href='#' onclick='setvalue(this.id)'>"+scheme_name+"</a></td><td>"+rr+"</td><td>"+scheme_aum_total+"</td><td>"+scheme_year1+"</td><td>"+scheme_year3+"</td><td>"+scheme_year5+"</td><td>"+exratio+"</td><td>"+high_sec_alloc+"</td></tr>";
					}
					else
					{
						tblData = tblData + "<tr><td><input id="+scheme_code+" type='checkbox' name='chkCompare' /></td><td><a id="+scheme_code+" href='#' onclick='setvalue(this.id)'>"+scheme_name+"</a></td><td>"+rr+"</td><td>"+scheme_aum_total+"</td><td>"+scheme_year1+"</td><td>"+scheme_year3+"</td><td>"+scheme_year5+"</td><td>"+exratio+"</td><td>"+high_sec_alloc+"</td></tr>";
					}
				}
				$("#tblData").html("");
				$("#tblData").html(tblData);
				var sorter = tsorter.create('tblData1');
			},
			error:function(jqXHR, textStatus, errorThrown) {
				alert("AJAX Error:" + textStatus);
			}

		})
}
function setvalue(obj)
{
	$.ajax({
			type:'post',
			url: 'http://localhost:3000/home/index',
			data :{schemecode:obj},
			datatype:'json',
			success:function(scheme_code, textStatus, jqXHR) {
			console.log(scheme_code);
			window.location = "http://localhost:3000/home/index_latest?";//redirect_url(scheme_code.schemecode);
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
			url: 'http://localhost:3000/home/index_search',
			data :{schemename:obj},
			datatype:'json',
			success:function(scheme_code, textStatus, jqXHR) {
			console.log(scheme_code);
			window.location = "http://localhost:3000/home/index_latest?";//redirect_url(scheme_code.schemecode);
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
                url: 'http://localhost:3000/home/index_latest?',
				//data :{schemecode:schemecode},
				datatype:'json',
				success:function(scheme_data, textStatus, jqXHR) {
					console.log(scheme_data);
					var scheme_item = scheme_data.schemedata[0];
					var scheme_name = scheme_item.s_name;
					var fund_manager = "";
					var navdate = "Nav as on " + scheme_item.navdate;
					var navrs = scheme_item.navrs;
					var navchange = scheme_item.navchange + "%";
					var incdate = scheme_item.incdate;
					var exitload = scheme_item.exitload;
					var expense = scheme_item.exratio;
					var incep = scheme_item.incret;
					var turn = scheme_item.turnover_ratio;
					var inv = scheme_item.mininv;
					var fund_mgr1 = scheme_item.fund_mgr1;
					var fund_mgr2 = scheme_item.fund_mgr2;
					var fund_mgr3 = scheme_item.fund_mgr3;
					var fund_mgr4 = scheme_item.fund_mgr4;
					var lockperiod = scheme_item.lockperiod;
					var type = "Status : "+scheme_item.type;
					var classification = scheme_item.classification;
					var indextype = "S&P BSE 500";
					var redem_period = "10";
					var aumamount = scheme_item.total;
					var aumdate = scheme_item.aumdate;
					if(fund_mgr1 != "")
					{
						fund_manager = fund_mgr1 +" "+ fund_manager;
					}
					if(fund_mgr2 != "")
					{
						fund_manager = fund_mgr2 +" "+ fund_manager;
					}
					if(fund_mgr3 != "")
					{
						fund_manager = fund_mgr3 +" "+ fund_manager;
					}
					if(fund_mgr4 != "")
					{
						fund_manager = fund_mgr4 +" "+ fund_manager;
					}
					$("#scheme_name").html(scheme_name);
					$("#fund_manager").html(fund_manager);
					$("#navrs").html(navrs);
					$("#navchange").html(navchange);
					$("#navdate").html(navdate);
					$("#incdate").html(incdate);
					$("#exitload").html(exitload);
					$("#expense").html(expense);
					$("#incep").html(incep);
					$("#turn").html(turn);
					$("#inv").html(inv);
					$("#type").html(type);
					$("#eqty_class").html(classification);
					$("#index_type").html(indextype);
					$("#lockperiod").html(lockperiod);
					$("#redem_period").html(redem_period);
					$("#aum").html(aumamount);
					get_dividend_data();
					get_peer_comparision();
					get_return_data();
					get_risk_measures();
					get_portfolio_holdings();
					get_hold_asset();
					port_avgcap();
					get_recent_updates();
                },
				error:function(jqXHR, textStatus, errorThrown) {
					alert("AJAX Error:" + textStatus);
				}
            });

}

function chkbox_click(obj)
{
	var checkboxId= obj.id;

	if(checkboxId == "chkAllothers")
	{
		if(document.getElementById("chkAllothers").checked == true)
		{
			document.getElementById("chkEo").checked = true;
			document.getElementById("chkDbOt").checked = true;
			document.getElementById("chkHyOth").checked = true;
		}
		else
		{
			document.getElementById("chkEo").checked = false;
			document.getElementById("chkDbOt").checked = false;
			document.getElementById("chkHyOth").checked = false;
		}

	}
	else
	{
		var querstring;
		var checkboxes = document.getElementsByName(checkboxId);
		for(var i=0, n=checkboxes.length;i<n;i++)
		{
			checkboxes[i].checked = obj.checked;
			if(i == 0)
			{
				querstring =  checkboxes[i].value;
			}
			else
			{
				querstring = querstring + "," + checkboxes[i].value;
			}
		}
		//alert(querstring);
	}
}

function selected_schemes()
{
	var eqty = document.getElementsByName("chkAllEquity");
	var dbt = document.getElementsByName("chkAllDebt");
	var hbd = document.getElementsByName("chkAllHybrid");
	var etf = document.getElementsByName("chkAllEtfs");
	var selected_schemes = "";
	for(var i = 0; i<eqty.length;i++)
	{
		if(eqty[i].checked == true)
		{
			if(selected_schemes == "")
			{
				selected_schemes = eqty[i].value;
			}
			else
			{
				selected_schemes = selected_schemes + "," + eqty[i].value;
			}
		}
	}
	for(var i = 0; i<dbt.length;i++)
	{
		if(dbt[i].checked == true)
		{
			if(selected_schemes == "")
			{
				selected_schemes = dbt[i].value;
			}
			else
			{
				selected_schemes = selected_schemes + "," + dbt[i].value;
			}
		}
	}
	for(var i = 0; i<hbd.length;i++)
	{
		if(hbd[i].checked == true)
		{
			if(selected_schemes == "")
			{
				selected_schemes = hbd[i].value;
			}
			else
			{
				selected_schemes = selected_schemes + "," + hbd[i].value;
			}
		}
	}
	for(var i = 0; i<etf.length;i++)
	{
		if(etf[i].checked == true)
		{
			if(selected_schemes == "")
			{
				selected_schemes = etf[i].value;
			}
			else
			{
				selected_schemes = selected_schemes + "," + etf[i].value;
			}
		}
	}
	$("#tblData").html("");
	$.ajax({
                type: "POST",
                url: 'http://localhost:3000/functionalities/asset_class_section?',
                data: { selected_schemes : selected_schemes },
                datatype:'json',
				success:function(asset_data, textStatus, jqXHR) {
				console.log(asset_data);
				var tblData;
				for(var i =0;i <= asset_data.schemedata.length-1;i++)
				{
					var scheme_data = asset_data.schemedata[i];
					var scheme_code = scheme_data.schemecode;
					var scheme_name = scheme_data.s_name;
					var scheme_classification = scheme_data.classification;
					var scheme_year1 = scheme_data.yrret_1;
					var scheme_year3 = scheme_data.yearret_3;
					var scheme_year5 = scheme_data.yearret_5;
					var scheme_aum_total = scheme_data.total;
					var exratio = scheme_data.exratio;
					var high_sec_alloc = "-";
					var t = "<tr><th>Select</th><th>Fund</th><th>Rupeevest<br>Rating</th><th>AUM <br>(in crores)</th><th>Return<br>(1 year)</th><th>Return<br>(3 year)</th><th>Return<br>(5 year)</th><th>Expense<br>Ratio</th><th>Highest Sector<br>Allocation</th></tr>";
					if(i == 0)
					{
						tblData = t + "<tr><td><input id="+scheme_code+" type='checkbox' name='chkCompare' /></td><td><a id="+scheme_code+" href='#' onclick='setvalue(this.id)'>"+scheme_name+"</a></td><td></td><td>"+scheme_aum_total+"</td><td>"+scheme_year1+"</td><td>"+scheme_year3+"</td><td>"+scheme_year5+"</td><td>"+exratio+"</td><td>"+high_sec_alloc+"</td></tr>";
					}
					else
					{
						tblData = tblData + "<tr><td><input id="+scheme_code+" type='checkbox' name='chkCompare' /></td><td><a id="+scheme_code+" href='#' onclick='setvalue(this.id)'>"+scheme_name+"</a></td><td></td><td>"+scheme_aum_total+"</td><td>"+scheme_year1+"</td><td>"+scheme_year3+"</td><td>"+scheme_year5+"</td><td>"+exratio+"</td><td>"+high_sec_alloc+"</td></tr>";
					}
				}

				$("#tblData").html(tblData);
                },  error:function(jqXHR, textStatus, errorThrown) {
					alert("AJAX Error:" + textStatus);
				}
            });
}

function add_compare()
{
	location.href = 'http://www.google.com/';
	var checkboxId;
	var chkbox_counter = 0;
	var chkboxes = document.getElementsByName("chkCompare");
	alert(chkboxes.length);
	for(var i=0;i<=chkboxes.length-1;i++)
	{
		if(chkboxes[i].checked == true)
		{

			if(chkbox_counter >= 10)
			{
				alert("only maximum of 10 funds can be selected");
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
	alert(chkbox_counter);
	if(chkbox_counter < 2)
	{
		alert("select atleast 2 funds");
	}
	else
	{
		alert(checkboxId);
	}
}

function fundname_search()
{
	$.ajax({
		type:'GET',
		url: 'http://localhost:3000/home/get_search_data',
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

function get_dividend_data()
{
	$.ajax({
			type:'GET',
			url: 'http://localhost:3000/functionalities/get_dividend_data',
			datatype:'json',
			success:function(dividend_data, textStatus, jqXHR) {
			console.log(dividend_data);
			var dividendData;
			for(var i =0;i <= dividend_data.dividend_data.length-1;i++)
			{
				var div_data = dividend_data.dividend_data[i];
				var recorddate = div_data.recorddate;
				var gross = div_data.gross;
				var div_type = div_data.div_type;
				if(i == 0)
				{
					dividendData = document.getElementById("dividend_data").innerHTML + "<tr class='active'><td>"+div_type+"</td><td>"+recorddate+"</td><td>"+gross+"</td></tr>";
				}
				else
				{
					dividendData = dividendData + "<tr class='active'><td></td><td>"+recorddate+"</td><td>"+gross+"</td></tr>";
				}
			  }

			$("#dividend_data").html(dividendData);
			},
				error:function(jqXHR, textStatus, errorThrown) {
				alert("AJAX Error:" + textStatus);
			}
  })
}

function get_peer_comparision()
{
	$.ajax({
			type:'GET',
			url: 'http://localhost:3000/functionalities/get_peer_comparision',
			datatype:'json',
			success:function(peer_comparision, textStatus, jqXHR) {
			console.log(peer_comparision);
			var pc_data;
			var th = "<thead><tr><th>Fund</th><th>Rupeevest Rating</th><th>AUM(in cr)</th><th>YTD</th><th>1 Month</th><th>3 Month</th><th>1 Year</th><th>3 Year</th><th>5 Year</th><th>10 Year</th><th>Expense Ratio(%)</th></tr></thead>";
			for(var i =0;i <= peer_comparision.peer_comparision.length-1;i++)
			{
				var pc_data = peer_comparision.peer_comparision[i];
				var scheme_code = pc_data.schemecode;
				var scheme_name = pc_data.s_name;
				var rating = "3";
				var scheme_aum_total = pc_data.total;
				var ytd = "0.0";
				var scheme_monthret1 = pc_data.monthret_1;
				var scheme_monthret3 = pc_data.monthret_3;
				var scheme_year1 = pc_data.yrret_1;
				var scheme_year3 = pc_data.yearret_3;
				var scheme_year5 = pc_data.yearret_5;
				var scheme_year10 = pc_data.yearret_5;
				var exratio = pc_data.exratio;

				if(i == 0)
				{
					tblData = th + "<tr><td><a id="+scheme_code+" href='#' >"+scheme_name+"</a></td><td>"+rating+"</td><td>"+scheme_aum_total+"</td><td>"+ytd+"</td><td>"+scheme_monthret1+"</td><td>"+scheme_monthret3+"</td><td>"+scheme_year1+"</td><td>"+scheme_year3+"</td><td>"+scheme_year5+"</td><td>"+scheme_year10+"</td><td>"+exratio+"</td></tr>";
				}
				else
				{
					tblData = tblData + "<tr><td><a id="+scheme_code+" href='#' >"+scheme_name+"</a></td><td>"+rating+"</td><td>"+scheme_aum_total+"</td><td>"+ytd+"</td><td>"+scheme_monthret1+"</td><td>"+scheme_monthret3+"</td><td>"+scheme_year1+"</td><td>"+scheme_year3+"</td><td>"+scheme_year5+"</td><td>"+scheme_year10+"</td><td>"+exratio+"</td></tr>";
				}
			  }
			$("#peertbl").html("");
			$("#peertbl").html(tblData);
			},
				error:function(jqXHR, textStatus, errorThrown) {
				alert("AJAX Error:" + textStatus);
			}
  })
}

function get_return_data()
{
	$.ajax({
			type:'GET',
			url: 'http://localhost:3000/functionalities/get_return_data',
			datatype:'json',
			success:function(returns_data, textStatus, jqXHR) {
			console.log(returns_data);
			var mf_data;
			var th = "<thead class='border-top'><tr><th>Return (%)</th><th>YTD</th><th>1 Month</th><th>3 Month</th><th>1 Year</th>   <th>3 Year</th><th>5 Year</th><th>10 Year</th><th></th><th></th></tr></thead>";
			for(var i =0;i <= returns_data.returns_data.length-1;i++)
			{
				mf_data = returns_data.returns_data[i];
				var scheme_name = mf_data.s_name;
				var ytd = mf_data.incnav;
				var monthret_1 = mf_data.monthret_1;
				var monthret_3 = mf_data.monthret_3;
				var yrret_1 = mf_data.yrret_1;
				var yearret_3 = mf_data.yearret_3;
				var yearret_5 = mf_data.yearret_5;
				var yearret_10 = mf_data.yearret_5;
				var indexname = mf_data.indexname;
				var br_ytd = mf_data.brnav;
				var br_monthret_1 = mf_data.br_monthret_1;
				var br_monthret_3 = mf_data.br_monthret_3;
				var br_yrret_1 = mf_data.br_yrret_1;
				var br_yearret_3 = mf_data.br_yrret_3;
				var br_yearret_5 = mf_data.br_yrret_5;
				var br_yearret_10 = mf_data.br_yrret_5;
				if(i == 0)
				{
					tblData = th + "<tr><td>"+scheme_name+"</td><td>"+ytd+"</td><td>"+monthret_1+"</td><td>"+monthret_3+"</td><td>"+yrret_1+"</td><td>"+yearret_3+"</td><td>"+yearret_5+"</td><td>"+yearret_10+"</td></tr><tr><td>"+indexname+"</td><td>"+br_ytd+"</td><td>"+br_monthret_1+"</td><td>"+br_monthret_3+"</td><td>"+br_yrret_1+"</td><td>"+br_yearret_3+"</td><td>"+br_yearret_5+"</td><td>"+br_yearret_10+"</td></tr>";
				}
			}
			  tblData = tblData + "<tr class='active'><td>Category Average</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr><tr><td>Rank Within Category</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr><tr class=active><td>Number of funds in category</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr><tr><td>As on April XYZ</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>";
			$("#mfreturn").html("");
			$("#mfreturn").html(tblData);
			},
				error:function(jqXHR, textStatus, errorThrown) {
				alert("AJAX Error:" + textStatus);
			}
  })
}

function get_risk_measures()
{
	$.ajax({
			type:'GET',
			url: 'http://localhost:3000/functionalities/get_risk_measures',
			datatype:'json',
			success:function(risk_data, textStatus, jqXHR) {
			console.log(risk_data);
			var rm_data;
			var th = "<thead class='border-top'><tr><th>Risk Measures (%)</th><th colspan='2'>Std Div</th><th>Sharpe</th><th>Sotino</th><th>Beta</th><th>Alpha</th><th colspan='2'>Treynor Ratio</th><th colspan='2'>Information ratio</th><th></th></tr></thead>";
			for(var i =0;i <= risk_data.risk_data.length-1;i++)
			{
				rm_data = risk_data.risk_data[i];
				var scheme_name = rm_data.s_name;
				var sd_x = rm_data.sd_x;
				var sharpe_x = rm_data.sharpe_x;
				var sortino_x = rm_data.sortino_x;
				var beta_x = rm_data.beta_x;
				var jalpha_x = rm_data.jalpha_x;
				var treynor_x = rm_data.treynor_x;
				var avg_x  = rm_data.avg_x ;
				var indexname = rm_data.indexname;
				var sd_y = rm_data.sd_y;
				var sharpe_y = rm_data.sharpe_y;
				var sortino_y = rm_data.sortino_y;
				var beta_y = rm_data.beta_y;
				var jalpha_y = rm_data.jalpha_y;
				var treynor_y = rm_data.treynor_y;
				var avg_y = rm_data.avg_y;
				if(i == 0)
				{
					tblData = th + "<tr><td>"+scheme_name+"</td><td colspan='2'>"+sd_x+"</td><td>"+sharpe_x+"</td><td>"+sortino_x+"</td><td>"+beta_x+"</td><td>"+jalpha_x+"</td><td colspan='2'>"+treynor_x+"</td><td colspan='2'>"+avg_x+"</td></tr><tr><td>"+indexname+"</td><td colspan='2'>"+sd_y+"</td><td>"+sharpe_y+"</td><td>"+sortino_y+"</td><td>"+beta_y+"</td><td>"+jalpha_y+"</td><td colspan='2'>"+treynor_y+"</td><td colspan='2'>"+avg_y+"</td></tr>";
				}
			}
			  tblData = tblData + "<tr class='active'><td>Category Average</td><td colspan='2'></td><td></td><td></td><td></td><td></td><td colspan='2'></td><td colspan='2'></td></tr><tr><td>Rank Within Category</td><td colspan='2'></td><td></td><td></td><td></td><td></td><td colspan='2'></td><td colspan='2'></td></tr><tr class=active><td>Number of funds in category</td><td colspan='2'></td><td></td><td></td><td></td><td></td><td colspan='2'></td><td colspan='2'></td></tr><tr><td>As on April XYZ</td><td colspan='2'></td><td></td><td></td><td></td><td></td><td colspan='2'></td><td colspan='2'></td></tr>";
			$("#mfratio").html("");
			$("#mfratio").html(tblData);
			},
				error:function(jqXHR, textStatus, errorThrown) {
				alert("AJAX Error:" + textStatus);
			}
  })
}

function get_portfolio_holdings()
{
	$.ajax({
			type:'GET',
			url: 'http://localhost:3000/functionalities/portfolio_holdings',
			datatype:'json',
			success:function(portfolio_holdings, textStatus, jqXHR) {
			console.log(portfolio_holdings);
			var tblData;
			var th = "<thead class='border-top'><tr><th>Security Name</th><th>Sector</th><th>Credit Rating</th><th>Weight (%)</th></tr></thead>";
			for(var i =0;i <= portfolio_holdings.portfolio_holdings.length-1;i++)
			{
				var ph_data = portfolio_holdings.portfolio_holdings[i];
				var scheme_code = ph_data.schemecode;
				var asect_name = ph_data.asect_name;
				var sect_name = ph_data.sect_name;
				var rating = ph_data.rating;
				var weight = ph_data.weight;
				if(i == 0)
				{
					tblData = th + "<tr><td>"+asect_name+"</td><td>"+sect_name+"</td><td>"+rating+"</td><td>"+weight+"</td></tr>";
				}
				else
				{
					tblData = tblData + "<tr><td>"+asect_name+"</td><td>"+sect_name+"</td><td>"+rating+"</td><td>"+weight+"</td></tr>";
				}
			  }
			$("#portfolio_holdings").html("");
			$("#portfolio_holdings").html(tblData);
			},
				error:function(jqXHR, textStatus, errorThrown) {
				alert("AJAX Error:" + textStatus);
			}
  })
}

function get_hold_asset()
{

	$.ajax({
		type:'GET',
		url: 'http://localhost:3000/home/get_holding_asset',
		datatype:'json',
		success:function(sectordata, textStatus, jqXHR) {
		 console.log(sectordata);
		 var tblData;
		 var th = " <thead><tr><th>Company</th><th>Sector</th><th>Credit Rating</th><th>% Assets</th><th>Previous Quarter %</th></tr></thead>";


		 for(var i =0;i <= sectordata.hold.length-1;i++)
		 {
			var item1 = sectordata.hold[i];
			var scheme_code = item1.schemecode;
			var company = item1.company;
			var sector = item1.sector;
			var credit_rating = item1.credit_rating;
			var assets = item1.assets;
			var previous_quarter  = item1.previous_quater;
            if(i == 0)
               {
                tblData = th + "<tr><td>"+company+"</td><td>"+sector+"</td><td>"+credit_rating+"</td><td>"+assets+"</td><td>"+previous_quarter+"</td></tr>";
                      }
              else
              {
               tblData = tblData + "<tr><td>"+company+"</td><td>"+sector+"</td><td>"+credit_rating+"</td><td>"+assets+"</td><td>"+previous_quarter+"</td></tr>";
                }
		 }
			 $("#holding_table").html("");
             $("#holding_table").html(tblData);
		},
		 error:function(jqXHR, textStatus, errorThrown) {
		   alert("AJAX Error:" + textStatus);
		 }
 })
}
function sector_search()
{

	$.ajax({
		type:'GET',
		url: 'http://localhost:3000/home/get_sector_data',
		datatype:'json',
		success:function(sectordata, textStatus, jqXHR) {
		 var fundnames = new Array;

		 for(var i =0;i <= sectordata.sec.length-1;i++)
		 {

			var item1 = sectordata.sec[i];
			var scheme_code = item1.schemecode;
			fundnames.push(item1.fund);
			//console.log(fundnames);

		 }
		 console.log(fundnames);
		    $("#sector_names").autocomplete({
				source: fundnames
			});
		//$("#scheme_code").html(scheme_code);
		//$("#s_name").html(s_name);
		},
		 error:function(jqXHR, textStatus, errorThrown) {
		   alert("AJAX Error:" + textStatus);
		 }
 })

}

function get_sector()
{
alert('punk')
	$.ajax({
		type:'GET',
		url: 'http://localhost:3000/home/get_sector_data',
		datatype:'json',
		success:function(sectordata, textStatus, jqXHR) {
		 console.log(sectordata);
		 var fundname = [];
		 var tblData;
		 var th = "<thead><tr><th>Fund</th><th>Dec-15</th><th>Sep-15</th><th>Jun-15</th><th>Mar-15</th></tr></thead>";
		 alert('hiii');


		 for(var i =0;i <= sectordata.sec.length-1;i++)
		 {
			var item1 = sectordata.sec[i];
			var scheme_code = item1.schemecode;
			var fund = item1.fund;
			var dec_15 = item1.dec_15;
			var sep_15 = item1.sep_15;
			var jun_15 = item1.jun_15;
			var mar_15 = item1.mar_15;
			fundname.push(item1.fund);
           if(i == 0)
               {
                tblData = th + "<tr><td>"+fund+"</td><td>"+dec_15+"</td><td>"+sep_15+"</td><td>"+jun_15+"</td><td>"+mar_15+"</td></tr>";
                      }
              else
              {
               tblData = tblData + "<tr><td>"+fund+"</td><td>"+dec_15+"</td><td>"+sep_15+"</td><td>"+jun_15+"</td><td>"+mar_15+"</td></tr>";
                }
		 }
				$("#sector_table").html("");
             $("#sector_table").html(tblData);
						  sort();

		},
		 error:function(jqXHR, textStatus, errorThrown) {
		   alert("AJAX Error:" + textStatus);
		 }
 })
}


function `stock_search`()
{

	$.ajax({
		type:'GET',
		url: 'http://localhost:3000/home/get_stock_data',
		datatype:'json',
		success:function(stockdata, textStatus, jqXHR) {
		 console.log(stockdata);
		 var fundname = [];

		 for(var i =0;i <= stockdata.stock.length-1;i++)
		 {
			var item1 = stockdata.stock[i];
			var scheme_code = item1.schemecode;
			fundname.push(item1.fund);

		 }
		    $("#stock_names").autocomplete({
				source: fundname
			});
		console.log(fundname);
		},
		 error:function(jqXHR, textStatus, errorThrown) {
		   alert("AJAX Error:" + textStatus);
		 }
 })
}

function get_stock_data()
{

	$.ajax({
		type:'GET',
		url: 'http://localhost:3000/home/get_stock_data',
		datatype:'json',
		success:function(stockdata, textStatus, jqXHR) {
		 console.log(stockdata);
		 var fundname = [];
		 var tblData;
		 var th = "<thead><tr><th>Fund</th><th>Dec-15</th><th>Sep-15</th><th>Jun-15</th><th>Mar-15</th><th>Dec-14</th></tr></thead>";

		 for(var i =0;i <= stockdata.stock.length-1;i++)
		 {
			var item1 = stockdata.stock[i];
			var scheme_code = item1.schemecode;
			var fund = item1.fund;
			var dec_15 = item1.dec_15;
			var sep_15 = item1.sep_15;
			var jun_15 = item1.jun_15;
			var mar_15 = item1.mar_15;
			fundname.push(item1.fund);
           if(i == 0)
               {
                tblData = th + "<tr><td>"+fund+"</td><td>"+dec_15+"</td><td>"+sep_15+"</td><td>"+jun_15+"</td><td>"+mar_15+"</td></tr>";
                      }
              else
              {
               tblData = tblData + "<tr><td>"+fund+"</td><td>"+dec_15+"</td><td>"+sep_15+"</td><td>"+jun_15+"</td><td>"+mar_15+"</td></tr>";
                }


		 }


			 $("#stock_table").html("");
             $("#stock_table").html(tblData);
		},
		 error:function(jqXHR, textStatus, errorThrown) {
		   alert("AJAX Error:" + textStatus);
		 }
 })
}

function port_avgcap()
{

	$.ajax({
		type:'GET',
		url: 'http://localhost:3000/functionalities/get_protfolio_avgmarketcap',
		datatype:'json',
		success:function(sectordata, textStatus, jqXHR) {
		console.log(sectordata);
		var tblData;
		var th = "<thead><tr><th>Portfolio Market Cap</th><th>Fund</th><th>Category Average</th></tr></thead>";


		for(var i =0;i <= sectordata.market.length-1;i++)
		{
			var item1 = sectordata.market[i];
			var scheme_code = item1.schemecode;
			var portfolio_marketcap = item1.portfolio_marketcap;
			var fund = item1.fund;
			var category_avg = item1.category_avg;
            if(i == 0)
            {
                tblData = th + "<tr><td>"+portfolio_marketcap+"</td><td>"+fund+"</td><td>"+category_avg+"</td></tr>";
                      }
            else
            {
               tblData = tblData + "<tr><td>"+portfolio_marketcap+"</td><td>"+fund+"</td><td>"+category_avg+"</td></tr>";
            }
		}
		$("#portfolio_table").html("");
        $("#portfolio_table").html(tblData);
		},
		error:function(jqXHR, textStatus, errorThrown) {
		  alert("AJAX Error:" + textStatus);
		}
 })
}
