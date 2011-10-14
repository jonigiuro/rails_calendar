document.observe('dom:loaded', function() {
	var current_back;
	
	$$('.single_event').each(function(element) {
	    element.observe('click', clicked_event);
	})

	function clicked_event() {
		//alert(this);
		if(this.getStyle('paddingBottom') == "15px"){
			this.setStyle({
			  paddingBottom:'2px',
				//backgroundColor: current_back
			});
		}else{
		//current_back=this.getStyle('backgroundColor'),
		this.setStyle({
		  paddingBottom:'15px',
			//backgroundColor: '#FF6600',
		});
		
	}
}

//$$('.single_event').each(function(element) {
//    element.observe('click', clicked_this);
//})
});
