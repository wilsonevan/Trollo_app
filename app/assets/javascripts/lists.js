var currentList = {};

$(document).ready( function() {
  
  $('.list-item').on('click', function() {
    currentList.id = this.dataset.id
    // debugger
    $.ajax({
      url: '/lists/' + currentList.id + '/tasks',
      method: 'GET',
      dataType: 'JSON'
    }).done( function(tasks) {
      var listOfTasks = $('#tasks-' + currentList.id);
      listOfTasks.empty();
      debugger
      tasks.forEach( function(task) {
        // <div class="item"></div>
        var div = '<div class="item" data-task-id="' + task.id + '">' + task.title + '</div>'
        listOfTasks.append(div)
      });
    });
  });
});

