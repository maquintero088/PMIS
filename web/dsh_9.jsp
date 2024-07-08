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
      <title>PMO - capacidad</title>
      <%    
          
          String 
                  column=request.getParameter("column"),
                  valor=request.getParameter("valor");
          if(request.getParameter("column")==null||request.getParameter("valor")==null||new Negocio().valor("PMO_CAPACIDAD", column, column, "'"+valor+"'")==null){
            column="";
            valor="";
        }
    //System.out.println(column);
    %>
    <script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script type="text/javascript">
        
      google.load("visualization", "1.1", {packages:["bar"]});
      google.setOnLoadCallback(drawStuff);
      
        
      
      function drawStuff() {
        var data9 = new google.visualization.arrayToDataTable([<%= new Dashboard().getChart("Capacidad",column,valor,0)%>]);

        var 
                view = new google.visualization.DataView(data9);
                    view.setColumns([0, 1,
                       { calc: "stringify",
                         sourceColumn: 1,
                         type: "string",
                         role: "annotation" },
                       2,
                       { calc: "stringify",
                         sourceColumn: 2,
                         type: "string",
                         role: "annotation" }]);
        
    var options = {
        chart:{
            orientation: 'vertical',
            hAxis: {title: 'Proyectos', titleTextStyle: {color: 'black'}},
            legend: { position: 'top', maxLines: 3 },
            bar: { groupWidth: '75%' },
            isStacked: false
        },                            
          series: {
            0: { axis: 'distance'}, // Bind series 0 to an axis named 'distance'.
            1: { axis: 'brightness'} // Bind series 1 to an axis named 'brightness'.
          },
          axes: {
            y: {
              distance: {side: 'right', label: 'No de Proyectos'}, // Left y-axis.
              brightness: {side: 'left', label: 'Puntaje'} // Right y-axis.
            }
          }
        };

      var chart9 = new google.charts.Bar(document.getElementById('dashboard9'));
      chart9.draw(view, options);
    };
    </script>
  </head>
  <body>
      <div id="dashboard9" style="min-width: 150%; height: 400px"></div>
      <table>
          <tr>              
              <td>
                  <div class="marco">
                            <table>
                                <tr>
                                    <td>
                                        <form action="dsh_9.jsp" method="post">        
                                            <table>
                                                <tr>
                                                    <td>
                                                        <select name="column" class="bt2" >
                                                            <option value="NOMBRE_PM">Project Manager</option>
                                                            <option value="NOMBRE_COMPLEJIDAD">Complejidad</option>
                                                            <option value="NOMBRE_TIPO_PROYECTO_MIC">Tipo de Proyecto MIC</option>                                
                                                            <option value="NOMBRE_TAREA">Tarea o Actividad</option>  
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
