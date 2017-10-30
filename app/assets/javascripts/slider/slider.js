$("document").ready(function(){
	filter_values();
function filter_values()
{
	$.ajax({
		type:'GET',
		url: '/home/filters_values',
		datatype:'json',
		success:function(filtervalues, textStatus, jqXHR) {
		 console.log(filtervalues);
		 var asset_min = filtervalues.filters_values[0].aumtotal_min;
		 var asset_max = filtervalues.filters_values[0].aumtotal_max;
		 var age_min = filtervalues.filters_values[0].aumtotal_min;
		 var age_max = filtervalues.filters_values[0].aumtotal_max;
		
		 var exitload_min = filtervalues.filters_values[0].exitload_min;
		 var exitload_max = filtervalues.filters_values[0].exitload_max;
		 
		 var expratio_min = filtervalues.filters_values[0].exp_ratio_min;
		 var expratio_max = filtervalues.filters_values[0].exp_ratio_max;
		
		 var turnover_ratio_min = filtervalues.filters_values[0].turnover_ratio_min;
		 var turnover_ratio_max = filtervalues.filters_values[0].turnover_ratio_max;
		 
		 asset_range(asset_min,asset_max);
		 //age_range(age_min,age_max);
		 exitload_range(exitload_min,exitload_max);
		 expratio_range(expratio_min,expratio_max);
		 turnover_range(turnover_ratio_min,turnover_ratio_max);
		 },
		 error:function(jqXHR, textStatus, errorThrown) {
		   alert("AJAX Error:" + textStatus);
		 }
 })
}
	var $range = $(".js-range-slider-asset"),
    $input = $(".js-input-from-asset"),
	$input1 = $(".js-input-to-asset"),
    instance;
	
function asset_range(min_value,max_value)
{
	var min = min_value,
    max = max_value;

$range.ionRangeSlider({
    type: "double",
    min: min,
    max: max,
    from: min_value,
	to: max_value,
    onStart: function (data) {
        $input.prop("value", data.from);
		$input1.prop("value", data.to);
    },
    onChange: function (data) {
        $input.prop("value", data.from);
		$input1.prop("value", data.to);
    }
});
}
    

instance = $range.data("ionRangeSlider");

$input.on("change keyup", function () {
    var val = $(this).prop("value");
    
    // validate
    if (val < min) {
        val = min;
    } else if (val > max) {
        val = max;
    }
    
    instance.update({
        from: val
    });
});
$input1.on("change keyup", function () {
    var val1 = $(this).prop("value");
    var val0 = $input.prop("value");
    // validate
    if (val1 < min) {
        val1 = min;
    } else if (val1 > max) {
        val1 = max;
    } else if (val1 < val0) {
        val01 = val0;
    }
    
    instance.update({
		from: val01,
        to: val1
    });
});



 var $range1 = $(".js-range-slider-exitload"),
    $input_exitload = $(".js-input-from-exitload"),
	$input_exitload1 = $(".js-input-to-exitload"),
    instance1;
	
function exitload_range(exitload_min,exitload_max)
{
	console.log(exitload_min);
    console.log(exitload_max);
	var min = exitload_min,
    max = exitload_max;

$range1.ionRangeSlider({
    type: "double",
    min: min,
    max: max,
    from: exitload_min,
	to: exitload_max,
    onStart: function (data) {
        $input_exitload.prop("value", data.from);
		$input_exitload1.prop("value", data.to);
    },
    onChange: function (data) {
        $input_exitload.prop("value", data.from);
		$input_exitload1.prop("value", data.to);
    }
});
}
 
instance1 = $range1.data("ionRangeSlider");

$input_exitload.on("change keyup", function () {
    var val = $(this).prop("value");
    
    // validate
    if (val < min) {
        val = min;
    } else if (val > max) {
        val = max;
    }
    
    instance.update({
        from: val
    });
});
$input_exitload1.on("change keyup", function () {
    var val1 = $(this).prop("value");
    var val0 = $input.prop("value");
    // validate
    if (val1 < min) {
        val1 = min;
    } else if (val1 > max) {
        val1 = max;
    } else if (val1 < val0) {
        val01 = val0;
    }
    
    instance1.update({
		from: val01,
        to: val1
    });
});


var $range_age = $(".js-range-slider-age"),
    $input_age = $(".js-input-from-age"),
	$input1_age = $(".js-input-to-age"),
    instance_age;
	
function age_range(age_min,age_max)
{
	var min = age_min,
    max = age_max;

$range.ionRangeSlider({
    type: "double",
    min: min,
    max: max,
    from: age_min,
	to: age_max,
    onStart: function (data) {
        $input_age.prop("value", data.from);
		$input1_age.prop("value", data.to);
    },
    onChange: function (data) {
        $input_age.prop("value", data.from);
		$input1_age.prop("value", data.to);
    }
});
}
    

instance_age = $range_age.data("ionRangeSlider");

$input_age.on("change keyup", function () {
    var val = $(this).prop("value");
    
    // validate
    if (val < min) {
        val = min;
    } else if (val > max) {
        val = max;
    }
    
    instance_age.update({
        from: val
    });
});
$input1_age.on("change keyup", function () {
    var val1 = $(this).prop("value");
    var val0 = $input_age.prop("value");
    // validate
    if (val1 < min) {
        val1 = min;
    } else if (val1 > max) {
        val1 = max;
    } else if (val1 < val0) {
        val01 = val0;
    }
    
    instance_age.update({
		from: val01,
        to: val1
    });
});

var $range_exp = $(".js-range-slider-expenseratio"),
    $input_exp = $(".js-input-from-expenseratio"),
	$input1_exp = $(".js-input-to-expenseratio"),
    instance_exp;
function expratio_range(expratio_min,expratio_max)
{
	var min = expratio_min,
    max = expratio_max;

$range_exp.ionRangeSlider({
    type: "double",
    min: min,
    max: max,
    from: expratio_min,
	to: expratio_max,
    onStart: function (data) {
        $input_exp.prop("value", data.from);
		$input1_exp.prop("value", data.to);
    },
    onChange: function (data) {
        $input_exp.prop("value", data.from);
		$input1_exp.prop("value", data.to);
    }
});
}
    

instance_exp = $range_exp.data("ionRangeSlider");

$input_exp.on("change keyup", function () {
    var val = $(this).prop("value");
    
    // validate
    if (val < min) {
        val = min;
    } else if (val > max) {
        val = max;
    }
    
    instance_exp.update({
        from: val
    });
});
$input1_exp.on("change keyup", function () {
    var val1 = $(this).prop("value");
    var val0 = $input_exp.prop("value");
    // validate
    if (val1 < min) {
        val1 = min;
    } else if (val1 > max) {
        val1 = max;
    } else if (val1 < val0) {
        val01 = val0;
    }
    
    instance_exp.update({
		from: val01,
        to: val1
    });
});

var $range_turn = $(".js-range-slider-turnoverratio"),
    $input_turn = $(".js-input-from-turnoverratio"),
	$input1_turn = $(".js-input-to-turnoverratio"),
    instance_turn;
function turnover_range(turnover_min,turnover_max)
{
	var min = turnover_min,
    max = turnover_max;

$range_turn.ionRangeSlider({
    type: "double",
    min: min,
    max: max,
    from: turnover_min,
	to: turnover_max,
    onStart: function (data) {
        $input_turn.prop("value", data.from);
		$input1_turn.prop("value", data.to);
    },
    onChange: function (data) {
        $input_turn.prop("value", data.from);
		$input1_turn.prop("value", data.to);
    }
});
}


instance_turn = $range.data("ionRangeSlider");

$input_turn.on("change keyup", function () {
    var val = $(this).prop("value");
    
    // validate
    if (val < min) {
        val = min;
    } else if (val > max) {
        val = max;
    }
    
    instance_turn.update({
        from: val
    });
});
$input1_turn.on("change keyup", function () {
    var val1 = $(this).prop("value");
    var val0 = $input_turn.prop("value");
    // validate
    if (val1 < min) {
        val1 = min;
    } else if (val1 > max) {
        val1 = max;
    } else if (val1 < val0) {
        val01 = val0;
    }
    
    instance_turn.update({
		from: val01,
        to: val1
    });
});

});


