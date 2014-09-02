// tipsy, facebook style tooltips for jquery
// version 1.0.0a
// (c) 2008-2010 jason frame [jason@onehackoranother.com]
// released under the MIT license

(function($) {
    
    function maybeCall(thing, ctx) {
        return (typeof thing == 'function') ? (thing.call(ctx)) : thing;
    };
    
    function isElementInDOM(ele) {
      while (ele = ele.parentNode) {
        if (ele == document) return true;
      }
      return false;
    };
    
    function Tipsy(element, options) {
        this.$element = $(element);
        this.options = options;
        this.enabled = true;
        this.fixTitle();
    };
    
    Tipsy.prototype = {
        show: function() {
            var title = this.getTitle();
            if (title && this.enabled) {
                var $tip = this.tip();
                
                $tip.find('.tipsy-inner')[this.options.html ? 'html' : 'text'](title);
                $tip[0].className = 'tipsy'; // reset classname in case of dynamic gravity
                $tip.remove().css({top: 0, left: 0, visibility: 'hidden', display: 'block'}).prependTo(document.body);
                
                var pos = $.extend({}, this.$element.offset(), {
                    width: this.$element[0].offsetWidth,
                    height: this.$element[0].offsetHeight
                });
                
                var actualWidth = $tip[0].offsetWidth,
                    actualHeight = $tip[0].offsetHeight,
                    gravity = maybeCall(this.options.gravity, this.$element[0]);
                
                var tp;
                switch (gravity.charAt(0)) {
                    case 'n':
                        tp = {top: pos.top + pos.height + this.options.offset, left: pos.left + pos.width / 2 - actualWidth / 2};
                        break;
                    case 's':
                        tp = {top: pos.top - actualHeight - this.options.offset, left: pos.left + pos.width / 2 - actualWidth / 2};
                        break;
                    case 'e':
                        tp = {top: pos.top + pos.height / 2 - actualHeight / 2, left: pos.left - actualWidth - this.options.offset};
                        break;
                    case 'w':
                        tp = {top: pos.top + pos.height / 2 - actualHeight / 2, left: pos.left + pos.width + this.options.offset};
                        break;
                }
                
                if (gravity.length == 2) {
                    if (gravity.charAt(1) == 'w') {
                        tp.left = pos.left + pos.width / 2 - 15;
                    } else {
                        tp.left = pos.left + pos.width / 2 - actualWidth + 15;
                    }
                }
                
                $tip.css(tp).addClass('tipsy-' + gravity);
                $tip.find('.tipsy-arrow')[0].className = 'tipsy-arrow tipsy-arrow-' + gravity.charAt(0);
                if (this.options.className) {
                    $tip.addClass(maybeCall(this.options.className, this.$element[0]));
                }
                
                if (this.options.fade) {
                    $tip.stop().css({opacity: 0, display: 'block', visibility: 'visible'}).animate({opacity: this.options.opacity});
                } else {
                    $tip.css({visibility: 'visible', opacity: this.options.opacity});
                }
            }
        },
        
        hide: function() {
            if (this.options.fade) {
                this.tip().stop().fadeOut(function() { $(this).remove(); });
            } else {
                this.tip().remove();
            }
        },
        
        fixTitle: function() {
            var $e = this.$element;
            if ($e.attr('title') || typeof($e.attr('original-title')) != 'string') {
                $e.attr('original-title', $e.attr('title') || '').removeAttr('title');
            }
        },
        
        getTitle: function() {
            var title, $e = this.$element, o = this.options;
            this.fixTitle();
            var title, o = this.options;
            if (typeof o.title == 'string') {
                title = $e.attr(o.title == 'title' ? 'original-title' : o.title);
            } else if (typeof o.title == 'function') {
                title = o.title.call($e[0]);
            }
            title = ('' + title).replace(/(^\s*|\s*$)/, "");
            return title || o.fallback;
        },
        
        tip: function() {
            if (!this.$tip) {
                this.$tip = $('<div class="tipsy"></div>').html('<div class="tipsy-arrow"></div><div class="tipsy-inner"></div>');
                this.$tip.data('tipsy-pointee', this.$element[0]);
            }
            return this.$tip;
        },
        
        validate: function() {
            if (!this.$element[0].parentNode) {
                this.hide();
                this.$element = null;
                this.options = null;
            }
        },
        
        enable: function() { this.enabled = true; },
        disable: function() { this.enabled = false; },
        toggleEnabled: function() { this.enabled = !this.enabled; }
    };
    
    $.fn.tipsy = function(options) {
        
        if (options === true) {
            return this.data('tipsy');
        } else if (typeof options == 'string') {
            var tipsy = this.data('tipsy');
            if (tipsy) tipsy[options]();
            return this;
        }
        
        options = $.extend({}, $.fn.tipsy.defaults, options);
        
        function get(ele) {
            var tipsy = $.data(ele, 'tipsy');
            if (!tipsy) {
                tipsy = new Tipsy(ele, $.fn.tipsy.elementOptions(ele, options));
                $.data(ele, 'tipsy', tipsy);
            }
            return tipsy;
        }
        
        function enter() {
            var tipsy = get(this);
            tipsy.hoverState = 'in';
            if (options.delayIn == 0) {
                tipsy.show();
            } else {
                tipsy.fixTitle();
                setTimeout(function() { if (tipsy.hoverState == 'in') tipsy.show(); }, options.delayIn);
            }
        };
        
        function leave() {
            var tipsy = get(this);
            tipsy.hoverState = 'out';
            if (options.delayOut == 0) {
                tipsy.hide();
            } else {
                setTimeout(function() { if (tipsy.hoverState == 'out') tipsy.hide(); }, options.delayOut);
            }
        };
        
        if (!options.live) this.each(function() { get(this); });
        
        if (options.trigger != 'manual') {
            var binder   = options.live ? 'live' : 'bind',
                eventIn  = options.trigger == 'hover' ? 'mouseenter' : 'focus',
                eventOut = options.trigger == 'hover' ? 'mouseleave' : 'blur';
            this[binder](eventIn, enter)[binder](eventOut, leave);
        }
        
        return this;
        
    };
    
    $.fn.tipsy.defaults = {
        className: null,
        delayIn: 0,
        delayOut: 0,
        fade: false,
        fallback: '',
        gravity: 'n',
        html: false,
        live: false,
        offset: 10,
        opacity: 0.8,
        title: 'title',
        trigger: 'hover'
    };
    
    $.fn.tipsy.revalidate = function() {
      $('.tipsy').each(function() {
        var pointee = $.data(this, 'tipsy-pointee');
        if (!pointee || !isElementInDOM(pointee)) {
          $(this).remove();
        }
      });
    };
    
    // Overwrite this method to provide options on a per-element basis.
    // For example, you could store the gravity in a 'tipsy-gravity' attribute:
    // return $.extend({}, options, {gravity: $(ele).attr('tipsy-gravity') || 'n' });
    // (remember - do not modify 'options' in place!)
    $.fn.tipsy.elementOptions = function(ele, options) {
        return $.metadata ? $.extend({}, options, $(ele).metadata()) : options;
    };
    
    $.fn.tipsy.autoNS = function() {
        return $(this).offset().top > ($(document).scrollTop() + $(window).height() / 2) ? 's' : 'n';
    };
    
    $.fn.tipsy.autoWE = function() {
        return $(this).offset().left > ($(document).scrollLeft() + $(window).width() / 2) ? 'e' : 'w';
    };
    
    /**
     * yields a closure of the supplied parameters, producing a function that takes
     * no arguments and is suitable for use as an autogravity function like so:
     *
     * @param margin (int) - distance from the viewable region edge that an
     *        element should be before setting its tooltip's gravity to be away
     *        from that edge.
     * @param prefer (string, e.g. 'n', 'sw', 'w') - the direction to prefer
     *        if there are no viewable region edges effecting the tooltip's
     *        gravity. It will try to vary from this minimally, for example,
     *        if 'sw' is preferred and an element is near the right viewable 
     *        region edge, but not the top edge, it will set the gravity for
     *        that element's tooltip to be 'se', preserving the southern
     *        component.
     */
     $.fn.tipsy.autoBounds = function(margin, prefer) {
		return function() {
			var dir = {ns: prefer[0], ew: (prefer.length > 1 ? prefer[1] : false)},
			    boundTop = $(document).scrollTop() + margin,
			    boundLeft = $(document).scrollLeft() + margin,
			    $this = $(this);

			if ($this.offset().top < boundTop) dir.ns = 'n';
			if ($this.offset().left < boundLeft) dir.ew = 'w';
			if ($(window).width() + $(document).scrollLeft() - $this.offset().left < margin) dir.ew = 'e';
			if ($(window).height() + $(document).scrollTop() - $this.offset().top < margin) dir.ns = 's';

			return dir.ns + (dir.ew ? dir.ew : '');
		}
	};
    
})(jQuery);


