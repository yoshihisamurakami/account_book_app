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
      url: '/target_terms/' + target
    }).done(function(json) {
     reloadOnPagination(json);
    }).fail(function(jqXHR, textStatus, errorThrown) {
     alert('error');
    })
    return false;
  })

  // 確定申告用
  $('.book_business_checkbox').on('click', function() {
    const attr_id = $(this).attr('id');
    const checked = $(this).prop("checked");
    const id = attr_id.replace('book_', '');
    update_business(id, checked);
  })

  // 事業経費チェックの更新
  const update_business = (id, checked) => {
    $.ajax({
      type: 'PATCH',
      url: `/tax_books/${id}/update_business`,
      data: {
        checked: checked
      }
    }).done(function(json) {
    }).fail(function(jqXHR, textStatus, errorThrown) {
      alert('error');
    });   
  }

  $('.tax_book_category').change(function() {
    const attr_id = $(this).attr('id');
    const val = $(this).val();
    const id = attr_id.replace('book_category_', '');
    update_category(id, val);
  })

  // カテゴリの更新
  const update_category = (id, val) => {
    $.ajax({
      type: 'PATCH',
      url: `/tax_books/${id}/update_category`,
      data: {
        val: val
      }
    }).done(function(json) {
    }).fail(function(jqXHR, textStatus, errorThrown) {
      alert('error');
    });   
  }

  // 適用エリアの更新
  $('.tax_book_summary').on('focusout', function() {
    const attr_id = $(this).attr('id');
    const val = $(this).val();
    const id = attr_id.replace('book_summary_', '');
    update_summary(id, val);
  })

  // 適用の更新
  const update_summary = (id, val) => {
    $.ajax({
      type: 'PATCH',
      url: `/tax_books/${id}/update_summary`,
      data: {
        val: val
      }
    }).done(function(json) {
    }).fail(function(jqXHR, textStatus, errorThrown) {
      alert('error');
    });
  }

  // 金額エリアの更新
  $('.tax_book_amount').on('focusout', function() {
    const attr_id = $(this).attr('id');
    const val = $(this).val();
    const id = attr_id.replace('book_amount_', '');
    update_amount(id, val);
  })

  const update_amount = (id, val) => {
    $.ajax({
      type: 'PATCH',
      url: `/tax_books/${id}/update_amount`,
      data: {
        val: val
      }
    }).done(function(json) {
    }).fail(function(jqXHR, textStatus, errorThrown) {
      alert('error');
    });
  }
});
