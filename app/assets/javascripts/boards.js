
$(function(){

	var taskBoard = new TaskBoardViewModel()
	taskBoard.loadTasks();

	ko.applyBindings(taskBoard);

});


function Task(task) {
	var self = this;
	self.name 		= task.name;
	self.content 	= task.content;
	self.uid 		= task.uid;
	self.avator_url = ko.computed(function(){
		return "https://graph.facebook.com/" + self.uid + "/picture?type=square";
	}, this);
}

function TaskBoardViewModel() {	

	this.tasks = ko.observableArray([]);
	this.inputTaskContent = ko.observable("");

	this.createTask = function() {
		console.log(this.inputTaskContent());
		this.registerTask();
	}

	this.addTask = function(task) {
		this.tasks.push(task);
	};

	this.removeTask = function() {
		this.tasks.remove(this);
	};
}

TaskBoardViewModel.prototype.loadTasks = function() {
	var self = this;
	$.ajax({
		type: "GET",
		url: "/api/tasks",
	})
	.done(function(data, status, settings) {
		$.each(data.tasks, function(){
			var task = new Task({
				name: this.user.name,
				content:  this.content,
				uid: this.user.oauth_tokens[0].uid,
			});
			self.tasks.push(task);
		});
	});
}

TaskBoardViewModel.prototype.registerTask = function() {
	var self = this;
	$.ajax({
		type: "POST",
		url: "/api/tasks",
		data: {
			task: {
				event_id: 1,
				content: self.inputTaskContent(),
			},
		},
	})
	.done(function(data, status, settings) {
		var task = new Task({
			name: data.task.user.name,
			content:  data.task.content,
			uid: data.task.user.oauth_tokens[0].uid,
		});
		//先頭に挿入
		self.tasks.unshift(task);
	})
	.fail(function(xhr, status, errorThrown){
		alert("fail");
		console.log(xhr);
		console.log(status);
		console.log(errorThrown);
	})
	.always(function(data, status, errorThrown){
	});
}