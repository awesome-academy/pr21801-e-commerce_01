$(document).on('turbolinks:load', function () {
  $(function(){
    $('#show-limit').on('change', function(){
      $(this).closest('form').trigger('submit');
    });
  });

  $('#search_category input').keyup(function(){
    $.get($('#search_category').attr('action'), $('#search_category').serialize(), null, 'script');
    return false;
  });

  $('.rating-symbol').on('click', function() {
    var input = $(this).closest('.rating').find('input:hidden');
    var product_id = input.data('id');
    var rate_id = input.data('rate-id');
    var current_star = input.data('star');
    var star = input.val();
    var rating_method = current_star == 0 ? 'POST' : 'PUT';
    var rating_url = current_star == 0 ? '/ratings' : '/ratings/' + rate_id;
    $.ajax({
      url: rating_url,
      method: rating_method,
      dataType: 'JSON',
      data: {
        rating: {
          product_id: product_id,
          stars: star
        }
      },
      success: function(data){
        input.data('rate', data.rating.id);
        input.val(data.rating.stars);
      },
      error: function(errors) {
        alert(errors.response_text);
      }
    });
  });

  $('.cart_table').on('change', '.input', function(){
    var quantity = $(this).val();
    var product_id = $(this).data('id');
    $.ajax({
      url: 'carts/' + product_id,
      method: 'PUT',
      data: {quantity: quantity}
    });
  });
});
