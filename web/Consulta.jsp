<%--  
    Document   : status
    Created on : 23/09/2014, 04:21:04 PM
    Author     : marcel.quintero
--%>
<%@page import="Services.Slides"%>
<%@page import="Datos.Oracle"%>
<%@page import="Negocio.Dashboard"%>
<%@page import="Negocio.Negocio"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>PMO - Consulta de Proyectos</title>
        <link href="CSS/css.css" rel="stylesheet" type="text/css"/>        
        <link href="IMAGES/tigopmo.png" type="image/x-icon" rel="shortcut icon" />
         <meta http-equiv="X-UA-Compatible" content="IE=11" />
        <%
    String[] D;
    if(request.getParameter("p")==null){
        
        D = null;
        
    }else {
        
        D = new String[15];
        
        D[0]= request.getParameter("p");
        D[1] = new Negocio().like("PMO_TAREAS", "PORCENTAJE", "NOMBRE_TAREA", 
                new Negocio().in("PMO_VIEW_TOTAL_PROYECTOS", "NOMBRE_TAREA", "ID_PROYECTOS", D[0]));
        D[2]= ""+(100-(Integer.parseInt(D[1]))); 
        D[3]= new Negocio().in("PMO_VIEW_TOTAL_PROYECTOS", "OBSERVACION_GESTION", "ID_PROYECTOS", D[0]);
        D[4]= new Negocio().caracteres(new Negocio().in("PMO_VIEW_TOTAL_PROYECTOS", "NOMBRE_PROYECTO", "ID_PROYECTOS", D[0]));
        D[5]= new Negocio().in("PMO_VIEW_TOTAL_PROYECTOS", "NOMBRE_TAREA", "ID_PROYECTOS", D[0]);
        D[6]= new Negocio().in("PMO_VIEW_TOTAL_PROYECTOS", "NOMBRE_TIEMPO", "ID_PROYECTOS", D[0]);  
        D[7]= new Negocio().in("PMO_TOTAL_PROYECTOS", "ID_TIEMPO", "ID_PROYECTOS", D[0]);                     
        D[8]= new Negocio().in("PMO_VIEW_TOTAL_PROYECTOS", "DIAS_RETRASO", "ID_PROYECTOS", D[0]);
        D[9]= new Negocio().in("PMO_VIEW_TOTAL_PROYECTOS", "DESCRIPCION_PROYECTO", "ID_PROYECTOS", D[0]);
        D[10]= new Negocio().in("PMO_VIEW_TOTAL_PROYECTOS", "NOMBRE_TIPO", "ID_PROYECTOS", D[0]);
    }
    
