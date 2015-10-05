

// Shrink menu bar on small viewports - defined in media_queries.css

	$(function() {
	// Create the dropdown
	$("<select/>").appendTo("nav");

	// Add a static spacer first so it won't show text
	$("<option />", {
	"selected": "selected",
	"disabled": "disabled",
	"value"   : "",
	"text"    : ""
	}).appendTo("nav select");

	//View opinions

	$("<option />", {
	"value"   : "/opinions",
	"text"    : "View opinions"
	}).appendTo("nav select");



	$("<option />", {
	"value"   : "/contact",
	"text"    : "Contact MNT"
	}).appendTo("nav select");



	$("<option />", {
	"value"   : "",
	"disabled": "disabled",
	"text"    : "---"
	}).appendTo("nav select");


	// Create default option of "popular categories"
	//if the user got their categories
	if($(".menu_right .cat .shrink").length>0){
	

	$("<option />", {
	"value"   : "",
	"text"    : "Your categories"
	}).appendTo("nav select");

	$("nav select").width('101px');

	}else{
	//if the user didn't get their categories
	

	$("<option />", {
	"value"   : "",
	"text"    : "Our top categories"
	}).appendTo("nav select");
	}
	
	// Populate dropdown with menu items tagged with a class of "shrink" 
	$("nav a.shrink").each(function() {
	var el = $(this);
	//\xA0 will changed to &nbsp;

	var dropdowntext= "\xA0\xA0-\xA0"+el.text();
	$("<option />", {
	"value"   : el.attr("href"),
	"text"    : dropdowntext
	}).appendTo("nav select");
	if($(".menu_right .cat .shrink").length>0){
		if(el.is($(".menu_right .cat .shrink").last())){

			//after generate your categories

			$("<option />", {
			"value"   : "",
			"disabled": "disabled",
			"text"    : "---"
			}).appendTo("nav select");

			$("<option />", {
			"value"   : "",
			"text"    : "Our top categories"
			}).appendTo("nav select");

			
		}
	}
	
	});
	
	// Add additional static menu items
	$("<option />", {
	"value"   : "",
	"disabled": "disabled",
	"text"    : "---"
	}).appendTo("nav select");
	
	$("<option />", {
	"value"   : "/categories",
	"text"    : "View all categories"
	}).appendTo("nav select");
	
	// Make unobtrusive
	$("nav select").change(function() {

	$(this).css({'text-indent': '-999px'});	
	
	window.location = $(this).find("option:selected").val();


	});

	$(".personal_list").change(function() {

	$(this).css({'text-indent': '-999px'});	
	
	window.location = $(this).find("option:selected").val();


	});



	//if the info section got 3 columns ,then we shrink the menu
	if($('.info_toc').length>0){ //.length&&$('.info_toc').children().length=='3'&&!$('.feedback').length)
		$("<select/>").appendTo(".info_toc").addClass("form_select");
		//put default option --the info page is reading now
		$("<option />", {
			"selected": "selected",
			"value"   : "",
			"text"    : $('.info_toc strong').text()
		}).appendTo(".info_toc select");

		//put all the links into the drop down list
		$(".info_toc a").each(function() {
			var el = $(this);
		$("<option />", {
			"value"   : el.attr("href"),
			"text"    : el.text()
		}).appendTo(".info_toc select");
	
		});

		//to bind the selection of the drop dwon list
		$(".info_toc select").change(function() {
			window.location = $(this).find("option:selected").val();
		});

	}
		//Info section drop down list only shows when the window screen is under 767px
	 $(window).resize(function(){
	 	
		if($(window).width()<=767&&$('.info_toc').children('ul').length>=1&&!$('.feedback').length){  	
     	//if($(window).width()<=767&&$('.info_toc').children('ul').length=='3'&&!$('.feedback').length){  - old 3-col code
			$('div.info_toc select').show();
			$(".info_toc ul").each(function() {
				$(this).hide();
			});
     	}else{
     		$('div.info_toc select').hide();
     		$(".info_toc ul").each(function() {
				$(this).show();
			});
     	}
      
	 }).resize();





	});

// Sticky Menu


$(function() {


         
    // get initial top offset of navigation
    var floating_navigation_offset_top = $('#navdiv').offset().top;
             
    // define the floating navigation function
    var floating_navigation = function(){
                // current vertical position from the top
        var scroll_top = $(window).scrollTop();
         
        // if scrolled more than the navigation, change its
                // position to fixed to float to top, otherwise change
                // it back to relative
        var htmlclass=$('html').attr('class');
        if (scroll_top > floating_navigation_offset_top) {
			$('body').css({ 'padding-top':'28px'}); // adds padding to replace the lost height of the menu after it changes display state
            $('#navdiv').css({ 'position':'fixed', 'top':'0','left':'0','-webkit-box-shadow':'0px 0px 10px rgba(0,0,0,.5)','-moz-box-shadow':'0px 0px 10px rgba(0,0,0,.5)','box-shadow':'0px 0px 10px rgba(0,0,0,.5)'});
			$('#menu li.home_icon').css({ 'visibility':'hidden','opacity':'0','margin-top':'-100px','transition':'visibility 0s 0.5s, opacity 0.5s linear, margin 0s ease-in-out' }); // hide home icon 
            $('#menu li.home_logo').css({ 'visibility':'visible','opacity':'1','margin-left':'0px','transition':'visibility 0s 0s, opacity 0.5s linear, margin 0s ease-in-out' }); // display home logo

            //if it's IE
      
            if((htmlclass.indexOf("ie7")>0||htmlclass.indexOf("ie8")>0)&&$(window).width()<891){

            if(htmlclass.indexOf("ie7")>0){
                $('#menu').width(860);    
            }
            
            $('#navdiv').css({ 'position': 'absolute', 'top':scroll_top,'left':0});

            }

        } else {

            $('body').css({ 'padding-top':0}); // removed padding applied in "scroll_top" above
            $('#navdiv').css({ 'position':'relative','top':'0','left':'0','-webkit-box-shadow':'none','-moz-box-shadow':'none','box-shadow':'none' });
			$('#menu li.home_icon').css({ 'visibility':'visible','opacity':'1','margin-top':'0px','transition':'visibility 0s 0s, opacity 0.5s linear, margin 0s ease-in-out' }); // hide home icon 
            $('#menu li.home_logo').css({ 'visibility':'hidden','opacity':'0','margin-left':'-9999px','transition':'visibility 0s 0.5s, opacity 0.5s linear, margin 0s ease-in-out' }); // hide home logo
              //if it's IE
            if(htmlclass.indexOf("ie7")>0&&$(window).width()<891){
                $('#menu').width($(".row").width());            }


        }  
    };
     
    // run function on load
    floating_navigation();
     
    // run function every time you scroll
    $(window).scroll(function() {
         floating_navigation();
    });
    

     var isMobile = {
        BlackBerry: function() {
        var ua = navigator.userAgent;
        return (ua.indexOf("BlackBerry") >= 0||ua.indexOf("BB") >= 0) ? true : false;
        } 
    };
    
    //For Black Berry only ,categories selection

    if(isMobile.BlackBerry()){
        
        $("nav select").after("<a href='/categories' class='blackberrycat' >categories</a>");


        $(".blackberrycat").css({
      
            "float":"right",
            "color": "#f4f4f4",
            "text-decoration":"none",
            "text-shadow":"0.1em 0.1em 0.05em #111"
        
        });


        $("nav select").hide();

        
    }


});  


