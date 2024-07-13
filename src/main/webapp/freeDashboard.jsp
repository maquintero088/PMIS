<%-- 
    Document   : Dashboard
    Created on : 10/09/2014, 03:00:22 PM
    Author     : Marcel.Quintero
--%>

<%@page import="com.qcmarcel.PMIS.Negocio.Negocio"%>
<%@page import="com.qcmarcel.PMIS.Negocio.Dashboard"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
       <link href="css/css.css" rel="stylesheet" type="text/css"/>        
        <link href="images/tigopmo.png" type="image/x-icon" rel="shortcut icon" />   
        <meta http-equiv="X-UA-Compatible" content="IE=11" />
        <title>PMO - Free Dashboard</title>
        <%
            String 
                G=request.getParameter("option_g"),
                T=new Negocio().in("PMIS_GRAFICA", "TITULO_GRAFICA", "ID_GRAFICA",request.getParameter("option_g"));
            String 
                column=request.getParameter("column"),
                valor=request.getParameter("valor");
        %>     
        <script type="text/javascript" src="https://www.google.com/jsapi"></script>
        <script type="text/javascript">
            google.load("visualization", "1", {packages:["corechart"]});
        google.setOnLoadCallback(drawChart1);
        function drawChart1() { 
            var 
                options = {
                    orientation: 'vertical',
                    hAxis: {title: 'Proyectos', titleTextStyle: {color: 'black'}},
                    legend: { position: 'top', maxLines: 3 },
                    bar: { groupWidth: '75%' },
                    isStacked: true
                };
        <%
            if(request.getParameter("column")==null||request.getParameter("valor")==null){
                column="";
                valor="";
            }
            if(G==null){%>
            
    
    <%}else if(G.equals("1")){%>
        var data1 = google.visualization.arrayToDataTable([<%= new Dashboard().getChart("VP",column,valor,1)%>]);
        var chart = new google.visualization.PieChart(document.getElementById('dashboard1'));
        chart.draw(data1, options);
    <%}else if(G.equals("2")){%>
        var data2 = google.visualization.arrayToDataTable([<%= new Dashboard().getChart("Estado",column,valor,1)%>]);
        var chart = new google.visualization.PieChart(document.getElementById('dashboard2'));
        chart.draw(data2, options);
    <%}else if(G.equals("3")){%>
        var data3 = google.visualization.arrayToDataTable([<%= new Dashboard().getChart("PM",column,valor,1)%>]);
        var chart = new google.visualization.PieChart(document.getElementById('dashboard3'));
        chart.draw(data3, options);
    <%}else if(G.equals("4")){%>
        var data4 = google.visualization.arrayToDataTable([<%= new Dashboard().getChart("Tarea",column,valor,1)%>]);
        var chart = new google.visualization.ColumnChart(document.getElementById('dashboard4'));
        chart.draw(data4, options);
    <%}else if(G.equals("5")){%>
        var data5 = google.visualization.arrayToDataTable([<%= new Dashboard().getChart("Area",column,valor,1)%>]);
        var chart = new google.visualization.PieChart(document.getElementById('dashboard5'));
        chart.draw(data5, options);
    <%}else if(G.equals("6")){%>
        var data6 = google.visualization.arrayToDataTable([<%= new Dashboard().getChart("Alcance",column,valor,1)%>]);
        var chart = new google.visualization.ColumnChart(document.getElementById('dashboard6'));
        chart.draw(data6, options);
    <%}else if(G.equals("7")){%>
        var data7 = google.visualization.arrayToDataTable([<%= new Dashboard().getChart("Tipo",column,valor,0)%>]);
        var chart = new google.visualization.PieChart(document.getElementById('dashboard7'));
        chart.draw(data7, options);
    <%}else if(G.equals("10")){%>
        var 
                data6 = google.visualization.arrayToDataTable([<%= new Dashboard().getChart("Alcance",column,valor,1)%>]), 
                data1 = google.visualization.arrayToDataTable([<%= new Dashboard().getChart("VP",column,valor,1)%>]),
                data7 = google.visualization.arrayToDataTable([<%= new Dashboard().getChart("Tipo",column,valor,0)%>]),
                data4 = google.visualization.arrayToDataTable([<%= new Dashboard().getChart("Tarea",column,valor,1)%>]),
                data2 = google.visualization.arrayToDataTable([<%= new Dashboard().getChart("Estado",column,valor,1)%>]),
                data3 = google.visualization.arrayToDataTable([<%= new Dashboard().getChart("PM",column,valor,1)%>]),
                data5 = google.visualization.arrayToDataTable([<%= new Dashboard().getChart("Area",column,valor,1)%>]); 
        
        var 
            chart1 = new google.visualization.PieChart(document.getElementById('dashboard1'))
            ,chart2 = new google.visualization.PieChart(document.getElementById('dashboard2'))
            ,chart3 = new google.visualization.PieChart(document.getElementById('dashboard3'))
            ,chart4 = new google.visualization.ColumnChart(document.getElementById('dashboard4'))
            ,chart5 = new google.visualization.PieChart(document.getElementById('dashboard5'))
            ,chart6 = new google.visualization.ColumnChart(document.getElementById('dashboard6'))
            ,chart7 = new google.visualization.PieChart(document.getElementById('dashboard7'));      
            
    chart1.draw(data1, options);
    chart2.draw(data2, options);
    chart3.draw(data3, options);
    chart4.draw(data4, options);
    chart5.draw(data5, options);
    chart6.draw(data6, options);
    chart7.draw(data7, options);
    <%}%>
    }
    </script>
  </head>
  <body>
      <div id="page-wrap">
          <header>   
          <img src="images/freedashboard.png" name="Dashboard" class="bimg" alt="dashboard" onclick="document.location='freeDashboard.jsp'"/>                                               
          <hr>
          <br>
      </header>
       <aside class="right">
          <div class="blanco">
              <form action="freeDashboard.jsp" method="post">
              <table>
                  <tr>
                      <td>
                          <select name="option_g" class="bt2" ><%
                                int [] gr = new Negocio().valoresInt("PMIS_GRAFICA where ID_GRAFICA not in (8,9) order by ID_GRAFICA desc", "ID_GRAFICA", "ID_GRAFICA"); 
                                String [] Gr = new Negocio().valores("PMIS_GRAFICA where ID_GRAFICA not in (8,9) order by ID_GRAFICA desc", "TITULO_GRAFICA", "TITULO_GRAFICA");
                                for (int option=0;option<gr.length;option++){                  
                                if(G==null){%>
                                <option value="<%=gr[option]%>">
                                    <%=Gr[option]%>
                                </option>
                                <%}else if(G.equals(""+gr[option])){%>
                                <option selected="" value="<%=gr[option]%>">
                                    <%=Gr[option]%>
                                </option>
                                <%}else{%>
                                <option value="<%=gr[option]%>">
                                    <%=Gr[option]%>
                                </option>
                                <%}}%>
                          </select>
                      </td>
                      <td>
                          <input type="submit" class="bt" value="Cargar">
                      </td>                          
                  </tr>
              </table>                                                
          </form>
          </div>         
      </aside>        
      <section class="dashboard">   
           <%if(G==null){
               
           }else if (Integer.parseInt(G)==10){%>   
           <div class="marco">
                            <table>
                                <tr>
                                    <td>
                                        <form action="freeDashboard.jsp" method="post">        
                                            <table>
                                                <tr>
                                                    <td>
                                                        <select name="column" class="bt2" >
                                                            <option value="NOMBRE_VICEPRESIDENCIA">Vicepresidencia</option>
                                                            <option value="NOMBRE_PM">Project Manager</option>                                
                                                            <option value="NOMBRE_RESPONSABLE">Nombre de Responsable</option> 
                                                            <option value="NOMBRE_AREA">Nombre de Área</option>  
                                                        </select> 
                                                    </td>
                                                    <td>
                                                        <input type="search" name="valor" required=""/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">                                                     
                                                        <input type="hidden" name="option_g" value="<%=G%>" />
                                                        <input type="submit" name="search" class="bt" value="buscar" /> 
                                                    </td>
                                                </tr>
                                            </table>
                                        </form>    
                                    </td>
                                </tr>                        
                            </table>
                        </div>
        <div class="blanco2">
            <div class="blanco">
                <table>
                    <tr>
                        <td>
                            <div>
                                <h4><%=new Negocio().valor("PMIS_GRAFICA", "TITULO_GRAFICA", "ID_GRAFICA", "1")%></h4>
                            </div>
                        </td>
                        <td>
                            <div class="blanco"><%=new Negocio().valor("PMIS_GRAFICA", "DESCRIPCION_GRAFICA", "ID_GRAFICA", "1")%></div>
                        </td>
                    </tr>
                </table> 
            </div>
            <div id="dashboard1" class="grafica"></div> 
        </div>
        <div class="blanco2">
            <div class="blanco">
                <table>
                    <tr>
                        <td>
                            <div>
                                <h4><%=new Negocio().valor("PMIS_GRAFICA", "TITULO_GRAFICA", "ID_GRAFICA", "2")%></h4>
                            </div>
                        </td>
                        <td>
                            <div class="blanco"><%=new Negocio().valor("PMIS_GRAFICA", "DESCRIPCION_GRAFICA", "ID_GRAFICA", "2")%></div>
                        </td>
                    </tr>
                </table> 
            </div>
            <div id="dashboard2" class="grafica"></div> 
        </div>
        <div class="blanco2">
            <div class="blanco">
                <table>
                    <tr>
                        <td>
                            <div>
                                <h4><%=new Negocio().valor("PMIS_GRAFICA", "TITULO_GRAFICA", "ID_GRAFICA", "3")%></h4>
                            </div>
                        </td>
                        <td>
                            <div class="blanco"><%=new Negocio().valor("PMIS_GRAFICA", "DESCRIPCION_GRAFICA", "ID_GRAFICA", "3")%></div>
                        </td>
                    </tr>
                </table> 
            </div>
            <div id="dashboard3" class="grafica"></div> 
        </div>
        <div class="blanco2">
            <div class="blanco">
                <table>
                    <tr>
                        <td>
                            <div>
                                <h4><%=new Negocio().valor("PMIS_GRAFICA", "TITULO_GRAFICA", "ID_GRAFICA", "4")%></h4>
                            </div>
                        </td>
                        <td>
                            <div class="blanco"><%=new Negocio().valor("PMIS_GRAFICA", "DESCRIPCION_GRAFICA", "ID_GRAFICA", "4")%></div>
                        </td>
                    </tr>
                </table> 
            </div>
            <div id="dashboard4" class="grafica"></div> 
        </div>
        <div class="blanco2">
            <div class="blanco">
                <table>
                    <tr>
                        <td>
                            <div>
                                <h4><%=new Negocio().valor("PMIS_GRAFICA", "TITULO_GRAFICA", "ID_GRAFICA", "5")%></h4>
                            </div>
                        </td>
                        <td>
                            <div class="blanco"><%=new Negocio().valor("PMIS_GRAFICA", "DESCRIPCION_GRAFICA", "ID_GRAFICA", "5")%></div>
                        </td>
                    </tr>
                </table> 
            </div>
            <div id="dashboard5" class="grafica"></div> 
        </div>
        <div class="blanco2">
            <div class="blanco">
                <table>
                    <tr>
                        <td>
                            <div>
                                <h4><%=new Negocio().valor("PMIS_GRAFICA", "TITULO_GRAFICA", "ID_GRAFICA", "6")%></h4>
                            </div>
                        </td>
                        <td>
                            <div class="blanco"><%=new Negocio().valor("PMIS_GRAFICA", "DESCRIPCION_GRAFICA", "ID_GRAFICA", "6")%></div>
                        </td>
                    </tr>
                </table> 
            </div>
            <div id="dashboard6" class="grafica"></div> 
        </div>
        <div class="blanco2">
            <div class="blanco">
                <table>
                    <tr>
                        <td>
                            <div>
                                <h4><%=new Negocio().valor("PMIS_GRAFICA", "TITULO_GRAFICA", "ID_GRAFICA", "7")%></h4>
                            </div>
                        </td>
                        <td>
                            <div class="blanco"><%=new Negocio().valor("PMIS_GRAFICA", "DESCRIPCION_GRAFICA", "ID_GRAFICA", "7")%></div>
                        </td>
                    </tr>
                </table> 
            </div>
            <div id="dashboard7" class="grafica"></div> 
        </div>
        <%}else{
            %>
        <div class="full">
            <table class="blanco">
                <tr>
                    <td>
                        <div class="blanco"><h4><%=T%></h4></div>
                    </td>
                    <td>
                        <div class="blanco"><%=new Negocio().valor("PMIS_GRAFICA", "DESCRIPCION_GRAFICA", "ID_GRAFICA", G)%></div>
                    </td>
                    <td>
                        <div class="marco">
                            <table>
                                <tr>
                                    <td>
                                        <form action="freeDashboard.jsp" method="post">        
                                            <table>
                                                <tr>
                                                    <td>
                                                        <select name="column" class="bt2" >
                                                            <option value="NOMBRE_VICEPRESIDENCIA">Vicepresidencia</option>
                                                            <option value="NOMBRE_PM">Project Manager</option>                                
                                                            <option value="NOMBRE_RESPONSABLE">Nombre de Responsable</option> 
                                                            <option value="NOMBRE_AREA">Nombre de Área</option>  
                                                        </select> 
                                                    </td>
                                                    <td>
                                                        <input type="search" name="valor" required=""/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">                                                        
                                                        <input type="hidden" name="option_g" value="<%=G%>" />
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
            <div id="dashboard<%=G%>" class="grafica"></div> 
        </div>
        <%
        }%>
      </section> 
      </div>
      <footer>
            <%@include  file="WEB-INF/jspf/foo.jspf" %>
      </footer>   
  </body>
</html>
