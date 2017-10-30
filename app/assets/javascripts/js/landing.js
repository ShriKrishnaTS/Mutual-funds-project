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
	alert('rupeevest');
	$.ajax({
			type:'GET',
			url: '/functionalities/schemedata_landing',
			datatype:'json',
			success:function(data1, textStatus, jqXHR) {
				console.log(data1);
				fill_snapshot_table(data1);
				var sorter = tsorter.create('snapshotTable');
				// customTableSorting();
			},
			error:function(jqXHR, textStatus, errorThrown) {
				alert("AJAX Error:" + textStatus);
			}

		})
}

function fill_snapshot_table(data1)
{
	var tblData;
	var th = "<thead><tr class='bg-color'><th style='width:50px'></th><th>Fund</th><th data-name='rup_rating'>Rupeevest </br>Rating</th><th data-name='aum'>AUM </br>(in crores)</th><th>Return</br>(1 year)</th><th>Return</br>(3 year)</th><th>Return</br> (5 year)</th><th>ExpenseRatio</th><th>Highest Sector Allocation</th></tr></thead>";
	//var t = document.getElementById("snapshotTabletblData").innerHTML;
	for(var i =0;i <= data1.schemedata.length-1;i++)
	{
		var scheme_data = data1.schemedata[i];
		var scheme_code = scheme_data.schemecode;
		var scheme_name = scheme_data.s_name;
		var fund_manager = scheme_data.fund_manager;
		var scheme_year1 = scheme_data.returns_1year;
		var scheme_year3 = scheme_data.returns_3year;
		var scheme_year5 = scheme_data.returns_5year;
		var scheme_aum_total = scheme_data.aumtotal;
		var exratio = scheme_data.expenceratio;
		var rr = scheme_data.rupeevest_rating;
		var returns_1month = scheme_data.returns_1month;
		var returns_3month = scheme_data.returns_3month;
		var turnover_ratio = scheme_data.turnover_ratio;
		var exitload = scheme_data.exitload;
		var navrs = scheme_data.navrs;
		var inception_date = scheme_data.inception_date;
		var minimum_investment = scheme_data.minimum_investment;
		var betax_returns = scheme_data.betax_returns;
		var alphax_returns = scheme_data.alphax_returns;
		var sotinox_returns = scheme_data.sotinox_returns;
		var sharpex_returns = scheme_data.sharpex_returns;


		var sdx_returns = scheme_data.sdx_returns;
		var portfolio_attributes = scheme_data.portfolio_attributes;
		var cost_factor = scheme_data.cost_factor;
		var risk = scheme_data.risk;
		var consistency_of_return = scheme_data.consistency_of_return;

		var total_return = scheme_data.total_return;
		var high_sec_alloc;
		if(scheme_data.highest_sector)
		{
			high_sec_alloc = scheme_data.highest_sector;
		}
		else
		{
			high_sec_alloc = "NA";
		}


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
		  /*tblData = t + "<tr><td><inputid="+scheme_code+"type='checkbox'name='chkCompare'/></td><td><aid="+scheme_code+"href='#'onclick='setvalue(this.id)'>"+scheme_name+"</a></td><td>"+rr+"</td><td data-name= 'aum' style='display:block;'>"+scheme_aum_total+"</td><td data-name= 'retyr1' style='display:block;'>"+scheme_year1+"</td><tddata-name= 'retyr3' style='display:block;'>"+scheme_year3+"</td><td data-name= 'retyr5' style='display:block;'>"+scheme_year5+"</td><td data-name= 'exratio' style='display:block;'>"+exratio+"</td><td data-name= 'retmth1' style='display:block;'>"+returns_1month+"</td><td data-name= 'retmth3' style='display:block;'>"+returns_3month+"</td><td data-name= 'tnratio' style='display:block;'>"+turnover_ratio+"</td><td data-name= 'exload' style='display:block;'>"+exitload+"</td><td data-name= 'navrs' style='display:block;'>"+navrs+"</td><td data-name= 'indate' style='display:block;'>"+inception_date+"</td><td data-name= 'mininv' style='display:block;'>"+minimum_investment+"</td><td data-name= 'betax' style='display:block;'>"+betax_returns+"</td><td data-name= 'alphax' style='display:block;'>"+alphax_returns+"</td><td data-name= 'sotionox' style='display:block;'>"+sotinox_returns+"</td><td data-name= 'sharpex' style='display:block;'>"+sharpex_returns+"</td><td data-name= 'sdx' style='display:block;'>"+sdx_returns+"</td><td data-name= 'portattr' style='display:block;'>"+portfolio_attributes+"</td><td data-name= 'costfctr' style='display:block;'>"+cost_factor+"</td><td data-name= 'risk' style='display:block;'>"+risk+"</td><td data-name= 'ctrn' style='display:block;'>"+consistency_of_return+"</td><td data-name= 'trtn' style='display:block;'>"+total_return+"</td></tr>";*/
		  tblData = th + "<tr><td style='width:50px'><input id="+scheme_code+" type='checkbox' name='chkCompare' /></td><td><a id="+scheme_code+" href='#' onclick='setvalue(this.id)'>"+scheme_name+"</a><br><a href='#' >"+fund_manager+"</a></td><td data-name = 'rup_rating'>"+rr+"</td><td data-name= 'aum'>"+scheme_aum_total+"</td><td>"+scheme_year1+"</td><td>"+scheme_year3+"</td><td>"+scheme_year5+"</td><td>"+exratio+"</td><td>"+high_sec_alloc+"</td></tr>";
		}

		else
		{
		   /*tblData = tblData + "<tr><td><inputid="+scheme_code+"type='checkbox'name='chkCompare'/></td><td><a id="+scheme_code+"href='#'onclick='setvalue(this.id)'>"+scheme_name+"</a></td><td>"+rr+"</td><td data-name= 'aum' style='display:block;'>"+scheme_aum_total+"</td><td data-name= 'retyr1' style='display:block;'>"+scheme_year1+"</td><td data-name= 'retyr3' style='display:block;'>"+scheme_year3+"</td><td data-name= 'retyr5' style='display:block;'>"+scheme_year5+"</td><td data-name= 'exratio' style='display:block;'>"+exratio+"</td><td data-name= 'retmth1' style='display:block;'>"+returns_1month+"</td><td data-name= 'retmth3' style='display:block;'>"+returns_3month+"</td><td data-name= 'tnratio' style='display:block;'>"+turnover_ratio+"</td><td data-name= 'exload' style='display:block;'>"+exitload+"</td><td data-name= 'navrs' style='display:block;'>"+navrs+"</td><td data-name= 'indate' style='display:block;'>"+inception_date+"</td><td data-name= 'mininv' style='display:block;'>"+minimum_investment+"</td><td data-name= 'betax' style='display:block;'>"+betax_returns+"</td><td data-name= 'alphax' style='display:block;'>"+alphax_returns+"</td><td data-name= 'sotionox' style='display:block;'>"+sotinox_returns+"</td><td data-name= 'sharpex' style='display:block;'>"+sharpex_returns+"</td><td data-name= 'sdx' style='display:block;'>"+sdx_returns+"</td><td data-name= 'portattr' style='display:block;'>"+portfolio_attributes+"</td><td data-name= 'costfctr' style='display:block;'>"+cost_factor+"</td><td data-name= 'risk' style='display:block;'>"+risk+"</td><td data-name= 'ctrn' style='display:block;'>"+consistency_of_return+"</td><td data-name= 'trtn' style='display:block;'>"+total_return+"</td></tr>";*/


			tblData = tblData + "<tr><td><input id="+scheme_code+" type='checkbox' name='chkCompare' /></td><td><a id="+scheme_code+" href='#' onclick='setvalue(this.id)'>"+scheme_name+"</a><br><a href='#' >"+fund_manager+"</a></td><td data-name = 'rup_rating'>"+rr+"</td><td data-name= 'aum'>"+scheme_aum_total+"</td><td>"+scheme_year1+"</td><td>"+scheme_year3+"</td><td>"+scheme_year5+"</td><td>"+exratio+"</td><td>"+high_sec_alloc+"</td></tr>";
		}
	}
	$("#snapshotTabletblData").html("");
	$("#snapshotTabletblData").html(tblData);
	customTableSorting();




}