/* https://github.com/hosokawat/jquery-localstorage */
/*
 * jQuery Local Storage Plugin v0.3 beta
 */
(function ($) {
  var localStorage = window.localStorage;
  $.support.localStorage = localStorage ? true : false;

  var remove = $.removeLocalStorage = function (key) {
    if (localStorage) localStorage.removeItem(key);
    return;
  };

  function allStorage () {
    return localStorage ? localStorage : undefined;
  }

  var config = $.localStorage = function (key, value) {
    // All Read
    if (arguments.length === 0 ) return allStorage(key);

    // Write
    if (value !== undefined) {
      if (localStorage) localStorage.setItem(key, value);
    }

    // Read
    var result;
    if (localStorage) {
      if (localStorage[key]) result = localStorage.getItem(key);
    }
    return result;
  };

  var io = $.localStorage.io = function (key) {
    return {read : function () {
      return config(key);
    }, write : function (value) {
      return config(key, value);
    }, remove : function () {
      return remove(key);
    }, key : key
    };
  };

})(jQuery);


//Based on http://www.sitepoint.com/html5-ajax-file-upload/ (but heavily modified)

var MAX_FILE_SIZE = 33554432; //32MB

function parseFile(file, image_target, callback) {
    //Basic file type validation
    if(file.type != 'image/jpeg' && file.type != 'image/png' && file.type != 'image/gif') {
        alert('Invalid image type. Valid formats: jpg, gif, png');
        return false;
    }

    //File size validation
    if(file.size > MAX_FILE_SIZE) {
        alert('File is too large. Max file size: ' + MAX_FILE_SIZE);
        return false;
    }

    //Toss an image preview in there right from the client-side
    var reader = new FileReader();
    reader.onload = function(e) {
        image_target.parents('.filedrag').find('.filedrag-preview').attr('src', e.target.result);
        // image_target.siblings('filedrag-filename').html(file.name);
    }
    reader.readAsDataURL(file);

    window[callback];
}

