$(document).ready(function(){
	

$(document).on("click",'#Amc_mst_btn', function() {
  $.ajax({
						type:'GET',
						url: '/functionalities/get_amc_msts',
						datatype:'json',
						success:function(data, textStatus, jqXHR) {
  console.log(data);

  //alert(textStatus);
  //alert(data.Amc_name.length);
  var divData;
  for(var i =0;i < data.Amc_name.length-1;i++)
  {
	var item = data.Amc_name[i];
	var amc_code = item.amc_code;
	var fund = item.fund;
	var corporate = item.corporate;
	var dayret_1 = item.dayret_1;
	var weekret_1 = item.weekret_1;
	var monthret_1 = item.monthret_1;
	if(i==0)
	{
		divData = "<div>"+ amc_code +"</div><div>"+ fund +"</div><div>"+ corporate +"</div><div>"+ dayret_1 +"</div><div>"+ weekret_1 +"</div><div>"+ monthret_1 +"</div>";
	}
	else
	{
		divData = divData + "<div>"+ amc_code +"</div><div>"+ fund +"</div><div>"+ corporate +"</div><div>"+ dayret_1 +"</div><div>"+ weekret_1 +"</div><div>"+ monthret_1 +"</div>";
	}
  }
	document.getElementById("amc_info").innerHTML = divData;
	
	
  },
  error:function(jqXHR, textStatus, errorThrown) {
    alert("AJAX Error:" + textStatus);
  }
	
  });
});

$(document).on("click",'#aum_total_btn', function() {
  
   $.ajax({
						type:'GET',
						url: '/functionalities/get_aum_totalvalue',
						datatype:'json',
						success:function(aum_data, textStatus, jqXHR) {
  console.log(aum_data);

  //alert(textStatus);
  //alert(aum_data.aum_totalvalue.length);
  var divData1;
  for(var i =0;i <= aum_data.aum_totalvalue.length-1;i++)
  {
	var aum = aum_data.aum_totalvalue[i];
	var aumtotal = aum.aumtotal;
	if(i==0)
	{
		divData1 = "<div>"+ aumtotal +"</div>";
	}
	else
	{
		divData1 = divData + "<div>"+ aumtotal +"</div>";
	}
  }
	$("#aum_total").html(divData1);
	
	
  },
  error:function(jqXHR, textStatus, errorThrown) {
    alert("AJAX Error:" + textStatus);
  }
	
  });
});

})

$(window).load(function(){
	//get_dividend_data();
});

function scheme_name()
{
	$.ajax({
						type:'GET',
						url: '/functionalities/get_scheme_name',
						datatype:'json',
						success:function(scheme_data, textStatus, jqXHR) {
  console.log(scheme_data);
  for(var i =0;i <= scheme_data.scheme_name.length-1;i++)
  {
	var scheme_item = scheme_data.scheme_name[i];
	var scheme_name = scheme_item.s_name;
  }
	$("#scheme_name").html(scheme_name);
  },
  error:function(jqXHR, textStatus, errorThrown) {
    alert("AJAX Error:" + textStatus);
  }
	
  })
}

function current_nav()
{
	   $.ajax({
						type:'GET',
						url: '/functionalities/get_current_nav_value',
						datatype:'json',
						success:function(data1, textStatus, jqXHR) {
  console.log(data1);
  for(var i =0;i <= data1.current_nav.length-1;i++)
  {
	var item1 = data1.current_nav[i];
	var navdate = "Nav as on " + item1.navdate;
	var navrs = item1.navrs;
	var navchange = item1.navchange + "%";
  }
	$("#navrs").html(navrs);
	$("#navchange").html(navchange);
	$("#navdate").html(navdate);
 },
  error:function(jqXHR, textStatus, errorThrown) {
    alert("AJAX Error:" + textStatus);
  }
	
  })
}

function get_fundmanager()
{
	 $.ajax({
						type:'GET',
						url: '/functionalities/get_fund_manager',
						datatype:'json',
						success:function(fund_data, textStatus, jqXHR) {
  console.log(fund_data);
  for(var i =0;i <= fund_data.fund_manager.length-1;i++)
  {
	var fund_item = fund_data.fund_manager[i];
	var fund_manager = fund_item.fundmanager;

  }
	$("#fund_manager").html(fund_manager);
	
	
  },
  error:function(jqXHR, textStatus, errorThrown) {
    alert("AJAX Error:" + textStatus);
  }
	
  })
}

function inception()
{
  $.ajax({
						type:'GET',
						url: '/functionalities/get_inception_date',
						datatype:'json',
						success:function(data1, textStatus, jqXHR) {
  console.log(data1);
  for(var i =0;i <= data1.inception_date.length-1;i++)
  {
	var item1 = data1.inception_date[i];
	var incdate = item1.incdate;
  }
	$("#incdate").html(incdate);
 },
  error:function(jqXHR, textStatus, errorThrown) {
    alert("AJAX Error:" + textStatus);
  }
	
  })
}

function exitload()
{
  $.ajax({
						type:'GET',
						url: '/functionalities/get_exit_load',
						datatype:'json',
						success:function(exdata, textStatus, jqXHR) {
  console.log(exdata);
  for(var i =0;i <= exdata.exit_load.length-1;i++)
  {
	var item1 = exdata.exit_load[i];
	var exitload = item1.exitload;
	
	
  }
	$("#exitload").html(exitload);
 },
  error:function(jqXHR, textStatus, errorThrown) {
    alert("AJAX Error:" + textStatus);
  }
	
  })
}

