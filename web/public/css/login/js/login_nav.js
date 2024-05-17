
  $(document).ready(function () {
    $(function () {
      $('.btn-gnavi').on('click', function () {
        var rightVal = 0;
        if ($(this).hasClass('hb-open')) {
          rightVal = -500;
          $(this).removeClass('hb-open');
        } else {
          $(this).addClass('hb-open');
        }
        $('#global-navi').stop().animate({
          top: rightVal
        }, 500);
      });


      $('.menu-toggle').click(function (e) {
        e.preventDefault();
        // alert('dd');
        $('.custom-dashboard').slideToggle();
    });
    });
  });
