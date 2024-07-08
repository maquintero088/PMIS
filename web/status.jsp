
<%-- 
    Document   : status
    Created on : 23/09/2014, 04:21:04 PM
    Author     : marcel.quintero
--%>
  <%@page import="java.util.Random"%>
<%@page import="Services.Slides"%>
<%@page import="Datos.Oracle"%>
<%@page import="Negocio.Dashboard"%>
<%@page import="Negocio.Negocio"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>PMO - Estado de Avance</title>
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
        <%          
        int count = new Dashboard().NProyectos(request.getParameter("searchc"),request.getParameter("searchp"));
         String [][] Status = new Dashboard().desempeno(request.getParameter("searchc"),request.getParameter("searchp"));   
               
        if(request.getParameter("p")==null){
            new Negocio().editar("TABLE", "PMO_STATUS_PROYECTOS_TEMP", "", 4);
                %>
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
                                    <form action="status.jsp" method="post">        
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
                                <div class="blanco" style="min-width: 600px">
                                        <p class="tx_silde_bazul">Por favor, elija un tipo y criterio de búsqueda.</p>
                                    </div>
                                <%}else{
                                        for(int t=0;t<Status.length;t++){%> 
                                            <form method="post" action="status.jsp">   
                                                <div>
                                                    <input type="hidden" name="p" value="<%=Status[t][0]%>" />
                                                    <input type="submit" name="b" class="bt2" value="<%=new Negocio().caracteres(Status[t][3])%>" 
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
            <%}else {
        if(new Negocio().valor("PMO_STATUS_PROYECTOS", "ID_STATUS_PROYECTOS", "PMO_PROYECTO",D[0])==null&&
                new Negocio().valor("PMO_STATUS_PROYECTOS_TEMP", "ID_STATUS_PROYECTOS", "PMO_PROYECTO",D[0])==null){
            Random idRandom= new Random();
            String USUARIO_PERSONA = new Negocio().valor("PMIS_USO", "USUARIO_USO", "ID_USO", new Negocio().like("PMIS_USO", "max(ID_USO)", "CRITERIO_USO", "comunicacion"));
            new Negocio().editar(
                    "ID_STATUS_PROYECTOS,PMO_PROYECTO,USUARIO_PERSONA", "PMO_STATUS_PROYECTOS_TEMP", 
                    "'"+idRandom.nextInt(100)+"',"+D[0]+",'"+USUARIO_PERSONA+"'", 1);    
                new Negocio().editar("PORCENTAJE = "+D[1]+", TAREA = '"+D[5]+"' ,TIEMPO = '"+D[6]+"'", "PMO_STATUS_PROYECTOS_TEMP", "PMO_PROYECTO = "+D[0],2);
        }else if(new Negocio().valor("PMO_STATUS_PROYECTOS_TEMP", "ID_STATUS_PROYECTOS", "PMO_PROYECTO",D[0])==null){
                Random idRandom= new Random();
                D[11]= new Negocio().in("PMO_STATUS_PROYECTOS", "max(ID_STATUS_PROYECTOS)", "PMO_PROYECTO", D[0]);
                new Negocio().editar(
                    "'"+idRandom.nextInt(100)+"',PMO_PROYECTO,SOFT_LAUNCH,COMMERCIAL_LAUNCH,sysdate,"
                            + "ACTIVIDADES,LOGROS,RIESGOS,OBSERVACIONES,RETRASOS_RESPONSABLES,"
                            + "USUARIO_PERSONA,PORCENTAJE,TAREA,TIEMPO", "PMO_STATUS_PROYECTOS_TEMP",
                    "PMO_STATUS_PROYECTOS where ID_STATUS_PROYECTOS = "+D[11], 3);    
                new Negocio().editar("PORCENTAJE = "+D[1]+", TAREA = '"+D[5]+"' ,TIEMPO = '"+D[6]+"'", "PMO_STATUS_PROYECTOS_TEMP", "PMO_PROYECTO = "+D[0],2);
            }
            if(request.getParameter("borrar")==null){
                D[11]= new Negocio().in("PMO_STATUS_PROYECTOS_TEMP", "max(ID_STATUS_PROYECTOS)", "PMO_PROYECTO", D[0]);
            }
            String  
                    field = request.getParameter("field"),
                    PMOSTATUSTEMP_String_requestID = request.getParameter("PMOSTATUSTEMP_ID"),
                    PMOSTATUSTEMP_String_requestDATE0 = new Negocio().valor("PMO_STATUS_PROYECTOS_TEMP", "SOFT_LAUNCH", "ID_STATUS_PROYECTOS" ,D[11]),
                    PMOSTATUSTEMP_String_requestDATE1 = new Negocio().valor("PMO_STATUS_PROYECTOS_TEMP", "COMMERCIAL_LAUNCH", "ID_STATUS_PROYECTOS" ,D[11]),
                    PMOSTATUSTEMP_String_requestUSUARIO = request.getParameter("PMOSTATUSTEMP_USUARIO");
            
            
            %> 
            <aside> 
            <table class="table">
                <tr>
                    <td class="right">
                        <div class="grisb">
                            <form action="comunicacion/ver.jsp" method="post">
                                <table>
                                <tr>
                                    <td>
                                        <input type="button" class="bt" value="Volver" onclick="document.location='http://localhost:8080/PMIS_Tigo_PMO/status.jsp'"/> 
                                    </td>
                                    <td>
                                        <input type="hidden" name="page" value="<%=request.getRequestURI().replace("/PMIS_Tigo_PMO/comunicacion/", "/PMIS_Tigo_PMO/comunicacion.jsp") %>" />
                                        <input type="hidden" name="4var1" value="<%=D[0]%>"/> 
                                        <input type="hidden" name="log" value="<%=PMOSTATUSTEMP_String_requestUSUARIO%>"/> 
                                        <input type="hidden" name="slide" value="4" /> 
                                        <input type="submit" class="bt" name="STATUS" value="Guardar todo">
                                    </td>
                                </tr>
                            </table> 
                            </form>                                                 
                        </div>
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
                                                <b class="tx_silde_bazul"><%= new Slides().getSlides(8, 3)%></b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="gris">
                                                <p class="tx_silde_bazul"><%= new Slides().getSlides(8, 4)%></p>
                                            </td>
                                            <td class="gris">
                                                <p class="tx_silde_bazul"><%=new Negocio().caracteres(D[5])%></p>
                                            </td>
                                        </tr>     
                                        <tr>
                                            <td>
                                                <p class="tx_silde_bazul"><%= new Slides().getSlides(8, 5)%></p>
                                            </td>
                                            <td>
                                                <%
                                                String 
                                                        PMOSTATUSTEMP_String_requestSOFT_LAUNCH = request.getParameter("SOFT_LAUNCH"),
                                                        PMOSTATUSTEMP_String_requestCOMMERCIAL_LAUNCH = request.getParameter("COMMERCIAL_LAUNCH"),
                                                        Dates[] = {"yyyy-MM-dd","yyyy-MM-dd kk:mm:ss"},
                                                        Dates2[] = {"yyyy-MM-dd kk:mm:ss","MMM - yyyy"};
                                                if(request.getParameter("campo")==null||request.getParameter("campo").equals("creado")){
                                                    if(PMOSTATUSTEMP_String_requestSOFT_LAUNCH == null){
                                                        PMOSTATUSTEMP_String_requestDATE0 = new Negocio().valor("PMO_STATUS_PROYECTOS_TEMP",
                                                                 "SOFT_LAUNCH",  "PMO_PROYECTO",D[0]);
                                                    }else if(request.getParameter("campo").equals("creado")){
                                                        new Negocio().editar("SOFT_LAUNCH = '"+
                                                                new Negocio().getDateFormat(
                                                                        PMOSTATUSTEMP_String_requestSOFT_LAUNCH, Dates)+"'",
                                                                "PMO_STATUS_PROYECTOS_TEMP","ID_STATUS_PROYECTOS = "+D[11],2);
                                                         PMOSTATUSTEMP_String_requestDATE0 = new Negocio().valor("PMO_STATUS_PROYECTOS_TEMP",
                                                                 "SOFT_LAUNCH",  "ID_STATUS_PROYECTOS",D[11]);
                                                    }                                                
                                                %>
                                                <form action="status.jsp" method="post">
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <%if(PMOSTATUSTEMP_String_requestDATE0 == null){%>
                                                                               <p>--Vacío--</p>
                                                                               <%}else{%>
                                                            <p class="tx_silde_bazul"><%=new Negocio().getDateFormat(PMOSTATUSTEMP_String_requestDATE0, Dates2)%></p> 
                                                            <%}%>
                                                        </td>
                                                        <td>
                                                            <input type="hidden" name="campo" value="crear"/>
                                                            <input type="hidden" name="field" value="SOFT_LAUNCH"/>
                                                            <input type="hidden" name="p" value="<%=D[0]%>" /> 
                                                            <input type="submit" name="submit_Retrasos_0" class="bt" value="Editar"/> 
                                                        </td>
                                                    </tr>
                                                </table>
                                                </form>                                                
                                                <%}else if(request.getParameter("campo").equals("crear")&&field.equals("SOFT_LAUNCH")){%>
                                                <%if(PMOSTATUSTEMP_String_requestDATE0 == null){%>
                                                                               <p>--Vacío--</p>
                                                                               <%}else{%>
                                                            <p class="tx_silde_bazul"><%=new Negocio().getDateFormat(PMOSTATUSTEMP_String_requestDATE0, Dates2)%></p> 
                                                            <%}%>
                                                <table>
                                                    <tr>
                                                        <td>
                                                         <form action="status.jsp" method="post">
                                                            <input type="date" name="SOFT_LAUNCH" value="" required/>
                                                            <input type="hidden" name="p" value="<%=D[0]%>" /> 
                                                            <input type="hidden" name="campo" value="creado"/>
                                                            <input type="submit" name="submit_Retrasos_0" class="bt" value="Guardar"/>
                                                        </form>  
                                                        </td>
                                                        <td>
                                                         <form action="status.jsp" method="post">
                                                            <input type="hidden" name="p" value="<%=D[0]%>" /> 
                                                            <input type="submit" name="submit_Retrasos_0" class="bt" value="Cancelar"/>
                                                        </form>  
                                                        </td>
                                                    </tr>                                                    
                                                </table>
                                                <%}else{%>
                                                <%if(PMOSTATUSTEMP_String_requestDATE0 == null){%>
                                                                               <p>--Vacío--</p>
                                                                               <%}else{%>
                                                            <p class="tx_silde_bazul"><%=new Negocio().getDateFormat(PMOSTATUSTEMP_String_requestDATE0, Dates2)%></p> 
                                                            <%}%>
                                                <%}%>
                                            </td>
                                        </tr> 
                                        <tr>
                                            <td class="gris">
                                                <p class="tx_silde_bazul"><%= new Slides().getSlides(8, 6)%></p>
                                            </td>
                                            <td class="gris">
                                                <%                                                
                                                if(request.getParameter("campo")==null||request.getParameter("campo").equals("creado")){
                                                    if(PMOSTATUSTEMP_String_requestCOMMERCIAL_LAUNCH == null){
                                                        PMOSTATUSTEMP_String_requestDATE1 = new Negocio().valor("PMO_STATUS_PROYECTOS_TEMP",
                                                                 "COMMERCIAL_LAUNCH",  "PMO_PROYECTO",D[0]);
                                                    }else if(request.getParameter("campo").equals("creado")){
                                                        new Negocio().editar("COMMERCIAL_LAUNCH = '"+
                                                                new Negocio().getDateFormat(
                                                                        PMOSTATUSTEMP_String_requestCOMMERCIAL_LAUNCH, Dates)+"'",
                                                                "PMO_STATUS_PROYECTOS_TEMP","ID_STATUS_PROYECTOS = "+D[11],2);
                                                         PMOSTATUSTEMP_String_requestDATE1 = new Negocio().valor("PMO_STATUS_PROYECTOS_TEMP",
                                                                 "COMMERCIAL_LAUNCH",  "ID_STATUS_PROYECTOS",D[11]);
                                                    }                                                
                                                %>
                                                <form action="status.jsp" method="post">
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <%if(PMOSTATUSTEMP_String_requestDATE1== null){%>
                                                                               <p>--Vacío--</p>
                                                                               <%}else{%>
                                                            <p class="tx_silde_bazul"><%=new Negocio().getDateFormat(PMOSTATUSTEMP_String_requestDATE1, Dates2)%></p> 
                                                            <%}%>
                                                        </td>
                                                        <td>
                                                            <input type="hidden" name="campo" value="crear"/>
                                                            <input type="hidden" name="field" value="COMMERCIAL_LAUNCH"/>
                                                            <input type="hidden" name="p" value="<%=D[0]%>" /> 
                                                            <input type="submit" name="submit_Retrasos_0" class="bt" value="Editar"/> 
                                                        </td>
                                                    </tr>
                                                </table>
                                                </form>                                                
                                                <%}else if(request.getParameter("campo").equals("crear")&&field.equals("COMMERCIAL_LAUNCH")){%>
                                                <%if(PMOSTATUSTEMP_String_requestDATE1 == null){%>
                                                                               <p>--Vacío--</p>
                                                                               <%}else{%>
                                                            <p class="tx_silde_bazul"><%=new Negocio().getDateFormat(PMOSTATUSTEMP_String_requestDATE1, Dates2)%></p> 
                                                            <%}%>
                                                            <table>
                                                    <tr>
                                                        <td>
                                                         <form action="status.jsp" method="post">
                                                            <input type="date" name="COMMERCIAL_LAUNCH" value="" required/>
                                                            <input type="hidden" name="p" value="<%=D[0]%>" /> 
                                                            <input type="hidden" name="campo" value="creado"/>                                                            
                                                            <input type="submit" name="submit_Retrasos_0" class="bt" value="Guardar"/>
                                                        </form>  
                                                        </td>
                                                        <td>
                                                         <form action="status.jsp" method="post">
                                                            <input type="hidden" name="p" value="<%=D[0]%>" /> 
                                                            <input type="submit" name="submit_Retrasos_0" class="bt" value="Cancelar"/>
                                                        </form>  
                                                        </td>
                                                    </tr>                                                    
                                                </table>       
                                                            <%}else{%>
                                                <%if(PMOSTATUSTEMP_String_requestDATE1 == null){%>
                                                                               <p>--Vacío--</p>
                                                                               <%}else{%>
                                                            <p class="tx_silde_bazul"><%=new Negocio().getDateFormat(PMOSTATUSTEMP_String_requestDATE1, Dates2)%></p> 
                                                            <%}%>
                                                <%}%>
                                            </td>
                                        </tr>   
                                        <tr>
                                            <td>
                                                <p class="tx_silde_bazul"><%= new Slides().getSlides(8, 7)%></p>
                                            </td>
                                            <td>
                                                <p class="tx_silde_bazul"><%=new Negocio().caracteres(D[6])%></p>
                                            </td>
                                        </tr> 
                                        <tr>
                                            <td class="gris">
                                                <p class="tx_silde_bazul"><%= new Slides().getSlides(8,8)%></p>
                                            </td>
                                            <td class="gris"> 
                                                <%
                                                String PMOSTATUSTEMP_Strings_RETRASOS = new Negocio().valor("PMO_STATUS_PROYECTOS_TEMP", "RETRASOS_RESPONSABLES", "PMO_PROYECTO", D[0]),
                                                        PMOSTATUSTEMP_String_requestRETRASOS_RESPONSABLES = request.getParameter("PMOSTATUSTEMP_RETRASOS");
                                                if(field==null||request.getParameter("borrar")==null){%> 
                                                <table>
                                                                        <tr>
                                                                            <td>
                                                                               <%if(PMOSTATUSTEMP_Strings_RETRASOS == null){%>
                                                                               <p>--Vacío--</p>
                                                                               <%}else{%>
                                                                               <table>
                                                                                   <%=new Negocio().getStringseparate(PMOSTATUSTEMP_Strings_RETRASOS)%>                                                        
                                                                               </table>
                                                                                   <%}%>
                                                                            </td>
                                                                            </tr>
                                                                                    <tr>
                                                                            <td>                                                                                
                                                                                <table>
                                                                                    <tr>      
                                                                                        <td>
                                                                                            <form action="status.jsp" method="post">
                                                                                                <input type="hidden" name="PMOSTATUSTEMP_ID" value="<%=D[11]%>"/> 
                                                                                                <input type="hidden" name="PMOSTATUSTEMP_USUARIO" value="<%=new Negocio().valor("PMIS_USO", "USUARIO_USO", "ID_USO", 
                                                                                                    new Negocio().like("PMIS_USO", "max(ID_USO)", "CRITERIO_USO", "comunicacion")) %>"/>
                                                                                                <input type="hidden" name="campo" value="crear"/>
                                                                                                <input type="hidden" name="borrar" value="no"/>
                                                                                                <input type="hidden" name="field" value="RETRASOS_RESPONSABLES"/>
                                                                                                <input type="hidden" name="p" value="<%=D[0]%>" /> 
                                                                                                <input type="submit" name="submit_Retrasos_0" class="bt" value="Añadir"/>   
                                                                                            </form> 
                                                                                        </td>   
                                                                                        <td>        
                                                                                            <form action="status.jsp" method="post">
                                                                                                <input type="hidden" name="PMOSTATUSTEMP_ID" value="<%=D[11]%>"/> 
                                                                                                <input type="hidden" name="borrar" value="si"/>  
                                                                                                <input type="hidden" name="campo" value="crear"/>
                                                                                                <input type="hidden" name="field" value="RETRASOS_RESPONSABLES"/>
                                                                                                <input type="hidden" name="p" value="<%=D[0]%>" />                                                                                                 
                                                                                                <input type="hidden" name="PMOSTATUSTEMP_USUARIO" value="<%=new Negocio().valor("PMIS_USO", "USUARIO_USO", "ID_USO", 
                                                                                                    new Negocio().like("PMIS_USO", "max(ID_USO)", "CRITERIO_USO", "comunicacion")) %>"/>
                                                                                                <input type="submit" name="submit_Retrasos_1" class="bt" value="Limpiar y Añadir"/>  
                                                                                            </form>
                                                                                        </td> 
                                                                                    </tr>
                                                                                </table>               
                                                                            </td>                        
                                                                        </tr>
                                                                    </table>
                                                <%}else if(field.equals("RETRASOS_RESPONSABLES")){                                                     
                                                    if(request.getParameter("borrar").equals("si")){
                                                        new Negocio().editar("RETRASOS_RESPONSABLES = ''", "PMO_STATUS_PROYECTOS_TEMP", "ID_STATUS_PROYECTOS = "+PMOSTATUSTEMP_String_requestID, 2);
                                                    }
                                                    String []  
                                                            PMOSTATUS_Strings_editRETRASOS_RESPONSABLES = {
                                                                "PMO_STATUS_PROYECTOS_TEMP", 
                                                                "RETRASOS_RESPONSABLES = concat('"+PMOSTATUSTEMP_String_requestRETRASOS_RESPONSABLES+"|',RETRASOS_RESPONSABLES)",                                                            
                                                                "ID_STATUS_PROYECTOS = "+PMOSTATUSTEMP_String_requestID+" and USUARIO_PERSONA = '"+PMOSTATUSTEMP_String_requestUSUARIO+"'",
                                                                "2"}
                                                            ;                                                    
                                                    if(new Negocio().valor( 
                                                            "PMO_STATUS_PROYECTOS_TEMP", 
                                                            "RETRASOS_RESPONSABLES", 
                                                            "ID_STATUS_PROYECTOS", 
                                                            PMOSTATUSTEMP_String_requestID+" and USUARIO_PERSONA = '"+PMOSTATUSTEMP_String_requestUSUARIO+"'")==null){  
                                                        PMOSTATUS_Strings_editRETRASOS_RESPONSABLES[1] = "RETRASOS_RESPONSABLES = '"+PMOSTATUSTEMP_String_requestRETRASOS_RESPONSABLES+"'"; 
                                                    }
                                                    String PMOSTATUSTEMP_String_readRETRASOS_RESPONSABLES = new Negocio().valor(
                                                            "PMO_STATUS_PROYECTOS_TEMP", 
                                                            "RETRASOS_RESPONSABLES", 
                                                            "ID_STATUS_PROYECTOS", 
                                                            PMOSTATUSTEMP_String_requestID+" and USUARIO_PERSONA = '"+PMOSTATUSTEMP_String_requestUSUARIO+"'");                                                    
                                                    if(request.getParameter("campo").equals("creado")){
                                                        
                                                    if(PMOSTATUSTEMP_String_requestRETRASOS_RESPONSABLES == null){
                                                        
                                                    }else{
                                                       new Negocio().setStringseparate(PMOSTATUS_Strings_editRETRASOS_RESPONSABLES); 
                                                    }
                                                    PMOSTATUSTEMP_String_readRETRASOS_RESPONSABLES = new Negocio().valor(
                                                            "PMO_STATUS_PROYECTOS_TEMP", 
                                                            "RETRASOS_RESPONSABLES", 
                                                            "ID_STATUS_PROYECTOS", 
                                                            PMOSTATUSTEMP_String_requestID+" and USUARIO_PERSONA = '"+PMOSTATUSTEMP_String_requestUSUARIO+"'"); 
                                                        %>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <% if(request.getParameter("borrar").equals("si")||PMOSTATUSTEMP_String_readRETRASOS_RESPONSABLES==null){%>
                                                                               <p>--Vacío--</p>
                                                                               <%}else{%>
                                                                    <table>
                                                                        <%=new Negocio().getStringseparate(PMOSTATUSTEMP_String_readRETRASOS_RESPONSABLES)%>
                                                                    </table>    
                                                                    <%}%>
                                                                </td>
                                                                </tr>
                                                                                    <tr>
                                                                <td>
                                                                    <form action="status.jsp" method="post">                                                                
                                                                        <input type="hidden" name="PMOSTATUSTEMP_ID" value="<%=PMOSTATUSTEMP_String_requestID%>"/>
                                                                        <input type="hidden" name="PMOSTATUSTEMP_USUARIO" value="<%=PMOSTATUSTEMP_String_requestUSUARIO%>"/>
                                                                        <input type="hidden" name="PMOSTATUSTEMP_RETRASOS" value="<%=PMOSTATUSTEMP_String_requestRETRASOS_RESPONSABLES%>"/>
                                                                        <input type="hidden" name="p" value="<%=D[0]%>" />   
                                                                        <input type="hidden" name="campo" value="editar"/>
                                                                        <input type="hidden" name="field" value="RETRASOS_RESPONSABLES"/>
                                                                        <input type="hidden" name="borrar" value="no"/> 
                                                                        <input type="submit" name="submit_Retrasos_2" class="bt" value="Agregar"/>
                                                                    </form> 
                                                                        <form action="status.jsp" method="post">       
                                                                            <input type="hidden" name="p" value="<%=D[0]%>" /> 
                                                                            <input type="hidden" name="PMOSTATUSTEMP_ID" value="<%=PMOSTATUSTEMP_String_requestID%>"/>
                                                                            <input type="submit" name="submit_Retrasos_2" class="bt" value="Finalizar"/>
                                                                        </form> 
                                                                </td>
                                                            </tr>
                                                        </table>
                                                <%}else{%>
                                                                    <% if(request.getParameter("borrar").equals("si")||PMOSTATUSTEMP_String_readRETRASOS_RESPONSABLES==null){%>
                                                                               <p>--Vacío--</p>
                                                                               <%}else{%>
                                                                    <table>
                                                                        <%=new Negocio().getStringseparate(PMOSTATUSTEMP_String_readRETRASOS_RESPONSABLES)%>
                                                                    </table> 
                                                                    <%}%>
                                                                            <table>
                                                                                <tr>                                                           
                                                                                    <td> 
                                                                                        <form action="status.jsp" method="post">                                                               
                                                                                            <table>                                                                    
                                                                                                <tr>
                                                                                                    <td>                                                                                                                                
                                                                                                        <input type="hidden" name="PMOSTATUSTEMP_ID" value="<%=PMOSTATUSTEMP_String_requestID%>"/>                   
                                                                                                        <input type="hidden" name="PMOSTATUSTEMP_USUARIO" value="<%=PMOSTATUSTEMP_String_requestUSUARIO%>"/>
                                                                                                        <input type="text" name="PMOSTATUSTEMP_RETRASOS" required pattern="[A-z-0-9- ]+"/>  
                                                                                                        <input type="hidden" name="campo" value="creado"/>
                                                                                                        <input type="hidden" name="field" value="RETRASOS_RESPONSABLES"/>
                                                                                                        <input type="hidden" name="borrar" value="no"/> 
                                                                                                        <input type="hidden" name="p" value="<%=D[0]%>" />                                                                   
                                                                                                    </td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td>
                                                                                                        <input type="submit" name="submit_Retrasos_1" class="bt" value="Guardar"/>
                                                                                                    </td>
                                                                                                </tr>
                                                                                            </table>    
                                                                                        </form>                                                           
                                                                                    </td>
                                                                                    <td>
                                                                                        <form action="status.jsp" method="post">
                                                                                            <input type="hidden" name="PMOSTATUSTEMP_ID" value="<%=PMOSTATUSTEMP_String_requestID%>"/>
                                                                                            <input type="hidden" name="PMOSTATUSTEMP_USUARIO" value="<%=PMOSTATUSTEMP_String_requestUSUARIO%>"/>
                                                                                            <input type="hidden" name="campo" value="creado"/>
                                                                                            <input type="hidden" name="borrar" value="no"/> 
                                                                                            <input type="hidden" name="field" value="RETRASOS_RESPONSABLES"/>
                                                                                            <input type="submit" name="submit_Retrasos_1" class="bt" value="Cancelar"/>
                                                                                            <input type="hidden" name="p" value="<%=D[0]%>" />   
                                                                                        </form>                                                                                                                                   
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                <%}}else{%>
                                                                               <%if(PMOSTATUSTEMP_Strings_RETRASOS==null){%>
                                                <p>--Vacío--</p>
                                                                               <% }else{%>
                                                                               <table>
                                                                                   <%=new Negocio().getStringseparate(PMOSTATUSTEMP_Strings_RETRASOS)%>                                                        
                                                                               </table>
                                                                                   <%}}%>
                                            </td>
                                        </tr> 
                                        <tr>
                                            <td>
                                                <p class="tx_silde_bazul"><%= new Slides().getSlides(8, 9)%></p>
                                            </td>
                                            <td>
                                                <p class="tx_silde_bazul"><%=D[1]%>%</p>
                                            </td>
                                        </tr>  
                                     </table> 
                                        </td>
                                    </tr>
                                </table>                              
                            </div>
                            <div style="border: thin solid rgb(0, 32, 96); padding: 1px; margin: 10px;">
                                <div class="status_acciones">
                                    <%= new Slides().getSlides(8, 10)%>
                                    <div>
                                                 <%
                                                String PMOSTATUSTEMP_Strings_ACTIVIDADES = new Negocio().valor("PMO_STATUS_PROYECTOS_TEMP", "ACTIVIDADES", "PMO_PROYECTO", D[0]),
                                                        PMOSTATUSTEMP_String_requestACTIVIDADES = request.getParameter("PMOSTATUSTEMP_ACTIVIDADES");             
                                                
                                                if(field==null||request.getParameter("borrar")==null){%>
                                                <table>
                                                                        <tr>
                                                                            <td>
                                                                               <%if(PMOSTATUSTEMP_Strings_ACTIVIDADES == null){%>
                                                                               <p>--Vacío--</p>
                                                                               <%}else{%>
                                                                               <table>
                                                                                   <%=new Negocio().getStringseparate(PMOSTATUSTEMP_Strings_ACTIVIDADES)%>                                                        
                                                                               </table>
                                                                                   <%}%>
                                                                            </td>
                                                                            </tr>
                                                                                    <tr>
                                                                            <td>                                                                                
                                                                                <table>
                                                                                    <tr>      
                                                                                        <td>
                                                                                            <form action="status.jsp" method="post">
                                                                                                <input type="hidden" name="PMOSTATUSTEMP_ID" value="<%=D[11]%>"/> 
                                                                                                <input type="hidden" name="PMOSTATUSTEMP_USUARIO" value="<%=new Negocio().valor("PMIS_USO", "USUARIO_USO", "ID_USO", 
                                                                                                    new Negocio().like("PMIS_USO", "max(ID_USO)", "CRITERIO_USO", "comunicacion")) %>"/>
                                                                                                <input type="hidden" name="campo" value="crear"/>
                                                                                                <input type="hidden" name="borrar" value="no"/>
                                                                                                <input type="hidden" name="field" value="ACTIVIDADES"/>
                                                                                                <input type="hidden" name="p" value="<%=D[0]%>" /> 
                                                                                                <input type="submit" name="submit_Retrasos_0" class="bt" value="Añadir"/>   
                                                                                            </form> 
                                                                                        </td>   
                                                                                        <td>        
                                                                                            <form action="status.jsp" method="post">
                                                                                                <input type="hidden" name="PMOSTATUSTEMP_ID" value="<%=D[11]%>"/> 
                                                                                                <input type="hidden" name="borrar" value="si"/>  
                                                                                                <input type="hidden" name="campo" value="crear"/>
                                                                                                <input type="hidden" name="field" value="ACTIVIDADES"/>
                                                                                                <input type="hidden" name="p" value="<%=D[0]%>" />                                                                                                 
                                                                                                <input type="hidden" name="PMOSTATUSTEMP_USUARIO" value="<%=new Negocio().valor("PMIS_USO", "USUARIO_USO", "ID_USO", 
                                                                                                    new Negocio().like("PMIS_USO", "max(ID_USO)", "CRITERIO_USO", "comunicacion")) %>"/>
                                                                                                <input type="submit" name="submit_Retrasos_1" class="bt" value="Limpiar y Añadir"/>  
                                                                                            </form>
                                                                                        </td> 
                                                                                    </tr>
                                                                                </table>               
                                                                            </td>                        
                                                                        </tr>
                                                                    </table>
                                                                                
                                                
                                                <%}else if(field.equals("ACTIVIDADES")){     
                                                    if(request.getParameter("borrar").equals("si")){
                                                        new Negocio().editar("ACTIVIDADES = ''", "PMO_STATUS_PROYECTOS_TEMP", "ID_STATUS_PROYECTOS = "+PMOSTATUSTEMP_String_requestID, 2);
                                                    }
                                                    String []  
                                                            PMOSTATUS_Strings_editACTIVIDADES = {
                                                                "PMO_STATUS_PROYECTOS_TEMP", 
                                                                "ACTIVIDADES = concat('"+PMOSTATUSTEMP_String_requestACTIVIDADES+"|',ACTIVIDADES)",                                                            
                                                                "ID_STATUS_PROYECTOS = "+PMOSTATUSTEMP_String_requestID+" and USUARIO_PERSONA = '"+PMOSTATUSTEMP_String_requestUSUARIO+"'",
                                                                "2"}
                                                            ;                                                    
                                                    if(new Negocio().valor(
                                                            "PMO_STATUS_PROYECTOS_TEMP", 
                                                            "ACTIVIDADES", 
                                                            "ID_STATUS_PROYECTOS", 
                                                            PMOSTATUSTEMP_String_requestID+" and USUARIO_PERSONA = '"+PMOSTATUSTEMP_String_requestUSUARIO+"'")==null){  
                                                        PMOSTATUS_Strings_editACTIVIDADES[1] = "ACTIVIDADES = '"+PMOSTATUSTEMP_String_requestACTIVIDADES+"'"; 
                                                    }
                                                    String PMOSTATUSTEMP_String_readACTIVIDADES = new Negocio().valor(
                                                            "PMO_STATUS_PROYECTOS_TEMP", 
                                                            "ACTIVIDADES", 
                                                            "ID_STATUS_PROYECTOS", 
                                                            PMOSTATUSTEMP_String_requestID+" and USUARIO_PERSONA = '"+PMOSTATUSTEMP_String_requestUSUARIO+"'");                                                    
                                                    if(request.getParameter("campo").equals("creado")){
                                                        
                                                    if(PMOSTATUSTEMP_String_requestACTIVIDADES == null){
                                                        
                                                    }else{
                                                       new Negocio().setStringseparate(PMOSTATUS_Strings_editACTIVIDADES); 
                                                    }
                                                    PMOSTATUSTEMP_String_readACTIVIDADES = new Negocio().valor(
                                                            "PMO_STATUS_PROYECTOS_TEMP", 
                                                            "ACTIVIDADES", 
                                                            "ID_STATUS_PROYECTOS", 
                                                            PMOSTATUSTEMP_String_requestID+" and USUARIO_PERSONA = '"+PMOSTATUSTEMP_String_requestUSUARIO+"'"); 
                                                        %>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <% if(request.getParameter("borrar").equals("si")||PMOSTATUSTEMP_String_readACTIVIDADES==null){%>
                                                                               <p>--Vacío--</p>
                                                                               <%}else{%>
                                                                    <table>
                                                                        <%=new Negocio().getStringseparate(PMOSTATUSTEMP_String_readACTIVIDADES)%>
                                                                    </table>    
                                                                    <%}%>
                                                                </td>
                                                                </tr>
                                                                                    <tr>
                                                                <td>
                                                                    <form action="status.jsp" method="post">                                                                
                                                                        <input type="hidden" name="PMOSTATUSTEMP_ID" value="<%=PMOSTATUSTEMP_String_requestID%>"/>
                                                                        <input type="hidden" name="PMOSTATUSTEMP_USUARIO" value="<%=PMOSTATUSTEMP_String_requestUSUARIO%>"/>
                                                                        <input type="hidden" name="PMOSTATUSTEMP_ACTIVIDADES" value="<%=PMOSTATUSTEMP_String_requestACTIVIDADES%>"/>
                                                                        <input type="hidden" name="p" value="<%=D[0]%>" />   
                                                                        <input type="hidden" name="campo" value="editar"/>
                                                                        <input type="hidden" name="borrar" value="no"/> 
                                                                        <input type="hidden" name="field" value="ACTIVIDADES"/>
                                                                        <input type="submit" name="submit_Retrasos_2" class="bt" value="Agregar"/>
                                                                    </form> 
                                                                        <form action="status.jsp" method="post">       
                                                                            <input type="hidden" name="p" value="<%=D[0]%>" /> 
                                                                            <input type="hidden" name="PMOSTATUSTEMP_ID" value="<%=PMOSTATUSTEMP_String_requestID%>"/>
                                                                            <input type="submit" name="submit_Retrasos_2" class="bt" value="Finalizar"/>
                                                                        </form> 
                                                                </td>
                                                            </tr>
                                                        </table>
                                                <%}else{%>
                                                                    <% if(request.getParameter("borrar").equals("si")||PMOSTATUSTEMP_String_readACTIVIDADES==null){%>
                                                                               <p>--Vacío--</p>
                                                                               <%}else{%>
                                                                    <table>
                                                                        <%=new Negocio().getStringseparate(PMOSTATUSTEMP_String_readACTIVIDADES)%>
                                                                    </table> 
                                                                    <%}%>
                                                                            <table>
                                                                                <tr>                                                           
                                                                                    <td> 
                                                                                        <form action="status.jsp" method="post">                                                               
                                                                                            <table>                                                                    
                                                                                                <tr>
                                                                                                    <td>                                                                                                                                
                                                                                                        <input type="hidden" name="PMOSTATUSTEMP_ID" value="<%=PMOSTATUSTEMP_String_requestID%>"/>                   
                                                                                                        <input type="hidden" name="PMOSTATUSTEMP_USUARIO" value="<%=PMOSTATUSTEMP_String_requestUSUARIO%>"/>
                                                                                                        <textarea  name="PMOSTATUSTEMP_ACTIVIDADES" required cols="300" rows="2"></textarea>  
                                                                                                        <input type="hidden" name="campo" value="creado"/>
                                                                                                        <input type="hidden" name="field" value="ACTIVIDADES"/>
                                                                                                        <input type="hidden" name="borrar" value="no"/> 
                                                                                                        <input type="hidden" name="p" value="<%=D[0]%>" />                                                                   
                                                                                                    </td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td>
                                                                                                        <input type="submit" name="submit_Retrasos_1" class="bt" value="Guardar"/>
                                                                                                    </td>
                                                                                                </tr>
                                                                                            </table>    
                                                                                        </form>                                                           
                                                                                    </td>
                                                                                    <td>
                                                                                        <form action="status.jsp" method="post">
                                                                                            <input type="hidden" name="PMOSTATUSTEMP_ID" value="<%=PMOSTATUSTEMP_String_requestID%>"/>
                                                                                            <input type="hidden" name="PMOSTATUSTEMP_USUARIO" value="<%=PMOSTATUSTEMP_String_requestUSUARIO%>"/>
                                                                                            <input type="hidden" name="campo" value="creado"/>
                                                                                            <input type="hidden" name="field" value="ACTIVIDADES"/>
                                                                                            <input type="hidden" name="borrar" value="no"/> 
                                                                                            <input type="submit" name="submit_Retrasos_1" class="bt" value="Cancelar"/>
                                                                                            <input type="hidden" name="p" value="<%=D[0]%>" />   
                                                                                        </form>                                                                                                                                   
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                <%}}else{%>
                                                <%if(PMOSTATUSTEMP_Strings_ACTIVIDADES==null){%>
                                                <p>--Vacío--</p>
                                                                               <% }else{%>
                                                <table>
                                                        <%=new Negocio().getStringseparate(PMOSTATUSTEMP_Strings_ACTIVIDADES)%>
                                                    </table>
                                                                               <%}}%>           
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
                                                   <%
                                                String PMOSTATUSTEMP_Strings_LOGROS = new Negocio().valor("PMO_STATUS_PROYECTOS_TEMP", "LOGROS", "PMO_PROYECTO", D[0]),
                                                        PMOSTATUSTEMP_String_requestLOGROS = request.getParameter("PMOSTATUSTEMP_LOGROS");             
                                                
                                                if(field==null||request.getParameter("borrar")==null){%>
                                                <table>
                                                                        <tr>
                                                                            <td>
                                                                               <%if(PMOSTATUSTEMP_Strings_LOGROS == null){%>
                                                                               <p>--Vacío--</p>
                                                                               <%}else{%>
                                                                               <table>
                                                                                   <%=new Negocio().getStringseparate(PMOSTATUSTEMP_Strings_LOGROS)%>                                                        
                                                                               </table>
                                                                                   <%}%>
                                                                            </td>
                                                                            </tr>
                                                                                    <tr>
                                                                            <td>                                                                                
                                                                                <table>
                                                                                    <tr>      
                                                                                        <td>
                                                                                            <form action="status.jsp" method="post">
                                                                                                <input type="hidden" name="PMOSTATUSTEMP_ID" value="<%=D[11]%>"/> 
                                                                                                <input type="hidden" name="PMOSTATUSTEMP_USUARIO" value="<%=new Negocio().valor("PMIS_USO", "USUARIO_USO", "ID_USO", 
                                                                                                    new Negocio().like("PMIS_USO", "max(ID_USO)", "CRITERIO_USO", "comunicacion")) %>"/>
                                                                                                <input type="hidden" name="campo" value="crear"/>
                                                                                                <input type="hidden" name="borrar" value="no"/>
                                                                                                <input type="hidden" name="field" value="LOGROS"/>
                                                                                                <input type="hidden" name="p" value="<%=D[0]%>" /> 
                                                                                                <input type="submit" name="submit_Retrasos_0" class="bt" value="Añadir"/>   
                                                                                            </form> 
                                                                                        </td>   
                                                                                        <td>        
                                                                                            <form action="status.jsp" method="post">
                                                                                                <input type="hidden" name="PMOSTATUSTEMP_ID" value="<%=D[11]%>"/> 
                                                                                                <input type="hidden" name="borrar" value="si"/>  
                                                                                                <input type="hidden" name="campo" value="crear"/>
                                                                                                <input type="hidden" name="field" value="LOGROS"/>
                                                                                                <input type="hidden" name="p" value="<%=D[0]%>" />                                                                                                 
                                                                                                <input type="hidden" name="PMOSTATUSTEMP_USUARIO" value="<%=new Negocio().valor("PMIS_USO", "USUARIO_USO", "ID_USO", 
                                                                                                    new Negocio().like("PMIS_USO", "max(ID_USO)", "CRITERIO_USO", "comunicacion")) %>"/>
                                                                                                <input type="submit" name="submit_Retrasos_1" class="bt" value="Limpiar y Añadir"/>  
                                                                                            </form>
                                                                                        </td> 
                                                                                    </tr>
                                                                                </table>               
                                                                            </td>                        
                                                                        </tr>
                                                                    </table>
                                                                                                    <%}else if(field.equals("LOGROS")){     
                                                    if(request.getParameter("borrar").equals("si")){
                                                        new Negocio().editar("LOGROS = ''", "PMO_STATUS_PROYECTOS_TEMP", "ID_STATUS_PROYECTOS = "+PMOSTATUSTEMP_String_requestID, 2);
                                                    }
                                                    String []  
                                                            PMOSTATUS_Strings_editLOGROS = {
                                                                "PMO_STATUS_PROYECTOS_TEMP", 
                                                                "LOGROS = concat('"+PMOSTATUSTEMP_String_requestLOGROS+"|',LOGROS)",                                                            
                                                                "ID_STATUS_PROYECTOS = "+PMOSTATUSTEMP_String_requestID+" and USUARIO_PERSONA = '"+PMOSTATUSTEMP_String_requestUSUARIO+"'",
                                                                "2"}
                                                            ;                                                    
                                                    if(new Negocio().valor(
                                                            "PMO_STATUS_PROYECTOS_TEMP", 
                                                            "LOGROS", 
                                                            "ID_STATUS_PROYECTOS", 
                                                            PMOSTATUSTEMP_String_requestID+" and USUARIO_PERSONA = '"+PMOSTATUSTEMP_String_requestUSUARIO+"'")==null){  
                                                        PMOSTATUS_Strings_editLOGROS[1] = "LOGROS = '"+PMOSTATUSTEMP_String_requestLOGROS+"'"; 
                                                    }
                                                    String PMOSTATUSTEMP_String_readLOGROS = new Negocio().valor(
                                                            "PMO_STATUS_PROYECTOS_TEMP", 
                                                            "LOGROS", 
                                                            "ID_STATUS_PROYECTOS", 
                                                            PMOSTATUSTEMP_String_requestID+" and USUARIO_PERSONA = '"+PMOSTATUSTEMP_String_requestUSUARIO+"'");                                                    
                                                    if(request.getParameter("campo").equals("creado")){
                                                        
                                                    if(PMOSTATUSTEMP_String_requestLOGROS == null){
                                                        
                                                    }else{
                                                       new Negocio().setStringseparate(PMOSTATUS_Strings_editLOGROS); 
                                                    }
                                                    PMOSTATUSTEMP_String_readLOGROS = new Negocio().valor(
                                                            "PMO_STATUS_PROYECTOS_TEMP", 
                                                            "LOGROS", 
                                                            "ID_STATUS_PROYECTOS", 
                                                            PMOSTATUSTEMP_String_requestID+" and USUARIO_PERSONA = '"+PMOSTATUSTEMP_String_requestUSUARIO+"'"); 
                                                        %>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <% if(request.getParameter("borrar").equals("si")||PMOSTATUSTEMP_String_readLOGROS==null){%>
                                                                               <p>--Vacío--</p>
                                                                               <%}else{%>
                                                                    <table>
                                                                        <%=new Negocio().getStringseparate(PMOSTATUSTEMP_String_readLOGROS)%>
                                                                    </table>    
                                                                    <%}%>
                                                                </td>
                                                                </tr>
                                                                <tr>
                                                                <td>
                                                                    <form action="status.jsp" method="post">                                                                
                                                                        <input type="hidden" name="PMOSTATUSTEMP_ID" value="<%=PMOSTATUSTEMP_String_requestID%>"/>
                                                                        <input type="hidden" name="PMOSTATUSTEMP_USUARIO" value="<%=PMOSTATUSTEMP_String_requestUSUARIO%>"/>
                                                                        <input type="hidden" name="PMOSTATUSTEMP_LOGROS" value="<%=PMOSTATUSTEMP_String_requestLOGROS%>"/>
                                                                        <input type="hidden" name="p" value="<%=D[0]%>" />   
                                                                        <input type="hidden" name="campo" value="editar"/>
                                                                        <input type="hidden" name="borrar" value="no"/> 
                                                                        <input type="hidden" name="field" value="LOGROS"/>
                                                                        <input type="submit" name="submit_Retrasos_2" class="bt" value="Agregar"/>
                                                                    </form> 
                                                                        <form action="status.jsp" method="post">       
                                                                            <input type="hidden" name="p" value="<%=D[0]%>" /> 
                                                                            <input type="hidden" name="PMOSTATUSTEMP_ID" value="<%=PMOSTATUSTEMP_String_requestID%>"/>
                                                                            <input type="submit" name="submit_Retrasos_2" class="bt" value="Finalizar"/>
                                                                        </form> 
                                                                </td>
                                                            </tr>
                                                        </table>
                                                <%}else{%>
                                                                    <% if(request.getParameter("borrar").equals("si")||PMOSTATUSTEMP_String_readLOGROS==null){%>
                                                                               <p>--Vacío--</p>
                                                                               <%}else{%>
                                                                    <table>
                                                                        <%=new Negocio().getStringseparate(PMOSTATUSTEMP_String_readLOGROS)%>
                                                                    </table> 
                                                                    <%}%>
                                                                            <table>
                                                                                <tr>                                                           
                                                                                    <td> 
                                                                                        <form action="status.jsp" method="post">                                                               
                                                                                            <table>                                                                    
                                                                                                <tr>
                                                                                                    <td>                                                                                                                                
                                                                                                        <input type="hidden" name="PMOSTATUSTEMP_ID" value="<%=PMOSTATUSTEMP_String_requestID%>"/>                   
                                                                                                        <input type="hidden" name="PMOSTATUSTEMP_USUARIO" value="<%=PMOSTATUSTEMP_String_requestUSUARIO%>"/>
                                                                                                        <textarea  name="PMOSTATUSTEMP_LOGROS" required cols="300" rows="2"></textarea>  
                                                                                                        <input type="hidden" name="campo" value="creado"/>
                                                                                                        <input type="hidden" name="field" value="LOGROS"/>
                                                                                                        <input type="hidden" name="borrar" value="no"/> 
                                                                                                        <input type="hidden" name="p" value="<%=D[0]%>" />                                                                   
                                                                                                    </td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td>
                                                                                                        <input type="submit" name="submit_Retrasos_1" class="bt" value="Guardar"/>
                                                                                                    </td>
                                                                                                </tr>
                                                                                            </table>    
                                                                                        </form>                                                           
                                                                                    </td>
                                                                                    <td>
                                                                                        <form action="status.jsp" method="post">
                                                                                            <input type="hidden" name="PMOSTATUSTEMP_ID" value="<%=PMOSTATUSTEMP_String_requestID%>"/>
                                                                                            <input type="hidden" name="PMOSTATUSTEMP_USUARIO" value="<%=PMOSTATUSTEMP_String_requestUSUARIO%>"/>
                                                                                            <input type="hidden" name="campo" value="creado"/>
                                                                                            <input type="hidden" name="field" value="LOGROS"/>
                                                                                            <input type="hidden" name="borrar" value="no"/> 
                                                                                            <input type="submit" name="submit_Retrasos_1" class="bt" value="Cancelar"/>
                                                                                            <input type="hidden" name="p" value="<%=D[0]%>" />   
                                                                                        </form>                                                                                                                                   
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                <%}}else{%>
                                                <%if(PMOSTATUSTEMP_Strings_LOGROS==null){%>
                                                <p>--Vacío--</p>
                                                                               <% }else{%>
                                                <table>
                                                        <%=new Negocio().getStringseparate(PMOSTATUSTEMP_Strings_LOGROS)%>
                                                    </table>
                                                                               <%}}%>          
                                                </div>                                                
                                            </div> 
                                        </td>
                                        <td>
                                            <div class="status_f">
                                                <b><%= new Slides().getSlides(8, 12)%></b>
                                                <div>
                                                    <%
                                                String PMOSTATUSTEMP_Strings_RIESGOS = new Negocio().valor("PMO_STATUS_PROYECTOS_TEMP", "RIESGOS", "PMO_PROYECTO", D[0]),
                                                        PMOSTATUSTEMP_String_requestRIESGOS = request.getParameter("PMOSTATUSTEMP_RIESGOS");             
                                                
                                                if(field==null||request.getParameter("borrar")==null){%>
                                                <table>
                                                                        <tr>
                                                                            <td>
                                                                               <%if(PMOSTATUSTEMP_Strings_RIESGOS == null){%>
                                                                               <p>--Vacío--</p>
                                                                               <%}else{%>
                                                                               <table>
                                                                                   <%=new Negocio().getStringseparate(PMOSTATUSTEMP_Strings_RIESGOS)%>                                                        
                                                                               </table>
                                                                                   <%}%>
                                                                            </td>
                                                                            </tr>
                                                                                    <tr>
                                                                            <td>                                                                                
                                                                                <table>
                                                                                    <tr>      
                                                                                        <td>
                                                                                            <form action="status.jsp" method="post">
                                                                                                <input type="hidden" name="PMOSTATUSTEMP_ID" value="<%=D[11]%>"/> 
                                                                                                <input type="hidden" name="PMOSTATUSTEMP_USUARIO" value="<%=new Negocio().valor("PMIS_USO", "USUARIO_USO", "ID_USO", 
                                                                                                    new Negocio().like("PMIS_USO", "max(ID_USO)", "CRITERIO_USO", "comunicacion")) %>"/>
                                                                                                <input type="hidden" name="campo" value="crear"/>
                                                                                                <input type="hidden" name="borrar" value="no"/>
                                                                                                <input type="hidden" name="field" value="RIESGOS"/>
                                                                                                <input type="hidden" name="p" value="<%=D[0]%>" /> 
                                                                                                <input type="submit" name="submit_Retrasos_0" class="bt" value="Añadir"/>   
                                                                                            </form> 
                                                                                        </td>   
                                                                                        <td>        
                                                                                            <form action="status.jsp" method="post">
                                                                                                <input type="hidden" name="PMOSTATUSTEMP_ID" value="<%=D[11]%>"/> 
                                                                                                <input type="hidden" name="borrar" value="si"/>  
                                                                                                <input type="hidden" name="campo" value="crear"/>
                                                                                                <input type="hidden" name="field" value="RIESGOS"/>
                                                                                                <input type="hidden" name="p" value="<%=D[0]%>" />                                                                                                 
                                                                                                <input type="hidden" name="PMOSTATUSTEMP_USUARIO" value="<%=new Negocio().valor("PMIS_USO", "USUARIO_USO", "ID_USO", 
                                                                                                    new Negocio().like("PMIS_USO", "max(ID_USO)", "CRITERIO_USO", "comunicacion")) %>"/>
                                                                                                <input type="submit" name="submit_Retrasos_1" class="bt" value="Limpiar y Añadir"/>  
                                                                                            </form>
                                                                                        </td> 
                                                                                    </tr>
                                                                                </table>               
                                                                            </td>                        
                                                                        </tr>
                                                                    </table>
                                                    <%}else if(field.equals("RIESGOS")){     
                                                    if(request.getParameter("borrar").equals("si")){
                                                        new Negocio().editar("RIESGOS = ''", "PMO_STATUS_PROYECTOS_TEMP", "ID_STATUS_PROYECTOS = "+PMOSTATUSTEMP_String_requestID, 2);
                                                    }
                                                    String []  
                                                            PMOSTATUS_Strings_editRIESGOS = {
                                                                "PMO_STATUS_PROYECTOS_TEMP", 
                                                                "RIESGOS = concat('"+PMOSTATUSTEMP_String_requestRIESGOS+"|',RIESGOS)",                                                            
                                                                "ID_STATUS_PROYECTOS = "+PMOSTATUSTEMP_String_requestID+" and USUARIO_PERSONA = '"+PMOSTATUSTEMP_String_requestUSUARIO+"'",
                                                                "2"}
                                                            ;                                                    
                                                    if(new Negocio().valor(
                                                            "PMO_STATUS_PROYECTOS_TEMP", 
                                                            "RIESGOS", 
                                                            "ID_STATUS_PROYECTOS", 
                                                            PMOSTATUSTEMP_String_requestID+" and USUARIO_PERSONA = '"+PMOSTATUSTEMP_String_requestUSUARIO+"'")==null){  
                                                        PMOSTATUS_Strings_editRIESGOS[1] = "RIESGOS = '"+PMOSTATUSTEMP_String_requestRIESGOS+"'"; 
                                                    }
                                                    String PMOSTATUSTEMP_String_readRIESGOS = new Negocio().valor(
                                                            "PMO_STATUS_PROYECTOS_TEMP", 
                                                            "RIESGOS", 
                                                            "ID_STATUS_PROYECTOS", 
                                                            PMOSTATUSTEMP_String_requestID+" and USUARIO_PERSONA = '"+PMOSTATUSTEMP_String_requestUSUARIO+"'");                                                    
                                                    if(request.getParameter("campo").equals("creado")){
                                                        
                                                    if(PMOSTATUSTEMP_String_requestRIESGOS == null){
                                                        
                                                    }else{
                                                       new Negocio().setStringseparate(PMOSTATUS_Strings_editRIESGOS); 
                                                    }
                                                    PMOSTATUSTEMP_String_readRIESGOS = new Negocio().valor(
                                                            "PMO_STATUS_PROYECTOS_TEMP", 
                                                            "RIESGOS", 
                                                            "ID_STATUS_PROYECTOS", 
                                                            PMOSTATUSTEMP_String_requestID+" and USUARIO_PERSONA = '"+PMOSTATUSTEMP_String_requestUSUARIO+"'"); 
                                                        %>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <% if(request.getParameter("borrar").equals("si")||PMOSTATUSTEMP_String_readRIESGOS==null){%>
                                                                               <p>--Vacío--</p>
                                                                               <%}else{%>
                                                                    <table>
                                                                        <%=new Negocio().getStringseparate(PMOSTATUSTEMP_String_readRIESGOS)%>
                                                                    </table>    
                                                                    <%}%>
                                                                </td>
                                                                </tr>
                                                                <tr>
                                                                <td>
                                                                    <form action="status.jsp" method="post">                                                                
                                                                        <input type="hidden" name="PMOSTATUSTEMP_ID" value="<%=PMOSTATUSTEMP_String_requestID%>"/>
                                                                        <input type="hidden" name="PMOSTATUSTEMP_USUARIO" value="<%=PMOSTATUSTEMP_String_requestUSUARIO%>"/>
                                                                        <input type="hidden" name="PMOSTATUSTEMP_RIESGOS" value="<%=PMOSTATUSTEMP_String_requestRIESGOS%>"/>
                                                                        <input type="hidden" name="p" value="<%=D[0]%>" />   
                                                                        <input type="hidden" name="campo" value="editar"/>
                                                                        <input type="hidden" name="borrar" value="no"/> 
                                                                        <input type="hidden" name="field" value="RIESGOS"/>
                                                                        <input type="submit" name="submit_Retrasos_2" class="bt" value="Agregar"/>
                                                                    </form> 
                                                                        <form action="status.jsp" method="post">       
                                                                            <input type="hidden" name="p" value="<%=D[0]%>" /> 
                                                                            <input type="hidden" name="PMOSTATUSTEMP_ID" value="<%=PMOSTATUSTEMP_String_requestID%>"/>
                                                                            <input type="submit" name="submit_Retrasos_2" class="bt" value="Finalizar"/>
                                                                        </form> 
                                                                </td>
                                                            </tr>
                                                        </table>
                                                <%}else{%>
                                                                    <% if(request.getParameter("borrar").equals("si")||PMOSTATUSTEMP_String_readRIESGOS==null){%>
                                                                               <p>--Vacío--</p>
                                                                               <%}else{%>
                                                                    <table>
                                                                        <%=new Negocio().getStringseparate(PMOSTATUSTEMP_String_readRIESGOS)%>
                                                                    </table> 
                                                                    <%}%>
                                                                            <table>
                                                                                <tr>                                                           
                                                                                    <td> 
                                                                                        <form action="status.jsp" method="post">                                                               
                                                                                            <table>                                                                    
                                                                                                <tr>
                                                                                                    <td>                                                                                                                                
                                                                                                        <input type="hidden" name="PMOSTATUSTEMP_ID" value="<%=PMOSTATUSTEMP_String_requestID%>"/>                   
                                                                                                        <input type="hidden" name="PMOSTATUSTEMP_USUARIO" value="<%=PMOSTATUSTEMP_String_requestUSUARIO%>"/>
                                                                                                        <textarea  name="PMOSTATUSTEMP_RIESGOS" required cols="300" rows="2"></textarea>  
                                                                                                        <input type="hidden" name="campo" value="creado"/>
                                                                                                        <input type="hidden" name="field" value="RIESGOS"/>
                                                                                                        <input type="hidden" name="borrar" value="no"/> 
                                                                                                        <input type="hidden" name="p" value="<%=D[0]%>" />                                                                   
                                                                                                    </td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td>
                                                                                                        <input type="submit" name="submit_Retrasos_1" class="bt" value="Guardar"/>
                                                                                                    </td>
                                                                                                </tr>
                                                                                            </table>    
                                                                                        </form>                                                           
                                                                                    </td>
                                                                                    <td>
                                                                                        <form action="status.jsp" method="post">
                                                                                            <input type="hidden" name="PMOSTATUSTEMP_ID" value="<%=PMOSTATUSTEMP_String_requestID%>"/>
                                                                                            <input type="hidden" name="PMOSTATUSTEMP_USUARIO" value="<%=PMOSTATUSTEMP_String_requestUSUARIO%>"/>
                                                                                            <input type="hidden" name="campo" value="creado"/>
                                                                                            <input type="hidden" name="field" value="RIESGOS"/>
                                                                                            <input type="hidden" name="borrar" value="no"/> 
                                                                                            <input type="submit" name="submit_Retrasos_1" class="bt" value="Cancelar"/>
                                                                                            <input type="hidden" name="p" value="<%=D[0]%>" />   
                                                                                        </form>                                                                                                                                   
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                <%}}else{%>
                                                <%if(PMOSTATUSTEMP_Strings_RIESGOS==null){%>
                                                <p>--Vacío--</p>
                                                <%}else{%>
                                                <table>
                                                    <%=new Negocio().getStringseparate(PMOSTATUSTEMP_Strings_RIESGOS)%>
                                                </table>
                                                <%}}%>        
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
    </body>
</html>

