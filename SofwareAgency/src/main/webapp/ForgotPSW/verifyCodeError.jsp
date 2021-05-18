<%@ page language="java" import="java.util.*,it.meucci.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
Dipendente userForgot;
userForgot = (Dipendente) session.getAttribute("SESSION_USERFORGOT");
String src="..//immaginiProfilo/"+userForgot.getImmagineProfilo();
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>login</title>
     <link rel="stylesheet" href="..//css/login.css">
</head>
<body>
    <div class="wrapper fadeInDown">
        <div id="formContent">
          <!-- Tabs Titles -->
          <h2 class="active">Verifica Account</h2>
      
          <!-- Icon -->
          <div class="fadeIn first">
            <img src="<%=src%>" id="icon" alt="User Icon" style="border-radius: 50%;" />
          </div>
      
          <!-- Login Form -->
          <form action="..//gestforgot?cmd=codecontrol" method="post">
            <h2 style="color: black; text-transform: none;">Gentile <%=userForgot.getCognome()+" "+userForgot.getNome()%> e' stato inviato il codice di verifica all'indrizzo email da lei scelto. La preghiamo di autenticarsi.</h2>
            <h3 style="color: red;">Il codice da lei inserito e' errato, riprova perfavore</h3>
            <input type="tel"  id="code" class="fadeIn third" name="code"  placeholder="inserisci qui il codice" maxlength="5"  required>
            <input type="submit" class="fadeIn fourth" value="Verifica">
          </form>
      
      
        </div>
      </div>
</body>
</html>