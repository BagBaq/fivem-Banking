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
				});
				$('#disconnect').click(function(){
					$('#main-menu, #transfer-menu, #withdraw-menu, #deposit-menu, #topbar').hide();
					$('body').removeClass("active");
					fetch('https://fivem-banking/NUIFocusOff', {
						method: 'POST',
						headers: {
							'Content-Type': 'application/json; charset=UTF-8',
						},
						body: JSON.stringify({})})
				})
			});
    		
	        $('#back').click(function(){
	            $('#transfer-menu, #withdraw-menu, #deposit-menu').hide();
	            $('#main-menu').show();
	        })
			$('#back-1').click(function(){
	            $('#transfer-menu, #withdraw-menu, #deposit-menu').hide();
	            $('#main-menu').show();
	        })
			$('#back-2').click(function(){
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
	        $("#deposit-submit").click(function(e) {
		        e.preventDefault();
		        fetch('https://fivem-banking/deposit', {
						method: 'POST',
						headers: {
							'Content-Type': 'application/json; charset=UTF-8',
						},
						body: JSON.stringify({
							damount: $("#depo-amount").val()
						})})
				$('#deposit-menu').hide();
				$('#main-menu').show();
				$("#depo-amount").val('');
			});
			$("#transfer-submit").click(function(e) {
		        e.preventDefault();
				fetch('https://fivem-banking/transfer', {
						method: 'POST',
						headers: {
							'Content-Type': 'application/json; charset=UTF-8',
						},
						body: JSON.stringify({
							tamount: $("#transfer-amount").val(),
							to: $("#to").val()
						})});
				$('#transfer-menu').hide();
				$('#main-menu').show();
				$("#transfer-amount").val('');
			});
			$("#withdraw-submit").click(function(e) {
				fetch('https://fivem-banking/withdraw', {
						method: 'POST',
						headers: {
							'Content-Type': 'application/json; charset=UTF-8',
						},
						body: JSON.stringify({
							wamount: $("#withdraw-amount").val()
						})})
				$('#withdraw-menu').hide();
				$('#main-menu').show();
				$("#withdraw-amount").val('');
			});
			document.onkeyup = function(data){
		        if (data.which == 27){
		            $('#main-menu, #transfer-menu, #withdraw-menu, #deposit-menu, #topbar').hide();
		            $('body').removeClass("active");
					fetch('https://fivem-banking/NUIFocusOff', {
						method: 'POST',
						headers: {
							'Content-Type': 'application/json; charset=UTF-8',
						},
						body: JSON.stringify({})})
		        }
		    }
		