/**
 * jQuery Validation Plugin 1.8.1
 *
 * http://bassistance.de/jquery-plugins/jquery-plugin-validation/
 * http://docs.jquery.com/Plugins/Validation
 *
 * Copyright (c) 2006 - 2011 Jörn Zaefferer
 *
 * Dual licensed under the MIT and GPL licenses:
 *   http://www.opensource.org/licenses/mit-license.php
 *   http://www.gnu.org/licenses/gpl.html
 */
(function(c){c.extend(c.fn,{validate:function(a){if(this.length){var b=c.data(this[0],"validator");if(b)return b;b=new c.validator(a,this[0]);c.data(this[0],"validator",b);if(b.settings.onsubmit){this.find("input, button").filter(".cancel").click(function(){b.cancelSubmit=true});b.settings.submitHandler&&this.find("input, button").filter(":submit").click(function(){b.submitButton=this});this.submit(function(d){function e(){if(b.settings.submitHandler){if(b.submitButton)var f=c("<input type='hidden'/>").attr("name",
b.submitButton.name).val(b.submitButton.value).appendTo(b.currentForm);b.settings.submitHandler.call(b,b.currentForm);b.submitButton&&f.remove();return false}return true}b.settings.debug&&d.preventDefault();if(b.cancelSubmit){b.cancelSubmit=false;return e()}if(b.form()){if(b.pendingRequest){b.formSubmitted=true;return false}return e()}else{b.focusInvalid();return false}})}return b}else a&&a.debug&&window.console&&console.warn("nothing selected, can't validate, returning nothing")},valid:function(){if(c(this[0]).is("form"))return this.validate().form();
else{var a=true,b=c(this[0].form).validate();this.each(function(){a&=b.element(this)});return a}},removeAttrs:function(a){var b={},d=this;c.each(a.split(/\s/),function(e,f){b[f]=d.attr(f);d.removeAttr(f)});return b},rules:function(a,b){var d=this[0];if(a){var e=c.data(d.form,"validator").settings,f=e.rules,g=c.validator.staticRules(d);switch(a){case "add":c.extend(g,c.validator.normalizeRule(b));f[d.name]=g;if(b.messages)e.messages[d.name]=c.extend(e.messages[d.name],b.messages);break;case "remove":if(!b){delete f[d.name];
return g}var h={};c.each(b.split(/\s/),function(j,i){h[i]=g[i];delete g[i]});return h}}d=c.validator.normalizeRules(c.extend({},c.validator.metadataRules(d),c.validator.classRules(d),c.validator.attributeRules(d),c.validator.staticRules(d)),d);if(d.required){e=d.required;delete d.required;d=c.extend({required:e},d)}return d}});c.extend(c.expr[":"],{blank:function(a){return!c.trim(""+a.value)},filled:function(a){return!!c.trim(""+a.value)},unchecked:function(a){return!a.checked}});c.validator=function(a,
b){this.settings=c.extend(true,{},c.validator.defaults,a);this.currentForm=b;this.init()};c.validator.format=function(a,b){if(arguments.length==1)return function(){var d=c.makeArray(arguments);d.unshift(a);return c.validator.format.apply(this,d)};if(arguments.length>2&&b.constructor!=Array)b=c.makeArray(arguments).slice(1);if(b.constructor!=Array)b=[b];c.each(b,function(d,e){a=a.replace(RegExp("\\{"+d+"\\}","g"),e)});return a};c.extend(c.validator,{defaults:{messages:{},groups:{},rules:{},errorClass:"error",
validClass:"valid",errorElement:"label",focusInvalid:true,errorContainer:c([]),errorLabelContainer:c([]),onsubmit:true,ignore:[],ignoreTitle:false,onfocusin:function(a){this.lastActive=a;if(this.settings.focusCleanup&&!this.blockFocusCleanup){this.settings.unhighlight&&this.settings.unhighlight.call(this,a,this.settings.errorClass,this.settings.validClass);this.addWrapper(this.errorsFor(a)).hide()}},onfocusout:function(a){if(!this.checkable(a)&&(a.name in this.submitted||!this.optional(a)))this.element(a)},
onkeyup:function(a){if(a.name in this.submitted||a==this.lastElement)this.element(a)},onclick:function(a){if(a.name in this.submitted)this.element(a);else a.parentNode.name in this.submitted&&this.element(a.parentNode)},highlight:function(a,b,d){a.type==="radio"?this.findByName(a.name).addClass(b).removeClass(d):c(a).addClass(b).removeClass(d)},unhighlight:function(a,b,d){a.type==="radio"?this.findByName(a.name).removeClass(b).addClass(d):c(a).removeClass(b).addClass(d)}},setDefaults:function(a){c.extend(c.validator.defaults,
a)},messages:{required:"This field is required.",remote:"Please fix this field.",email:"Please enter a valid email address.",url:"Please enter a valid URL.",date:"Please enter a valid date.",dateISO:"Please enter a valid date (ISO).",number:"Please enter a valid number.",digits:"Please enter only digits.",creditcard:"Please enter a valid credit card number.",equalTo:"Please enter the same value again.",accept:"Please enter a value with a valid extension.",maxlength:c.validator.format("Please enter no more than {0} characters."),
minlength:c.validator.format("Please enter at least {0} characters."),rangelength:c.validator.format("Please enter a value between {0} and {1} characters long."),range:c.validator.format("Please enter a value between {0} and {1}."),max:c.validator.format("Please enter a value less than or equal to {0}."),min:c.validator.format("Please enter a value greater than or equal to {0}.")},autoCreateRanges:false,prototype:{init:function(){function a(e){var f=c.data(this[0].form,"validator");e="on"+e.type.replace(/^validate/,
"");f.settings[e]&&f.settings[e].call(f,this[0])}this.labelContainer=c(this.settings.errorLabelContainer);this.errorContext=this.labelContainer.length&&this.labelContainer||c(this.currentForm);this.containers=c(this.settings.errorContainer).add(this.settings.errorLabelContainer);this.submitted={};this.valueCache={};this.pendingRequest=0;this.pending={};this.invalid={};this.reset();var b=this.groups={};c.each(this.settings.groups,function(e,f){c.each(f.split(/\s/),function(g,h){b[h]=e})});var d=this.settings.rules;
c.each(d,function(e,f){d[e]=c.validator.normalizeRule(f)});c(this.currentForm).validateDelegate(":text, :password, :file, select, textarea","focusin focusout keyup",a).validateDelegate(":radio, :checkbox, select, option","click",a);this.settings.invalidHandler&&c(this.currentForm).bind("invalid-form.validate",this.settings.invalidHandler)},form:function(){this.checkForm();c.extend(this.submitted,this.errorMap);this.invalid=c.extend({},this.errorMap);this.valid()||c(this.currentForm).triggerHandler("invalid-form",
[this]);this.showErrors();return this.valid()},checkForm:function(){this.prepareForm();for(var a=0,b=this.currentElements=this.elements();b[a];a++)this.check(b[a]);return this.valid()},element:function(a){this.lastElement=a=this.clean(a);this.prepareElement(a);this.currentElements=c(a);var b=this.check(a);if(b)delete this.invalid[a.name];else this.invalid[a.name]=true;if(!this.numberOfInvalids())this.toHide=this.toHide.add(this.containers);this.showErrors();return b},showErrors:function(a){if(a){c.extend(this.errorMap,
a);this.errorList=[];for(var b in a)this.errorList.push({message:a[b],element:this.findByName(b)[0]});this.successList=c.grep(this.successList,function(d){return!(d.name in a)})}this.settings.showErrors?this.settings.showErrors.call(this,this.errorMap,this.errorList):this.defaultShowErrors()},resetForm:function(){c.fn.resetForm&&c(this.currentForm).resetForm();this.submitted={};this.prepareForm();this.hideErrors();this.elements().removeClass(this.settings.errorClass)},numberOfInvalids:function(){return this.objectLength(this.invalid)},
objectLength:function(a){var b=0,d;for(d in a)b++;return b},hideErrors:function(){this.addWrapper(this.toHide).hide()},valid:function(){return this.size()==0},size:function(){return this.errorList.length},focusInvalid:function(){if(this.settings.focusInvalid)try{c(this.findLastActive()||this.errorList.length&&this.errorList[0].element||[]).filter(":visible").focus().trigger("focusin")}catch(a){}},findLastActive:function(){var a=this.lastActive;return a&&c.grep(this.errorList,function(b){return b.element.name==
a.name}).length==1&&a},elements:function(){var a=this,b={};return c(this.currentForm).find("input, select, textarea").not(":submit, :reset, :image, [disabled]").not(this.settings.ignore).filter(function(){!this.name&&a.settings.debug&&window.console&&console.error("%o has no name assigned",this);if(this.name in b||!a.objectLength(c(this).rules()))return false;return b[this.name]=true})},clean:function(a){return c(a)[0]},errors:function(){return c(this.settings.errorElement+"."+this.settings.errorClass,
this.errorContext)},reset:function(){this.successList=[];this.errorList=[];this.errorMap={};this.toShow=c([]);this.toHide=c([]);this.currentElements=c([])},prepareForm:function(){this.reset();this.toHide=this.errors().add(this.containers)},prepareElement:function(a){this.reset();this.toHide=this.errorsFor(a)},check:function(a){a=this.clean(a);if(this.checkable(a))a=this.findByName(a.name).not(this.settings.ignore)[0];var b=c(a).rules(),d=false,e;for(e in b){var f={method:e,parameters:b[e]};try{var g=
c.validator.methods[e].call(this,a.value.replace(/\r/g,""),a,f.parameters);if(g=="dependency-mismatch")d=true;else{d=false;if(g=="pending"){this.toHide=this.toHide.not(this.errorsFor(a));return}if(!g){this.formatAndAdd(a,f);return false}}}catch(h){this.settings.debug&&window.console&&console.log("exception occured when checking element "+a.id+", check the '"+f.method+"' method",h);throw h;}}if(!d){this.objectLength(b)&&this.successList.push(a);return true}},customMetaMessage:function(a,b){if(c.metadata){var d=
this.settings.meta?c(a).metadata()[this.settings.meta]:c(a).metadata();return d&&d.messages&&d.messages[b]}},customMessage:function(a,b){var d=this.settings.messages[a];return d&&(d.constructor==String?d:d[b])},findDefined:function(){for(var a=0;a<arguments.length;a++)if(arguments[a]!==undefined)return arguments[a]},defaultMessage:function(a,b){return this.findDefined(this.customMessage(a.name,b),this.customMetaMessage(a,b),!this.settings.ignoreTitle&&a.title||undefined,c.validator.messages[b],"<strong>Warning: No message defined for "+
a.name+"</strong>")},formatAndAdd:function(a,b){var d=this.defaultMessage(a,b.method),e=/\$?\{(\d+)\}/g;if(typeof d=="function")d=d.call(this,b.parameters,a);else if(e.test(d))d=jQuery.format(d.replace(e,"{$1}"),b.parameters);this.errorList.push({message:d,element:a});this.errorMap[a.name]=d;this.submitted[a.name]=d},addWrapper:function(a){if(this.settings.wrapper)a=a.add(a.parent(this.settings.wrapper));return a},defaultShowErrors:function(){for(var a=0;this.errorList[a];a++){var b=this.errorList[a];
this.settings.highlight&&this.settings.highlight.call(this,b.element,this.settings.errorClass,this.settings.validClass);this.showLabel(b.element,b.message)}if(this.errorList.length)this.toShow=this.toShow.add(this.containers);if(this.settings.success)for(a=0;this.successList[a];a++)this.showLabel(this.successList[a]);if(this.settings.unhighlight){a=0;for(b=this.validElements();b[a];a++)this.settings.unhighlight.call(this,b[a],this.settings.errorClass,this.settings.validClass)}this.toHide=this.toHide.not(this.toShow);
this.hideErrors();this.addWrapper(this.toShow).show()},validElements:function(){return this.currentElements.not(this.invalidElements())},invalidElements:function(){return c(this.errorList).map(function(){return this.element})},showLabel:function(a,b){var d=this.errorsFor(a);if(d.length){d.removeClass().addClass(this.settings.errorClass);d.attr("generated")&&d.html(b)}else{d=c("<"+this.settings.errorElement+"/>").attr({"for":this.idOrName(a),generated:true}).addClass(this.settings.errorClass).html(b||
"");if(this.settings.wrapper)d=d.hide().show().wrap("<"+this.settings.wrapper+"/>").parent();this.labelContainer.append(d).length||(this.settings.errorPlacement?this.settings.errorPlacement(d,c(a)):d.insertAfter(a))}if(!b&&this.settings.success){d.text("");typeof this.settings.success=="string"?d.addClass(this.settings.success):this.settings.success(d)}this.toShow=this.toShow.add(d)},errorsFor:function(a){var b=this.idOrName(a);return this.errors().filter(function(){return c(this).attr("for")==b})},
idOrName:function(a){return this.groups[a.name]||(this.checkable(a)?a.name:a.id||a.name)},checkable:function(a){return/radio|checkbox/i.test(a.type)},findByName:function(a){var b=this.currentForm;return c(document.getElementsByName(a)).map(function(d,e){return e.form==b&&e.name==a&&e||null})},getLength:function(a,b){switch(b.nodeName.toLowerCase()){case "select":return c("option:selected",b).length;case "input":if(this.checkable(b))return this.findByName(b.name).filter(":checked").length}return a.length},
depend:function(a,b){return this.dependTypes[typeof a]?this.dependTypes[typeof a](a,b):true},dependTypes:{"boolean":function(a){return a},string:function(a,b){return!!c(a,b.form).length},"function":function(a,b){return a(b)}},optional:function(a){return!c.validator.methods.required.call(this,c.trim(a.value),a)&&"dependency-mismatch"},startRequest:function(a){if(!this.pending[a.name]){this.pendingRequest++;this.pending[a.name]=true}},stopRequest:function(a,b){this.pendingRequest--;if(this.pendingRequest<
0)this.pendingRequest=0;delete this.pending[a.name];if(b&&this.pendingRequest==0&&this.formSubmitted&&this.form()){c(this.currentForm).submit();this.formSubmitted=false}else if(!b&&this.pendingRequest==0&&this.formSubmitted){c(this.currentForm).triggerHandler("invalid-form",[this]);this.formSubmitted=false}},previousValue:function(a){return c.data(a,"previousValue")||c.data(a,"previousValue",{old:null,valid:true,message:this.defaultMessage(a,"remote")})}},classRuleSettings:{required:{required:true},
email:{email:true},url:{url:true},date:{date:true},dateISO:{dateISO:true},dateDE:{dateDE:true},number:{number:true},numberDE:{numberDE:true},digits:{digits:true},creditcard:{creditcard:true}},addClassRules:function(a,b){a.constructor==String?this.classRuleSettings[a]=b:c.extend(this.classRuleSettings,a)},classRules:function(a){var b={};(a=c(a).attr("class"))&&c.each(a.split(" "),function(){this in c.validator.classRuleSettings&&c.extend(b,c.validator.classRuleSettings[this])});return b},attributeRules:function(a){var b=
{};a=c(a);for(var d in c.validator.methods){var e=a.attr(d);if(e)b[d]=e}b.maxlength&&/-1|2147483647|524288/.test(b.maxlength)&&delete b.maxlength;return b},metadataRules:function(a){if(!c.metadata)return{};var b=c.data(a.form,"validator").settings.meta;return b?c(a).metadata()[b]:c(a).metadata()},staticRules:function(a){var b={},d=c.data(a.form,"validator");if(d.settings.rules)b=c.validator.normalizeRule(d.settings.rules[a.name])||{};return b},normalizeRules:function(a,b){c.each(a,function(d,e){if(e===
false)delete a[d];else if(e.param||e.depends){var f=true;switch(typeof e.depends){case "string":f=!!c(e.depends,b.form).length;break;case "function":f=e.depends.call(b,b)}if(f)a[d]=e.param!==undefined?e.param:true;else delete a[d]}});c.each(a,function(d,e){a[d]=c.isFunction(e)?e(b):e});c.each(["minlength","maxlength","min","max"],function(){if(a[this])a[this]=Number(a[this])});c.each(["rangelength","range"],function(){if(a[this])a[this]=[Number(a[this][0]),Number(a[this][1])]});if(c.validator.autoCreateRanges){if(a.min&&
a.max){a.range=[a.min,a.max];delete a.min;delete a.max}if(a.minlength&&a.maxlength){a.rangelength=[a.minlength,a.maxlength];delete a.minlength;delete a.maxlength}}a.messages&&delete a.messages;return a},normalizeRule:function(a){if(typeof a=="string"){var b={};c.each(a.split(/\s/),function(){b[this]=true});a=b}return a},addMethod:function(a,b,d){c.validator.methods[a]=b;c.validator.messages[a]=d!=undefined?d:c.validator.messages[a];b.length<3&&c.validator.addClassRules(a,c.validator.normalizeRule(a))},
methods:{required:function(a,b,d){if(!this.depend(d,b))return"dependency-mismatch";switch(b.nodeName.toLowerCase()){case "select":return(a=c(b).val())&&a.length>0;case "input":if(this.checkable(b))return this.getLength(a,b)>0;default:return c.trim(a).length>0}},remote:function(a,b,d){if(this.optional(b))return"dependency-mismatch";var e=this.previousValue(b);this.settings.messages[b.name]||(this.settings.messages[b.name]={});e.originalMessage=this.settings.messages[b.name].remote;this.settings.messages[b.name].remote=
e.message;d=typeof d=="string"&&{url:d}||d;if(this.pending[b.name])return"pending";if(e.old===a)return e.valid;e.old=a;var f=this;this.startRequest(b);var g={};g[b.name]=a;c.ajax(c.extend(true,{url:d,mode:"abort",port:"validate"+b.name,dataType:"json",data:g,success:function(h){f.settings.messages[b.name].remote=e.originalMessage;var j=h===true;if(j){var i=f.formSubmitted;f.prepareElement(b);f.formSubmitted=i;f.successList.push(b);f.showErrors()}else{i={};h=h||f.defaultMessage(b,"remote");i[b.name]=
e.message=c.isFunction(h)?h(a):h;f.showErrors(i)}e.valid=j;f.stopRequest(b,j)}},d));return"pending"},minlength:function(a,b,d){return this.optional(b)||this.getLength(c.trim(a),b)>=d},maxlength:function(a,b,d){return this.optional(b)||this.getLength(c.trim(a),b)<=d},rangelength:function(a,b,d){a=this.getLength(c.trim(a),b);return this.optional(b)||a>=d[0]&&a<=d[1]},min:function(a,b,d){return this.optional(b)||a>=d},max:function(a,b,d){return this.optional(b)||a<=d},range:function(a,b,d){return this.optional(b)||
a>=d[0]&&a<=d[1]},email:function(a,b){return this.optional(b)||/^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i.test(a)},
url:function(a,b){return this.optional(b)||/^(https?|ftp):\/\/(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(\#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/i.test(a)},
date:function(a,b){return this.optional(b)||!/Invalid|NaN/.test(new Date(a))},dateISO:function(a,b){return this.optional(b)||/^\d{4}[\/-]\d{1,2}[\/-]\d{1,2}$/.test(a)},number:function(a,b){return this.optional(b)||/^-?(?:\d+|\d{1,3}(?:,\d{3})+)(?:\.\d+)?$/.test(a)},digits:function(a,b){return this.optional(b)||/^\d+$/.test(a)},creditcard:function(a,b){if(this.optional(b))return"dependency-mismatch";if(/[^0-9-]+/.test(a))return false;var d=0,e=0,f=false;a=a.replace(/\D/g,"");for(var g=a.length-1;g>=
0;g--){e=a.charAt(g);e=parseInt(e,10);if(f)if((e*=2)>9)e-=9;d+=e;f=!f}return d%10==0},accept:function(a,b,d){d=typeof d=="string"?d.replace(/,/g,"|"):"png|jpe?g|gif";return this.optional(b)||a.match(RegExp(".("+d+")$","i"))},equalTo:function(a,b,d){d=c(d).unbind(".validate-equalTo").bind("blur.validate-equalTo",function(){c(b).valid()});return a==d.val()}}});c.format=c.validator.format})(jQuery);
(function(c){var a={};if(c.ajaxPrefilter)c.ajaxPrefilter(function(d,e,f){e=d.port;if(d.mode=="abort"){a[e]&&a[e].abort();a[e]=f}});else{var b=c.ajax;c.ajax=function(d){var e=("port"in d?d:c.ajaxSettings).port;if(("mode"in d?d:c.ajaxSettings).mode=="abort"){a[e]&&a[e].abort();return a[e]=b.apply(this,arguments)}return b.apply(this,arguments)}}})(jQuery);
(function(c){!jQuery.event.special.focusin&&!jQuery.event.special.focusout&&document.addEventListener&&c.each({focus:"focusin",blur:"focusout"},function(a,b){function d(e){e=c.event.fix(e);e.type=b;return c.event.handle.call(this,e)}c.event.special[b]={setup:function(){this.addEventListener(a,d,true)},teardown:function(){this.removeEventListener(a,d,true)},handler:function(e){arguments[0]=c.event.fix(e);arguments[0].type=b;return c.event.handle.apply(this,arguments)}}});c.extend(c.fn,{validateDelegate:function(a,
b,d){return this.bind(b,function(e){var f=c(e.target);if(f.is(a))return d.apply(f,arguments)})}})})(jQuery);


(function(h,f){"object"===typeof exports?f(exports):"function"===typeof define&&define.amd?define(["exports"],f):f(h)})(this,function(h){function f(a){this._targetElement=a;this._options={nextLabel:"Next &rarr;",prevLabel:"&larr; Back",skipLabel:"Skip",doneLabel:"Done",tooltipPosition:"bottom",tooltipClass:"",exitOnEsc:!0,exitOnOverlayClick:!0,showStepNumbers:!0}}function n(){"undefined"!==typeof this._introBeforeChangeCallback&&this._introBeforeChangeCallback.call(this,this._targetElement.element);
"undefined"===typeof this._currentStep?this._currentStep=0:++this._currentStep;this._introItems.length<=this._currentStep?("function"===typeof this._introCompleteCallback&&this._introCompleteCallback.call(this),m.call(this,this._targetElement)):s.call(this,this._introItems[this._currentStep])}function t(){if(0===this._currentStep)return!1;"undefined"!==typeof this._introBeforeChangeCallback&&this._introBeforeChangeCallback.call(this,this._targetElement.element);s.call(this,this._introItems[--this._currentStep])}
function m(a){var b=a.querySelector(".introjs-overlay");b.style.opacity=0;setTimeout(function(){b.parentNode&&b.parentNode.removeChild(b)},500);(a=a.querySelector(".introjs-helperLayer"))&&a.parentNode.removeChild(a);if(a=document.querySelector(".introjs-showElement"))a.className=a.className.replace(/introjs-[a-zA-Z]+/g,"").replace(/^\s+|\s+$/g,"");if((a=document.querySelectorAll(".introjs-fixParent"))&&0<a.length)for(var c=a.length-1;0<=c;c--)a[c].className=a[c].className.replace(/introjs-fixParent/g,
"").replace(/^\s+|\s+$/g,"");window.removeEventListener?window.removeEventListener("keydown",this._onKeyDown,!0):document.detachEvent&&document.detachEvent("onkeydown",this._onKeyDown);this._currentStep=void 0}function u(a,b,c){b.style.top=null;b.style.right=null;b.style.bottom=null;b.style.left=null;if(this._introItems[this._currentStep]){var d="",d=this._introItems[this._currentStep],d="string"===typeof d.tooltipClass?d.tooltipClass:this._options.tooltipClass;b.className=("introjs-tooltip "+d).replace(/^\s+|\s+$/g,
"");switch(this._introItems[this._currentStep].position){case "top":b.style.left="15px";b.style.top="-"+(l(b).height+10)+"px";c.className="introjs-arrow bottom";break;case "right":b.style.left=l(a).width+20+"px";c.className="introjs-arrow left";break;case "left":b.style.top="15px";b.style.right=l(a).width+20+"px";c.className="introjs-arrow right";break;default:b.style.bottom="-"+(l(b).height+10)+"px",c.className="introjs-arrow top"}}}function p(a){if(a&&this._introItems[this._currentStep]){var b=
l(this._introItems[this._currentStep].element);a.setAttribute("style","width: "+(b.width+10)+"px; height:"+(b.height+10)+"px; top:"+(b.top-5)+"px;left: "+(b.left-5)+"px;")}}function s(a){var b;"undefined"!==typeof this._introChangeCallback&&this._introChangeCallback.call(this,a.element);var c=this,d=document.querySelector(".introjs-helperLayer");l(a.element);if(null!=d){var g=d.querySelector(".introjs-helperNumberLayer"),f=d.querySelector(".introjs-tooltiptext"),w=d.querySelector(".introjs-arrow"),
q=d.querySelector(".introjs-tooltip"),e=d.querySelector(".introjs-skipbutton");b=d.querySelector(".introjs-prevbutton");var j=d.querySelector(".introjs-nextbutton");q.style.opacity=0;p.call(c,d);if((d=document.querySelectorAll(".introjs-fixParent"))&&0<d.length)for(var k=d.length-1;0<=k;k--)d[k].className=d[k].className.replace(/introjs-fixParent/g,"").replace(/^\s+|\s+$/g,"");d=document.querySelector(".introjs-showElement");d.className=d.className.replace(/introjs-[a-zA-Z]+/g,"").replace(/^\s+|\s+$/g,
"");c._lastShowElementTimer&&clearTimeout(c._lastShowElementTimer);c._lastShowElementTimer=setTimeout(function(){null!=g&&(g.innerHTML=a.step);f.innerHTML=a.intro;u.call(c,a.element,q,w);q.style.opacity=1},350)}else{e=document.createElement("div");d=document.createElement("div");k=document.createElement("div");e.className="introjs-helperLayer";p.call(c,e);this._targetElement.appendChild(e);d.className="introjs-arrow";k.innerHTML='<div class="introjs-tooltiptext">'+a.intro+'</div><div class="introjs-tooltipbuttons"></div>';
this._options.showStepNumbers&&(b=document.createElement("span"),b.className="introjs-helperNumberLayer",b.innerHTML=a.step,e.appendChild(b));k.appendChild(d);e.appendChild(k);j=document.createElement("a");j.onclick=function(){c._introItems.length-1!=c._currentStep&&n.call(c)};j.href="javascript:void(0);";j.innerHTML=this._options.nextLabel;b=document.createElement("a");b.onclick=function(){0!=c._currentStep&&t.call(c)};b.href="javascript:void(0);";b.innerHTML=this._options.prevLabel;e=document.createElement("a");
e.className="introjs-button introjs-skipbutton";e.href="javascript:void(0);";e.innerHTML=this._options.skipLabel;e.onclick=function(){c._introItems.length-1==c._currentStep&&"function"===typeof c._introCompleteCallback&&c._introCompleteCallback.call(c);c._introItems.length-1!=c._currentStep&&"function"===typeof c._introExitCallback&&c._introExitCallback.call(c);m.call(c,c._targetElement)};var h=k.querySelector(".introjs-tooltipbuttons");h.appendChild(e);1<this._introItems.length&&(h.appendChild(b),
h.appendChild(j));u.call(c,a.element,k,d)}0==this._currentStep?(b.className="introjs-button introjs-prevbutton introjs-disabled",j.className="introjs-button introjs-nextbutton",e.innerHTML=this._options.skipLabel):this._introItems.length-1==this._currentStep?(e.innerHTML=this._options.doneLabel,b.className="introjs-button introjs-prevbutton",j.className="introjs-button introjs-nextbutton introjs-disabled"):(b.className="introjs-button introjs-prevbutton",j.className="introjs-button introjs-nextbutton",
e.innerHTML=this._options.skipLabel);j.focus();a.element.className+=" introjs-showElement";e=v(a.element,"position");"absolute"!==e&&"relative"!==e&&(a.element.className+=" introjs-relativePosition");for(e=a.element.parentNode;null!=e&&"body"!==e.tagName.toLowerCase();)b=v(e,"z-index"),/[0-9]+/.test(b)&&(e.className+=" introjs-fixParent"),e=e.parentNode;e=a.element.getBoundingClientRect();0<=e.top&&0<=e.left&&e.bottom+80<=window.innerHeight&&e.right<=window.innerWidth||(b=a.element.getBoundingClientRect(),
e=b.bottom-(b.bottom-b.top),j=b.bottom,b=void 0!=window.innerWidth?window.innerHeight:document.documentElement.clientHeight,b=j-b,0>e?window.scrollBy(0,e-30):window.scrollBy(0,b+100))}function v(a,b){var c="";a.currentStyle?c=a.currentStyle[b]:document.defaultView&&document.defaultView.getComputedStyle&&(c=document.defaultView.getComputedStyle(a,null).getPropertyValue(b));return c&&c.toLowerCase?c.toLowerCase():c}function x(a){var b=document.createElement("div"),c="",d=this;b.className="introjs-overlay";
if("body"===a.tagName.toLowerCase())c+="top: 0;bottom: 0; left: 0;right: 0;position: fixed;",b.setAttribute("style",c);else{var g=l(a);g&&(c+="width: "+g.width+"px; height:"+g.height+"px; top:"+g.top+"px;left: "+g.left+"px;",b.setAttribute("style",c))}a.appendChild(b);b.onclick=function(){!0==d._options.exitOnOverlayClick&&m.call(d,a);void 0!=d._introExitCallback&&d._introExitCallback.call(d)};setTimeout(function(){c+="opacity: .8;";b.setAttribute("style",c)},10);return!0}function l(a){var b={};b.width=
a.offsetWidth;b.height=a.offsetHeight;for(var c=0,d=0;a&&!isNaN(a.offsetLeft)&&!isNaN(a.offsetTop);)c+=a.offsetLeft,d+=a.offsetTop,a=a.offsetParent;b.top=d;b.left=c;return b}var r=function(a){if("object"===typeof a)return new f(a);if("string"===typeof a){if(a=document.querySelector(a))return new f(a);throw Error("There is no element with given selector.");}return new f(document.body)};r.version="0.5.0";r.fn=f.prototype={clone:function(){return new f(this)},setOption:function(a,b){this._options[a]=
b;return this},setOptions:function(a){var b=this._options,c={},d;for(d in b)c[d]=b[d];for(d in a)c[d]=a[d];this._options=c;return this},start:function(){a:{var a=this._targetElement,b=[],c=this;if(this._options.steps)for(var d=[],g=0,d=this._options.steps.length;g<d;g++){var f=this._options.steps[g];f.step=g+1;"string"===typeof f.element&&(f.element=document.querySelector(f.element));b.push(f)}else{d=a.querySelectorAll("*[data-intro]");if(1>d.length)break a;g=0;for(f=d.length;g<f;g++){var h=d[g];
b.push({element:h,intro:h.getAttribute("data-intro"),step:parseInt(h.getAttribute("data-step"),10),tooltipClass:h.getAttribute("data-tooltipClass"),position:h.getAttribute("data-position")||this._options.tooltipPosition})}}b.sort(function(a,c){return a.step-c.step});c._introItems=b;x.call(c,a)&&(n.call(c),a.querySelector(".introjs-skipbutton"),a.querySelector(".introjs-nextbutton"),c._onKeyDown=function(b){if(27===b.keyCode&&!0==c._options.exitOnEsc)m.call(c,a),void 0!=c._introExitCallback&&c._introExitCallback.call(c);
else if(37===b.keyCode)t.call(c);else if(39===b.keyCode||13===b.keyCode)n.call(c),b.preventDefault?b.preventDefault():b.returnValue=!1},c._onResize=function(){p.call(c,document.querySelector(".introjs-helperLayer"))},window.addEventListener?(window.addEventListener("keydown",c._onKeyDown,!0),window.addEventListener("resize",c._onResize,!0)):document.attachEvent&&(document.attachEvent("onkeydown",c._onKeyDown),document.attachEvent("onresize",c._onResize)))}return this},goToStep:function(a){this._currentStep=
a-2;"undefined"!==typeof this._introItems&&n.call(this);return this},exit:function(){m.call(this,this._targetElement)},refresh:function(){p.call(this,document.querySelector(".introjs-helperLayer"));return this},onbeforechange:function(a){if("function"===typeof a)this._introBeforeChangeCallback=a;else throw Error("Provided callback for onbeforechange was not a function");return this},onchange:function(a){if("function"===typeof a)this._introChangeCallback=a;else throw Error("Provided callback for onchange was not a function.");
return this},oncomplete:function(a){if("function"===typeof a)this._introCompleteCallback=a;else throw Error("Provided callback for oncomplete was not a function.");return this},onexit:function(a){if("function"===typeof a)this._introExitCallback=a;else throw Error("Provided callback for onexit was not a function.");return this}};return h.introJs=r});


$(document).ready(function() {

/*Check logout message*/
var logout_message = document.getElementById("logout_message");
var logout_message_value = logout_message.getAttribute("value");

var is_usermobile = document.getElementById("is_usermobile");
var is_usermobile_value = is_usermobile.getAttribute("value");
if(logout_message_value=="1"&&is_usermobile_value=='0'){
  /*Fade out after 5 secs*/
    $('#toast_message_logout').fadeIn('slow').delay(7500).fadeOut('slow');
}

$("#tooltrigger").click(function(){
  //introJs().goToStep(1).start();
  introJs().start();
});


$('a.login-window').click(function(event) {
    
            //Getting the variable's value from a link 
    //var loginBox = $(this).attr('href');
    var loginBox = "#login-box";
    //Fade in the Popup
    $(loginBox).fadeIn(300);
    
    //Set the center alignment padding + border see css style
    var popMargTop = ($(loginBox).height() + 24) / 2; 
    var popMargLeft = ($(loginBox).width() + 24) / 2; 
    
    $(loginBox).css({ 
        'margin-top' : -popMargTop,
        'margin-left' : -popMargLeft
    });
    
    // Add the mask to body
    
    $('#mask').fadeIn(300);

    event.preventDefault();  

    $("a.login-window").click( function() {
       return false;    
    });
});



// When clicking on the button close or the mask layer the popup closed

var htmlclass=$('html').attr('class');


$('#mask').click(function(){
  if($(".article_print").length>0){
      
    if(htmlclass.indexOf("ie")>0){
      ie_version=htmlclass.substring(htmlclass.lastIndexOf("ie"),htmlclass.lastIndexOf("ie")+3);
      
       if(!ie_version==""){
        $('html').addClass(ie_version);
        }
    }


      $(".article_print").remove();
      $("#print-pre").remove();
      $(".article").find( "*" ).removeClass("non_print");
      
  }
    $('.login-popup').fadeOut(300);
    $('.article_print').fadeOut(300);
    $('#mask').fadeOut(300);
});

$('#close_button').click(function(){
    $('.login-popup').fadeOut(300);
    $('#mask').fadeOut(300);
});


//AJAX PART TO CHECK THE USER

$('#login_form_submit').click( function() {

    $("#login_form").submit( function() {

        $("#mask").unbind("click");

 //      return false;    
    });
 
});




/*To Make sure the Sign in form is in the center of the window*/

$(window).resize(function(){
    
    var loginBox = "#login-box";

    //Set the center alignment padding + border see css style
    var popMargTop = ($(loginBox).height() + 24) / 2; 
    var popMargLeft = ($(loginBox).width() + 24) / 2; 
    
    $(loginBox).css({ 
        'margin-top' : -popMargTop,
        'margin-left' : -popMargLeft
    }); 

  });


/*Show the Category in Newsletter page*/




$('.daily').change(function() {
    var $check = $(this);
    if ($check.prop('checked')) {
      $('.daily_choose').attr("disabled",false);
        $('.daily_choose option[value=full]').prop('selected', 'selected');
    } else {
      $('.daily_choose').attr("disabled",true);
      $('.daily_choose option[value=""]').prop('selected', 'selected');
      $('.daily_choose').change();
    }

});


$('.weekly').change(function() {
    var $check = $(this);
    if ($check.prop('checked')) {
      $('.weekly_choose').attr("disabled",false);
        $('.weekly_choose option[value=full]').prop('selected', 'selected');
    } else {
      $('.weekly_choose').attr("disabled",true);
      $('.weekly_choose option[value=""]').prop('selected', 'selected');
      $('.weekly_choose').change();
    }

});


$('.daily_choose').change(function(){
    var select_value=$('.daily_choose').val();
    var category=$('#daily_cat');
    if(select_value=='select'){
      category.show();
    }else{
      category.hide();
      $("#daily_cat").find($(":checkbox")).each(function()
        {
          $(this).prop('checked',false);
        });
    }
});


$('.weekly_choose').change(function(){
    var select_value=$('.weekly_choose').val();
    var category=$('#weekly_cat');
    if(select_value=='select'){
      category.show();
    }else{
      category.hide();
      $("#weekly_cat").find($(":checkbox")).each(function()
        {
          $(this).prop('checked',false);
        });
    }
});


$('input[name=newsfeedtype]').click(function(){
  var item=$('input[name=newsfeedtype]:checked').val();
  var category=$('#newsfeed_cat');
    if(item=='customised'){
      category.show();
    }else{
      category.hide();
      $("#newsfeed_cat").find($(":checkbox")).each(function()
        {
          $(this).prop('checked',false);
        });
    }
});




$("#btn_tickall_daily").click(function()       
      {
        var checked_status = this.checked;
        $("#daily_cat").find($(":checkbox")).each(function()
        {
          
          $(this).prop('checked',true);
        });
      });         



$('#btn_untick_daily').click(function(){
      $("#daily_cat").find($(":checkbox")).each(function()
      {
        $(this).prop('checked',false);
    });
});


$("#btn_tickall_weekly").click(function()       
      {
        var checked_status = this.checked;
        $("#weekly_cat").find($(":checkbox")).each(function()
        {
          $(this).prop('checked',true);
        });
      });         



$('#btn_untick_weekly').click(function(){
      $("#weekly_cat").find($(":checkbox")).each(function()
      {
        $(this).prop('checked',false);
    });
});



});



// slidebox content

$(function() {
	
	if($("#slidebox").length>0){
		
	$(window).scroll(function(){
		/* when reaching an element with id "slidebox_trigger" we want to show the slidebox. Let's get the distance from the top to the element */
		var distanceTop = $('#slidebox_trigger').offset().top - $(window).height();
		
		if  ($(window).scrollTop() > distanceTop)
			$('#slidebox_container').animate({'right':'20px'},1200);
		else 
			$('#slidebox_container').stop(true).animate({'right':'-9999px'},300);	
	});
	
	/* remove the slidebox when clicking the cross */
	$('#slidebox .close').bind('click',function(){
		$('#slidebox_container').remove();
	});


	}

});