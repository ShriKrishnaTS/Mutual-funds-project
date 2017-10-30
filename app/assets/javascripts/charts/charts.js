
$(document).ready(function(){
	// $(window).load(function(){
		// alert("windowload");
	// asect_alloc();
	// port_graph();
	// return_graph("Annual Returns");
// });
	//asect_alloc();
	//port_graph();
	//return_bar();
	//return_graph("Annual Returns");
	$(".annualReturns").addClass("active");

	$(".annualReturns").click(function(){
		$(this).addClass("active");
		$(".quarterlyReturns").removeClass("active");
		$(".monthlyReturns").removeClass("active");
		var annualReturns = $(this).text();
		return_graph(annualReturns);
	});

	$(".quarterlyReturns").click(function(){
		$(this).addClass("active");
		$(".annualReturns").removeClass("active");
		$(".monthlyReturns").removeClass("active");
		var quarterlyReturns = $(this).text();
		return_graph(quarterlyReturns);
	});

	$(".monthlyReturns").click(function(){
		$(this).addClass("active");
		$(".annualReturns").removeClass("active");
		$(".quarterlyReturns").removeClass("active");
		var monthlyReturns = $(this).text();
		return_graph(monthlyReturns);
	});

//$(function () {


 });

 function asect_alloc()
	{
		$.ajax({
			type:'get',
			url: '/functionalities/asect_allocation_chart',
			datatype:'json',
			success:function(asect_alloc, textStatus, jqXHR) {
			console.log(asect_alloc);
			var text;
			var chart=[];
			for(var i =0;i <= asect_alloc.asect_alloc_chart.length-1;i++)
			{
				var asect_data = asect_alloc.asect_alloc_chart[i];
				var sect_code = asect_data.rupeevest_asect;
				var hold_perc = asect_data.holdpercentage;
				if(i == 0)
				{
					text = sect_code + " - " + hold_perc;
					//chart = "['" +sect_code+ "', "+hold_perc+"],";
					var obj={};
					obj.char=sect_code;
					obj.value=hold_perc;
					chart.push(obj);

				}
				else
				{
					text = text + "<br>" + sect_code + " - " + hold_perc;
					//chart = chart + "['" +sect_code+ "', "+hold_perc+"],";
					var obj1={};
					obj1.char=sect_code;
					obj1.value=hold_perc;
					chart.push(obj1);
				}
				//alert(sect_code);
				//alert(hold_perc);
			}
			//alert(text);
			//alert(chart);
			asect_alloc_piechart(text,chart);
			},
			error:function(jqXHR, textStatus, errorThrown) {
				alert("AJAX Error:" + textStatus);
			  }
		})
	}

	function asect_alloc_piechart(objText,objChart)
	{
		console.log('type ::' +typeof objChart);
		console.log(objChart);
		var array1=[];
		var array2=[];
		var array3=[];
		var array4=[];
		for(var j=0;j<objChart.length;j++){
			if(j==0){
				array1.push(objChart[j].char);
				array1.push(objChart[j].value);
			}
			if(j==1){
				array2.push(objChart[j].char);
				array2.push(objChart[j].value);
			}
			if(j==2){
				array3.push(objChart[j].char);
				array3.push(objChart[j].value);
			}
			if(j==3){
				array4.push(objChart[j].char);
				array4.push(objChart[j].value);
			}
		}
		if(array1.length<1){
			array1=['W',0];
		}
		if(array2.length<1){
			array2=['X',0];
		}
		if(array3.length<1){
			array3=['Y',0];

		}if(array4.length<1){
			array4=['Z',0];
		}
		console.log('array1');
		console.log(array1);
		console.log('array2');
		console.log(array2);

		$('#container-7').highcharts({
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: 0,
                plotShadow: false
            },
            title: {
                //text: 'EQUITY - 70<br>DEBT - 20<br>CASH - 10',
				text : objText,
                align: 'center',
                verticalAlign: 'middle',
                                        style: {
                            fontWeight: 'normal',
                            color: '#000'
                        },
                margin:50,
                x: 0,
                y: -15
            },
            exporting: { enabled: false },
            tooltip: {
                pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
            },
            plotOptions: {
                pie: {
                    dataLabels: {
                        enabled: false,
                        distance: -50,
                        style: {
                            fontWeight: 'bold',
                            color: 'white'
                        }
                    },
                    startAngle: -180,
                    endAngle: 180,
                    center: ['50%', '50%']
                }
            },
            series: [{
                type: 'pie',
                name: 'Asset Allocation',
                innerSize: '75%',
                data: [
					//['E', 98.8],['C', 1.2],['A',0],
					array1,array2,array3,array4,
					//['C',1.8],['E',98.2],
                    //['EQUITY', 70],['DEBT', 20],['CASH', 10],
					//objChart
                    /*{
                        name: 'Proprietary or Undetectable',
                        y: 0.4,
                        dataLabels: {
                            enabled: false
                        }
                    }*/
                ]
            }]
        });
	}
    //});
