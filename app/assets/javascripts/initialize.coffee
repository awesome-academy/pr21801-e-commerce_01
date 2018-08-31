jQuery(document).on 'turbolinks:load', ->
  $('.slick_slide').slick({
    cssEase: 'linear',
    dots: true,
    fade: true,
    infinite: true,
    speed: 500,
  });