function uploadFile(file, post_target, input_id, onComplete) {
    var xhr = new XMLHttpRequest();
    var response = null;

    //Create progress bar
    // $(".filedrag-progress").html('<p>Uploading...</p>');

    //Update progress bar
    xhr.upload.addEventListener("progress", function(e) {
        var pc = parseInt(100 - (e.loaded / e.total * 100));
        $(".filedrag-progress p").css("backgroundPosition", pc + "% 0");
    }, false);

    //Upload finished
    xhr.onreadystatechange = function(e) {
        if (xhr.readyState == 4) {
            if(xhr.status == 200) {
                $(".filedrag-progress p").addClass("success");
                $(".filedrag-progress p").html("Success!");
                $(".filedrag-progress p").fadeOut('slow', function() {
                    $(".filedrag-progress p").html("");
                    $(".filedrag-progress p").removeClass("success");
                });

                if(!xhr.responseText) {
                    $('.filedrag-filename').html('Error fetching post response');
                    return false;
                }

                response = JSON.parse(xhr.responseText);
                response.input_id = input_id;

                if(onComplete) { window[onComplete](response); }
            }
            else {
                $('.filedrag-filename').html('Error posting image');
                return false;
            }
        }
    };

    //Start the upload
    xhr.open("POST", post_target); // + "/filetype/" + file.type.replace("image/", ""), true);
    // xhr.setRequestHeader("X_FILENAME", file.name);
    xhr.send(file);
}

function initUploaders(post_target, onComplete) {
    var xhr = new XMLHttpRequest();

    //Only do this stuff if the technology is supported
    if (xhr.upload) {
        //Handle the dragover event
        $('.filedrag-droparea').on("dragover", function(e) {
            e.stopPropagation();
            e.preventDefault();
            if(!$(this).hasClass('hover')) { $(this).addClass('hover'); }
        });

        //And the dragleave event
        $('.filedrag-droparea').on("dragleave", function(e) {
            e.stopPropagation();
            e.preventDefault();
            if($(this).hasClass('hover')) { $(this).removeClass('hover'); }
        });

        //A file was dragged onto the droppable area, do stuff
        $('.filedrag-droparea').on("drop", function(e) {
            //Prevent bubbling or default browser handling of image drag/drop
            e.stopPropagation();
            e.preventDefault();

            //Disable hover state
            if($(this).hasClass('hover')) { $(this).removeClass('hover'); }
            
            //Fetch the images from the FileList object
            var files=e.originalEvent.dataTransfer.files;

            //We'll return this in the response, because it comes in handy sometimes
            var input_id = $(this).siblings('.filedrag-input').attr('id');

            // process all File objects
            for (var i = 0, f; f = files[i]; i++) {
                parseFile(f, $(this));
                uploadFile(f, post_target, input_id, onComplete);
            }
        });

        $('.filedrag-droparea').on("click", function(e) {
            $(this).siblings('.filedrag-input').trigger('click');
        });

        //Handle file select
        $('.filedrag-input').change(function(e){
            var files = e.target.files;

            //We'll return this in the response, because it comes in handy sometimes
            var input_id = $(this).siblings('.filedrag-input').attr('id');

            // process all File objects
            for (var i = 0, f; f = files[i]; i++) {
                parseFile(f, $(this));
                uploadFile(f, post_target, input_id, onComplete);
            }
        });

        //Show the drag and drop area
        $('.filedrag-droparea').show();
        $('.filedrag-input').hide();
    }
}

