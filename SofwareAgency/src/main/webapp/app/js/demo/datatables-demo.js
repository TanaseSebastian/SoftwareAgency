$(document).ready(function() {
// Call the dataTables jQuery plugin
      $('#dataTable').DataTable( {
  		    aLengthMenu: [
        [10, 25, 50, 100, -1],
        [10, 25, 50, 100, "All"]
    ],
    dom: 'Bfrtip',
        buttons: [
            'copy', 'csv', 'excel', 'pdf', 'print'
        ]
    } );
} );