//return_bar();

   function return_graph(tabValue)
{
	$.ajax({
			type:'GET',
			url: '/functionalities/get_returns_year',
			datatype:'json',
			success:function(return_data, textStatus, jqXHR) {
			console.log(return_data);
			var ry_data;
			var returnYear = [];
			var returnAvgYear = [];
			var th = "<thead><tr><th>Historical Performance</th><th>2005</th><th>2006</th><th>2007</th><th>2008</th><th>2009</th><th>2010</th><th>2011</th><th>2012</th><th>2013</th><th>2014</th></tr></thead>";
			for(var i =0;i <= return_data.returns_year.length-1;i++)
			{
				ry_data = return_data.returns_year[i];
				var s_name = ry_data.s_name;
				if(tabValue == "Annual Returns"){
					for(var j=1;j<=10;j++){
						var return_year = ry_data["return_year"+j];
						console.log(return_year);
						returnYear.push(return_year);
					}

					for(var j=1;j<=10;j++){
						var return_avg_year = ry_data["avg_year"+j];
						console.log(return_avg_year);
						returnAvgYear.push(return_avg_year);
						//tblData=th + "<tr><td>"+s_name+"</td><td>"+ry_data["avg_year"+j]+"</td></tr>";
					}
				}


				if(tabValue == "Quarterly Returns"){
					for(var j=1;j<=10;j++){
						var return_quarter = ry_data["return_quarter"+j];
						console.log(return_quarter);
						returnYear.push(return_quarter);
					}

					for(var j=1;j<=10;j++){
						var return_avg_quarter = ry_data["avg_quarter"+j];
						console.log(return_avg_quarter);
						returnAvgYear.push(return_avg_quarter);
					}

				}


				if(tabValue == "Monthly Returns"){

					for(var j=1;j<=10;j++){
						var return_month = ry_data["return_month"+j];
						console.log(return_month);
						returnYear.push(return_month);
					}

					for(var j=1;j<=10;j++){
						var return_avg_month = ry_data["avg_month"+j];
						console.log(return_avg_month);
						returnAvgYear.push(return_avg_month);
					}

				}

			}
			console.log("---Starts---");
			console.log(returnYear);
			console.log("---Ends---");
			var obj={};
			returns_barchart("text",returnYear,returnAvgYear);

			for(var i =0;i <= return_data.returns_year.length-1;i++)
			{
				ry_data = return_data.returns_year[i];
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
				var rank_year1 = ry_data.rank_year1;
				var rank_year2 = ry_data.rank_year2;
				var rank_year3 = ry_data.rank_year3;
				var rank_year4 = ry_data.rank_year4;
				var rank_year5 = ry_data.rank_year5;
				var rank_year6 = ry_data.rank_year6;
				var rank_year7 = ry_data.rank_year7;
				var rank_year8 = ry_data.rank_year8;
				var rank_year9 = ry_data.rank_year9;
				var rank_year10 = ry_data.rank_year10;
				var avg_year1 = ry_data.avg_year1;
				var avg_year2 = ry_data.avg_year2;
				var avg_year3 = ry_data.avg_year3;
				var avg_year4 = ry_data.avg_year4;
				var avg_year5 = ry_data.avg_year5;
				var avg_year6 = ry_data.avg_year6;
				var avg_year7 = ry_data.avg_year7;
				var avg_year8 = ry_data.avg_year8;
				var avg_year9 = ry_data.avg_year9;
				var avg_year10 = ry_data.avg_year10;
				var rank = "Rank";

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
				var rank_month1 = ry_data.rank_month1;
				var rank_month2 = ry_data.rank_month2;
				var rank_month3 = ry_data.rank_month3;
				var rank_month4 = ry_data.rank_month4;
				var rank_month5 = ry_data.rank_month5;
				var rank_month6 = ry_data.rank_month6;
				var rank_month7 = ry_data.rank_month7;
				var rank_month8 = ry_data.rank_month8;
				var rank_month9 = ry_data.rank_month9;
				var rank_month10 = ry_data.rank_month10;
				var avg_month1 = ry_data.avg_month1;
				var avg_month2 = ry_data.avg_month2;
				var avg_month3 = ry_data.avg_month3;
				var avg_month4 = ry_data.avg_month4;
				var avg_month5 = ry_data.avg_month5;
				var avg_month6 = ry_data.avg_month6;
				var avg_month7 = ry_data.avg_month7;
				var avg_month8 = ry_data.avg_month8;
				var avg_month9 = ry_data.avg_month9;
				var avg_month10 = ry_data.avg_month10;

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


				var rank_quarter1 = ry_data.rank_quarter1;
				var rank_quarter2 = ry_data.rank_quarter2;
				var rank_quarter3 = ry_data.rank_quarter3;
				var rank_quarter4 = ry_data.rank_quarter4;
				var rank_quarter5 = ry_data.rank_quarter5;
				var rank_quarter6 = ry_data.rank_quarter6;
				var rank_quarter7 = ry_data.rank_quarter7;
				var rank_quarter8 = ry_data.rank_quarter8;
				var rank_quarter9 = ry_data.rank_quarter9;
				var rank_quarter10 = ry_data.rank_quarter10;
				var avg_quarter1 = ry_data.avg_quarter1;
				var avg_quarter2 = ry_data.avg_quarter2;
				var avg_quarter3 = ry_data.avg_quarter3;
				var avg_quarter4 = ry_data.avg_quarter4;
				var avg_quarter5 = ry_data.avg_quarter5;
				var avg_quarter6 = ry_data.avg_quarter6;
				var avg_quarter7 = ry_data.avg_quarter7;
				var avg_quarter8 = ry_data.avg_quarter8;
				var avg_quarter9 = ry_data.avg_quarter9;
				var avg_quarter10 = ry_data.avg_quarter10;

				var an1 = return_year1 - avg_year1;
				var diff_year1 = an1.toFixed(2);
				var an2 = return_year2 - avg_year2;
				var diff_year2 = an2.toFixed(2);
				var an3 = return_year3 - avg_year3;
				var diff_year3 = an3.toFixed(2);
				var an4 = return_year4 - avg_year4;
				var diff_year4 = an4.toFixed(2);
				var an5 = return_year5 - avg_year5;
				var diff_year5 = an5.toFixed(2);
				var an6 = return_year6 - avg_year6;
				var diff_year6 = an6.toFixed(2);
				var an7 = return_year7 - avg_year7;
				var diff_year7 = an7.toFixed(2);
				var an8 = return_year8 - avg_year8;
				var diff_year8 = an8.toFixed(2);
				var an9 = return_year9 - avg_year9;
				var diff_year9 = an9.toFixed(2);
				var an10 = return_year10 - avg_year10;
				var diff_year10 = an10.toFixed(2);

				var m1 = return_month1 - avg_month1;
				var diff_month1 = m1.toFixed(2);
				var m2 = return_month2 - avg_month2;
                var diff_month2 = m2.toFixed(2);

				var m3 = return_month3 - avg_month3;
				var diff_month3 = m3.toFixed(2);
				var m4 = return_month4 - avg_month4;
				var diff_month4 = m4.toFixed(2);
				var m5 = return_month5 - avg_month5;
				var diff_month5 = m5.toFixed(2);
				var m6 = return_month6 - avg_month6;
				var diff_month6 = m6.toFixed(2);
				var m7 = return_month7 - avg_month7;
				var diff_month7 = m7.toFixed(2);
				var m8 = return_month8 - avg_month8;
				var diff_month8 = m8.toFixed(2);
				var m9 = return_month9 - avg_month9;
				var diff_month9 = m9.toFixed(2);
				var m10 = return_month10 - avg_month10;
				var diff_month10 = m10.toFixed(2);
				var q1 = return_quarter1 - avg_quarter1;
				var diff_quarter1 = q1.toFixed(2);
				var q2 = return_quarter2 - avg_quarter2;
				var diff_quarter2 = q2.toFixed(2);
				var q3 = return_quarter3 - avg_quarter3;
				var diff_quarter3 = q3.toFixed(2);
				var q4 = return_quarter4 - avg_quarter4;
				var diff_quarter4 = q4.toFixed(2);
				var q5 = return_quarter5 - avg_quarter5;
				var diff_quarter5 = q5.toFixed(2);
				var q6 = return_quarter6 - avg_quarter6;
				var diff_quarter6 = q6.toFixed(2);
				var q7 = return_quarter7 - avg_quarter7;
				var diff_quarter7 = q7.toFixed(2);
				var q8 = return_quarter8 - avg_quarter8;
				var diff_quarter8 = q8.toFixed(2);
				var q9 = return_quarter9 - avg_quarter9;
				var diff_quarter9 = q9.toFixed(2);
				var q10 = return_quarter10 - avg_quarter10;
				var diff_quarter10 = q10.toFixed(2);
				var category = ry_data.classification;

				if(i == 0)
				{


					if(tabValue == "Annual Returns"){
						tblData=th + "<tr><td>"+s_name+"</td><td>"+return_year1+"</td><td>"+return_year2+"</td><td>"+return_year3+"</td><td>"+return_year4+"</td><td>"+return_year5+"</td><td>"+return_year6+"</td><td>"+return_year7+"</td><td>"+return_year8+"</td><td>"+return_year9+"</td><td>"+return_year10+"</td></tr>";
						tblData = tblData + "<tr><td> Category ("+classification+")</td><td>"+avg_year1+"</td><td>"+avg_year2+"</td><td>"+avg_year3+"</td><td>"+avg_year4+"</td><td>"+avg_year5+"</td><td>"+avg_year6+"</td><td>"+avg_year7+"</td><td>"+avg_year8+"</td><td>"+avg_year9+"</td><td>"+avg_year10+"</td></tr>";
						tblData = tblData + "<tr><td> -/+Category ("+category +")</td><td>"+diff_year1+"</td><td>"+diff_year2+"</td><td>"+diff_year3+"</td><td>"+diff_year4+"</td><td>"+diff_year5+"</td><td>"+diff_year6+"</td><td>"+diff_year7+"</td><td>"+diff_year8+"</td><td>"+diff_year9+"</td><td>"+diff_year10+"</td></tr>";
						tblData = tblData + "<tr><td>"+rank+"</td><td>"+rank_year1+"</td><td>"+rank_year2+"</td><td>"+rank_year3+"</td><td>"+rank_year4+"</td><td>"+rank_year5+"</td><td>"+rank_year6+"</td><td>"+rank_year7+"</td><td>"+rank_year8+"</td><td>"+rank_year9+"</td><td>"+rank_year10+"</td></tr>";
					}

					if(tabValue == "Quarterly Returns"){
						tblData=th + "<tr><td>"+s_name+"</td><td>"+return_quarter1+"</td><td>"+return_quarter2+"</td><td>"+return_quarter3+"</td><td>"+return_quarter4+"</td><td>"+return_quarter5+"</td><td>"+return_quarter6+"</td><td>"+return_quarter7+"</td><td>"+return_quarter8+"</td><td>"+return_quarter9+"</td><td>"+return_quarter10+"</td></tr>";
						tblData = tblData + "<tr><td> Category ("+classification+")</td><td>"+avg_quarter1+"</td><td>"+avg_quarter2+"</td><td>"+avg_quarter3+"</td><td>"+avg_quarter4+"</td><td>"+avg_quarter5+"</td><td>"+avg_quarter6+"</td><td>"+avg_quarter7+"</td><td>"+avg_quarter8+"</td><td>"+avg_quarter9+"</td><td>"+avg_quarter10+"</td></tr>";
						tblData = tblData + "<tr><td> -/+Category ("+category +")</td><td>"+  diff_quarter1 +"</td><td>"+ diff_quarter2+"</td><td>"+ diff_quarter3 +"</td><td>"+ diff_quarter4+"</td><td>"+ diff_quarter5 +"</td><td>"+ diff_quarter6 +"</td><td>"+ diff_quarter7 +"</td><td>"+ diff_quarter8 +"</td><td>"+ diff_quarter9+"</td><td>"+ diff_quarter10+"</td></tr>";
						tblData = tblData + "<tr><td>"+rank+"</td><td>"+rank_quarter1+"</td><td>"+rank_quarter2+"</td><td>"+rank_quarter3+"</td><td>"+rank_quarter4+"</td><td>"+rank_quarter5+"</td><td>"+rank_quarter6+"</td><td>"+rank_quarter7+"</td><td>"+rank_quarter8+"</td><td>"+rank_quarter9+"</td><td>"+rank_quarter10+"</td></tr>";
					}
					if(tabValue == "Monthly Returns"){
	                    tblData=th + "<tr><td>"+s_name+"</td><td>"+return_month1+"</td><td>"+return_month2+"</td><td>"+return_month3+"</td><td>"+return_month4+"</td><td>"+return_month5+"</td><td>"+return_month6+"</td><td>"+return_month7+"</td><td>"+return_month8+"</td><td>"+return_month9+"</td><td>"+return_month10+"</td></tr>";
						tblData = tblData + "<tr><td> Category ("+classification+")</td><td>"+avg_month1+"</td><td>"+avg_month2+"</td><td>"+avg_month3+"</td><td>"+avg_month4+"</td><td>"+avg_month5+"</td><td>"+avg_month6+"</td><td>"+avg_month7+"</td><td>"+avg_month8+"</td><td>"+avg_month9+"</td><td>"+avg_month10+"</td></tr>";
						tblData = tblData + "<tr><td>-/+Category ("+category +")</td><td>"+diff_month1+"</td><td>"+diff_month2+"</td><td>"+diff_month3+"</td><td>"+diff_month4+"</td><td>"+diff_month5+"</td><td>"+diff_month6+"</td><td>"+diff_month7+"</td><td>"+diff_month8+"</td><td>"+diff_month9+"</td><td>"+diff_month10+"</td></tr>";
						tblData = tblData + "<tr><td>"+rank+"</td><td>"+rank_month1+"</td><td>"+rank_month2+"</td><td>"+rank_month3+"</td><td>"+rank_month4+"</td><td>"+rank_month5+"</td><td>"+rank_month6+"</td><td>"+rank_month7+"</td><td>"+rank_month8+"</td><td>"+rank_month9+"</td><td>"+rank_month10+"</td></tr>";
					}

				}


				else{

					//tblData = tblData + "<tr class='active'><td>Category Average</td><td colspan='2'></td><td></td><td></td><td></td><td></td><td colspan='2'></td><td colspan='2'></td></tr><tr><td>Rank Within Category</td><td colspan='2'></td><td></td><td></td><td></td><td></td><td colspan='2'></td><td colspan='2'></td></tr><tr class=active><td>Number of funds in category</td><td colspan='2'></td><td></td><td></td><td></td><td></td><td colspan='2'></td><td colspan='2'></td></tr><tr><td>As on April XYZ</td><td colspan='2'></td><td></td><td></td><td></td><td></td><td colspan='2'></td><td colspan='2'></td></tr>";
				}

			$("#yearreturn").html("");
			$("#yearreturn").html(tblData);
			customTableSorting();

}
                },

				error:function(jqXHR, textStatus, errorThrown) {
					alert("AJAX Error:" + textStatus);
				}
            });

}

