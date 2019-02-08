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
  $('#prev_month').on('click', function() {
    $.ajax({
      type: 'GET',
      url: '/target_terms/prev'
    }).done(function(json) {
      if (typeof json.status !== 'undefined') {
        if (json.status == 'ok') {
          location.reload();
        }
      }
    }).fail(function(jqXHR, textStatus, errorThrown) {
      alert('error');
    })
    return false;
  })
  $('#next_month').on('click', function() {
    $.ajax({
      type: 'GET',
      url: '/target_terms/next'
    }).done(function(json) {
      if (typeof json.status !== 'undefined') {
        if (json.status == 'ok') {
          location.reload();
        }
      }
    }).fail(function(jqXHR, textStatus, errorThrown) {
      alert('error');
    })
    return false;
  })
});
