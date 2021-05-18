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
<body>
    <div class="wrapper fadeInDown">
        <div id="formContent">
          <!-- Tabs Titles -->
          <h2 class="active">RESETTA PASSWORD</h2>
          
      
          <!-- Icon -->
          <div class="fadeIn first">
             <img src="<%=src%>" id="icon" alt="User Icon" style="border-radius: 50%;" />
          </div>
      
        <h1 style="color: green;">Gentile <%=userForgot.getCognome()+" "+userForgot.getNome()%> La tua password e' stata cambiata con successo</h1>

        <form action="..\\login.jsp">
            <input type="submit" class="fadeIn fourth" value="Accedi al tuo account">
          </form>

      
      
        </div>
      </div>
</body>
</html>