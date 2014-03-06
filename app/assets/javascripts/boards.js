$(function(){

    var taskBoard = new TaskBoardViewModel()
    taskBoard.loadTasks();
    
    ko.applyBindings(taskBoard);

 });



