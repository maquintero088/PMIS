<%-- 
    Document   : ejey
    Created on : 5/12/2014, 03:25:04 PM
    Author     : Marcel.Quintero
--%>

<%@page import="Negocio.Negocio"%>
<%@page import="Negocio.Dashboard"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
      <!--<link href="CSS/css.css" rel="stylesheet" type="text/css"/>-->
      <link href="CSS/table.css" rel="stylesheet" type="text/css"/>
      <title>PMO - actualización</title>
      <%
          String 
                  column=request.getParameter("column"),
                  valor=request.getParameter("valor");
          if(request.getParameter("column")==null||request.getParameter("valor")==null){
              column="";
              valor="";
          }else if(new Negocio().valor(column.replace("ID_", "PMO_"), column, "LOWER("+column.replace("ID_", "NOMBRE_")+")", "'"+valor.toLowerCase()+"'")==null){
              column="";
              valor="";
          }else{
              String table=column.replace("ID_", "PMO_");
              if(table.equals("PMO_TAREA")){
                  table=table.replace("TAREA", "TAREAS");
              }
              valor = new Negocio().valor(table, column, "LOWER("+column.replace("ID_", "NOMBRE_")+")", "'"+valor.toLowerCase()+"'");
          }          
          %> 
	  <script type="text/javascript" src="https://www.google.com/jsapi"></script>
       <script type="text/javascript">
	   google.load("visualization", "1.1", {packages:["bar"]});
      google.setOnLoadCallback(drawStuff);
      function drawStuff() {          
          var data8 = new google.visualization.arrayToDataTable([<%= new Dashboard().getChart("Actualizacion",column.toLowerCase()/*""*/,valor.toLowerCase()/*""*/,0)%>]); 
          var options = {
              chart:{
                  orientation: 'vertical',
                  hAxis: {title: 'Proyectos', titleTextStyle: {color: 'black'}},
                  legend: { position: 'top', maxLines: 3 },
                  bar: { groupWidth: '75%' },
                  isStacked: false
              },                            
              series: {
                  0: { axis: 'distance'} ,
                  1: { axis: 'brightness'}                         
              },
              axes: { 
                  y: {
                      distance: {side: 'right', label: 'Proyectos'} ,                      
                      brightness: {side: 'left', label: 'Dias'}                       
                  }
              }
          };
          var chart8 = new google.charts.Bar(document.getElementById('dashboard8'));
          chart8.draw(data8, options);
    };
    
	   </script>
	   </head>
	   <body>   
               <div id="dashboard8" style="min-width: 150%; height: 400px"></div>
	   <table>
               <tr>                   
                   <td>
                       <div class="marco">
                           <table>
                               <tr>
                                   <td>
                                       <form action="dsh_8.jsp" method="post">        
                                           <table>
                                               <tr>
                                                   <td>
                                                       <select name="column" class="bt2" >
                                                           <option value="ID_VICEPRESIDENCIA">Vicepresidencia</option>
                                                           <option value="ID_PM">Project Manager</option>
                                                           <option value="ID_TIPO_PROYECTO_MIC">Tipo de Proyecto MIC</option>                                
                                                            <option value="ID_AREA">Área</option> 
                                                            <option value="ID_TAREA">Tarea o Actividad</option>   
                                                        </select> 
                                                    </td>
                                                    <td>
                                                        <input type="search" name="valor" required=""/>
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
                   </td>
               </tr>
           </table>
           </body>
</html>
