function checkFBAuthResponse(response) { 
	console.log(response);
}
function initFacebook() {
	FB.init({ appId: '333864290041286', status: false, cookie: true, xfbml: true ,oauth:true});
	FB.getLoginStatus(function(response) {
		if (response.authResponse && response.authResponse.userID) {
			checkFBAuthResponse(response);
		}
		else {
			FB.login(function(response){
				if (response.authResponse) {
			    	checkFBAuthResponse(response);
			    } else { }
			});
		}
	});
}	
function buildSize(width,height) {
	return{
		width : width,
		height : height,
		ratio : height/width
	};
}
function toDegree(radian) {	
	return radian / (Math.PI * 2 ) * 360;
}
function autoResizeContentsContainer(){
	// 1024/768
	var leftBarWidth = 150;

	var originalSize = {
		width  : rollingpaper.width + leftBarWidth,
		height : rollingpaper.height
	};
	var paperRatio = originalSize.height / originalSize.width; 
	
	var $container = $(".paper_outer");
	var $parent = $(".Container");// $container.parent();
	
	var currentSize = buildSize($parent.width(),$parent.height());
	
	//
	if(paperRatio < currentSize.ratio){
		$container.width(currentSize.width);
		$container.height(currentSize.width*paperRatio);
		$container.css({
			"left": 0,
			"top" : (currentSize.height - $container.height()) / 2
		});
	}
	else{
		$container.height(currentSize.height);
		$container.width(currentSize.height/paperRatio);
		$container.css({
			"left" : (currentSize.width - $container.width()) / 2,
			"top"  : 0
		});
	}
	
	$front = $(".Web_front");
	$front.css({
		left : (currentSize.width - $front.width())/2,
		top  : (currentSize.height - $front.height())/2
	});
}

$(function(){
	initFacebook();
	$(".sound_content").click(function(){
		var audio = $( $(this).find("audio")[0] );
		console.log(audio);
		audio[0].play();
	});
	autoResizeContentsContainer();
	
	
	$(".clear_icon").click(function(){
		$(".icon_door2").hide();
		$(".title_container").clearQueue().fadeOut();
	});
	setTimeout(function(){
		$(".title_container").trigger("click");
	},1000000);
	
	
	$(".under_scroll_left").click(function(){
		$(".under_list_box").animate({"left": "+=465px"});
		return false;
	});
	$(".under_scroll_right").click(function(){
		$(".under_list_box").animate({"left": "-=465px"});
		return false;
	});
	
	$($(".page_indicator")[0]).addClass("selected");
	
	$(".icon_door").click(function(){
		$(".title_container").clearQueue().fadeIn();
		$(".icon_door2").fadeIn();
		
	});
	
	$(".icon_door2").click(function(){
		$(".icon_door").fadeIn();	
		$(".title_container").clearQueue().fadeOut();	
	});

	var alreadySendMessage = false;

	var message = prompt("메시지 : ");
	$.post("/api/papers/1/feedback",{"feedback" : message},function(response){
		console.log(arguments);
	});
	
	$(window).bind('beforeunload', function(eventObject) {
		if(alreadySendMessage) {
			return
		} else {
			return "아직 친구들에게 메시지를 보내지 않으셨습니다";
		}
	});
});