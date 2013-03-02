rber = {
  currentQuestion : {},

  init : function(){
    rber.randomQuestion();
    rber.showLoading();
    rber.bindControls();
  },

  bindControls: function(){
    $('#submit').click(function(){
      var answer = $('#answer').val();
      rber.checkAnswer(answer);
    })
  },

  showLoading: function(){
    $('#loading').show();
  },

  hideLoading: function(){
    $('#loading').hide();
  },

  showQuestion: function(){
    $('#question').text(rber.currentQuestion.question);
    $('#answer').val('');
  },

  checkAnswer: function(answer){
    if( answer == rber.currentQuestion.answer){
      alert('cool story bro');
      rber.randomQuestion();
    }else{
      alert('try again bro');
    }
  },

  randomQuestion: function(){
    $.ajax({
      type: 'GET',
      url: '/random.json',
      success: function(response){
        rber.hideLoading();
        rber.currentQuestion = response
        rber.showQuestion();
      }

    });
  }

}



$(document).ready(function() {
  rber.init();
})