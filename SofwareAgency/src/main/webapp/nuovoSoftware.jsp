<%@include file= "header.jsp"%>

            <!-- Main Container -->
            <main id="main-container">

             <!-- Hero -->
     <div class="bg-image" style="background-image: url('assets/media/photos/photo26@2x.jpg');">
                    <div class="bg-black-op-75">
                        <div class="content content-top content-full text-center">
                            <div class="py-20">
                                <h1 class="h2 font-w700 text-white mb-10">  <i class="fa fa-plus text-muted mr-5"></i>Nuovo Software</h1>
                                <h2 class="h4 font-w400 text-white-op mb-0"> Questo è il 7th software che stai aggiungendo.</h2>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- END Hero -->

                <!-- Breadcrumb -->
                <div class="bg-body-light border-b">
                    <div class="content py-5 text-center">
                        <nav class="breadcrumb bg-body-light mb-0">
                        <a class="breadcrumb-item" href="dashboard.jsp">Dashboard</a>
                            <a class="breadcrumb-item" href="visualizzaPacchetti.jsp">Pacchetti software</a>
                            <span class="breadcrumb-item active">Nuovo Dipendente</span>
                        </nav>
                    </div>
                </div>
                <!-- END Breadcrumb -->



                  <!-- Page Content -->
                  <div class="content">
                    <div class="block block-rounded block-fx-shadow">
                        <div class="block-content">
                            <form action="be_pages_real_estate_listing_new.html" method="POST" enctype="multipart/form-data" onsubmit="return false;">
                                <!-- Photos -->
                                <h2 class="content-heading text-black">Photos</h2>
                                <div class="row items-push">
                                    <div class="col-lg-3">
                                        <p class="text-muted">
                                            Add nice and clean photos to better showcase your property
                                        </p>
                                    </div>
                                    <div class="col-lg-7 offset-lg-1">
                                        <div class="form-group">
                                            <div class="custom-file form">
                                                <!-- Populating custom file input label with the selected filename (data-toggle="custom-file-input" is initialized in Helpers.coreBootstrapCustomFileInput()) -->
                                                <!-- When multiple files are selected, we use the word 'Files'. You can easily change it to your own language by adding the following to the input, eg for DE: data-lang-files="Dateien" -->
                                                <input type="file" class="custom-file-input" id="re-listing-photos" name="re-listing-photos" data-toggle="custom-file-input" multiple>
                                                <label class="custom-file-label" for="re-listing-photos">Choose files</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- END Photos -->

                                <!-- Vital Info -->
                                <h2 class="content-heading text-black">Vital Info</h2>
                                <div class="row items-push">
                                    <div class="col-lg-3">
                                        <p class="text-muted">
                                            Pay extra attention since this is the data which customers will see first.
                                        </p>
                                    </div>
                                    <div class="col-lg-7 offset-lg-1">
                                        <div class="form-group">
                                            <label for="re-listing-name">Name</label>
                                            <input type="text" class="form-control form-control-lg" id="re-listing-name" name="re-listing-name" placeholder="eg Brand New Apartment">
                                        </div>
                                        <div class="form-group">
                                            <label for="re-listing-address">Address</label>
                                            <input type="text" class="form-control form-control-lg" id="re-listing-address" name="re-listing-address" placeholder="eg Street Name 45, NY">
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-md-8">
                                                <label for="re-listing-status">Status</label>
                                                <select class="form-control form-control-lg" id="re-listing-status" name="re-listing-status">
                                                    <option value="0">Please select</option>
                                                    <option value="sale">For Sale</option>
                                                    <option value="rent">For Rent</option>
                                                    <option value="unavailable">Unavailable</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-md-8">
                                                <label for="re-listing-price">Price</label>
                                                <input type="text" class="form-control form-control-lg" id="re-listing-price" name="re-listing-price" placeholder="eg $250,000">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- END Vital Info -->

                                <!-- Additional Info -->
                                <h2 class="content-heading text-black">Additional Info</h2>
                                <div class="row items-push">
                                    <div class="col-lg-3">
                                        <p class="text-muted">
                                            Add more details to make your property more appealing and interesting
                                        </p>
                                    </div>
                                    <div class="col-lg-7 offset-lg-1">
                                        <div class="form-group">
                                            <label for="re-listing-description">Description</label>
                                            <textarea class="form-control form-control-lg" id="re-listing-description" name="re-listing-description" rows="8" placeholder="How old is it? Which are its key features?"></textarea>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-md-8">
                                                <label for="re-listing-bedrooms">Bedrooms</label>
                                                <select class="form-control form-control-lg" id="re-listing-bedrooms" name="re-listing-bedrooms">
                                                    <option value="0">Please select</option>
                                                    <option value="1">1</option>
                                                    <option value="2">2</option>
                                                    <option value="3">3</option>
                                                    <option value="4">4</option>
                                                    <option value="5">5</option>
                                                    <option value="6">6</option>
                                                    <option value="7">7</option>
                                                    <option value="8">8</option>
                                                    <option value="9">9</option>
                                                    <option value="10plus">10+</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-md-8">
                                                <label for="re-listing-bathrooms">Bathrooms</label>
                                                <select class="form-control form-control-lg" id="re-listing-bathrooms" name="re-listing-bathrooms">
                                                    <option value="0">Please select</option>
                                                    <option value="1">1</option>
                                                    <option value="2">2</option>
                                                    <option value="3">3</option>
                                                    <option value="4">4</option>
                                                    <option value="5">5</option>
                                                    <option value="6">6</option>
                                                    <option value="7">7</option>
                                                    <option value="8">8</option>
                                                    <option value="9">9</option>
                                                    <option value="10plus">10+</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-md-8">
                                                <label for="re-listing-parking">Parking</label>
                                                <select class="form-control form-control-lg" id="re-listing-parking" name="re-listing-parking">
                                                    <option value="0">Please select</option>
                                                    <option value="1">1</option>
                                                    <option value="2">2</option>
                                                    <option value="3">3</option>
                                                    <option value="4">4</option>
                                                    <option value="5">5</option>
                                                    <option value="6">6</option>
                                                    <option value="7">7</option>
                                                    <option value="8">8</option>
                                                    <option value="9">9</option>
                                                    <option value="10plus">10+</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-md-8">
                                                <label for="re-listing-heating">Heating</label>
                                                <select class="form-control form-control-lg" id="re-listing-heating" name="re-listing-heating">
                                                    <option value="0">Please select</option>
                                                    <option value="electricity">Electricity</option>
                                                    <option value="gas">Gas</option>
                                                    <option value="unavailable">Unavailable</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-md-8">
                                                <label for="re-listing-size">Size (in sq.ft.)</label>
                                                <input type="text" class="form-control form-control-lg" id="re-listing-size" name="re-listing-size" placeholder="eg 300">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- END Additional Info -->

                                <!-- Contact Info -->
                                <h2 class="content-heading text-black">Contact Info</h2>
                                <div class="row items-push">
                                    <div class="col-lg-3">
                                        <p class="text-muted">
                                            How can your customers reach you?
                                        </p>
                                    </div>
                                    <div class="col-lg-7 offset-lg-1">
                                        <div class="form-group row">
                                            <div class="col-md-8">
                                                <label for="re-listing-email">Email</label>
                                                <input type="text" class="form-control form-control-lg" id="re-listing-email" name="re-listing-email">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-md-8">
                                                <label for="re-listing-phone">Phone</label>
                                                <input type="text" class="form-control form-control-lg" id="re-listing-phone" name="re-listing-phone">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- END Contact Info -->

                                <!-- Form Submission -->
                                <div class="row items-push">
                                    <div class="col-lg-7 offset-lg-4">
                                        <div class="form-group">
                                            <button type="submit" class="btn btn-alt-success">
                                                <i class="fa fa-plus mr-5"></i>
                                                Add Listing
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <!-- END Form Submission -->
                            </form>
                        </div>
                    </div>
                </div>
                <!-- END Page Content -->

            </main>
            <!-- END Main Container -->

            <%@include file= 'footer.jsp' %>