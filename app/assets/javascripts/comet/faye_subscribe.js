$(function() {
  var faye = new Faye.Client('http://localhost:9292/faye');
  faye.subscribe('/comet/messages/new', function (data) {
    eval(data);
  });
});
