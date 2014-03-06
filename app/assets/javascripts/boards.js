$(function(){

    var taskBoard = new TaskBoardViewModel()
    taskBoard.loadTasks();
    taskBoard.loadEventMembers();

    ko.applyBindings(taskBoard);

 });



