<%-- 
    Document   : enviar
    Created on : 27/10/2014, 04:45:04 PM
    Author     : Marcel.Quintero
--%>


<%@page import="Negocio.Comunicacion"%>
<%@page import="java.io.File"%>
<%@page import="Negocio.Negocio"%>
<%@page import="Services.Slides"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
        <link href="../css/css.css" rel="stylesheet" type="text/css"/> 
        <link href="../images/tigopmo.png" type="image/x-icon" rel="shortcut icon" /> 
         <meta http-equiv="X-UA-Compatible" content="IE=11" />
        
           <% 
                String 
                     varString=request.getParameter("varString");
             int intSlide=Integer.parseInt(request.getParameter("slide"));   
             
             String [] INTERESADO_Strings_set = new String [new Negocio().count2("INT_INTERESADO", "PT_PERSONA", "PMO_PROYECTO", varString)];
             String [][] params = {{intSlide+"var1","page","slide"},{varString,"2FPMIS_Tigo_PMO%2Fcomunicacion.jsp",intSlide+""}};   
             //new Slides().exportar(request.getParameter("url"),params); 
             String [][] 
                    INTERESADO_Strings_init = new String [new Negocio().count2("INT_INTERESADO", "PT_PERSONA", "PMO_PROYECTO", Integer.parseInt(varString)+" and INT_ROL not in (2721)")][2]; 
            String [] 
                    INTERESADO_Strings_id = new Negocio().valores("INT_INTERESADO where PMO_PROYECTO = "+varString+" and INT_ROL not in (2721)", "PT_PERSONA", "PT_PERSONA");
            if(INTERESADO_Strings_init==null){
                //INTERESADO_Strings_init[0][0] = INTERESADO_Strings_id[0];
                //INTERESADO_Strings_init[0][1] = new Negocio().valor("PT_PERSONA", "NN_NOMBRES_PERSONA", "USUARIO_PERSONA", INTERESADO_Strings_id[0]);
                System.out.println("vacio");
            }else{
            for(int i=0;i<INTERESADO_Strings_init.length;i++){
                INTERESADO_Strings_init[i][0] = new Negocio().valor("PT_PERSONA", "MAIL_PERSONA", "USUARIO_PERSONA", "'"+INTERESADO_Strings_id[i]+"'");
                INTERESADO_Strings_init[i][1] = new Negocio().valor("PT_PERSONA", "NN_NOMBRES_PERSONA", "USUARIO_PERSONA", "'"+INTERESADO_Strings_id[i]+"'");
                //System.out.println(INTERESADO_Strings_init[i][0]+" - "+INTERESADO_Strings_init[i][1]);
            }}
             %>
             <script type="text/javascript">
                 function comprobar(valor) {
         var pulsado = false;//variable de comprobación
         var opciones = document.destinatario.PT_PERSONA; //array de elementos
         var elegido = -1; 
         //número del elemento elegido en el array
         for (i=0;i<opciones.length;i++) { //bucle de comprobación
               if (opciones[i].checked === true) {
               pulsado = true;
                 <% 
            INTERESADO_Strings_set = request.getParameterValues("PT_PERSONA");%>
               
               }
             }
          
         //if (pulsado === true) { //mensaje de formulario válido
           // miOpcion = opciones[elegido].value
            //alert("Has elegido la opción: " + miOpcion + "\n El formulario ha sido enviado.")
            //}
         //else { //mensaje de formulario no válido.
           // alert("no has elegido ninguna opción. \n Elige una opción para que el formulario pueda ser enviado")
           // return false //el formulario no se envía.
          //  }
         };
             </script>
             <%
         if(request.getParameter("Confirmar")==null||request.getParameterValues("PT_PERSONA")==null){       
             %>       
        
        <title>PMO - Comunicación</title>
    </head>
    <body>        
        <section>
            <div class="blanco">
                <table class="full">
                    <tr>
                        <td colspan="2"> 
                            <div class="min-marg">
                                <b class="tx_silde_bazul">Proceso de Notificación PMO</b>
                                <p>Por favor elija los interesados del proyecto a los que desea Notificar:</p>                        
                            </div> 
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <form method="post" action="../comunicacion.jsp">              
                                <input class="bt" type="submit" name="bt_volver" value="volver"/>
                                <input type="hidden" name="log" value="<%=request.getParameter("log")%>" />
                            </form>
                        </td>
                        <td class="grisk">
                            <form name="destinatario" method="post" action="enviar.jsp" onsubmit="comprobar()">                   
                    <div >
                        <table class="min-marg">
                            <%for(int i=0; i<INTERESADO_Strings_init.length;i++){%>                    
                            <tr>
                                <td>
                                    <%=INTERESADO_Strings_init[i][1]%>
                                </td>
                                <td>
                                    <input  type="checkbox" name="PT_PERSONA" value="<%=INTERESADO_Strings_init[i][0]%>" onblur="comprobar(<%=i%>)"/>
                                </td> 
                            </tr>
                            <%}%>
                            <tr>
                                <td>
                                    <div class="min-marg">
                            <input type="hidden" name="Confirmar" value="Si"/> 
                            <input type="hidden" name="varString" value="<%=varString%>"/> 
                            <input type="hidden" name="page" value="<%=request.getParameter("page")%>" />
                            <input type="hidden" name="url" value="<%=request.getParameter("url")%>" />
                            <input type="hidden" name="slide" value="<%=request.getParameter("slide")%>"/> 
                            <input type="hidden" name="log" value="<%=request.getParameter("log")%>" />
                            <input class="bt" type="submit" name="bt_enviar" value="Enviar"/>                    
                        </div>  
                                </td>
                            </tr>
                        </table>
                    </div>                                           
                </form>
                        </td>                        
                    </tr>
                </table>     
            </div>                                                            
        </section>               
        <%}else{                  
             
           
             String []
                     otros=new Negocio().valores(
                             "INT_INTERESADO where PMO_PROYECTO = "+varString+" and INT_ROL in (2721)", "PT_PERSONA", "PT_PERSONA");
             for(int cc = 0;cc<otros.length;cc++){
                 otros[cc]=new Negocio().valor("PT_PERSONA", "MAIL_PERSONA", "USUARIO_PERSONA", "'"+otros[cc]+"'");
             }     
                    switch(intSlide){
            case 0:
            case 1:
                String [] 
                        aprobacion={
                            new Slides().getSlides(4, 1)+                            
                            new Negocio().caracteres(
                                    new Negocio().in(
                                            "PMO_TOTAL_PROYECTOS",
                                            "NOMBRE_PROYECTO", 
                                            "ID_PROYECTOS", 
                                            varString
                                    )
                            )+new Slides().getSlides(4, 3)+   
                            new Negocio().in(
                                    "PMO_TIPO", 
                                    "NOMBRE_TIPO", 
                                    "ID_TIPO", 
                                    new Negocio().in(
                                            "PMO_TOTAL_PROYECTOS", 
                                            "ID_TIPO", 
                                            "ID_PROYECTOS", 
                                            varString
                                    )
                            )
                                ,
                            new Slides().getSlides(4, 5)+
                            new Negocio().in(
                                    "PMO_TOTAL_PROYECTOS", 
                                    "FECHA_PROXIMA_PRIORIZACION", 
                                    "ID_PROYECTOS", 
                                    varString
                            ).replace("00:00:00", "")+    
                            new Slides().getSlides(4, 7)
                        },
                        to=INTERESADO_Strings_set;
                    
                    new Slides().enviar(
                            aprobacion, 
                            "PMO-Aprobacion.pptx",
                            to,request.getParameter("url"),params
                    );
                    new Slides().enviar(
                            aprobacion, 
                            "PMO-Aprobacion.pptx",
                            otros,request.getParameter("url"),params
                    );
                break;
            case 2:
                String []
                    bau={
                        new Slides().getSlides(7, 0)+
                        new Negocio().caracteres(
                                new Negocio().in(
                                        "PMO_TOTAL_PROYECTOS", 
                                        "NOMBRE_PROYECTO", 
                                        "ID_PROYECTOS", 
                                        varString
                                )
                        )
                        ,
                        new Slides().getSlides(7, 2)+
                        new Negocio().in(
                                "PMO_TOTAL_PROYECTOS", 
                                "PRIORIZACION", 
                                "ID_PROYECTOS", 
                                varString
                        )
                    },
                    to2=INTERESADO_Strings_set;
                
                    new Slides().enviar(                            
                            bau, 
                            "PMO-Bau.pptx",
                            to2,request.getParameter("url"),params); 
                    new Slides().enviar(                            
                            bau, 
                            "PMO-Bau.pptx",
                            otros,request.getParameter("url"),params);
                break;
            case 3:
                String []
                    project={
                        new Slides().getSlides(6, 0)+
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
                        )
                            ,
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
                        )
                },cells [] = new Comunicacion().top() ,to3=INTERESADO_Strings_set;
                
                new Slides().enviar(
                            project, 
                            "PMO-Project.pptx",
                            to3,request.getParameter("url"),params);
                new Slides().enviar(
                            project, 
                            "PMO-Project.pptx",
                            otros,request.getParameter("url"),params);
                
                break;
            case 4:
                String ID_STATUS_PROYECTOS=new Negocio().in("PMO_STATUS_PROYECTOS", "max(ID_STATUS_PROYECTOS)", "PMO_PROYECTO", varString);
                String []
                        Avance = {
                            new Slides().getSlides(8, 0)+" "+
                                new Negocio().in("PMO_VIEW_TOTAL_PROYECTOS", "NOMBRE_TIPO", "ID_PROYECTOS", 
                                    new Negocio().in("PMO_STATUS_PROYECTOS", "PMO_PROYECTO", "ID_STATUS_PROYECTOS", ID_STATUS_PROYECTOS))+" "+
                                new Negocio().caracteres(new Negocio().in("PMO_VIEW_TOTAL_PROYECTOS", "NOMBRE_PROYECTO", "ID_PROYECTOS",                         
                                    new Negocio().in("PMO_STATUS_PROYECTOS", "PMO_PROYECTO", "ID_STATUS_PROYECTOS", ID_STATUS_PROYECTOS))),
                            new Negocio().in("PMO_VIEW_TOTAL_PROYECTOS", "DESCRIPCION_PROYECTO", "ID_PROYECTOS", 
                                new Negocio().in("PMO_STATUS_PROYECTOS", "PMO_PROYECTO", "ID_STATUS_PROYECTOS", ID_STATUS_PROYECTOS)),
                            new Slides().getSlides(8, 10)+"\n"+
                                new Negocio().in("PMO_STATUS_PROYECTOS", "ACTIVIDADES", "ID_STATUS_PROYECTOS", ID_STATUS_PROYECTOS),
                            new Slides().getSlides(8, 11)+"\n"+
                                new Negocio().in("PMO_STATUS_PROYECTOS", "LOGROS", "ID_STATUS_PROYECTOS", ID_STATUS_PROYECTOS),
                            new Slides().getSlides(8, 12)+"\n"+
                                new Negocio().in("PMO_STATUS_PROYECTOS", "RIESGOS", "ID_STATUS_PROYECTOS", ID_STATUS_PROYECTOS)
                        }
                        ,to4=INTERESADO_Strings_set;
                if(Avance[2]==null||Avance[3]==null||Avance[4]==null){
                    
                }else{
                    Avance[2]=Avance[2].replace("|", "\n");
                    Avance[3]=Avance[3].replace("|", "\n");
                    Avance[4]=Avance[4].replace("|", "\n");
                }
                new Slides().enviar(
                            Avance, 
                            "PMO-Avance.pptx",
                            to4,request.getParameter("url"),params);
                new Slides().enviar(
                            Avance, 
                            "PMO-Avance.pptx",
                            otros,request.getParameter("url"),params);
                break;
            case 5:
                
                break;
        }
        %><%@include file="../WEB-INF/jspf/continue.jspf" %><%
        }
        %> 
        
    </body>
</html>
