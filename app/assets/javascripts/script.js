$('.myButton').click(function(e) {
  $(`.new_reply_${$(this).attr("data-id")}`).toggle('slow', function() {
  });
});

$('form.new_comment').submit(function(e) {
	e.preventDefault();
	var params = $(this).serialize()
	var route = $(this).attr('action')
	$.post(route, params).done(function(comment) {
		var time = moment(comment["created_at"]).fromNow();
		$('ul#comments').append('<li class="comment">' + '<div class="body">' + '<font size="1">' + comment["user"]["first_name"] + " wrote this " + time + '<br>' + '</font>' + comment["content"])
	});
});

$('.myButton2').click(function(e) {
	var forms = $($(this).parent()).attr("class")
	$('form.'+forms).submit(function(e) {
		e.preventDefault();
		var params = $($(this)).serialize()
		var route = $($(this)).attr('action')
		var self = this
		// var replyId = $(this).attr("class")
		$.post(route, params).done(function(comment) {
			var time = moment(comment["created_at"]).fromNow();

			$('ul#comments').append('<ul style="list-style: none;", class="comment_list">' + '<li class="comment">' + '<div class="body">' + '<font size="1">' + comment["user"]["first_name"] + " wrote this " + time + '<br>' + '</font>' + comment["content"] + '</div>' + '</li>' + '</ul>')
	});
});
})

