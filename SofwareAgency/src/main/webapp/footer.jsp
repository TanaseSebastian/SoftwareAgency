            <!-- Footer -->
            <footer id="page-footer" class="opacity-0">
                <div class="content py-20 font-size-sm clearfix">
                    <div class="text-center">
                        Esame di stato 2020-2021 Istituto tecnico A.Meucci Casarano(LE) classe VBI Specializazzione: INFORMATICA E TELECOMUNICAZIONI Alunno: <a class="font-w600" href="https://www.linkedin.com/in/tanasesebastian/" target="_blank">Tanase Sebastian</a> &copy; <span class="js-year-copy"></span>
                    </div>
                </div>
            </footer>
            <!-- END Footer -->
        </div>
        <!-- END Page Container -->
        
         <!-- Logout Modal-->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Sicuro di voler uscire?</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">Seleziona "Logout" se sei sicuro di voler terminare la sessione.</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Annulla</button>
                    <a class="btn btn-primary" href="logout">Logout</a>
                </div>
            </div>
        </div>
    </div>
    
          <!-- modulo per scelta della quantità di elementi datatables-->
 <div class="modal" id="chooseEntries" role="dialog" aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <h4>
                Indicare il numero di righe che si vuole vedere.
              </h4>
          </div>
          <div class="modal-body">
          <form action="" method="post" id="chooseEntriesForm" name="chooseEntriesForm" role="form" >
            <div class="col-md-12 form-group">
				<center>
				<select id="select-entries" name="select-entries" class="col-md-6 " required>
				 <option value="" disabled selected hidden>Seleziona numero righe</option>
					<option value="1">1</option>
					<option value="10">10</option>
					<option value="25">25</option>
					<option value="50">50</option>
					<option value="100">100</option>
					<option value="-1">TUTTE</option>
				</select>
				</center>
            </div>
          <div class="text-center" style="margin-top: 30px;">
           <button type="button" class="btn btn-danger" data-dismiss="modal">Annulla</button>
          <button type="submit" class="btn btn-primary">Prosegui <i class="fa fa-arrow-right" aria-hidden="true"></i></button>
          </div>
        </form>
          </div>
      </div>
  </div>
  </div>