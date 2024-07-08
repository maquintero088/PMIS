<%-- 
    Document   : ver
    Created on : 30/12/2014, 12:18:32 PM
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
        <link href="../CSS/css.css" rel="stylesheet" type="text/css"/> 
        <link href="../CSS/table.css" rel="stylesheet" type="text/css"/>
        <link href="../IMAGES/tigopmo.png" type="image/x-icon" rel="shortcut icon" />
         <meta http-equiv="X-UA-Compatible" content="IE=11" />
        <script type="text/javascript">
           if(history.forward(1)){
                history.replace(history.forward(1));
            }
        </script>
        <title>PMO - Comunicación</title> 
    </head>
    <body>
        <%String 
                link="",varString="";   
          int intSlide=Integer.parseInt(request.getParameter("slide"));  
            switch(intSlide){
            case 0:
            case 1:
                varString = request.getParameter("1var1");
                String [] Date = {"yyyy-MM-dd kk:mm:ss","EEEE, dd - MM - yyyy"};
                %><div class="blanco">
                    <div class="right">                       
                        <table>
                            <tr>
                                <td>
                                    <form method="post" action="../comunicacion.jsp">              
                                        <input type="hidden" name="log" value="<%=request.getParameter("log")%>" />
                                        <input type="hidden" name="com_option" value="<%=request.getParameter("slide")%>"/>
                                        <input class="bt" type="submit" name="bt_volver" value="volver"/>		
                                    </form>
                                </td>
                                <td>
                                    <form method="post" action="enviar.jsp">
                                        <input type="hidden" name="varString" value="<%=varString%>"/> 
                                        <input type="hidden" name="url" value="<%=request.getRequestURL()%>" />
                                        <input type="hidden" name="page" value="<%=request.getParameter("page")%>" />
                                        <input type="hidden" name="slide" value="<%=request.getParameter("slide")%>"/> 
                                        <input type="hidden" name="log" value="<%=request.getParameter("log")%>" />
                                        <input class="bt" type="submit" name="bt_enviar" value="Continuar"/>                      
                                    </form>  
                                </td>                                
                            </tr>
                        </table>	
                    </div> <br class="">
                <div class="slidetitle">
                    <b><%= new Slides().getSlides(4, 0)%></b>                    
                </div>
                <div class="slidebody">
                        <div class="cuadro1">                                                    
                            <%= new Slides().getSlides(4, 1)%><b><%=
                            new Negocio().caracteres(
                                    new Negocio().in(
                                            "PMO_TOTAL_PROYECTOS",
                                            "NOMBRE_PROYECTO", 
                                            "ID_PROYECTOS", 
                                            varString
                                    ))%></b>
                            <%= new Slides().getSlides(4, 3)%><b><%=new Negocio().in(
                                    "PMO_TIPO", 
                                    "NOMBRE_TIPO", 
                                    "ID_TIPO", 
                                    new Negocio().in(
                                            "PMO_TOTAL_PROYECTOS", 
                                            "ID_TIPO", 
                                            "ID_PROYECTOS", 
                                            varString
                                    )
                            )%></b>
                        </div>
                        <div class="cuadrofecha">                                                    
                            <%=new Slides().getSlides(4, 5)+
                            new Negocio().caracteres(new Negocio().getDateFormat(new Negocio().in(
                                    "PMO_TOTAL_PROYECTOS", 
                                    "FECHA_PROXIMA_PRIORIZACION", 
                                    "ID_PROYECTOS", 
                                    varString
                            ), Date).replace("-", "de"))+     
                            new Slides().getSlides(4, 7)%>
                        </div>             
                    <div>
                        <%@include  file="../WEB-INF/jspf/com-t5.jspf" %>
                    </div>
                </div>
                    <div class="slidefooter">
                        <img class="full" src="../IMAGES/comunicacion/com-foo.png" name="Requerimientos" alt="fases" />  
                    </div>
            </div> <%break;
            case 2:
                varString = request.getParameter("2var1");%>
                <div class="blanco">
                    <div class="right">
                        <table>
                            <tr>
                                <td>
                                    <form method="post" action="../comunicacion.jsp">              
                                        <input type="hidden" name="log" value="<%=request.getParameter("log")%>" />
                                        <input type="hidden" name="com_option" value="<%=request.getParameter("slide")%>"/>
                                        <input class="bt" type="submit" name="bt_volver" value="volver"/>		
                                    </form>
                                </td>
                                <td>
                                    <form method="post" action="enviar.jsp">
                                        <input type="hidden" name="varString" value="<%=varString%>"/> 
                                        <input type="hidden" name="url" value="<%=request.getRequestURL()%>" />
                                        <input type="hidden" name="page" value="<%=request.getParameter("page")%>" />
                                        <input type="hidden" name="slide" value="<%=request.getParameter("slide")%>"/> 
                                        <input type="hidden" name="log" value="<%=request.getParameter("log")%>" />
                                        <input class="bt" type="submit" name="bt_enviar" value="Continuar"/>                      
                                    </form>  
                                </td>                                
                            </tr>
                        </table>	
                    </div> <br class="">
                    <div class="slidetitle">
                    <b><%=new Slides().getSlides(7, 0)+
                        new Negocio().caracteres(
                                new Negocio().in(
                                        "PMO_TOTAL_PROYECTOS", 
                                        "NOMBRE_PROYECTO", 
                                        "ID_PROYECTOS", 
                                        varString
                                )
                        )%></b>                    
                </div>
                <div class="slidebody">
                    <div class="cuadro1">
                        <%= new Slides().getSlides(7, 2)+
                        new Negocio().valor(
                                "PMO_TOTAL_PROYECTOS", 
                                "PRIORIZACION", 
                                "ID_PROYECTOS", 
                                varString
                        )%>
                    </div> 
                    <div class="parrafo1">
                    <%@include  file="../WEB-INF/jspf/com-t8.jspf" %>
                    </div>
                </div> 
                    <div class="slidefooter">
                        <img class="full" src="../IMAGES/comunicacion/com-foo.png" name="Requerimientos" alt="fases" />  
                    </div>
                </div>
                <%
                break;
            case 3:
                varString = request.getParameter("3var1");
                %><div class="blanco">
                    <div class="right">
                        <table>
                            <tr>
                                <td>
                                    <form method="post" action="../comunicacion.jsp">              
                                        <input type="hidden" name="log" value="<%=request.getParameter("log")%>" />
                                        <input type="hidden" name="com_option" value="<%=request.getParameter("slide")%>"/>
                                        <input class="bt" type="submit" name="bt_volver" value="volver"/>		
                                    </form>
                                </td>
                                <td>
                                    <form method="post" action="enviar.jsp">
                                        <input type="hidden" name="varString" value="<%=varString%>"/> 
                                        <input type="hidden" name="url" value="<%=request.getRequestURL()%>" />
                                        <input type="hidden" name="page" value="<%=request.getParameter("page")%>" />
                                        <input type="hidden" name="slide" value="<%=request.getParameter("slide")%>"/> 
                                        <input type="hidden" name="log" value="<%=request.getParameter("log")%>" />
                                        <input class="bt" type="submit" name="bt_enviar" value="Continuar"/>                      
                                    </form>  
                                </td>                                
                            </tr>
                        </table>	
                    </div> <br class="">
    <div class="slidetitle">
        <b><%=new Slides().getSlides(6, 0)+
                        new Negocio().in(
                                "PMO_TIPO", 
                                "NOMBRE_TIPO", 
                                "ID_TIPO", 
                                new Negocio().in(
                                        "PMO_TOTAL_PROYECTOS", 
                                        "ID_TIPO", "ID_PROYECTOS", 
                                        varString
                                )
                        ).toUpperCase()+
                        ": "+
                        new Negocio().caracteres(
                                new Negocio().in(
                                        "PMO_TOTAL_PROYECTOS", 
                                        "NOMBRE_PROYECTO", 
                                        "ID_PROYECTOS", 
                                        varString
                                )
                        )%></b>        
                        
    </div>  
    <div class="slidebody">
        <div class="cuadro1">
            <%=
                    new Slides().getSlides(6, 2)+
                        new Negocio().in(
                                "PMO_PM", 
                                "NOMBRE_PM", 
                                "ID_PM", 
                                new Negocio().in(
                                        "PMO_TOTAL_PROYECTOS", 
                                        "ID_PM", 
                                        "ID_PROYECTOS", 
                                        varString
                                )
                        ).toUpperCase()+
                        new Slides().getSlides(6, 4)+
                        new Negocio().in(
                                "PMO_TOTAL_PROYECTOS", 
                                "PRIORIZACION", 
                                "ID_PROYECTOS", 
                                varString
                        )%>
        </div>
        <div class="parrafo1">
            <%@include  file="../WEB-INF/jspf/com-t7.jspf" %>
        </div>
        <div class="parrafo1">
            <%@include  file="../WEB-INF/jspf/com-t7_1.jspf" %>
        </div>
        <div class="slidefooter">
            <img class="full" src="../IMAGES/comunicacion/com-foo.png" name="Requerimientos" alt="fases" />
        </div>        
    </div>
</div><%
    
                break;
            case 4:
                varString = request.getParameter("4var1");
                String            
                        ID_STATUS_PROYECTOS=new Negocio().in("PMO_STATUS_PROYECTOS_TEMP", "max(ID_STATUS_PROYECTOS)", "PMO_PROYECTO", varString), 
                        USUARIO_PERSONA=new Negocio().valor("PMO_STATUS_PROYECTOS_TEMP", "USUARIO_PERSONA", "ID_STATUS_PROYECTOS", ID_STATUS_PROYECTOS);
                
               // if(new Negocio().count("PMO_STATUS_PROYECTOS_TEMP", "ID_STATUS_PROYECTOS", "PMO_PROYECTO", varString)==null){
                    new Negocio().editar("null,PMO_PROYECTO,SOFT_LAUNCH,COMMERCIAL_LAUNCH,sysdate,"
                        + "ACTIVIDADES,LOGROS,RIESGOS,OBSERVACIONES,RETRASOS_RESPONSABLES,"
                        + "USUARIO_PERSONA,PORCENTAJE,TAREA,TIEMPO", "PMO_STATUS_PROYECTOS", "PMO_STATUS_PROYECTOS_TEMP where ID_STATUS_PROYECTOS = "+ID_STATUS_PROYECTOS, 3); 
                    new Negocio().editar("CRITERIO_USO,SQL_USO,USUARIO_USO","PMIS_USO","'Crear: Comunicacion - Status','Insert into PMO_STATUS_PROYECTOS select * from PMO_STATUS_PROYECTOS_TEMP','"+USUARIO_PERSONA+"'",1);                    
             //   }
                new Negocio().editar("TABLE", "PMO_STATUS_PROYECTOS_TEMP", "", 4);
                            if(new Negocio().count("PMO_STATUS_PROYECTOS", "ID_STATUS_PROYECTOS", "PMO_PROYECTO", varString)==null){%>
                            <article class="grafica">
                    <b class="tx_silde_bazul">No Hay información disponible para este Proyecto</b>
                </article>
                    <%}else{
                                ID_STATUS_PROYECTOS=new Negocio().in("PMO_STATUS_PROYECTOS", "max(ID_STATUS_PROYECTOS)", "PMO_PROYECTO", varString); 
                String [] 
                        D = new String[15],                                                        
                        Dates = {"yyyy-MM-dd kk:mm:ss","MMM - yyyy"};
                
                D[0]= new Negocio().caracteres(new Negocio().in("PMO_VIEW_TOTAL_PROYECTOS", "NOMBRE_PROYECTO", "ID_PROYECTOS", 
                        new Negocio().in("PMO_STATUS_PROYECTOS", "PMO_PROYECTO", "ID_STATUS_PROYECTOS", ID_STATUS_PROYECTOS)));
                D[1] = new Negocio().in("PMO_STATUS_PROYECTOS", "PORCENTAJE", "ID_STATUS_PROYECTOS", ID_STATUS_PROYECTOS);
                D[2]= ""+(100-(Integer.parseInt(D[1]))); 
                D[3]= new Negocio().in("PMO_STATUS_PROYECTOS", "SOFT_LAUNCH", "ID_STATUS_PROYECTOS", ID_STATUS_PROYECTOS);
                D[4]= new Negocio().in("PMO_STATUS_PROYECTOS", "COMMERCIAL_LAUNCH", "ID_STATUS_PROYECTOS", ID_STATUS_PROYECTOS);
                for(int d=3;d<5;d++){
                   if(D[d]==null){
                      D[d]="Indefinido"; 
                   }else{
                      D[d]=new Negocio().getDateFormat(D[d], Dates);
                   } 
                }                
                D[5]= new Negocio().in("PMO_STATUS_PROYECTOS", "TAREA", "ID_STATUS_PROYECTOS", ID_STATUS_PROYECTOS);
                D[6]= new Negocio().in("PMO_STATUS_PROYECTOS", "TIEMPO", "ID_STATUS_PROYECTOS", ID_STATUS_PROYECTOS);  
                D[7]= new Negocio().in("PMO_TOTAL_PROYECTOS", "ID_TIEMPO", "ID_PROYECTOS", 
                        new Negocio().in("PMO_STATUS_PROYECTOS", "PMO_PROYECTO", "ID_STATUS_PROYECTOS", ID_STATUS_PROYECTOS));                    
                D[8]= new Negocio().in("PMO_STATUS_PROYECTOS", "RETRASOS_RESPONSABLES", "ID_STATUS_PROYECTOS", ID_STATUS_PROYECTOS);
                D[9]= new Negocio().in("PMO_VIEW_TOTAL_PROYECTOS", "DESCRIPCION_PROYECTO", "ID_PROYECTOS", 
                        new Negocio().in("PMO_STATUS_PROYECTOS", "PMO_PROYECTO", "ID_STATUS_PROYECTOS", ID_STATUS_PROYECTOS));
                D[10]= new Negocio().in("PMO_VIEW_TOTAL_PROYECTOS", "NOMBRE_TIPO", "ID_PROYECTOS", 
                        new Negocio().in("PMO_STATUS_PROYECTOS", "PMO_PROYECTO", "ID_STATUS_PROYECTOS", ID_STATUS_PROYECTOS));
                D[11]= new Negocio().in("PMO_STATUS_PROYECTOS", "ACTIVIDADES", "ID_STATUS_PROYECTOS", ID_STATUS_PROYECTOS);
                D[12]= new Negocio().in("PMO_STATUS_PROYECTOS", "LOGROS", "ID_STATUS_PROYECTOS", ID_STATUS_PROYECTOS);
                D[13]= new Negocio().in("PMO_STATUS_PROYECTOS", "RIESGOS", "ID_STATUS_PROYECTOS", ID_STATUS_PROYECTOS);    
                    %>
                <div class="blanco">
                    <div class="right">                       
                        <table>
                            <tr>
                                <td>
                                    <form method="post" action="../status.jsp">  
                                        <%if(request.getParameter("page")==null){
                                        
                                        }else{%>
                                        <input class="bt" type="submit" name="bt_volver" value="volver"/>
                                        <%}%>                                        		
                                    </form>
                                </td>
                                <td>
                                    <form method="post" action="enviar.jsp">
                                        <input type="hidden" name="varString" value="<%=varString%>"/> 
                                        <input type="hidden" name="url" value="<%=request.getRequestURL()%>" />
                                        <input type="hidden" name="page" value="<%=request.getParameter("page")%>" />
                                        <input type="hidden" name="slide" value="<%=request.getParameter("slide")%>"/> 
                                        <input type="hidden" name="log" value="<%=request.getParameter("log")%>" />
                                        <input class="bt" type="submit" name="bt_enviar" value="Continuar"/>                      
                                    </form>  
                                </td>                                
                            </tr>
                        </table>	
                    </div> <br class="">
                            <div class="slidetitle">
                                <b><%= new Slides().getSlides(8, 0)%> <%=D[10]%> <%=D[0]%></b>
                                <img src="../IMAGES/comunicacion/color_<%=D[7]%>.png" class="right" width="30" alt="status_color" />
                            </div>
                            <div class="slidebody">
                                <table class="table">
                                    <tr>
                                        <Td>
                                             <div class="status_description">
                                                <%=new Negocio().caracteres(D[9])%>                                   
                                            </div>
                                        </td>
                                        <Td>
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
                                                    <Td>
                                                        <p><%= new Slides().getSlides(8, 5)%></p>
                                                    </td>
                                                    <Td>
                                                        <p><%=D[3]%></p>
                                                    </td>
                                                </tr> 
                                                <tr>
                                                    <td class="gris">
                                                        <p><%= new Slides().getSlides(8, 6)%></p>
                                                    </td>
                                                    <td class="gris">
                                                        <p><%=D[4]%></p>
                                                    </td>
                                                </tr>     
                                                <tr>
                                                    <Td>
                                                        <p><%= new Slides().getSlides(8, 7)%></p>
                                                    </td>
                                                    <Td>
                                                        <p><%=new Negocio().caracteres(D[6])%></p>
                                                    </td>
                                                </tr> 
                                                <tr>
                                                    <td class="gris">
                                                        <p><%= new Slides().getSlides(8, 8)%></p>
                                                    </td>
                                                    <td class="gris">
                                                        <%if(D[8] == null){
                                                            %><p>No aplica</p><%
                                                        }else{%>
                                                        <table class="full">
                                                            <%=new Negocio().getStringseparate(new Negocio().caracteres(D[8]))%>
                                                        </table>
                                                            <%}%>                                               
                                                    </td>
                                                </tr>  
                                                <tr>    
                                                    <Td>                                                       
                                                        <p><%= new Slides().getSlides(8, 9)%></p>
                                                    </td>
                                                    <Td>
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
                                        <%if(D[11]== null){
                                                    %><p class="tx_silde_bazul">No aplica</p><%
                                                }else{%>
                                                    <table>
                                                        <%=new Negocio().getStringseparate(new Negocio().caracteres(D[11]))%>
                                                    </table>
                                                    <%}%>
                                    </div>
                                </div>
                            </div>
                            <div class="parrafo1">
                                <table class="table">
                                    <tr>
                                        <Td>
                                            <div class="status_f">
                                                <b><%= new Slides().getSlides(8, 11)%></b>
                                                <div>
                                                    <%if(D[12] == null){
                                                    %><p class="tx_silde_bazul">No aplica</p><%
                                                }else{%>
                                                    <table >
                                                        <%=new Negocio().getStringseparate(new Negocio().caracteres(D[12]))%>
                                                    </table>
                                                <%}%>
                                                </div>                                                
                                            </div> 
                                        </td>
                                        <Td>
                                            <div class="status_f">
                                                <b><%= new Slides().getSlides(8, 12)%></b>
                                                <div>
                                                <%if(D[13] == null){
                                                    %><p class="tx_silde_bazul">No aplica</p><%
                                                }else{%>
                                                    <table >
                                                        <%=new Negocio().getStringseparate(new Negocio().caracteres(D[13]))%>
                                                    </table>
                                                <%}%>
                                                </div> 
                                            </div> 
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="slidefooter">
                               <img class="full" src="../IMAGES/comunicacion/com-foo.png" name="Requerimientos" alt="fases" />
                            </div>
                        </div>   
        <%
               } break;
            case 5:
                varString = request.getParameter("5var1");
                break;
            }
            
        %>              
    </body>
</html>
