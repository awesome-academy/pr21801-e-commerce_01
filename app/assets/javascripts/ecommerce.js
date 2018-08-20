$(document).on("turbolinks:load", function () {
  $(function(){
    $("#show-limit").on("change", function(){
      $(this).closest("form").trigger("submit");
    });
  });

  $('#search_category input').keyup(function(){
    $.get($('#search_category').attr('action'), $('#search_category').serialize(), null, 'script');
    return false;
  });
});
