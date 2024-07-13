<%-- 
    Document   : index
    Created on : 14/08/2014, 10:39:12 AM
    Author     : Marcel.Quintero
--%>

<%@page import="com.qcmarcel.PMIS.Negocio.Negocio"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>PMO - Base</title>  
        <link href="css/css.css" rel="stylesheet" type="text/css"/>        
        <link href="images/tigopmo.png" type="image/x-icon" rel="shortcut icon" />
        <meta http-equiv="X-UA-Compatible" content="IE=11" />
    </head>
    <body>
        <div id="page-wrap">
            <header class="marco">
            <img src="images/base.png" class="bimg"  name="gestion" alt="gestion" onclick="document.location='Gestion.jsp'"/>               
            <hr> 
            <br>
      </header>
     <aside> 
            <form action="Gestion.jsp" method="post">
                <input type="submit" class="menu" name="m" value="Project Management" />
                <input type="submit" class="menu" name="m" value="StakeHolders" />
                <input type="submit" class="menu" name="m" value="Lesson Learned" />
                <input type="submit" class="menu" name="m" value="Documentacion" />
            </form>
        </aside>
        <section>
            <%if(request.getParameter("m") ==null){
                %>
            
            <%
            }else{%>
            <object width="800" height="400" type="text/html" data="<%= new Negocio().like("PMIS_MODULO", "TT_URL_MODULO", "NN_NOMBRE_MODULO", request.getParameter("m"))%>"></object>
                <%
            }%>
        </section>
        </div>        
        <footer>
            <%@include  file="WEB-INF/jspf/foo.jspf" %>
        </footer>    
    </body>
</html>
