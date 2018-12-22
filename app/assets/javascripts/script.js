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
});
