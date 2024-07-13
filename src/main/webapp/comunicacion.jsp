<%-- 
    Document   : comunicacion
    Created on : 7/10/2014, 03:56:28 PM
    Author     : Marcel.Quintero
--%>

<%@page import="Datos.Oracle"%>
<%@page import="Negocio.Negocio"%>
<%@page import="Services.Slides"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>PMO - Comunicación</title>
        <link href="css/css.css" rel="stylesheet" type="text/css"/>   
        <link href="css/table.css" rel="stylesheet" type="text/css"/>        
        <link href="images/tigopmo.png" type="image/x-icon" rel="shortcut icon" />
         <meta http-equiv="X-UA-Compatible" content="IE=11" />
        <script type="text/javascript">
            if(history.forward(1)){
                history.replace(history.forward(1));
            }
        </script>
    </head>
    <body>
        <div id="page-wrap">               
        <header class="azul">   
            <img src="images/comunicacion.png" class="bimg" name="comunicacion" alt="comunicacion" onclick="document.location='comunicacion.jsp'"/> 
            <hr>
        </header>
        <aside> 
        <%if(request.getParameter("log")==null){%>
            <%@include file="WEB-INF/jspf/login.jspf" %>            
        <%}else{ String [] slide = new Negocio().valores("PMIS_SLIDE", "NOMBRE_SLIDE", "NOMBRE_SLIDE");
                         for(int option=0;option<slide.length;option++){%> 
                         <form class="left" style="min-width: 20%;" action="comunicacion.jsp" method="post">
                             <input type="hidden" name="log" value="<%=request.getParameter("log")%>" />
                             <input type="hidden" name="com_option" value="<%=slide[option]%>" />
                             <input type="submit" name="option" class="bt3" value="<%=slide[option]%>">
                         </form> 
                             <%}%> 
                     </aside>                             
                     <br><br><br>
                             <section>
                         <%@include file="WEB-INF/jspf/slides.jspf" %>
                     </section>
               <%}%>  
        </div> 
        <%if(request.getParameter("option")==null){%>
         <footer>            
            <%@include  file="WEB-INF/jspf/foo.jspf" %>
        </footer>
        <%}%>
    </body>
</html>
