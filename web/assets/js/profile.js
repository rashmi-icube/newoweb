$(document).ready(function() {
    $('#mobileSettings').addClass('current');
            
    $('input[type=file]').change(function() {
        $('.image-size-warning').hide();
        if(allowImageFormat('prof_img', false)) {
            uploadImage(); 
        } 
    });

	$('.personal-details-list #editPersonalDetails').on('click', function() {
		var no = $('.personal-details-list .personal-cell-no').text();
		$('.personal-details-list .personal-cell-no').hide();
		$('.personal-details-list .personal-cell-no + input').val(no).show().focus();
		$('.personal-details-list .edit-actions').css('visibility', 'visible');
	});
    
    $('.personal-details-box input[type="tel"], .mobile-contact-info-box input[type="tel"]').on('keypress', function(event) {
        // Allow only backspace, delete, enter and plus sign
        if (event.keyCode === 46 || event.keyCode === 8 || event.keyCode === 13 || event.keyCode === 43) {
        }
        else {
            // Ensure that it is a number and stop the keypress
            if (event.keyCode < 48 || event.keyCode > 57) {
                event.preventDefault(); 
            }   
        }
    });

	$('#cancelEdit').on('click', function() {
		$('.personal-cell-no + input').hide();
		$('.personal-cell-no').show();
		$('.edit-actions').removeAttr('style');
	});

	$('#saveEdit').on('click', function() {
		var no = $('.personal-cell-no + input').val();
        var postData = {'type':'odetails','phone':no};
        $.ajax({
           type: "POST",
            url: "/individual/updatedetails.jsp",
            data: postData,
            success: function(resp){
                if(resp.status === "1") {
                    location.reload();
                }
            },
            dataType: 'JSON'
        });
	});

	$('#changePassword').on('click', function() {
		$('.block_page').fadeIn();
		$('.modal_box input').val('');
        $('.modal_box .meter').removeAttr('style');
		$('body').css('overflow', 'hidden');
        $('.invalid-current').hide();
	});	

    function check_pass(obj, meter) {
        var val = $(obj).val();
        var no=0;
        if(val !== "") {
            // If the password length is less than or equal to 8
            if(val.length <= 8) {
                no = 1;
            }   
            // If the password length is greater than 8 and contains any lowercase alphabet or number or special character
            if(val.length>8 && val.match(/\d+/) && (val.match(/[a-z]/) || val.match(/.[!,@,#,$,%,^,&,*,?,_,~,-,(,)]/))) {
                no = 2;
            }    
            // If the password length is greater than 8 and contains alphabets, numbers and special characters
            if(val.length>6 && val.match(/[a-z]/) && val.match(/[A-Z]/) && val.match(/\d+/) && val.match(/[!,@,#,$,%,^,&,*,?,_,~,-,(,)]/)) {
                no = 3;
            }

            if(no === 1) {
              $(meter).animate({width:'25px'}, 300);
              $(meter).css('background-color', 'rgba(255, 0, 0, 0.5)');
            }
            if(no === 2) {
              $(meter).animate({width:'50px'}, 300);
              $(meter).css('background-color', '#ff9');
            }
            if(no === 3) {
              $(meter).animate({width:'75px'}, 300);
              $(meter).css('background-color', 'rgba(76, 175, 80, 0.5)');
            }
        }
        else {
            $(meter).css({width:'0'});
            $(meter).css('background-color', '#f2f2f2');
        }
    }
    
    $('#newPassword').keyup(function(){
        var bar = $(this).parents('table').find('.meter');
        check_pass($(this), bar);
    });

	$('#cancelPassword').on('click', function() {
		$('.block_page').fadeOut();	
		$('body').removeAttr('style');
	});

	$('#savePassword').on('click', function() {
        $('.invalid-current').hide();        
        var currentPassword = $('#currentPassword').val();
        var newPassword = $('#newPassword').val();
        var confirmPassword = $('#confirmPassword').val();
            
        if(newPassword === currentPassword) {
            // $('#newPassword')[0].setCustomValidity("New password can't be same as current password!");
            return 0;
        } 
        if(newPassword.length < 8) {
            return 0;
        } 
        if(newPassword.search(/\d/) === -1) {
            return 0;
        } 
        
        if(currentPassword.length > 0 && newPassword.length > 0 && confirmPassword.length > 0) {
            if(newPassword === confirmPassword) {
                event.preventDefault();
                var postData = {
                    'type': 'cpass',
                    'oldpass': currentPassword,
                    'newpass': newPassword,
                    'newConfirmpass': confirmPassword
                };
                $.ajax({
                    type: "POST",
                    url: "/individual/updatedetails.jsp",
                    data: postData,
                    dataType: 'JSON',
                    success: function (resp) {
                        if (resp.status == "1") {
                            $('.password-change-successful').show();
                            setTimeout(function () {
                                window.location.href = "../signout.jsp";
                            }, 3000);

                        } else {
                            $('.invalid-current').show().css('display', 'block');
                        }
                    }
                });
            } else {
                $('#confirmPassword')[0].setCustomValidity("Passwords don't match!");
            }
        }
	});

	$('.header button').on('click', function() {
        $(this).parent().next().find('.to-add-item').find('#currentJob').prop('checked', false);
        $(this).parent().next().find('.to-add-item').find('.current-job-present').remove().end().find('#wToDt').show().prop('required', true);
		$(this).parent().next().find('.to-add-item').find('input').val('').end().slideDown();
		$(this).parent().next().find('.to-add-item .org-start-date').removeAttr('max').datepicker('option', {maxDate: 0});
		$(this).parent().next().find('.to-add-item .org-end-date').removeAttr('min').datepicker('option', {maxDate: 0});
		$(this).parent().next().find('.to-add-item select').val('');
	});

	$('.cancelAdd').on('click', function() {
		$(this).parents('.to-add-item').slideUp();
        $(this).parents('.to-add-item').find('.k-invalid-msg').remove();
	});

	$('.saveAdd').on('click', function() {
		var src = $(this).parents('.to-add-item');
		if($(src).find('form')[0].checkValidity()) {
			event.preventDefault();
			var flag = $(this).closest('.experience-list').length || $(this).closest('.education-list').length;			
			if(flag) {
                if($(this).attr('id') === 'wSaveAdd') {
                    addWorkplace();
                } else {
                    addEducation();
                }
			} else {
                addLanguage($(src).find('select').val());
			}			
			$(src).hide();
		}
	});

	$('.org-start-date').on('change', function() {
		var start = $(this).val();
		$(this).siblings('input').prop('min', start);
	});
	$('.org-end-date').on('change', function() {
		var end = $(this).val();
		$(this).siblings('input').prop('max', end);
	});
    
    $('#currentJob').on('change', function() {
        if(this.checked) {
            $('#wToDt').hide().removeAttr('required').val('');
            $('#wToDt').before('<span class="current-job-present">Present</span>');
            $('#wToDt').next('span').remove();
        } else {
            $('.current-job-present').remove();
            $('#wToDt').show().prop('required', true);
        }
    });
    
    // Remove previously added languages from the add language list
    $('#addOneLanguage').on('click', function() {
        var lang = [];
        $('.language-list .list-item').each(function() {
            lang.push($(this).find('.item-title').text());
        });
        for(var i=0; i<lang.length; i++) {
            $(this).find('option').filter(function() {
                if($(this).text() === lang[i]) {
                   $(this).hide();
                } else {
                    $(this).removeAttr('style');
                }
            });
        }
    });
    
	if (document.documentElement.clientWidth <= 480) {
        replaceButtonMobile();
        
        $('#goToSettings').on('click', function() {
            $('.settings-sign-page').show('slide', {direction: 'left'}, 400);
            var marginLeft = $('.settings-sign-page div:first').offset().left;
            $('.settings-sign-page div:nth-child(3) a').offset({left: marginLeft});
            $(window).on('touchmove', function(e) {
                e.preventDefault();
                e.stopPropagation();
            }, false);
        });  

        $('#goToProfile').on('click', function() {
            $('.mobile-page-title .settings-page').show();
            $('.mobile-page-title .password-page').hide();
            $('body').removeAttr('style');
            $('#changePasswordMobile+form').animate({ left: '100%' }, '400', function() {
                $(this).hide();
            });
        });
        
		$('.mobile-contact-info-box #editPersonalDetails').on('click', function() {
			var no = $('.mobile-contact-info-box .personal-cell-no').text();
			$('.mobile-contact-info-box .personal-cell-no').hide();
			$('.mobile-contact-info-box .personal-cell-no + input').val(no).show().focus();
			$('.mobile-contact-info-box .edit-actions').css('visibility', 'visible');
		});

		$('#cancelEditMobile').on('click', function() {
			$('.mobile-contact-info-box .personal-cell-no + input').hide();
			$('.mobile-contact-info-box .personal-cell-no').show();
			$('.mobile-contact-info-box .edit-actions').removeAttr('style');
		});

		$('#saveEditMobile').on('click', function() {
			var no = $('.mobile-contact-info-box .personal-cell-no + input').val();
            var postData = {'type':'odetails','phone':no};
            $.ajax({
               type: "POST",
                url: "/individual/updatedetails.jsp",
                data: postData,
                dataType: 'JSON',
                success: function(resp){
                    if(resp.status === "1") {
                        location.reload();
                    }
                }
            });
		});

        $('#changePasswordMobile').on('click', function() {
            $('.mobile-page-title .settings-page').hide();
            $('.mobile-page-title .password-page').show();
            $('body').css('overflow', 'hidden');
            $(this).next('form').show().animate({ left: '0' }, '400');
            $(this).next('form').on('touchmove', function(e) {
                e.preventDefault();
            });
            $(this).next('form').find('input').val('');
            $(this).next('form').find('.meter').removeAttr('style');
        });
        
        $('input[type=password]').on('click', function(){
            $('#changePasswordMobile').next('form').css('height','110vh');
        });

        $('#newPwd').keyup(function(){
            var bar = $(this).next().find('.meter');
            check_pass($(this), bar);
        });

        $('#cancelPwd').on('click', function() {
            $('.mobile-page-title .settings-page').show();
            $('.mobile-page-title .password-page').hide();
            $('body').removeAttr('style');
            $(this).closest('form').animate({ left: '100%' }, '400', function() {
                $(this).hide();
            });
        });

        $('#savePwd').on('click', function() {
            $('.mobile-contact-info-box .invalid-current').hide();
            var currentPassword = $('#currentPwd').val();
            var newPassword = $('#newPwd').val();
            var confirmPassword = $('#confirmPwd').val();

            if(newPassword === currentPassword) {
                return 0;
            } 
            if(newPassword.length < 8) {
                return 0;
            } 
            if(newPassword.search(/\d/) === -1) {
                return 0;
            } 

            if(currentPassword.length > 0 && newPassword.length > 0 && confirmPassword.length > 0) {
                if(newPassword === confirmPassword) {
                    $('#confirmPwd')[0].setCustomValidity('');
                    event.preventDefault();
                    var postData = {
                        'type': 'cpass',
                        'oldpass': currentPassword,
                        'newpass': newPassword,
                        'newConfirmpass': confirmPassword
                    };
                    $.ajax({
                       type: "POST",
                        url: "/individual/updatedetails.jsp",
                        data: postData,
                        dataType: 'JSON',
                        success: function(resp){
                            if (resp.status === "1") {
                                $('.password-change-successful-mobile').show();
                                setTimeout(function () {
                                    window.location.href = "../signout.jsp";
                                }, 3000);
                            } else {
                                $('.mobile-contact-info-box .invalid-current').show().css('display', 'block');
                            }
                        }
                    });
                } else {
                    $('#confirmPwd')[0].setCustomValidity("Passwords don't match!");
                }
            }
        });
	}
});

function replaceButtonMobile() {    
    if(document.documentElement.clientWidth <= 480) {
        if(window.innerHeight > window.innerWidth) {
            $('.list-item button').text('x');
            $('.cancelAdd').text('x');
            $('.saveAdd').text('✔');
        }
    }
}

function addWorkplace() {
    var wOrgname = $('#wOrgname').val();
    var wPosition = $('#wPosition').val();
    var wFromDt = $('#wFromDt').val();
    var wToDt = $('#wToDt').val();
    var wLocation = $('#wLocation').val();
    var dataAdd = {'cname':wOrgname, 'position':wPosition, 'fromdate':wFromDt,'todate':wToDt,'location':wLocation};
    $.ajax({
        type: "POST",
        url: "/individual/addworkexperience.jsp",
        data: dataAdd,        
        dataType: 'JSON',
        success: function(resp){
            if(resp.status === '1') {
                $('#experience-list').html(resp.data);
                replaceButtonMobile();
            } else {
                var errorStg = '';
                for(var key in resp.error) {
                    errorStg += resp.error[key] + '\n';
                }
                errorStg += 'Please enter proper details.';
                alert(errorStg);
            }
        }
    });
}

function addEducation() {
    var eName = $('#eOrgname').val();
    var eQual = $('#eQual').val();
    var eFromDt = $('#eFromDt').val();
    var eToDt = $('#eToDt').val();
    var eLoc = $('#eLoc').val();
    var dataAdd = {'iname':eName, 'qualification':eQual, 'fromdate':eFromDt,'todate':eToDt,'location':eLoc};
    jQuery.ajax({
        type: "POST",
        url: "/individual/addeducation.jsp",
        data: dataAdd,
        dataType: 'JSON',
        success: function(resp){
            if(resp.status === '1') {
                $('#education-list').html(resp.data);
                replaceButtonMobile();
            } else {
               var errorStg = '';
                for(var key in resp.error) {
                    errorStg += resp.error[key] + '\n';
                }
                errorStg += 'Please enter proper details.';
                alert(errorStg);
            }
        }
    });
}

function addLanguage(lid) {
    var dataAdd = {'lid':lid};
    $.ajax({
        type: "POST",
        url: "/individual/addlanguage.jsp",
        data: dataAdd,
        dataType: 'JSON',
        success: function(resp){
            if(resp.status === '1') {
                $('#language-list').html(resp.data);
            } else {
                alert(resp.error);
            }
        }
    });
}

function removeWorkExp(id) {
    var dataRemove = {'wid':id};
    $.ajax({
        type: "POST",
        url: "/individual/removedetails.jsp",
        data: dataRemove,
        dataType: 'HTML',
        success: function(resp){
            $('#experience-list').html(resp);
            replaceButtonMobile();
        }
    });
}

function removeEducation(id) {
    var dataRemove = {'eid':id};
    $.ajax({
        type: "POST",
        url: "/individual/removedetails.jsp",
        data: dataRemove,
        dataType: 'HTML',
        success: function(resp){
            $('#education-list').html(resp);
            replaceButtonMobile();
        }
    });
}

function removeLanguage(id) {
    var dataRemove = {'lid':id};
    $.ajax({
        type: "POST",
        url: "/individual/removedetails.jsp",
        data: dataRemove,
        dataType: 'HTML',
        success: function(resp){
            $('#language-list').html(resp);
        }
    });
}

function performClick(elemId) {
    var elem = document.getElementById(elemId);
    if(elem && document.createEvent) {
       var evt = document.createEvent("MouseEvents");
       evt.initEvent("click", true, false);
       elem.dispatchEvent(evt);
    }
}
   
function allowImageFormat(fieldid, canBlank) {
    var fileName1 = document.getElementById(fieldid);
    var file1 = fileName1.files[0];
    if(canBlank && typeof file1 == 'undefined') {
        return true;
    }
    var fileExt = file1.name.split('.').pop().toLowerCase();
    if(fileExt === 'png' || fileExt === 'gif' || fileExt === 'jpg' || fileExt === 'jpeg') {
        var imgbytes = file1.size; // Size returned in bytes.
        var imgkbytes = Math.round(parseInt(imgbytes)/1024);
        if(imgkbytes > 500){
            $('.image-size-warning .error-type').text('Image size larger than 500kb.');
            $('.image-size-warning').show();
            setTimeout(function() {
                $('.image-size-warning').hide();
                $('#prof_img').val('');
            }, 8000);
        } else {
            return true;
        }
    } else {
        $('.image-size-warning .error-type').text('Upload failed. Invalid file format.');
        $('.image-size-warning').show();
        setTimeout(function() {
            $('.image-size-warning').hide();
        }, 8000);
    }
    return false;
}

function uploadImage() {
    $('.overlay_form').show();
    if(true) {
        var iframe = $('<iframe name="postframe" id="postframe" class="hidden" src="about:none" />');
        $('div#iframe').append(iframe);
        $('#profileImgForm').attr("action", "/individual/profilepic.jsp");
        $('#profileImgForm').attr("method", "post");
        $('#profileImgForm').attr("enctype", "multipart/form-data");
        $('#profileImgForm').attr("encoding", "multipart/form-data");
        $('#profileImgForm').attr("target", "postframe");
        $('#profileImgForm').submit();        

        //need to get contents of the iframe
        $("#postframe").load(
            function () {
                $('.overlay_form').hide();
                iframeContents = $("iframe")[0].contentDocument.body.innerHTML;
                resp = JSON.parse(iframeContents);
                if(resp.status == 1) {
                    d = new Date();
                    $('img.profimg').attr('src', $('img.profimg').attr('src')+"&r="+d.getTime());
                    var picSrc = $('img.profimg').attr('src')+"&r="+d.getTime();
                    $('div.profimg').attr('style', 'background-image: url(' + picSrc + ')');
                }
            }
        );			
    }
}