$('#search_text').keyup(function(){
	$.post('/students/search_teacher', { search: { text: $("#search_text").val() } }, null, 'script')
    });