function returns_barchart(objText,returnYear,returnAvgYear)
{

 $('#container-6').highcharts({
                chart: {
                    type: 'column'
                },
                title: {
                    text: ''
                },
                exporting: { enabled: false },
                xAxis: {
                    categories: ['2004', '2005', '2006', '2007', '2008', '2009', '2010', '2011', '2012', '2013', '2014', '2015']
                },
                yAxis: {
                    title: {
                        text: 'Returns ( % )'
                    },
                    categories: ['-100', '-50', '0', '50', '100', '150']
                },
                credits: {
                    enabled: true
                },
                series: [{
                    name: 'HDFC Top 200 Fund',
                    data: returnYear
                },
                {
                    name: 'Equity: Large Cap',
                    data: returnAvgYear
                }]
            });
        }

     function alloc_bench_chart(portCatArray,portHoldArray,portSectArray,classification){

        	$(function () {
				var txt = "";
				if(classification == "Equity")
				{
					txt = "Section Allocation v/s Category Average";
				}
				else if(classification == "Debt")
				{
					txt = "Credit Rating v/s Category Average";
				}
				else{

				}

    var chart = new Highcharts.Chart({
    //$('#container').highcharts({
        chart: {
            renderTo: 'container-01',
            type: 'column',
            options3d: {
                enabled: true,
                alpha: 0,
                beta: 15,
                depth: 0,
                viewDistance: 50
            }
        },
        title: {
            //text: 'Section Allocation v/s Category Average'
			text: txt
        },
        subtitle: {
            text: ''
        },
                        xAxis: {
                    categories: portSectArray
                },
        yAxis: {
                    title: {
                        text: 'Assets ( % )'
                    },
                     min: 0,
                     max: 50,
                     tickInterval: 5
        },
        exporting: { enabled: false },
        plotOptions: {
            column: {
                depth: 45
            }
        },
        series: [{
            name: 'HDFC Top 200 Fund',
            data: portHoldArray
        },{
            name: 'S&P BSE 200',
            data: portCatArray
        }]
    });
});
}

