$(function() {
  setInterval(
    function() {
      $.ajax({
        type: "GET",
        url: "/users"
      })
    }, 10000);
});
