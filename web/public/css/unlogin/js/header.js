
        $(document).ready(function () {
            $('.down-icon').click(function (e) {
                e.preventDefault();
                $('.custom-select').slideToggle();
            });
            $('.btn-gnavi').on('click', function () {

                var rightVal = 0;
                if ($(this).hasClass('hb-open')) {
                  rightVal = -500;
                  $(this).removeClass('hb-open');
                } else {
                  $(this).addClass('hb-open');
                }

                $('#global-navi').animate({
                  top: rightVal
                }, 500);
              });

        });


