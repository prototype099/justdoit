$(function(){

    var taskEdit = new TaskEditViewModel()
    taskEdit.loadTaskComments();

    ko.applyBindings(taskEdit);

 });
