(function($) {
  $(function() {
    // let's update the download button for the users OS if we can.
    $('.download').each(function() {
      var type = '(source)';
      var link = '/download.html';
      if (navigator.userAgent.indexOf("Mac") != -1) {
        type = '( MacOSX / Intel )';
        link = 'http://eddylab.org/software/hmmer3/3.1b2/hmmer-3.1b2-macosx-intel.tar.gz';
      }
      else if (navigator.userAgent.indexOf("Linux") != -1) {
        if (navigator.userAgent.indexOf("x86_64") != -1) {
          type = '( Linux / Intel x86_64)';
          link = 'http://eddylab.org/software/hmmer3/3.1b2/hmmer-3.1b2-linux-intel-x86_64.tar.gz';
        }
        else {
          type = '( Linux / Intel ia32)';
          link = 'http://eddylab.org/software/hmmer3/3.1b2/hmmer-3.1b2-linux-intel-ia32.tar.gz';
        }
      }
      else if (navigator.userAgent.indexOf("Win") != -1) {
        type = '( Windows )';
        link = '/download.html#windows';
      }
      $('.os').text(type);
      $('.download .btn').attr('href', link);
    });
  });
})(jQuery);