// $("document").ready(function(){
 // var $range = $(".js-range-slider-exitload"),
    // $input = $(".js-input-from-exitload"),
	// $input1 = $(".js-input-to-exitload"),
    // instance;
	
// function exitload_range(exitload_min,exitload_max)
// {
	// alert(exitload_min);
		 // alert(exitload_max);
	// var min = exitload_min,
    // max = exitload_max;

// $range.ionRangeSlider({
    // type: "double",
    // min: min,
    // max: max,
    // from: exitload_min,
	// to: exitload_max,
    // onStart: function (data) {
        // $input.prop("value", data.from);
		// $input1.prop("value", data.to);
    // },
    // onChange: function (data) {
        // $input.prop("value", data.from);
		// $input1.prop("value", data.to);
    // }
// });
// }
 

// instance = $range.data("ionRangeSlider");

// $input.on("change keyup", function () {
    // var val = $(this).prop("value");
    
    // // validate
    // if (val < min) {
        // val = min;
    // } else if (val > max) {
        // val = max;
    // }
    
    // instance.update({
        // from: val
    // });
// });
// $input1.on("change keyup", function () {
    // var val1 = $(this).prop("value");
    // var val0 = $input.prop("value");
    // // validate
    // if (val1 < min) {
        // val1 = min;
    // } else if (val1 > max) {
        // val1 = max;
    // } else if (val1 < val0) {
        // val01 = val0;
    // }
    
    // instance.update({
		// from: val01,
        // to: val1
    // });
// });
// });



$("document").ready(function(){

});

