
$(function() {
				window.addEventListener('message', function(event) {
					if (event.data.type === "openBank"){
		                $('#main-menu, #topbar').show();
		                $('body').addClass("active");
					} else if(event.data.type === "balanceHUD") {
							$('#name').html(event.data.player);
							$('#balance').html(event.data.balance);
					} else if (event.data.type === "closeAll"){
		                $('#main-menu, #transfer-menu, #withdraw-menu, #deposit-menu, #topbar').hide();
		                $('body').removeClass("active");
					}
					else if (event.data.type === "alert") {
						if (event.data.t == "success")
							$("#alert").attr('class', 'alert-green');
						else
							$("#alert").attr('class', 'alert-orange');
						$("#alert").html(event.data.m).show().delay(5000).fadeOut();
					}
				});
			});
    		$('.btn-sign-out').click(function(){
	            $('#main-menu, #transfer-menu, #withdraw-menu, #deposit-menu, #topbar').hide();
	            $('body').removeClass("active");
	            $.post('http://fivem-banking/NUIFocusOff', JSON.stringify({}));
	        })
	        $('.back').click(function(){
	            $('#transfer-menu, #withdraw-menu, #deposit-menu').hide();
	            $('#main-menu').show();
	        })
	        $('#deposit').click(function(){
	            $('#main-menu').hide();
	            $('#deposit-menu').show();
	        })
	        $('#withdraw').click(function(){
	            $('#main-menu').hide();
	            $('#withdraw-menu').show();
	        })
	        $('#transfer').click(function(){
	            $('#main-menu').hide();
	            $('#transfer-menu').show();
	        })
	        $("#deposit-submit").submit(function(e) {
		        e.preventDefault(); // Prevent form from submitting
		        $.post('http://fivem-banking/deposit', JSON.stringify({
		            amount: $("#amount").val()
		        }));
				$('#depositUI').hide();
				$('#general').show();
				$("#amount").val('');
			});
			$("#transfer-submit").submit(function(e) {
		        e.preventDefault(); // Prevent form from submitting
		        $.post('http://fivem-banking/transfer', JSON.stringify({
					to: $("#to").val(),
		            amountt: $("#amountt").val()
		        }));
				$('#transferUI').hide();
				$('#general').show();
				$("#amountt").val('');
			});
			$("#withdraw-submit").submit(function(e) {
				e.preventDefault(); // Prevent form from submitting
		        $.post('http://fivem-banking/withdraw', JSON.stringify({
		            withdraw-amount: $("#withdraw-amount").val()
		        }));
				$('#withdraw-menu').hide();
				$('#main-menu').show();
				$("#withdraw-amount").val('');
			});
			document.onkeyup = function(data){
		        if (data.which == 27){
		            $('#main-menu, #transfer-menu, #withdraw-menu, #deposit-menu, #topbar').hide();
		            $('body').removeClass("active");
		            $.post('http://fivem-banking/NUIFocusOff', JSON.stringify({}));
		        }
		    }
