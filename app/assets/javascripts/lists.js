var currentList = {};
var showTasks = false;

$(document).ready( function() {
  
  $('.list-item').on('click', function() {
    currentList.id = this.dataset.id;
    // debugger
    showTasks = !showTasks;
    

    if (showTasks) {
      $.ajax({
        url: '/lists/' + currentList.id + '/tasks',
        method: 'GET',
        dataType: 'JSON'
      }).done( function(tasks) {
        var listOfTasks = $('#tasks-' + currentList.id);
        listOfTasks.empty();
        tasks.forEach( function(task) {
          // Print out task with due date and whether it has been completed
          var div = '<div class="item" data-task-id="' + task.id + '">'
          div += '<div class="right floated content">'
          if (task.due_date) {
            var taskDate = task.due_date.split("-")
            div += '<i class="clock outline icon"></i>' + taskDate[1] + '/' + taskDate[2] + '/' + taskDate[0].slice(2) + '|'
          } 
          if (task.completed) {
            div += '<i class="check square outline icon"></i>'
          } else {
            div += '<i class="square outline icon"></i>'
          }
          
          // Finally, add the actual title of the task to be printed out
          div += '</div><div class="content">' + task.title + '</div></div>'
          listOfTasks.append(div)
          $('#bottom-button-' + currentList.id).show();
        });

      });

    } else { // Hide the task list
      var listOfTasks = $('#tasks-' + currentList.id);
      listOfTasks.empty();
      $('#bottom-button-' + currentList.id).hide();
    }
  });
});