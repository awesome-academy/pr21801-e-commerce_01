jQuery(document).on 'turbolinks:load', ->
  $('.slick_slide').slick({
    cssEase: 'linear',
    dots: true,
    fade: true,
    infinite: true,
    speed: 500,
  });

  $('.slider-for').slick({
    slidesToShow: 1,
    slidesToScroll: 1,
    arrows: false,
    fade: true,
    asNavFor: '.slider-nav'
  });
  $('.slider-nav').slick({
    slidesToShow: 4,
    slidesToScroll: 1,
    asNavFor: '.slider-for',
    dots: true,
    centerMode: true,
    focusOnSelect: true
  });
