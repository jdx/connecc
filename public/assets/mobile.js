$(document).ready(function(){$("#find-code-button").click(function(){var a=$("#find-code-input").val();if(!/^[a-zA-Z0-9]{5}$/.test(a)){alert("Code must be 5 letters/numbers")}else{$.ajax({url:"/"+a,success:function(b){$.mobile.changePage("/"+a)},error:function(b){alert("Error: No card found")},})}})});