%>  
    </head>
    <body>             
        <div id="page-wrap">
            <header>   
          <img src="IMAGES/Consulta.png" name="Dashboard" class="bimg" alt="dashboard" onclick="document.location='http://localhost:8080/PMIS_Tigo_PMO/Consulta.jsp'"/>                                               
          <hr>   
          <br>
      </header>
          <section>
    <% int count = new Dashboard().NProyectos(request.getParameter("searchc"),request.getParameter("searchp"));
         String [][] Status = new Dashboard().desempeno(request.getParameter("searchc"),request.getParameter("searchp"));   
         String actualizacion = request.getParameter("actualizacion");
               
        if(request.getParameter("p")==null){%>
                <section class="grisb">                                       
                    <div class="marco">
                        <table>
                            <tr>
                                <td>
                                    <div >
                            <p>Haga Click en un Proyecto para obtener Status</p>
                            <input type="text" class="blanco" disabled value="<%=count%>"/>
                        </div> 
                                </td>
                                <td>
                                    <form action="Consulta.jsp" method="post">        
                                        <table>
                                <tr>
                                    <td>
                                        <select name="searchc" class="bt2" >
                                            <option value="NO_REQ_PADRE">Número de Requerimiento</option>
                                            <option value="NOMBRE_PROYECTO">Nombre del Proyecto</option>
                                            <option value="NOMBRE_VICEPRESIDENCIA">Vicepresidencia</option>
                                            <option value="NOMBRE_PM">Project Manager</option>                                
                                            <option value="NOMBRE_RESPONSABLE">Nombre de Responsable</option> 
                                            <option value="NOMBRE_AREA">Nombre de Área</option>  
                                        </select> 
                                    </td>
                                    <td>
                                        <input type="search" name="searchp" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <input type="submit" name="search" class="bt" value="buscar"/> 
                                    </td>
                                </tr>
                            </table>
                        </form>    
                                </td>
                            </tr>
                        </table>
                    </div>
                    <hr>
                    <table>
                        <tr>
                            <td class="td1"> 
                                <%if(request.getParameter("searchc")==null||request.getParameter("searchp")==null){ %>
                                <div class="blanco">
                                    <div class="slidebody">
                                        Por favor, elija un tipo y criterio de búsqueda.
                                    </div>
                                </div>
                                <%}else{
                                        for(int t=0;t<Status.length;t++){%> 
                                            <form action="Consulta.jsp">   
                                                <div>    
                                                         <input type="hidden" name="p" value="<%=Status[t][0]%>" /> 
                                                         <input type="submit" class="bt2" value="<%=new Negocio().caracteres(Status[t][3])%>" 
                                                                title="<%="Req_Padre: "+Status[t][7]+"\n"
                                                                        + "Project Manager: "+Status[t][5]+"\n"
                                                                        + "Tipo: "+Status[t][2]+"\n"
                                                                        + "Área: "+Status[t][1]+"\n" 
                                                                        + "Vicepresidencia: "+Status[t][6]+"\n"
                                                                        + "Responsable: "+Status[t][4]%>">                                                                                                      
                                                </div>                                                
                                            </form>
                                    <%}}%>
                            </td>
                        </tr>
                    </table>
                </section> 
                            <aside>       
   <%}else if(new Negocio().count("PMO_STATUS_PROYECTOS", "ID_STATUS_PROYECTOS", "PMO_PROYECTO", D[0])==null){%>
       <article>
           <b class="tx_silde_bazul">No Hay información disponible para este Proyecto</b>
           <input type="button" class="bt" value="Volver" onclick="document.location='http://localhost:8080/PMIS_Tigo_PMO/Consulta.jsp'"/> 
       </article>
   <%}else{
            String [] 
                    historyDate = new Negocio().valores(
                            "PMO_STATUS_PROYECTOS where PMO_PROYECTO = "+D[0]+" order by ID_STATUS_PROYECTOS desc", 
                            "FECHA_ACTUALIZACION", 
                            "FECHA_ACTUALIZACION"
                    ), 
                    historyId = new Negocio().valores(
                            "PMO_STATUS_PROYECTOS where PMO_PROYECTO = "+D[0]+" order by ID_STATUS_PROYECTOS desc",
                            "ID_STATUS_PROYECTOS",
                            "ID_STATUS_PROYECTOS"
                    ),
                    historyStatus = new Negocio().getStatus(actualizacion,D[0]);
                    String Dates[] = {"yyyy-MM-dd kk:mm:ss","MMM - yyyy"};
   %>
    <table class="table">
                <tr>
                    <td class="marco">
                        <form action="Consulta.jsp" >
                            <table class="right">
                                <tr>
                                    <td>
                                        <input type="hidden" name="p" value="<%=D[0]%>" />
                                        <select name="actualizacion" class="bt2" >
                                            <%for (int option=0;option<historyDate.length;option++){
                                                if(actualizacion==null){%>
                                                <option value="<%=historyId[option]%>">
                                                    <%=historyDate[option]%>
                                                </option>                                        
                                                <%}else if(actualizacion.equals(historyId[option])){%>
                                                <option selected="" value="<%=historyId[option]%>">
                                                    <%=historyDate[option]%>
                                                </option>
                                                <%}else{%>
                                                <option value="<%=historyId[option]%>">
                                                    <%=historyDate[option]%>
                                                </option>
                                                <%}}%>
                                        </select>
                                    </td>
                                    <td>
                                        <input type="submit" class="bt"  value="Cargar">
                                    </td>
                                    <td>
                                        <input type="button" class="bt" value="Volver" onclick="document.location='http://localhost:8080/PMIS_Tigo_PMO/Consulta.jsp'"/>
                                    </td>
                                </tr>
                            </table>                
                        </form>                                 
                    </td>                                        
                </tr>
                <tr>
                    <td>
                        <div class="slide">
                            <div class="slidetitle">
                                <b><%= new Slides().getSlides(8, 0)%> <%=D[10]%> <%=D[4]%></b>
                                <img src="IMAGES/comunicacion/color_<%=D[7]%>.png" class="right" width="30" alt="status_color" />
                            </div>
                            <div class="slidebody">
                                <table class="table">
                                    <tr>
                                        <td>
                                             <div class="status_description">
                                                <%=new Negocio().caracteres(D[9])%>                                   
                                            </div>
                                        </td>
                                        <td>
                                            <table class="status_table">
                                        <tr>
                                            <td colspan="2" class="border_status">
                                                <b><%= new Slides().getSlides(8, 3)%></b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="gris">
                                                <p><%= new Slides().getSlides(8, 4)%></p>
                                            </td>
                                            <td class="gris">
                                                <p><%=new Negocio().caracteres(D[5])%></p>
                                            </td>
                                        </tr>     
                                        <tr>
                                            <td>
                                                <p><%= new Slides().getSlides(8, 5)%></p>
                                            </td>
                                            <td>
                                                <p><%=new Negocio().getDateFormat(historyStatus[0], Dates)%></p>
                                            </td>
                                        </tr> 
                                        <tr>
                                            <td class="gris">
                                                <p><%= new Slides().getSlides(8, 6)%></p>
                                            </td>
                                            <td class="gris">
                                                <p><%=new Negocio().getDateFormat(historyStatus[1], Dates)%></p>
                                            </td>
                                        </tr>     
                                        <tr>
                                            <td>
                                                <p><%= new Slides().getSlides(8, 7)%></p>
                                            </td>
                                            <td>
                                                <p><%=new Negocio().caracteres(D[6])%></p>
                                            </td>
                                        </tr> 
                                        <tr>
                                            <td class="gris">
                                                <p><%= new Slides().getSlides(8, 8)%></p>
                                            </td>
                                            <td class="gris">
                                                    <%if(historyStatus[2] == null){
                                                    %><p>No aplica</p><%
                                                }else{%>
                                                    <table class="full">
                                                        <%=new Negocio().getStringseparate(historyStatus[2])%>
                                                    </table>
                                                <%}%>                                               
                                            </td>
                                        </tr>  
                                        <tr>
                                            <td>
                                                <p><%= new Slides().getSlides(8, 9)%></p>
                                            </td>
                                            <td>
                                                <p><%=D[1]%>%</p>
                                            </td>
                                        </tr> 
                                     </table> 
                                        </td>
                                    </tr>
                                </table>    
                            </div>
                            <div >
                                <div class="status_acciones">
                                    <%= new Slides().getSlides(8, 10)%>
                                    <hr class="status_acciones">
                                    <div>
                                        <%if(historyStatus[3] == null){
                                                    %><p class="tx_silde_bazul">No aplica</p><%
                                                }else{%>
                                                <table class="full">
                                                        <%=new Negocio().getStringseparate(historyStatus[3])%>
                                                    </table>
                                                    <%}%>
                                    </div>
                                </div>
                            </div>
                            <div class="parrafo1">
                                <table class="table">
                                    <tr>
                                        <td>
                                            <div class="status_f">
                                                <b><%= new Slides().getSlides(8, 11)%></b>
                                                <div>
                                                    <%if(historyStatus[4] == null){
                                                    %><p class="tx_silde_bazul">No aplica</p><%
                                                }else{%>
                                                    <table class="full">
                                                        <%=new Negocio().getStringseparate(historyStatus[4])%>
                                                    </table>
                                                <%}%>
                                                </div>                                                
                                            </div> 
                                        </td>
                                        <td>
                                            <div class="status_f">
                                                <b><%= new Slides().getSlides(8, 12)%></b>
                                                <div>
                                                <%if(historyStatus[5] == null){
                                                    %><p class="tx_silde_bazul">No aplica</p><%
                                                }else{%>
                                                    <table class="full">
                                                        <%=new Negocio().getStringseparate(historyStatus[5])%>
                                                    </table>
                                                <%}%>
                                                </div> 
                                            </div> 
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="slidefooter">
                                <img src="IMAGES/comunicacion/com-foo.png" class="full" alt=""/>
                            </div>
                        </div>                     
                    </td>                    
                </tr>                
            </table>                       
            <%}%>
        </aside>
</section>
        </div> 
        <%if(request.getParameter("searchc")==null||request.getParameter("searchp")==null){%>
        <!--<footer>
            <%@include  file="WEB-INF/jspf/foo.jspf" %>
      </footer>  -->
      <%}%>
    </body>
</html>

