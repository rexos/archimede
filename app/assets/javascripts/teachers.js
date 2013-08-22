$('#replicate_data').click( function(){
	$('#teacher_bill_name').val( $('#teacher_name').val() );
	$('#teacher_bill_last_name').val( $('#teacher_last_name').val() );
	$('#teacher_bill_street').val( $('#teacher_street').val() );
	$('#teacher_bill_country').val( $('#teacher_country').val() );
	$('#teacher_bill_number').val( $('#teacher_number').val() );
	$('#teacher_bill_city').val( $('#teacher_city').val() );
	$('#teacher_bill_province').val( $('#teacher_province').val() );
	$('#teacher_bill_cap').val( $('#teacher_cap').val() );
} );

$('div.rating-show').raty({
	half     : true,
	    readOnly : true,
	    hints: ['Cattivo', 'Scarso', 'Normale', 'Buono', 'Grandioso'],
	    score: function() {
	    return $(this).attr('data-score');
	}
    });

$('#star').raty({
	half     : true,
	    size     : 24,
	    hints: ['Cattivo', 'Scarso', 'Normale', 'Buono', 'Grandioso'],
	    target : '#hint',
	    targetText : '--',
	    score: function() {
	    return $(this).attr('data-score');
	},
	    click: function(score, evt) {
	    $.ajax({
		    type: "POST",
			url: "/students/rate_teacher",
			data: { rating_value: score }
		})
	},
});