function alloc_bench_chart_hybrid(portCatArray,portHoldArray,portSectArray,classification){

        	$(function () {
				var txt = "";
				if(classification == "Equity")
				{
					txt = "Section Allocation v/s Category Average";
				}
				else if(classification == "Debt")
				{
					txt = "Credit Rating v/s Category Average";
				}
				else{

				}

    var chart = new Highcharts.Chart({
    //$('#container').highcharts({
        chart: {
            renderTo: 'container-02',
            type: 'column',
            options3d: {
                enabled: true,
                alpha: 0,
                beta: 15,
                depth: 0,
                viewDistance: 50
            }
        },
        title: {
            //text: 'Section Allocation v/s Category Average'
			text: txt
        },
        subtitle: {
            text: ''
        },
                        xAxis: {
                    categories: portSectArray
                },
        yAxis: {
                    title: {
                        text: 'Assets ( % )'
                    },
                     min: 0,
                     max: 50,
                     tickInterval: 5
        },
        exporting: { enabled: false },
        plotOptions: {
            column: {
                depth: 45
            }
        },
        series: [{
            name: 'HDFC Top 200 Fund',
            data: portHoldArray
        },{
            name: 'S&P BSE 200',
            data: portCatArray
        }]
    });
});
}
function port_graph()
{

	$.ajax({
		type:'GET',
		url: '/functionalities/get_protfolio_graph',
		datatype:'json',
		success:function(sectordata, textStatus, jqXHR) {
		console.log(sectordata);
            var portCatArray = [];
            var portHoldArray = [];
            var portSectArray = [];
			var portCatArray_h = [];
            var portHoldArray_h = [];
            var portSectArray_h = [];
			var classification = sectordata.classification;
            if(classification == "Equity")
			{
				for(var i=0;i<=sectordata.port_graph.length-1;i++){
				//console.log(sectordata.port_graph[i].cat_avg);
				//console.log(sectordata.port_graph[i].rv_sect_name);
				//console.log(sectordata.port_graph[i].hold_perc);
				//chart = chart + "['" +cat_avg+ "', "+hold_perc+"],";
			   //console.log(sectordata["port_graph"][i].cat_avg);
				portCatArray.push(sectordata["port_graph"][i].cat_avg);
				portHoldArray.push(sectordata["port_graph"][i].hold_perc);
				portSectArray.push(sectordata["port_graph"][i].rv_sect_name);
				}
			}
			else if(classification == "Debt")
			{
				for(var i=0;i<=sectordata.port_graph.length-1;i++){
				portCatArray.push(sectordata["port_graph"][i].average);
				portHoldArray.push(sectordata["port_graph"][i].holdpercentage);
				portSectArray.push(sectordata["port_graph"][i].rupeevest_group);
				}
			}
			else if(classification == "Hybrid")
			{
				for(var i=0;i<=sectordata.port_graph_sector.length-1;i++){
				portCatArray.push(sectordata["port_graph_sector"][i].cat_avg);
				portHoldArray.push(sectordata["port_graph_sector"][i].hold_perc);
				portSectArray.push(sectordata["port_graph_sector"][i].rv_sect_name);
				}
				for(var i=0;i<=sectordata.port_graph_credit.length-1;i++){
				portCatArray_h.push(sectordata["port_graph_credit"][i].average);
				portHoldArray_h.push(sectordata["port_graph_credit"][i].holdpercentage);
				portSectArray_h.push(sectordata["port_graph_credit"][i].rupeevest_group);
				}
			}



		/*console.log("string after loop");
		console.log(portCatArray);
		console.log(portHoldArray);
		console.log(portSectArray);
*/		if(classification == "Hybrid")
		{
			alloc_bench_chart(portCatArray,portHoldArray,portSectArray,classification);
			alloc_bench_chart_hybrid(portCatArray_h,portHoldArray_h,portSectArray_h,classification);
		}
		else
		{
			alloc_bench_chart(portCatArray,portHoldArray,portSectArray,classification);
		}

		},
		error:function(jqXHR, textStatus, errorThrown) {
		  alert("AJAX Error:" + textStatus);
		}
 })
}
