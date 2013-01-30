$(function() {
  setInterval(
    function() {
      $.ajax({
        type: "GET",
        url: "/ajax/messages"
      })
    }, 2000);
});