function chkbox_click(obj)
{
	var checkboxId= obj.id;
	//alert(checkboxId);
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
function rating_all()
{
	if(document.getElementById("chkratingAll").checked == true)
	{
		document.getElementById("ratingFive").checked = true;
		document.getElementById("ratingFour").checked = true;
		document.getElementById("ratingThree").checked = true;
		document.getElementById("ratingTwo").checked = true;
		document.getElementById("ratingOne").checked = true;
		document.getElementById("ratingUn").checked = true;
	}
	else
	{
		document.getElementById("ratingFive").checked = false;
		document.getElementById("ratingFour").checked = false;
		document.getElementById("ratingThree").checked = false;
		document.getElementById("ratingTwo").checked = false;
		document.getElementById("ratingOne").checked = false;
		document.getElementById("ratingUn").checked = false;
	}

}
function selected_schemes(obj)
{
	var selected_schemes = "";
	var condn_type = "";
	if(obj == "asset_selection")
	{
		var eqty = document.getElementsByName("chkAllEquity");
		var dbt = document.getElementsByName("chkAllDebt");
		var hbd = document.getElementsByName("chkAllHybrid");
		var etf = document.getElementsByName("chkAllEtfs");

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
	}
	else if(obj == "rup_rating")
	{
		var rating = document.getElementsByName("chkratingAll");
		for(var i = 0; i<rating.length;i++)
		{
			if(rating[i].checked == true)
			{
				if(selected_schemes == "")
				{
					selected_schemes = rating[i].value;
				}
				else
				{
					selected_schemes = selected_schemes + "," + rating[i].value;
				}
			}
		}
		//alert(selected_schemes);
	}
	else if(obj == "factor_score")
	{
			selected_schemes = selected_schemes + document.getElementById("totalreturn").value + "," + document.getElementById("consisreturn").value + "," + document.getElementById("risk").value + "," + document.getElementById("costfactor").value + "," + document.getElementById("portattr").value;

			condn_type = "factor_score";
	}
	else if(obj == "filters")
	{
		var asset_min = $("#fromValueasset").val();
		var asset_max = $("#toValueasset").val();
		var age_min = $("#fromValueage").val();
		var age_max =$("#toValueage").val();
		var exitload_min =$("#fromValueexitload").val();
		var exitload_max = $("#toValueexitload").val();
		var turnover_ratio_min =$("#fromValueturnoverratio").val();
		var turnover_ratio_max =$("#toValueturnoverratio").val();
		var expenceratio_min =$("#fromValueexpenseratio").val();
		var expenceratio_max =$("#toValueexpenseratio").val();
		var amc =$("#amcname").val();
		var index = $("#indexname").val();
		var fund_manager = $("#fundmanager").val();
		var amcall = document.getElementById("chkAmc").checked;
		var indexall = document.getElementById("chkIndex").checked;
		var fundmgrall = document.getElementById("chkFund").checked;
		selected_schemes = asset_min +","+ asset_max +","+ age_min +","+ age_max +","+ exitload_min +","+ exitload_max +","+ turnover_ratio_min +","+ turnover_ratio_max +","+ expenceratio_min +","+ expenceratio_max +","+ amc +","+ index +","+ fund_manager+","+amcall+","+indexall+","+fundmgrall;
		condn_type = "filters";
	}
	else{

	}
	if(selected_schemes == "")
	{
		alert("Select Some parameters to retrieve data");
	}
	else
	{
		$("#snapshotTabletblData").html("");
		//  customTableSorting();
		$.ajax({
                type: "POST",
                url: '/functionalities/asset_class_section?',
                data: { selected_schemes : selected_schemes,condn_type:condn_type },
                datatype:'json',
				success:function(data1, textStatus, jqXHR) {
				console.log(data1);
				/*var tblData;
				var t = document.getElementById("snapshotTabletblData").innerHTML;
				for(var i =0;i <= data1.schemedata.length-1;i++)
				{
					var scheme_data = data1.schemedata[i];
					var scheme_code = scheme_data.schemecode;
					var scheme_name = scheme_data.s_name;
					var scheme_year1 = scheme_data.returns_1year;
					var scheme_year3 = scheme_data.returns_3year;
					var scheme_year5 = scheme_data.returns_5year;
					var scheme_aum_total = scheme_data.aumtotal;
					var exratio = scheme_data.expenceratio;
					var rr = scheme_data.rupeevest_rating;
					var returns_1month = scheme_data.returns_1month;
					var returns_3month = scheme_data.returns_3month;
					var turnover_ratio = scheme_data.turnover_ratio;
					var exitload = scheme_data.exitload;
					var navrs = scheme_data.navrs;
					var inception_date = scheme_data.inception_date;
					var minimum_investment = scheme_data.minimum_investment;
					var betax_returns = scheme_data.betax_returns;
					var alphax_returns = scheme_data.alphax_returns;
					var sotinox_returns = scheme_data.sotinox_returns;
					var sharpex_returns = scheme_data.sharpex_returns;


					var sdx_returns = scheme_data.sdx_returns;
					var portfolio_attributes = scheme_data.portfolio_attributes;
					var cost_factor = scheme_data.cost_factor;
					var risk = scheme_data.risk;
					var consistency_of_return = scheme_data.consistency_of_return;

					var total_return = scheme_data.total_return;
					var high_sec_alloc = scheme_data.highest_sector;
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
					{*/
					  /*tblData = t+"<tr><td><inputid="+scheme_code+"type='checkbox'name='chkCompare'/></td><td><aid="+scheme_code+"href='#'onclick='setvalue(this.id)'>"+scheme_name+"</a></td><td>"+rr+"</td><td>"+scheme_aum_total+"</td><td>"+scheme_year1+"</td><td>"+scheme_year3+"</td><td>"+scheme_year5+"</td><td>"+exratio+"</td><td>"+returns_1month+"</td><td>"+returns_3month+"</td><td>"+turnover_ratio+"</td><td>"+exitload+"</td><td>"+navrs+"</td><td>"+inception_date+"</td><td>"+minimum_investment+"</td><td>"+betax_returns+"</td><td>"+alphax_returns+"</td><td>"+sotinox_returns+"</td><td>"+sharpex_returns+"</td><td>"+sdx_returns+"</td><td>"+portfolio_attributes+"</td><td>"+cost_factor+"</td><td>"+risk+"</td><td>"+consistency_of_return+"</td><td>"+total_return+"</td></tr>";*/
					 /* tblData = t + "<tr><td><input id="+scheme_code+" type='checkbox' name='chkCompare'/></td><td><a id="+scheme_code+" href='#' onclick='setvalue(this.id)'>"+scheme_name+"</a></td><td>"+rr+"</td><td>"+scheme_aum_total+"</td><td>"+scheme_year1+"</td><td>"+scheme_year3+"</td><td>"+scheme_year5+"</td><td>"+exratio+"</td><td>"+high_sec_alloc+"</td></tr>";
					}

					else
					{*/
                       /*tblData = tblData +"<tr><td><inputid="+scheme_code+"type='checkbox'name='chkCompare'/></td><td><aid="+scheme_code+"href='#'onclick='setvalue(this.id)'>"+scheme_name+"</a></td><td>"+rr+"</td><td>"+scheme_aum_total+"</td><td>"+scheme_year1+"</td><td>"+scheme_year3+"</td><td>"+scheme_year5+"</td><td>"+exratio+"</td><td>"+returns_1month+"</td><td>"+returns_3month+"</td><td>"+turnover_ratio+"</td><td>"+exitload+"</td><td>"+navrs+"</td><td>"+inception_date+"</td><td>"+minimum_investment+"</td><td>"+betax_returns+"</td><td>"+alphax_returns+"</td><td>"+sotinox_returns+"</td><td>"+sharpex_returns+"</td><td>"+sdx_returns+"</td><td>"+portfolio_attributes+"</td><td>"+cost_factor+"</td><td>"+risk+"</td><td>"+consistency_of_return+"</td><td>"+total_return+"</td></tr>";*/


						/*tblData = tblData + "<tr><td><input id="+scheme_code+" type='checkbox' name='chkCompare' /></td><td><a id="+scheme_code+" href='#' onclick='setvalue(this.id)'>"+scheme_name+"</a></td><td>"+rr+"</td><td>"+scheme_aum_total+"</td><td>"+scheme_year1+"</td><td>"+scheme_year3+"</td><td>"+scheme_year5+"</td><td>"+exratio+"</td><td>"+high_sec_alloc+"</td></tr>";
					}
				}
				$("#snapshotTabletblData").html("");
				$("#snapshotTabletblData").html(tblData);*/
				fill_snapshot_table(data1);
				fill_landing_returns(data1);
				//  customTableSorting();
				//var sorter = tsorter.create('snapshotTable');

                },  error:function(jqXHR, textStatus, errorThrown) {
					alert("AJAX Error:" + textStatus);
				}
            });
	}

}


function get_dividend_data()
{
	$.ajax({
			type:'GET',
			url: '/functionalities/get_dividend_data',
			datatype:'json',
			success:function(dividend_data, textStatus, jqXHR) {
				console.log('response')
			console.log(dividend_data.dividend_data.length);
			var data;
			var th = "<thead><tr><th>Plan</th><th>Record Date</th><th>Dividend(Rs/Unit)</th></tr></thead>";
			for(var i =0; i<= dividend_data.dividend_data.length-1;i++)
			{
				var div_data = dividend_data.dividend_data[i];
				console.log(div_data)
				var recorddate = div_data.recorddate;
				var gross = div_data.gross;
				var div_type = div_data.div_type;

				if(i == 0)
				{
					tblData = th + "<tr><td>"+div_type+"</td><td>"+recorddate+"</td><td>"+gross+"</td></tr>";
				}

				{
					tblData = tblData + "<tr><td>"+div_type+"</td><td>"+recorddate+"</td><td>"+gross+"</td></tr>";
				}
			  }

			$("#dividend_data").html("");
			$("#dividend_data").html(tblData);
			customTableSorting();
			},
				error:function(jqXHR, textStatus, errorThrown) {
				alert("AJAX Error:" + textStatus);
			}
  })
}

function get_recent_updates()
{
    $.ajax({
            type:'GET',
            url: '/functionalities/get_recent_updates',
            datatype:'json',
            success:function(Recent_updates, textStatus, jqXHR) {
                console.log('response')
                alert("hii");
            console.log(Recent_updates.Recent_updates.length);
            var data;
            var th = "<thead><tr> <th></th><th> </th></tr></thead>";
            for(var i =0; i<= Recent_updates.Recent_updates.length-1;i++)
            {
                var recent_data = Recent_updates.Recent_updates[i];
                console.log(recent_data)
                var headline = recent_data.headline;
                var date = recent_data.date;


                if(i == 0)
                {
                    tblData = th + "<tr><td>"+headline+"|"+date+"</td></tr>";
                }

                {
                    tblData = tblData + "<tr><td>"+headline+"| "+date+"</td></tr>";
                }
              }

            $("#Recent_updates").html("");
            $("#Recent_updates").html(tblData);
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
			url: '/functionalities/get_peer_comparision',
			datatype:'json',
			success:function(peer_comparision, textStatus, jqXHR) {
			console.log(peer_comparision);
			var pc_data;
			var th = "<thead><tr><th>Fund</th><th>Rupeevest Rating</th><th>AUM(in cr)</th><th>YTD</th><th>1 Month</th><th>3 Month</th><th>1 Year</th><th>3 Year</th><th>5 Year</th><th>Expense Ratio(%)</th></tr></thead>";
			for(var i =0;i <= peer_comparision.peer_comparision.length-1;i++)
			{
				var pc_data = peer_comparision.peer_comparision[i];
				var scheme_code = pc_data.schemecode;
				var s_name = pc_data.s_name;
				var rupeevest_rating = pc_data.rupeevest_rating;
				var ytd_returns = pc_data.ytd_returns;
				var returns_1month = pc_data.returns_1month;
				var returns_3month = pc_data.returns_3month;
				var returns_1year = pc_data.returns_1year;
				var returns_3year = pc_data.returns_3year;
				var returns_5year = pc_data.returns_5year;
				var aumtotal = pc_data.aumtotal;
				var expenceratio = pc_data.expenceratio;
				if(i == 0)
				{
					tblData = th + "<tr><td>"+s_name+"</td><td>"+rupeevest_rating+"</td><td>"+aumtotal+"</td><td>"+ytd_returns+"</td><td>"+returns_1month+"</td><td>"+returns_3month+"</td><td>"+returns_1year+"</td><td>"+returns_3year+"</td><td>"+returns_5year+"</td><td>"+expenceratio+"</td></tr>";
				}
				else
				{
					tblData = tblData + "<tr><td>"+s_name+"</td><td>"+rupeevest_rating+"</td><td>"+aumtotal+"</td><td>"+ytd_returns+"</td><td>"+returns_1month+"</td><td>"+returns_3month+"</td><td>"+returns_1year+"</td><td>"+returns_3year+"</td><td>"+returns_5year+"</td><td>"+expenceratio+"</td></tr>";
				}
			  }
			$("#peertabl").html("");
			$("#peertabl").html(tblData);
			customTableSorting();
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
			url: '/functionalities/get_return_data',
			datatype:'json',
			success:function(returns_data, textStatus, jqXHR) {
			console.log(returns_data);
			var mf_data;
			var th = "<thead><tr><th>Return(%)</th><th>YTD</th><th>1 Month</th><th>3 Month</th><th>1 Year</th>   <th>3 Year</th><th>5 Year</th></tr></thead>";
			for(var i =0;i <= returns_data.returns_data.length-1;i++)
			{
				mf_data = returns_data.returns_data[i];
				var scheme_name = mf_data.s_name;
				var monthret_1 = mf_data.returns_1month;
				var monthret_3 = mf_data.returns_3month;
				var yrret_1 = mf_data.returns_1year;
				var yearret_3 = mf_data.returns_3year;
				var yearret_5 = mf_data.returns_5year;
				var fund = "Fund";
				var ytd = mf_data.ytd_returns;
				var index_name = mf_data.index_name;
				var category_Average = "category Average";
				var Rank =  "Rank Within category";
				var Number_fund = " Number Of funds in category";
				var rank_ytd = mf_data.rank_ytd;
				var rank_1month = mf_data.rank_1month;
				var rank_3month = mf_data.rank_3month;
				var rank_1year = mf_data.rank_1year;
				var rank_3year = mf_data.rank_3year;
				var rank_5year = mf_data.rank_5year;
				var funds_num_ytd = mf_data.no_of_funds_total;
				var funds_num_month1 = mf_data.no_of_funds_total;
				var funds_num_month3 = mf_data.no_of_funds_total;
				var funds_num_year1 = mf_data.no_of_funds_total;
				var funds_num_year3 = mf_data.no_of_funds_total;
				var funds_num_year5 = mf_data.no_of_funds_total;
				var ytd_avg = mf_data.ytd_avg;
				var avg_month1 = mf_data.avg_month1;
				var avg_month3 = mf_data.avg_month3;
				var avg_year1 = mf_data.avg_year1;
				var avg_year3 = mf_data.avg_year3;
				var avg_year5 = mf_data.avg_year5;
				var ytdret = mf_data.ytdret;
				var monthret_1 = mf_data.monthret_1;
				var monthret_3 = mf_data.monthret_3;
				var yrret_1 = mf_data.yrret_1;
				var yrret_3 = mf_data.yrret_3;
				var yrret_5 = mf_data.yrret_5;

				if(i == 0)
				{
					tblData = th + "<tr><td>"+fund+"</td><td>"+ytd+"</td><td>"+monthret_1+"</td><td>"+monthret_3+"</td><td>"+yrret_1+"</td><td>"+yearret_3+"</td><td>"+yearret_5+"</td></tr>";
					tblData = tblData + "<tr><td>"+index_name+"</td><td>"+ytdret+"</td><td>"+monthret_1+"</td><td>"+monthret_3+"</td><td>"+yrret_1+"</td><td>"+yrret_3+"</td><td>"+yrret_5+"</td></tr>";
					tblData = tblData + "<tr><td>"+category_Average+"</td><td>"+ytd_avg+"</td><td>"+avg_month1+"</td><td>"+avg_month3+"</td><td>"+avg_year1+"</td><td>"+avg_year3+"</td><td>"+avg_year5+"</td></tr>";
					tblData = tblData + "<tr><td>"+Rank+"</td><td>"+rank_ytd+"</td><td>"+rank_1month+"</td><td>"+rank_3month+"</td><td>"+rank_1year+"</td><td>"+rank_3year+"</td><td>"+rank_5year+"</td></tr>";
					tblData = tblData + "<tr><td>"+Number_fund+"</td><td>"+funds_num_ytd+"</td><td>"+funds_num_month1+"</td><td>"+funds_num_month3+"</td><td>"+funds_num_year1+"</td><td>"+funds_num_year3+"</td><td>"+funds_num_year5+"</td></tr>";
				}
				else{
                   // tblData = tblData + "<tr><td>"+fund+"</td><td>"+ytd+"</td><td>"+monthret_1+"</td><td>"+monthret_3+"</td><td>"+yrret_1+"</td><td>"+yearret_3+"</td><td>"+yearret_5+"</td></tr><tr></tr>";

				}
			}

			$("#return").html("");
			$("#return").html(tblData);
			customTableSorting();
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
			url: '/functionalities/get_risk_measures',
			datatype:'json',
			success:function(risk_data, textStatus, jqXHR) {
			console.log(risk_data);
			var rm_data;
			var th = "<thead><tr><th>Risk Measure(%)</th><th>Std Div</th><th>Sharpe</th><th>Sotino</th><th>Beta</th><th>Alpha</th><th>Treynor Ratio</th></tr></thead>";
			for(var i =0;i <= risk_data.risk_data.length-1;i++)
			{
				rm_data = risk_data.risk_data[i];
				var scheme_name = rm_data.s_name;
				var sdx_returns = rm_data.sdx_returns;
				var sharpex_returns = rm_data.sharpex_returns;
				var sotinox_returns = rm_data.sotinox_returns;
				var betax_returns = rm_data.betax_returns;
				var alphax_returns = rm_data.alphax_returns;
				var treynorx_returns = rm_data.treynorx_returns;
				var fund = "Fund";
				var index_name = rm_data.index_name;
				var category_Average = "category Average";
				var Rank =  "Rank Within category";
				var Number_fund = " Number Of funds in category";
				var sdy_returns = rm_data.sdy_returns;
				var sharpey_returns = rm_data.sharpey_returns;
				var sotinoy_returns = rm_data.sotinoy_returns;
				var betay_returns = rm_data.betay_returns;
				var alphay_returns = rm_data.alphay_returns;
				var treynory_returns = rm_data.treynory_returns;
				var rank_sd = rm_data.rank_sd;
				var rank_sharpe = rm_data.rank_sharpe;
				var rank_sotino = rm_data.rank_sotino;
				var rank_beta = rm_data.rank_beta;
				var rank_alpha = rm_data.rank_alpha;
				var rank_treynor = rm_data.rank_treynor;
				var avg_std_dev = rm_data.avg_std_dev;
				var avg_sharpe = rm_data.avg_sharpe;
				var avg_sotino = rm_data.avg_sotino;
				var avg_beta = rm_data.avg_beta;
				var avg_alpha = rm_data.avg_alpha;
				var avg_treyno = rm_data.avg_treyno;
				var avg_t = rm_data.no_of_funds_total;
				var avg_ta = rm_data.no_of_funds_total;
				var avg_tb = rm_data.no_of_funds_total;
				var avg_tc = rm_data.no_of_funds_total;
				var avg_td = rm_data.no_of_funds_total;
				var avg_te = rm_data.no_of_funds_total;
				if(i == 0)
				{
					tblData=th + "<tr><td>"+fund+"</td><td>"+sdx_returns+"</td><td>"+sharpex_returns+"</td><td>"+sotinox_returns+"</td><td>"+betax_returns+"</td><td>"+alphax_returns+"</td><td>"+treynorx_returns+"</td></tr>";
					tblData = tblData + "<tr><td>"+index_name+"</td><td>"+sdy_returns+"</td><td>"+sharpey_returns+"</td><td>"+sotinoy_returns+"</td><td>"+betay_returns+"</td><td>"+alphay_returns+"</td><td>"+treynory_returns+"</td></tr>";
					tblData = tblData + "<tr><td>"+category_Average+"</td><td>"+avg_std_dev+"</td><td>"+avg_sharpe+"</td><td>"+avg_sotino+"</td><td>"+avg_beta+"</td><td>"+avg_alpha+"</td><td>"+avg_treyno+"</td></tr>";
					tblData = tblData + "<tr><td>"+Rank+"</td><td>"+rank_sd+"</td><td>"+rank_sharpe+"</td><td>"+rank_sotino+"</td><td>"+rank_beta+"</td><td>"+rank_alpha+"</td><td>"+rank_treynor+"</td></tr>";
					tblData = tblData + "<tr><td>"+Number_fund+"</td><td>"+avg_t+"</td><td>"+avg_ta+"</td><td>"+avg_tb+"</td><td>"+avg_tc+"</td><td>"+avg_td+"</td><td>"+avg_te+"</td></tr>";


				}


				else{

					/*tblData = tblData + "<tr class='active'><td>Category Average</td><td colspan='2'></td><td></td><td></td><td></td><td></td><td colspan='2'></td><td colspan='2'></td></tr><tr><td>Rank Within Category</td><td colspan='2'></td><td></td><td></td><td></td><td></td><td colspan='2'></td><td colspan='2'></td></tr><tr class=active><td>Number of funds in category</td><td colspan='2'></td><td></td><td></td><td></td><td></td><td colspan='2'></td><td colspan='2'></td></tr><tr><td>As on April XYZ</td><td colspan='2'></td><td></td><td></td><td></td><td></td><td colspan='2'></td><td colspan='2'></td></tr>";*/
				}
			}


			$("#riskmeasure").html("");
			$("#riskmeasure").html(tblData);
			customTableSorting();
			},
				error:function(jqXHR, textStatus, errorThrown) {
				alert("AJAX Error:" + textStatus);
			}
  })
}
function rupeevest_rating()
{
	alert('star_rating');
	$.ajax({
		type:'GET',
		url: '/functionalities/star_rating',
		datatype:'json',
		success:function(star_ratings, textStatus, jqXHR) {
		console.log(star_ratings);
		for(var i =0;i <= star_ratings.star_ratings.length-1;i++)
		{
			var item1 = star_ratings.star_ratings[i];
			var rupeevest_rating = item1.rupeevest_rating;

			$("#rupeevest_rating").html(rupeevest_rating);
			$(".displayStars").html(rupeevest_rating).stars();


		}
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
			url: '/functionalities/portfolio_holdings',
			datatype:'json',
			success:function(portfolio_holdings, textStatus, jqXHR) {
			console.log(portfolio_holdings);
			var tblData;
			var th = "<thead class='border-top'><tr><th>Security Name</th><th>Sector</th><th>Credit Rating</th><th>Weight (%)</th></tr></thead>";
			for(var i =0;i <= portfolio_holdings.portfolio_holdings.length-1;i++)
			{
				var ph_data = portfolio_holdings.portfolio_holdings[i];
				var compname = ph_data.compname;
				var sect_name = ph_data.sect_name;
				var rating = ph_data.rating;
				var holdpercentage = ph_data.holdpercentage;
				if(i == 0)
				{
					tblData = th + "<tr class='post'><td>"+compname+"</td><td>"+sect_name+"</td><td>"+rating+"</td><td>"+holdpercentage+"</td></tr>";
				}
				else
				{
					tblData = tblData + "<tr class='post'><td>"+compname+"</td><td>"+sect_name+"</td><td>"+rating+"</td><td>"+holdpercentage+"</td></tr>";
				}
			  }
			$("#portfolio_holdings").html("");
			$("#portfolio_holdings").html(tblData);
			portfolio_pagination();
			customTableSorting();
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
		url: '/home/get_holding_asset',
		datatype:'json',
		success:function(sectordata, textStatus, jqXHR) {
		 console.log(sectordata);
		 var tblData;
		 var th = " <thead><tr><th>Company</th><th>Industry</th><th>Sector</th><th>Assets %</th><th>Previous Quarter %</th></tr></thead>";


		 for(var i =0;i <= sectordata.hold.length-1;i++)
		 {
			var item1 = sectordata.hold[i];
			var scheme_code = item1.schemecode;
			var company = item1.compname;
			var sector = item1.sect_name;
			var rv_sector = item1.rv_sect_name;
			var holdpercentage = item1.holdpercentage;
			var previous_quarter  = item1.prev_holdperc;
            if(i == 0)
               {
                tblData = th + "<tr><td>"+company+"</td><td>"+sector+"</td><td>"+rv_sector+"</td><td>"+holdpercentage+"</td><td>"+previous_quarter+"</td></tr>";
                      }
              else
              {
               tblData = tblData + "<tr><td>"+company+"</td><td>"+sector+"</td><td>"+rv_sector+"</td><td>"+holdpercentage+"</td><td>"+previous_quarter+"</td></tr>";
                }
		 }
			 $("#holding_table").html("");
             $("#holding_table").html(tblData);
						 customTableSorting();
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
		url: '/home/get_sector_search',
		datatype:'json',
		success:function(sectordata, textStatus, jqXHR) {
		var fundnames = new Array;

		for(var i =0;i <= sectordata.secsearch.length-1;i++)
		{

			var item1 = sectordata.secsearch[i];
			var sect_code = item1.rv_sect_code;
			fundnames.push(item1.rv_sect_name);
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

	var obj = document.getElementById("sector_names").value;
	$.ajax({
		type:'post',
		url: '/home/get_sector_data',
		data :{sectorname:obj},
		datatype:'json',
		success:function(sectordata, textStatus, jqXHR) {
		console.log(sectordata);
		var fundname = [];
		var tblData;
		var th = "<thead><tr><th>Fund</th><th>Dec-15</th><th>Sep-15</th><th>Jun-15</th><th>Mar-15</th><th>desc-15</th></tr></thead>";


		for(var i =0;i <= sectordata.sec.length-1;i++)
		{
			var item1 = sectordata.sec[i];
			var schemecode = item1.schemecode;
			var s_name = item1.s_name;
			var hold_perc_q1 = item1.hold_perc_q1;
			var hold_perc_q2 = item1.hold_perc_q2;
			var hold_perc_q3 = item1.hold_perc_q3;
			var hold_perc_q4 = item1.hold_perc_q4;
			var hold_perc_q5 = item1.hold_perc_q5;

			fundname.push(item1.fund);
           if(i == 0)
               {
                tblData = th + "<tr><td>"+s_name+"</td><td>"+hold_perc_q1+"</td><td>"+hold_perc_q2+"</td><td>"+hold_perc_q3+"</td><td>"+hold_perc_q4+"</td><td>"+hold_perc_q5+"</td></tr>";
                      }
              else
              {
               tblData = tblData + "<tr><td>"+s_name+"</td><td>"+hold_perc_q1+"</td><td>"+hold_perc_q2+"</td><td>"+hold_perc_q3+"</td><td>"+hold_perc_q4+"</td><td>"+hold_perc_q5+"</td></tr>";
                }
		}
			$("#sector_table").html("");
             $("#sector_table").html(tblData);
						 customTableSorting();
		},
		error:function(jqXHR, textStatus, errorThrown) {
		  alert("AJAX Error:" + textStatus);
		}
 })
}


function stock_search()
{

	$.ajax({
		type:'GET',
		url: '/home/get_stock_search',
		datatype:'json',
		success:function(stockdata, textStatus, jqXHR) {
		var stocknames = new Array;

		for(var i =0;i <= stockdata.stocksearch.length-1;i++)
		{

			var item1 = stockdata.stocksearch[i];
			var scheme_code = item1.fincode;
			stocknames.push(item1.compname+"|"+item1.s_name);
			//console.log(stocknames);

		}
		console.log(stocknames);
		   $("#stock_names").autocomplete({
				source: stocknames
			});
		//$("#scheme_code").html(scheme_code);
		//$("#s_name").html(s_name);
		},
		error:function(jqXHR, textStatus, errorThrown) {
		  alert("AJAX Error:" + textStatus);
		}
 })

}


function stock_data()
{
	var obj = document.getElementById("stock_names").value;
	$.ajax({
		type:'post',
		url: '/home/get_stock_data',
		data :{stockname:obj},
		datatype:'json',
		success:function(stockdata, textStatus, jqXHR) {
		console.log(stockdata);
		var tblData;
		var th = "<thead><tr><th>S Name</th><th>Hold Perc(%) </th><th>Date</th></tr></thead>";

		for(var i =0;i <= stockdata.stock.length-1;i++)
		{
			var item1 = stockdata.stock[i];
			var compname = item1.compname;
			var s_name = item1.s_name;
			var holdpercentage = item1.holdpercentage;
			var invdate = item1.invdate;
			var name = item1.name;


           if(i == 0)
               {
				$("#stock_head").html(compname+" | "+name);
                tblData = th + "<tr><td>"+s_name+"</td><td>"+holdpercentage+"</td><td>"+invdate+"</td></tr>";
                }
              else
              {
               tblData = tblData + "<tr><td>"+s_name+"</td><td>"+holdpercentage+"</td><td>"+invdate+"</td></tr>";
               }
		}
		    	$("#stock_table").html("");
             $("#stock_table").html(tblData);
						 customTableSorting();
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
		url: '/functionalities/get_protfolio_avgmarketcap',
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
				customTableSorting();
		},
		error:function(jqXHR, textStatus, errorThrown) {
		  alert("AJAX Error:" + textStatus);
		}
 })
}

/*#pe_pb script */

function concentration_values()
{
	$.ajax({
			type:'GET',
			url: '/functionalities/get_concentration_value',
			datatype:'json',
			success:function(scheme_data,textStatus, jqXHR) {
	  console.log(scheme_data);
	  for(var i =0;i <= scheme_data.concen_value.length-1;i++)
	  {
		var count =  scheme_data.concen_value[0];
		var pe =  scheme_data.concen_value[1];
		var pb =  scheme_data.concen_value[2];
		var top10 =  parseInt(scheme_data.concen_value[3]).toFixed(2);
		var top5 =  parseInt(scheme_data.concen_value[4]).toFixed(2);
		var top3 = parseInt( scheme_data.concen_value[5]).toFixed(2);




	  }
		$("#pe").html(pe);
		$("#pb").html(pb);
		$("#stocks").html(count);
		$("#top3").html(top3);
		$("#top5").html(top5);
		$("#top10").html(top10);
	   },
	  error:function(jqXHR, textStatus, errorThrown) {
		alert("AJAX Error:" + textStatus);
	  }

	  })
}

function fundmanager()
{
	$.ajax({
	type: 'GET',
	url: '/home/get_landing_fundmanager',
	datatype: 'json',
	success: function (fundman, textStatus, jqXHR) {
	console.log(fundman);

		// console.log(Object.keys(fundman).length);
		var fundmanager="";
		$.each(fundman,function(key,value){
		$.each(value,function(key1,value1){
			/*alert(value1.fundmanager);*/
		fundmanager +='<option >'+value1.fund_manager+'</option>'
		})
		})

		$("#fundmanager").html("");
		$("#fundmanager").html(fundmanager);

		},
		error: function (jqXHR, textStatus, errorThrown) {
		alert("AJAX Error:" + textStatus);
		}

	})
}

function amcname()
{
	$.ajax({
	type: 'GET',
	url: '/home/get_landing_amc',
	datatype: 'json',
	success: function (amcn, textStatus, jqXHR) {
		console.log(amcn);

		// console.log(Object.keys(amcn).length);
		var amcname="";
		$.each(amcn,function(key,value){
		$.each(value,function(key1,value1){
		amcname +='<option >'+value1.amc+'</option>'
		})
		})

		$("#amcname").html("");
		$("#amcname").html(amcname);

		},
		error: function (jqXHR, textStatus, errorThrown) {
		alert("AJAX Error:" + textStatus);
		}

	})
}

function index_name()
{
	$.ajax({
	type: 'GET',
	url: '/home/get_landing_index',
	datatype: 'json',
	success: function (index, textStatus, jqXHR) {
		console.log(index);

		// console.log(Object.keys(amcn).length);
		var indexname="";
		$.each(index,function(key,value){
		$.each(value,function(key1,value1){
		//alert(value1.indexname);

		indexname +='<option >'+value1.index_name+'</option>'
		})
		})

		$("#indexname").html("");
		$("#indexname").html(indexname);

		},
		error: function (jqXHR, textStatus, errorThrown) {
		alert("AJAX Error:" + textStatus);
		}

	})
}

// Portfolio table pagination
function portfolio_pagination()
{
	pageSize = 4;
console.log("No. of Pages -- "+$('.pagination .post').length/pageSize);
var totalPages = $('.pagination .post').length/pageSize;
showPage = function(page) {
    $(".post").hide();

    $(".post").each(function(n) {

        if (n >= pageSize * (page - 1) && n < pageSize * page)
            $(this).show();
    });
}

showPage(1);

$("#pages .pages_1").click(function() {
    $("#pages .pages_1").removeClass("current");
    $(this).addClass("current");
    showPage(parseInt($(this).text()));
});

    $('#prev').click(prevPage);
    $('#next').click(nextPage);


var page = 1;

function prevPage() {
    //debugger;
    if (page === 1) {
		//alert("prev");
        //page = Math.floor($('.pagination .post').length/pageSize);
    } else {
        page--;
    }
    console.log(page);
    showPage(page);
}

function nextPage() {
    if (page == Math.floor($('.pagination .post').length/pageSize)) {
		//alert("last");
        //page = 1;
    } else {
        page++;
    }
	console.log(page);
    showPage(page);
}
}

function get_landing_returns()
{

	$.ajax({
		type:'GET',
		url: '/home/get_landing_returns',
		datatype:'json',
		success:function(sectordata, textStatus, jqXHR) {
		//console.log(sectordata);
		fill_landing_returns(sectordata);
		},
		error:function(jqXHR, textStatus, errorThrown) {
		 alert("AJAX Error:" + textStatus);
		}
 })
}
function fill_landing_returns(sectordata)
{
	console.log(sectordata);
		var annual_return;
		var month_return;
		var quarter_return;

		var ath = "<thead class='bg-color'><tr><th>Fund</th>";
		var ath_header = sectordata.ten_yrs;
		var ath_split = ath_header.split(",");
		for (var ai=0;ai<=ath_split.length-1;ai++)
		{
			ath = ath + "<th>"+ath_split[ai]+"</th>";
		}
		ath = ath + "</tr></thead>";

		var mth = "<thead class='bg-color'><tr><th>Fund</th>";
		var mth_header = sectordata.ten_months;
		var mth_split = mth_header.split(",");
		for (var mi=mth_split.length-1;mi>=0;mi--)
		{
			mth = mth + "<th>"+mth_split[mi]+"</th>";
		}
		mth = mth + "</tr></thead>";

		var qth = "<thead class='bg-color'><tr><th>Fund</th>";
		var qth_header = sectordata.ten_quarters;
		var qth_split = qth_header.split(",");
		for (var qi=0;qi<=qth_split.length-1;qi++)
		{
			qth = qth + "<th>"+qth_split[qi]+"</th>";
		}
		qth = qth + "</tr></thead>";


		for(var i =0;i <= sectordata.return_tab.length-1;i++)
		{
			var ry_data = sectordata.return_tab[i];
			var scheme_code = ry_data.schemecode;
			var s_name = ry_data.s_name;
			var classification = ry_data.classification;
			var return_year1 = ry_data.return_year1;
			var return_year2 = ry_data.return_year2;
			var return_year3 = ry_data.return_year3;
			var return_year4 = ry_data.return_year4;
			var return_year5 = ry_data.return_year5;
			var return_year6 = ry_data.return_year6;
			var return_year7 = ry_data.return_year7;
			var return_year8 = ry_data.return_year8;
			var return_year9 = ry_data.return_year9;
			var return_year10 = ry_data.return_year10;
			var return_month1 = ry_data.return_month1;
			var return_month2 = ry_data.return_month2;
			var return_month3 = ry_data.return_month3;
			var return_month4 = ry_data.return_month4;
			var return_month5 = ry_data.return_month5;
			var return_month6 = ry_data.return_month6;
			var return_month7 = ry_data.return_month7;
			var return_month8 = ry_data.return_month8;
			var return_month9 = ry_data.return_month9;
			var return_month10 = ry_data.return_month10;
		    var return_quarter1 = ry_data.return_quarter1;
			var return_quarter2 = ry_data.return_quarter2;
			var return_quarter3 = ry_data.return_quarter3;
			var return_quarter4 = ry_data.return_quarter4;
			var return_quarter5 = ry_data.return_quarter5;
			var return_quarter6 = ry_data.return_quarter6;
			var return_quarter7 = ry_data.return_quarter7;
			var return_quarter8 = ry_data.return_quarter8;
			var return_quarter9 = ry_data.return_quarter9;
			var return_quarter10 = ry_data.return_quarter10;


            if(i == 0)
            {
                annual_return = ath + "<tr><td>"+s_name+"</td><td>"+return_year1+"</td><td>"+return_year2+"</td><td>"+return_year3+"</td><td>"+return_year4+"</td><td>"+return_year5+"</td><td>"+return_year6+"</td><td>"+return_year7+"</td><td>"+return_year8+"</td><td>"+return_year9+"</td><td>"+return_year10+"</td> </tr>";

				 quarter_return = qth + "<tr><td>"+s_name+"</td><td>"+return_quarter1+"</td><td>"+return_quarter2+"</td><td>"+return_quarter3+"</td><td>"+return_quarter4+"</td><td>"+return_quarter5+"</td><td>"+return_quarter6+"</td><td>"+return_quarter7+"</td><td>"+return_quarter8+"</td><td>"+return_quarter9+"</td><td>"+return_quarter10+"</td> </tr>";

				  month_return = mth + "<tr><td>"+s_name+"</td><td>"+return_month1+"</td><td>"+return_month2+"</td><td>"+return_month3+"</td><td>"+return_month4+"</td><td>"+return_month5+"</td><td>"+return_month6+"</td><td>"+return_month7+"</td><td>"+return_month8+"</td><td>"+return_month9+"</td><td>"+return_month10+"</td> </tr>";
            }
            else
            {
               annual_return = annual_return + "<tr><td>"+s_name+"</td><td>"+return_year1+"</td><td>"+return_year2+"</td><td>"+return_year3+"</td><td>"+return_year4+"</td><td>"+return_year5+"</td><td>"+return_year6+"</td><td>"+return_year7+"</td><td>"+return_year8+"</td><td>"+return_year9+"</td><td>"+return_year10+"</td> </tr>";

			   quarter_return = quarter_return + "<tr><td>"+s_name+"</td><td>"+return_quarter1+"</td><td>"+return_quarter2+"</td><td>"+return_quarter3+"</td><td>"+return_quarter4+"</td><td>"+return_quarter5+"</td><td>"+return_quarter6+"</td><td>"+return_quarter7+"</td><td>"+return_quarter8+"</td><td>"+return_quarter9+"</td><td>"+return_quarter10+"</td> </tr>";

			   month_return = month_return + "<tr><td>"+s_name+"</td><td>"+return_month1+"</td><td>"+return_month2+"</td><td>"+return_month3+"</td><td>"+return_month4+"</td><td>"+return_month5+"</td><td>"+return_month6+"</td><td>"+return_month7+"</td><td>"+return_month8+"</td><td>"+return_month9+"</td><td>"+return_month10+"</td> </tr>";
            }
         }
		$("#annuallyTable").html("");
        $("#annuallyTable").html(annual_return);
        $("#quarterlyTable").html("");
        $("#quarterlyTable").html(quarter_return);
        $("#monthlyTable").html("");
        $("#monthlyTable").html(month_return);
				customTableSorting();

}
function get_growth_plan()
{


	$.ajax({
		type:'GET',
		url: '/functionalities/get_growth_plan',
		datatype:'json',
		success:function(growthdata, textStatus, jqXHR) {
		console.log(growthdata);
		var tblData;
		var th = "<table><thead><tr><th>Div Type</th><th>NAV</th></tr></thead>";

		 //alert(growthdata.growth_plan.length);
		for(var i =0;i <= growthdata.growth_plan.length-1;i++)
		{
			var item1 = growthdata.growth_plan[i];
			var div_type = item1.div_type;
			var navrs = item1.navrs;

            if(i == 0)
            {
                tblData = th + "<tr><td>"+div_type+"</td><td>"+navrs+"</td></tr>";
                      }
            else
            {
               tblData = tblData + "<tr><td>"+div_type+"</td><td>"+navrs+"</td></tr>";
            }
		}
		tblData = tblData + "</table>"
		$("#dialog-modal").html("");
        $("#dialog-modal").html(tblData);
		},
		error:function(jqXHR, textStatus, errorThrown) {
		  alert("AJAX Error:" + textStatus);
		}
 })
}

function getAllElementsWithAttribute(attribute)
{
  var matchingElements = [];
  var allElements = document.getElementsByTagName('*');
  for (var i = 0, n = allElements.length; i < n; i++)
  {
    if (allElements[i].getAttribute(attribute) !== null)
    {
      // Element exists with attribute. Add to array.
      matchingElements.push(allElements[i]);
    }
  }
  return matchingElements;
}

function showcolumns(obj)
{
	var objval = obj;
	var col = getAllElementsWithAttribute('data-name');
	//alert(col.length);
   	if(document.getElementById(objval).checked == true)
	{
		alert("inside if");
		for(i=0;i<col.length;i++)
		{

			col[i].style.display = 'block';
		}
	}
	else
	{
		alert("inside else");
		for(i=0;i<col.length;i++)
		{
			col[i].style.display = 'none';
		}
	}
}
function get_portfolio_markettable()
{
	$.ajax({
		type:'GET',
		url: '/functionalities/portfolio_markettable',
		datatype:'json',
		success:function(port_cap, textStatus, jqXHR) {
		console.log(port_cap);
		for(var i =0;i <= port_cap.cap_values.length-1;i++)
		{
			var item1 = port_cap.cap_values[i];
			var lcap = item1.lcap;
			var mcap = item1.mcap;
			var scap = item1.scap;
			var ppmcap = item1.ppmcap;
			$("#lcap").html(lcap);
			$("#mcap").html(mcap);
			$("#scap").html(scap);
			if(ppmcap >= 10000000) ppmcap = (ppmcap/10000000).toFixed(2) + ' Cr';
      else if(ppmcap >= 100000) ppmcap = (ppmcap/100000).toFixed(2) + ' Lac';
      else if(ppmcap >= 1000) avg_mcap = (ppmcap/1000).toFixed(2) + ' K';
      $("#ppmcap").html(ppmcap);
			// $("#ppmcap").html(ppmcap);
		}
		},
		error:function(jqXHR, textStatus, errorThrown) {
		  alert("AJAX Error:" + textStatus);
		}
 })
}
function get_portfolio_markettable_avgmcap()
{
	$.ajax({
		type:'GET',
		url: '/functionalities/portfolio_markettable_avgmcap',
		datatype:'json',
		success:function(avg_mcap, textStatus, jqXHR) {
		console.log(avg_mcap);
		for(var i =0;i <= avg_mcap.avg_mcap.length-1;i++)
		{
			var item1 = avg_mcap.avg_mcap[i];
			var avg_mcap = item1.avg_mcap;

			if(avg_mcap >= 10000000) avg_mcap = (avg_mcap/10000000).toFixed(2) + ' Cr';
      else if(avg_mcap >= 100000) avg_mcap = (avg_mcap/100000).toFixed(2) + ' Lac';
      else if(avg_mcap >= 1000) avg_mcap = (avg_mcap/1000).toFixed(2) + ' K';
      $("#avgmcap").html(avg_mcap);
		}
		},
		error:function(jqXHR, textStatus, errorThrown) {
		  alert("AJAX Error:" + textStatus);
		}
 })
}

function get_portfolio_markettable_allcapavgs()
{
	$.ajax({
		type:'GET',
		url: '/functionalities/portfolio_markettable_allcapavgs',
		datatype:'json',
		success:function(avg_allcap, textStatus, jqXHR) {
		console.log(avg_allcap);
		for(var i =0;i <= avg_allcap.avg_allcap.length-1;i++)
		{
			var item1 = avg_allcap.avg_allcap[i];
			var avg_lcap = item1.lcap_avg;
			var avg_mcap = item1.mcap_avg;
			var avg_scap = item1.scap_avg;

			$("#lcapavg").html(avg_lcap);
			$("#mcapavg").html(avg_mcap);
			$("#scapavg").html(avg_scap);
		}
		},
		error:function(jqXHR, textStatus, errorThrown) {
		  alert("AJAX Error:" + textStatus);
		}
 })
}
