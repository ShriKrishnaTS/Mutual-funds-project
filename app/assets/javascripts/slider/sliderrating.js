$("document").ready(function(){
var $range = $(".js-range-slider-totalreturn"),
    $input = $(".js-input-from-totalreturn"),
	$input1 = $(".js-input-to-totalreturn"),
    instance,
    min = 1,
    max = 5;

	
	

$range.ionRangeSlider({
    type: "single",
    min: min,
    max: max,
	values: [1, 2, 3, 4, 5],
	grid:true,
	hide_min_max: true,
    hide_from_to: true,
    onStart: function (data) {
        $input.prop("value", data.from);
		$input1.prop("value", data.to);
    },
    onChange: function (data) {
        $input.prop("value", data.from);
		$input1.prop("value", data.to);
    }
});

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
});


$("document").ready(function(){
var $range = $(".js-range-slider-age"),
    $input = $(".js-input-from-age"),
	$input1 = $(".js-input-to-age"),
    instance,
    min = 5,
    max = 60;

$range.ionRangeSlider({
    type: "double",
    min: min,
    max: max,
    from: 5,
	to: 60,
    onStart: function (data) {
        $input.prop("value", data.from);
		$input1.prop("value", data.to);
    },
    onChange: function (data) {
        $input.prop("value", data.from);
		$input1.prop("value", data.to);
    }
});

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
});







