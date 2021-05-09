<%@ page language="java" import="it.meucci.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%
	String benvenuto =(String)session.getAttribute("Benvenuto");
	if(benvenuto==null) benvenuto="";
  %>   
<%@include file="header.jsp" %>

            <!-- Main Container -->
            <main id="main-container">

                <!-- Hero -->
                <!-- jQuery Vide for video backgrounds, for more examples you can check out https://github.com/VodkaBears/Vide -->
                <div class="bg-video" data-vide-bg="assets/media/videos/city_night" data-vide-options="posterType: jpg">
                    <div class="bg-primary-dark-op">
                        <div class="content text-center">
                            <div style="padding: 45vh 0 45vh 0;" >
                                <h1 class="font-w700 text-white mb-10">Dashboard</h1>
                                <h2 class="h4 font-w400 text-white-op">Benvenuto <%=user.getNome()%> nella dashbord di  <i class="si si-fire text-primary"></i>
                                    <span class="font-size-xl text-dual-primary-light">code</span><span class="font-size-xl text-primary">base</span> !</h2>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- END Hero -->


                <!-- Page Content -->
                <div class="content">
                    <h2 class="content-heading">Blank <small>Get Started</small></h2>
                    <p>Create your own awesome project!</p>
                </div>
                <!-- END Page Content -->
            </main>
            <!-- END Main Container -->

			<% if(benvenuto.equals("true")){%>
			
			<!-- Onboarding Modal functionality is initialized in js/pages/be_pages_dashboard.min.js which was auto compiled from _es6/pages/be_pages_dashboard.js -->
<div class="modal fade" id="modal-onboarding" tabindex="-1"
	role="dialog" aria-labelledby="modal-onboarding" aria-hidden="true"
	ata-keyboard="false" data-backdrop="static">
	<div
		class="modal-dialog modal-lg modal-dialog-centered modal-dialog-popout"
		role="document">
		<div class="modal-content rounded">
			<div class="block block-rounded block-transparent mb-0 bg-pattern"
				style="background-image: url('assets/media/various/bg-pattern-inverse.png');">
				<div class="block-content block-content-full">
					<div class="js-slider slick-dotted-inner" data-dots="true"
						data-arrows="false" data-infinite="false">
						<div class="pt-30">
							<div class="row justify-content-center text-center">
								<div class="col-md-10 col-lg-8">
									<i class="si si-fire fa-4x text-primary"></i>
									<h3 class="font-size-h2 font-w300 mt-20">Welcome to
										Codebase!</h3>
									<p class="text-muted">This is a modal you can show to your
										users when they first sign in to their dashboard. It is a
										great place to welcome and introduce them to your application
										and its functionality.</p>
									<button type="button"
										class="btn btn-sm btn-hero btn-noborder btn-primary mb-10 mx-5"
										onclick="jQuery('.js-slider').slick('slickGoTo', 1);">
										Key features <i class="fa fa-arrow-right ml-5"></i>
									</button>
								</div>
							</div>
						</div>
						<div class="slick-slide pt-30">
							<div class="row justify-content-center">
								<div class="col-md-10 col-lg-8">
									<h3 class="font-size-h2 font-w300 mb-5">Backup</h3>
									<p class="text-muted">Backups are taken with every new
										change to ensure complete piece of mind. They are kept safe
										for immediate restores.</p>
									<h3 class="font-size-h2 font-w300 mb-5">Invoices</h3>
									<p class="text-muted">They are sent automatically to your
										clients with the completion of every project, so you don't
										have to worry about getting paid.</p>
									<div class="text-center">
										<button type="button"
											class="btn btn-sm btn-hero btn-noborder btn-primary mb-10 mx-5"
											onclick="jQuery('.js-slider').slick('slickGoTo', 2);">
											Complete Profile <i class="fa fa-arrow-right ml-5"></i>
										</button>
									</div>
								</div>
							</div>
						</div>
						<div class="slick-slide pb-50">
							<div class="row justify-content-center text-center">
								<div class="col-md-10 col-lg-8">
									<h3 class="font-size-h2 font-w300 mt-20">
										<i class="si si-note text-primary"></i> Per finire imposta una
										password
									</h3>
									<!-- jQuery Validation functionality is initialized in js/pages/be_forms_validation.min.js which was auto compiled from _es6/pages/be_forms_validation.js -->
									<form class="js-validation-material" action="gestutenti?cmd=setPassword" method="post">
										<div id="js-pw-strength2-container" class="form-group">
											<div class="form-material">
												<input type="text" id="cf" name="cf" value="<%=user.getCf()%>" hidden>
												<input type="password" class="js-pw-strength2 form-control"
													id="password" name="password"
													placeholder="Scegli una password sicura..."> <label
													for="password">Password</label>
											</div>
											<div
												class="js-pw-strength2-progress pw-strength-progress mt-5"></div>
											<p class="js-pw-strength2-feedback form-text"></p>
										</div>
										<div class="form-group">
											<div class="form-material">
												<input type="password" class="form-control"
													id="confirm-password" name="confirm-password"
													placeholder="..e confermala!"> <label
													for="confirm-password">Confirm Password</label>
											</div>
										</div>
										<div class="form-group">
											<button type="submit"
												class="btn btn-sm btn-hero btn-noborder btn-success mb-10 mx-5">
												Get Started <i class="fa fa-check ml-5"></i>
											</button>
										</div>
									</form>

								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- END Onboarding Modal -->
			
			<%}%>
            <%request.getSession().setAttribute("Benvenuto", "false"); %>

           
		<%@include file="footer.jsp"%>
        <%@include file="librerie.jsp"%>
    </body>
</html>