function expenseratio()
{
  $.ajax({
						type:'GET',
						url: '/functionalities/get_expense_ratio',
						datatype:'json',
						success:function(exratio, textStatus, jqXHR) {
  console.log(exratio);
  for(var i =0;i <= exratio.expense_ratio.length-1;i++)
  {
	var item1 = exratio.expense_ratio[i];
	var expense = item1.exratio;
	// console.log(item1);

    //alert(expense);
	
  }
	$("#expense").html(expense);
 },
  error:function(jqXHR, textStatus, errorThrown) {
    alert("AJAX Error:" + textStatus);
  }
	
  })
}

function inceptionre()
{
  $.ajax({
						type:'GET',
						url: '/functionalities/get_inception_return',
						datatype:'json',
						success:function(incret, textStatus, jqXHR) {
  console.log(incret);
  for(var i =0;i <= incret.inception_return.length-1;i++)
  {
	var item1 = incret.inception_return[i];
	var incep = item1.incret;
	// console.log(item1);

    //alert(incep);
	
  }
	$("#incep").html(incep);
 },
  error:function(jqXHR, textStatus, errorThrown) {
    alert("AJAX Error:" + textStatus);
  }
	
  })
}

function turnoverratio()
{
  $.ajax({
						type:'GET',
						url: '/functionalities/get_turnover_ratio',
						datatype:'json',
						success:function(turnover_ratio, textStatus, jqXHR) {
  console.log(turnover_ratio);
  for(var i =0;i <= turnover_ratio.turnover_rati.length-1;i++)
  {
	var item1 = turnover_ratio.turnover_rati[i];
	var turn = item1.turnover_ratio;
	// console.log(item1);

    //alert(turn);
	
  }
	$("#turn").html(turn);
 },
  error:function(jqXHR, textStatus, errorThrown) {
    alert("AJAX Error:" + textStatus);
  }
	
  })
}

function mininvestment()
{
  $.ajax({
						type:'GET',
						url: '/functionalities/get_minimum_investment',
						datatype:'json',
						success:function(mininv, textStatus, jqXHR) {
  console.log(mininv);
  for(var i =0;i <= mininv.minimum_invest.length-1;i++)
  {
	var item1 = mininv.minimum_invest[i];
	var inv = item1.mininv;
	// console.log(item1);

    //alert(inv);
	
  }
	$("#inv").html(inv);
 },
  error:function(jqXHR, textStatus, errorThrown) {
    alert("AJAX Error:" + textStatus);
  }
	
  })
}


function mcap_classification()
{
  $.ajax({
						type:'GET',
						url: '/mcap_classification/get_mcap_classification',
						datatype:'json',
						success:function(data1, textStatus, jqXHR) {
  console.log(data1);
  var tblData;
  for(var i =0;i <= data1.mcap_avg.length-1;i++)
  {
	var item1 = data1.mcap_avg[i];
	var ps_code = item1.ps_code;
	var mcap_avg = item1.mcap_avg;
	var mcap_count = item1.mcap_count;
	if(i == 0)
	{
		tblData = "<tr><td>"+ps_code+"</td><td>"+mcap_avg+"</td><td>"+mcap_count+"</td></tr>";
	}
	else
	{
		tblData = tblData + "<tr><td>"+ps_code+"</td><td>"+mcap_avg+"</td><td>"+mcap_count+"</td></tr>";
	}
  }
	$("#mcap_avg").html(tblData);
 },
  error:function(jqXHR, textStatus, errorThrown) {
    alert("AJAX Error:" + textStatus);
  }
	
  })
}


function fund_data()
{
  $.ajax({
						type:'GET',
						url: '/mcap_classification/get_mcap_classification',
						datatype:'json',
						success:function(data1, textStatus, jqXHR) {
  console.log(data1);
  var tblData;
 
	$("#mcap_avg").html(tblData);
 },
  error:function(jqXHR, textStatus, errorThrown) {
    alert("AJAX Error:" + textStatus);
  }
	
  })
}

function schemedata_landing1()
{
	$.ajax({
						type:'GET',
						url: '/functionalities/schemedata_landing',
						datatype:'json',
						success:function(data1, textStatus, jqXHR) {
  console.log(data1);
  var tblData;
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
	var high_sec_alloc = "-";
	
	if(i == 0)
	{
		tblData = document.getElementById("tblData").innerHTML + "<tr><td><input type='checkbox' /></td><td id="+scheme_code+"><a href='/home/index_latest?scheme_code="+scheme_code+"'>"+scheme_name+"</a></td><td></td><td>"+scheme_aum_total+"</td><td>"+scheme_year1+"</td><td>"+scheme_year3+"</td><td>"+scheme_year5+"</td><td>"+exratio+"</td><td>"+high_sec_alloc+"</td></tr>";
	}
	else
	{
		tblData = tblData + "<tr><td><input type='checkbox' /></td><td id="+scheme_code+"><a href='/home/index_latest?scheme_code="+scheme_code+"' >"+scheme_name+"</a></td><td></td><td>"+scheme_aum_total+"</td><td>"+scheme_year1+"</td><td>"+scheme_year3+"</td><td>"+scheme_year5+"</td><td>"+exratio+"</td><td>"+high_sec_alloc+"</td></tr>";
	}
  }
  
	$("#tblData").html(tblData);
 },
  error:function(jqXHR, textStatus, errorThrown) {
    alert("AJAX Error:" + textStatus);
  }
	
  })
}




