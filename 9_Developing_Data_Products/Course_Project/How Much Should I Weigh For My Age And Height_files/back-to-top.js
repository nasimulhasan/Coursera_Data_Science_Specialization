

// Back to top

$(function () {

    /* set variables locally for increased performance */
    var scroll_timer;
    var displayed = false;
    var $message = $('#message a');
    var $window = $(window);
    var top = $(document.body).children(0).position().top;

    /* react to scroll event on window */
    $window.scroll(function () {
        //console.log("This is top "+top+ $window.scrollTop());
        window.clearTimeout(scroll_timer);
        scroll_timer = window.setTimeout(function () {
            if($window.scrollTop() <= top)
            {
                displayed = false;
                $message.fadeOut(100);
            }
            else if(displayed == false)
            {   
                displayed = true;
                $message.show();
                $message.fadeIn();
                $message.stop(true, true).show().click(function () { 
                    $message.fadeOut(250);
                    $("html, body").animate({ scrollTop: 0 }, 600);
                    return false;
         });
            }
        }, 500);
    });


    //SCROLL TO TOP FOR ARTICLE

    $('.top_button').click(function(event) {

        $("html, body").animate({ scrollTop: 0 }, 600);
        
        return false;

    });

});


(function($) {

    $.organicTabs = function(el, options) {
    
        var base = this;
        base.$el = $(el);
        base.$nav = base.$el.find(".nav");
                
        base.init = function() {
        
            base.options = $.extend({},$.organicTabs.defaultOptions, options);
            
            // Accessible hiding fix
            $(".hide").css({
                "position": "relative",
                "top": 0,
                "left": 0,
                "display": "none"
            }); 
            
            base.$nav.delegate("li > a", "click", function() {
            
                // Figure out current list via CSS class
                var curList = base.$el.find("a.current").attr("href").substring(1),
                
                // List moving to
                    $newList = $(this),
                    
                // Figure out ID of new list
                    listID = $newList.attr("href").substring(1),
                
                // Set outer wrapper height to (static) height of current inner list
                    $allListWrap = base.$el.find(".list-wrap"),
                    curListHeight = $allListWrap.height();
                $allListWrap.height(curListHeight);
                                        
                if ((listID != curList) && ( base.$el.find(":animated").length == 0)) {
                                            
                    // Fade out current list
                    base.$el.find("#"+curList).fadeOut(base.options.speed, function() {
                        
                        // Fade in new list on callback
                        base.$el.find("#"+listID).fadeIn(base.options.speed);
                        
                        // Adjust outer wrapper to fit new list snuggly
                        var newHeight = base.$el.find("#"+listID).height();
                        $allListWrap.animate({
                            height: newHeight
                        });
                        
                        // Remove highlighting - Add to just-clicked tab
                        base.$el.find(".nav li a").removeClass("current");
                        $newList.addClass("current");
                            
                    });
                    
                }   
                
                // Don't behave like a regular link
                // Stop propegation and bubbling
                return false;
            });
            
        };
        base.init();
    };
    
    $.organicTabs.defaultOptions = {
        "speed": 300
    };
    
    $.fn.organicTabs = function(options) {
        return this.each(function() {
            (new $.organicTabs(this, options));
        });
    };
    
})(jQuery);

// Popular Tabs

	$(function() {
		$("#popular_tabs").organicTabs({
		"speed": 100
		});
	});


$(document).ready(function(){
	dynamicFaq();
	var hashpath = window.location.hash;
	var pathtrigger='a[href="'+hashpath+'"]';
	if(!hashpath==''){
	var element_top=$(pathtrigger).closest("dt").position().top;
	
	$('html, body').animate({
    	scrollTop: $(window).scrollTop()+element_top
	});
	$(pathtrigger).closest("dt").click();
	}
});

function dynamicFaq(){
	$('dd').hide();
	$('dt').bind('click', function(){
		$(this).toggleClass('open').next().slideToggle();;
	});
}

// Facebook code from - https://developers.facebook.com/docs/plugins/

(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_GB/all.js#xfbml=1";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));





$(document).ready(function() {

  //find out all youtube iframe first

  var $allVideosframe = $("iframe[src^='//www.youtube.com']");
  $allVideosframe.each(function() {
   var $video=$(this);
//wrap it ,so it'll have a video container that we can add styles   
   $video.wrap("<div class='video_frame'></div>");
  });

/*----------------------------------------------------------------------*/

  //find out all youtube object


  var $allVideosframe = $("object embed[src^='http://www.youtube.com']").parent();
  $allVideosframe.each(function() {
      var $video=$(this);
      $video.wrap("<div class='video_frame'></div>");
  });

/*----------------------------------------------------------------------*/




//only find out all the video from health guru

var $allVideos = $(".video_frame object[data^='http://static-cf-1.hgcdn.net/']"),
    // The element that is fluid width
    $fluidEl = $(".video_frame");
  
// Figure out and save aspect ratio for each video
$allVideos.each(function() {

  $(this).data('aspectRatio', this.height / this.width).removeAttr('height').removeAttr('width');
});

// When the window is resized
$(window).resize(function() {

  var newWidth = $fluidEl.width();

  // Resize all videos according to their own aspect ratio
  $allVideos.each(function() {

    var $el = $(this);
    $el.width(newWidth).height(newWidth*$el.data('aspectRatio'));

  });

// Kick off one resize to fix all videos on page load
}).resize();

});