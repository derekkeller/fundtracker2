// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

	$(".report_item_title").click(function () {
		$(this).siblings().hide("slow");
		$(".report_item_title").siblings().hide("slow")
		$(this).siblings().toggleSlide("slow");
		end
	});

$(function (){  
    $('#event_date').datepicker({ dateFormat: 'yy-mm-dd' });
});

$(function (){  
    $('#task_due_date').datepicker({ dateFormat: 'yy-mm-dd' });
});

$(function (){  
    $('#task_completed_date').datepicker({ dateFormat: 'yy-mm-dd' });
});	

$('.delete').click(function(model_name, item_id){
  var answer = confirm('Are you sure you want to delete this?');
  if (answer) {
		$('#' + model_name + '_' + item_id).hide();
		$.post('/' + model_name + '/' + item_id, {_method : 'delete', authenticity_token : '<%= form_authenticity_token %>'});
	} else {
		return false
	}
});


$(document).ready(function() {

  if($("p.notice")[0].innerHTML != ''){
	   $('p.notice').show();
  }
  if($('p.alert')[0].innerHTML != ''){
		 $('p.alert').show();
  }
		
});

function to_organization_index(t) {
	if (t) {
		location.href = '/organizations/' + t.value;
	}
}

function to_fund_show(t, oid) {
	if (t.value != '') {
		location.href = '/organizations/' + oid + '/funds/' + t.value;
	} else {
		location.href = '/organizations/' + oid;
	}
}

function to_company_show(f, oid, fid) {
	if(f.value != '') {
		location.href = '/organizations/' + oid + '/funds/' + fid + '/companies/' + f.value;
	} else {
		location.href = '/organizations/' + oid + '/funds/' + fid;
	}
}
