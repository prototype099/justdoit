function Task(task) {
	var self = this;

	self.id 		= task.id;
	self.user_id	= task.user_id;
	self.name 		= task.name;
	self.content 	= task.content;
	self.uid 		= task.uid;

	self.edit_url	= ko.computed(function(){
		return "/tasks/" + self.id + '/edit';
	}, this);

	self.avator_url = ko.computed(function(){
		return "https://graph.facebook.com/" + self.uid + "/picture?type=square";
	}, this);
}

function Member(user_id, uid) {
	var self = this;

	self.user_id	= user_id;
	self.uid 		= uid;

	self.member_avator_url = ko.computed(function(){
		return "https://graph.facebook.com/" + self.uid + "/picture?type=square";
	}, this);
}

function TaskBoardViewModel() {	

	this.tasks 		= ko.observableArray([]);
	this.members 	= ko.observableArray([]);

	this.inputTaskContent = ko.observable("");

	this.createTask = function() {
		console.log(this.inputTaskContent());
		this.registerTask();
	}
}

TaskBoardViewModel.prototype.loadTasks = function() {
	var self = this;

	$.ajax({
		type: 		"GET",
		cache: 		false,
     	dataType: 	"json",
     	contentType: "application/json; charset=UTF-8",
		url: gon.api_event_tasks_path,
	})
	.done(function(data, status, settings) {
		for(var i=0; i<data.tasks.length; i++) {
			console.log(data.tasks[i]);
			var task = new Task({
				id: 	data.tasks[i].id,
				user_id: data.tasks[i].user_id,
				name: 	data.tasks[i].user.name,
				content: data.tasks[i].content,
				uid: 	data.tasks[i].user.oauth_tokens[0].uid,
			});
			self.tasks.push(task);
		}
	});
}

TaskBoardViewModel.prototype.registerTask = function() {
	var self = this;
	$.ajax({
		type: "POST",
		url: gon.api_create_task_path,
		data: {
			task: {
				event_id: gon.event_id,
				content: this.inputTaskContent(),
			},
		},
	})
	.done(function(data, status, settings) {
		var task = new Task({
			id: 	data.task.id,
			user_id: data.task.user_id,
			name: 	data.task.user.name,
			content:  data.task.content,
			uid: 	data.task.user.oauth_tokens[0].uid,
		});
		//先頭に挿入
		self.tasks.unshift(task);
		self.inputTaskContent("");

		console.log(data.new_member);
		if (data.new_member) {
			self.members.push(new Member(task.user_id, task.uid))
		}

	})
	.fail(function(xhr, status, errorThrown){
		// TODO error handling
		alert("fail");
		data = $.parseJSON(xhr.responseText);
		console.log(data);
		console.log(xhr.responseText);
		console.log(status);
		console.log(errorThrown);
	})
	.always(function(data, status, errorThrown){
	});
}


TaskBoardViewModel.prototype.loadEventMembers = function() {
	var self = this;

	$.ajax({
		type: 		"GET",
		cache: 		false,
     	dataType: 	"json",
     	contentType: "application/json; charset=UTF-8",
		url: gon.api_event_members_path,
	})
	.done(function(data, status, settings) {
		for(var i=0; i<data.members.length; i++) {
			console.log(data.members[i]);
			var member = new Member(data.members[i].user.id, 
									data.members[i].user.oauth_tokens[0].uid);
			self.members.push(member);
		}
	});
}