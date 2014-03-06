
function Comment(comment) {
	var self = this;

	this.id 	= comment.id;
	this.body 	 = comment.body;
	this.user_id = comment.user_id;
	this.user_name = comment.user_name;
	this.uid 	   = comment.uid;

	this.commented_avator_url = ko.computed(function(){
		return fb_avator_url(this.uid);
	}, this);

}

function TaskEditViewModel() {


	this.comments = ko.observableArray([]);
	this.inputComment = ko.observable("");

	this.createComment = function() {
		console.log(this.inputComment());
		this.registerComment();
	};

}

TaskEditViewModel.prototype.loadTaskComments = function() {

	var self = this;

	$.ajax({
		type: 		"GET",
		cache: 		false,
     	dataType: 	"json",
     	contentType: "application/json; charset=UTF-8",
		url: gon.api_task_comments_path,
	})
	.done(function(data, status, setting){
		console.log(data);
		for(var i = 0; i < data.comments.length; i++) {
			var comment = new Comment({
				id:    		data.comments[i].id,
				body:  		data.comments[i].body,
				user_id: 	data.comments[i].user_id,
				user_name: 	data.comments[i].user.name,
				uid:  		data.comments[i].user.oauth_tokens[0].uid,
			});
			console.log(comment);
			self.comments.push(comment);
		}
	})
	.fail(function(xhr, status, errorThrown){
		console.log(xhr);
		var data = $.parseJSON(xhr.responseText);
		console.log(status);
		console.log(errorThrown); 
	})
	.always(function(xhr, status, errorThrown){
	});

}

TaskEditViewModel.prototype.registerComment = function(){
	var self = this;

	$.ajax({
		type: "POST",
		url: gon.api_task_comments_path,
		data: {
			comment: {
				task_id: gon.task_id,
				body:  	 this.inputComment(),
			},
		},
	})
	.done(function(data, status, setting){
		console.log(data);
		var comment = new Comment({
			id:  	data.comment.id,
			body:  	data.comment.body,
			user_id:  	data.comment.user_id,
			user_name:  data.comment.user.name,
			uid: 	data.comment.user.oauth_tokens[0].uid,
		});
		self.comments.unshift(comment);
		self.inputComment("");
	})
	.fail(function(xhr, status, errorThrown){
		console.log(xhr);
		var data = $.parseJSON(xhr.responseText);
		console.log(data);
	});
}