$(document).on('turbolinks:load', function() {
  $('#checkbox_deposit').on('click', function() {
    $('#book_category_id').val('');
    $('#book_category_id').prop('disabled', true);
    $('#book_category_id').css('background-color', '#ddd');
  })
  $('#checkbox_payment').on('click', function() {
    $('#book_category_id').prop('disabled', false);
    $('#book_category_id').css('background-color', '#fff');
  })
  var reloadOnPagination = function(json) {
    if (typeof json.status !== 'undefined') {
      if (json.status == 'ok') {
        location.reload();
      }
    }
  }
  $('#prev_month, #next_month').on('click', function() {
    var id =  $(this).attr("id");
    var target = id.replace(/_month/, '');
    $.ajax({
      type: 'GET',
      url: '/target_months/' + target  //target_months/prev
    }).done(function(json) {
     reloadOnPagination(json);
    }).fail(function(jqXHR, textStatus, errorThrown) {
     alert('error');
    })
    return false;
  })
});
