function Controller(){
}

Controller.prototype = {
  bindEvents: function(){
    $('select').on('change', this.setFont);
    $('#add').on('click', this.save)
  },

  setFont: function(e){
    e.preventDefault();
    var $font = $('select').val();

    var $url = $('select').attr('id');
    console.log($url);
    $.ajax({
      url: $url,
      type: 'put',
      data: {font: $font}
    }).done(changeFontView);

    function changeFontView(data){
      $('head').append($('<link>').attr('rel', 'stylesheet').attr('type', 'text/css').attr('href', 'https://fonts.googleapis.com/css?family=' + $('select').val()));
      $('#journal_title').css('font-family', $('select').val().split('+').join(' '));
      $('#journal_template').css('font-family', $('select').val().split('+').join(' '));
    }
  },

  loadFonts: function loadFonts(){
    $.ajax( {
      url: 'https://www.googleapis.com/webfonts/v1/webfonts?key=AIzaSyADgGSfRTA3BZJsItLnFgQs6cvSKjHzKRk',
      type: 'get',
      data: {
        sort: 'alpha'
      }
    })
    //append fonts to select dropdown
    .done(function (res) {
      var fonts = res.items;
      for (var i = 0; i < fonts.length; i++) {
        var font_title = fonts[i].family; //ex: "Open Sans"
        var $option = $('<option value=' + font_title.split(' ').join('+') + '></option>'); //<option value='Open+Sans'></option>
        $option.text(font_title) //<option value='Open+Sans>Open Sans</option>'
        $option.appendTo('select');
      }
    });
  }



} //END CONTROLLER PROTOTYPE

