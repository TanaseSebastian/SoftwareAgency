<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <script src="assets/js/codebase.core.min.js"></script>
        <script src="assets/js/codebase.app.min.js"></script>

	    <!--  Page level plugins -->
	    <script src="app/vendor/datatables/jquery.dataTables.min.js"></script>
	    <script src="app/vendor/datatables/dataTables.bootstrap4.min.js"></script> 
    


        <script src="assets/js/codebase.core.min.js"></script>
        <script src="assets/js/codebase.app.min.js"></script>
        <script src="assets/js/plugins/flatpickr/flatpickr.min.js"></script>

 <!-- Page JS Plugins -->
        <script src="assets/js/plugins/pwstrength-bootstrap/pwstrength-bootstrap.min.js"></script>
        <script src="assets/js/plugins/bootstrap-datepicker/js/bootstrap-datepicker.min.js"></script>
        <script src="assets/js/plugins/bootstrap-colorpicker/js/bootstrap-colorpicker.min.js"></script>
        <script src="assets/js/plugins/bootstrap-maxlength/bootstrap-maxlength.min.js"></script>
        <script src="assets/js/plugins/select2/js/select2.full.min.js"></script>
        <script src="assets/js/plugins/jquery-tags-input/jquery.tagsinput.min.js"></script>
        <script src="assets/js/plugins/jquery-auto-complete/jquery.auto-complete.min.js"></script>
        <script src="assets/js/plugins/masked-inputs/jquery.maskedinput.min.js"></script>
        <script src="assets/js/plugins/ion-rangeslider/js/ion.rangeSlider.min.js"></script>
        <script src="assets/js/plugins/dropzonejs/dropzone.min.js"></script>
        <script src="assets/js/plugins/flatpickr/flatpickr.min.js"></script>
        <!-- Page JS Plugins -->
        <script src="assets/js/plugins/jquery-vide/jquery.vide.min.js"></script>
        <!-- Page JS Plugins -->
        <script src="assets/js/plugins/select2/js/select2.full.min.js"></script>
        <script src="assets/js/plugins/jquery-validation/jquery.validate.min.js"></script>
        <script src="assets/js/plugins/jquery-validation/additional-methods.js"></script>
        <<!-- Page JS Plugins -->
        <script src="assets/js/plugins/pwstrength-bootstrap/pwstrength-bootstrap.min.js"></script>
        <script src="assets/js/plugins/flatpickr/flatpickr.min.js"></script>
	     <script src=" https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>
	    <script src="https://cdn.datatables.net/buttons/1.7.0/js/dataTables.buttons.min.js"></script>
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
	    <script src="https://cdn.datatables.net/buttons/1.7.0/js/buttons.html5.min.js"></script>
	    <script src="https://cdn.datatables.net/buttons/1.7.0/js/buttons.print.min.js"></script>
        
            <!-- Page JS Code -->
            <script src="assets/js/pages/be_forms_plugins.min.js"></script>


        <!-- Page JS Plugins -->
        <script src="assets/js/plugins/chartjs/Chart.bundle.min.js"></script>
        <script src="assets/js/plugins/slick/slick.min.js"></script>

        <!-- Page JS Code -->
        <script src="assets/js/pages/be_forms_validation.min.js"></script>
        <script src="assets/js/pages/be_pages_dashboard.min.js"></script>
        
        
   <script src=" https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/1.7.0/js/dataTables.buttons.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
    <script src="https://cdn.datatables.net/buttons/1.7.0/js/buttons.html5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/1.7.0/js/buttons.print.min.js"></script>
     <!-- Page JS Code -->
        <script src="assets/js/pages/be_forms_validation.min.js"></script>
        <script src="assets/js/pages/be_pages_dashboard.min.js"></script>
        
         <!-- Page JS Plugins -->
        <script src="assets/js/plugins/bootstrap-notify/bootstrap-notify.min.js"></script>
        <script src="assets/js/plugins/es6-promise/es6-promise.auto.min.js"></script>
        <script src="assets/js/plugins/sweetalert2/sweetalert2.min.js"></script>
        
        <!-- Page JS Code -->
        <script src="assets/js/pages/be_ui_activity.min.js"></script>
<script>
  $(".date").flatpickr({
	    dateFormat: "Y-m-d",
	    "locale": {
	        "firstDayOfWeek": 1 // set start day of week to Monday
	    }
	});
</script>
<script>
    function submitForm(action)
    {
        document.getElementById('form').action = action;
        document.getElementById('form').submit();
    }
</script>
  <script>
  $(document).on("click", "#changeEntriesButton", function () {
	     var requestPage = $(this).data('id');
	     var servlet="gestutenti?cmd=entries&page=";
	     var action=servlet+requestPage;
	     $("#chooseEntriesForm").attr('action', action);
	});
  </script>
<script>
$(document).ready(function() {
    $('#dataTable').DataTable( {
        dom: 'Bfrtip',
        buttons: [
            'copy', 'csv', 'excel', 'pdf', 'print'
        ]
    } );
} );
</script>
 <script>
 function readURL(input) {
	  if (input.files && input.files[0]) {
	    var reader = new FileReader();
	    
	    reader.onload = function(e) {
	      $('#avatarImg').attr('src', e.target.result);
	    }
	    
	    reader.readAsDataURL(input.files[0]); // convert to base64 string
	  }
	}

	$("#avatarNewImg").change(function() {
	  readURL(this);
	});
</script>
 <script type="text/javascript">
 function check_pass() {
	    if (document.getElementById('password').value ==
	            document.getElementById('confirm_password').value) {
	        document.getElementById('submit').disabled = false;
	    } else {
	        document.getElementById('submit').disabled = true;
	    }
	}
  </script>