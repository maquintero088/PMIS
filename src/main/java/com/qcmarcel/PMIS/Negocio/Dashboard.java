package com.qcmarcel.PMIS.Negocio;

import java.util.Arrays;


public class Dashboard {    
   
    public String grafica,titulo;
    String dashboard,data,Filtname;  
    String [] Data,Nombres,Grupos;
    String [][] status,layerdata;
    String tipos = "";    
    private String orderby="";
    private String char0;
    private String union="";
    
    public String getChart(String grafica,String column,String valor,int tipos){
        if(tipos==0){
            if(grafica.equals("Tipo")){
                this.tipos = "AREA = 'PMO'";
            }                    
        }else{
            this.tipos = "NOMBRE_TIPO in (2,3)";
        }
        if(grafica.equals("PM")){
            this.tipos = this.tipos+" and AREA = 'PMO'";
        }
        if("Estado".equals(grafica)){
            String [] valores = {"NOMBRE_VICEPRESIDENCIA","NOMBRE_ESTADO_PRIORIZACION","COUNT(ID_PROYECTOS)","PMO_VIEW_TOTAL_PROYECTOS"};
            dashboard = ""+this.getMatrix(valores,column,valor);
        }else if("Alcance".equals(grafica)){
            String [] valores = {"NOMBRE_ESTADO_ALCANCE","NOMBRE_VICEPRESIDENCIA","COUNT(ID_PROYECTOS)","PMO_VIEW_TOTAL_PROYECTOS"};
            dashboard = ""+this.getMatrix(valores,column,valor);
        }else if("VP".equals(grafica)){
            String valores = "['VICEPRESIDENCIA','PROYECTOS'],";
            dashboard = ""+valores+"\n "+this.getRows("NOMBRE_VICEPRESIDENCIA", "COUNT(ID_PROYECTOS)", "PMO_VIEW_TOTAL_PROYECTOS",column,valor);
        }else if("Tipo".equals(grafica)){
            String valores = "['TIPO','PROYECTOS'],";
            dashboard = ""+valores+"\n "+this.getRows("NOMBRE_TIPO", "COUNT(ID_PROYECTOS)", "PMO_VIEW_TOTAL_PROYECTOS",column,valor);
        }else if("Tarea".equals(grafica)){
            String valores = "['TAREAS','PROYECTOS'],";
            dashboard = ""+valores+"\n "+this.getRows("NOMBRE_TAREA", "COUNT(ID_PROYECTOS)", "PMO_VIEW_TOTAL_PROYECTOS",column,valor);
        }
        else if("PM".equals(grafica)){
            String valores = "['Project Manager','PROYECTOS'],";
            dashboard = ""+valores+"\n "+this.getRows("NOMBRE_PM", "COUNT(ID_PROYECTOS)", "PMO_VIEW_TOTAL_PROYECTOS",column,valor);
        }
        else if("Area".equals(grafica)){
            String valores = "['AREA','PROYECTOS'],";
            dashboard = ""+valores+"\n "+this.getRows("NOMBRE_AREA", "COUNT(ID_PROYECTOS)", "PMO_VIEW_TOTAL_PROYECTOS",column,valor);
        }else if("Capacidad".equals(grafica)){
            //new Negocio().editar("","call_generar_capacidad()","",5);
            String [] valores = {
                "nombre_pm",
                "pmo_capacidad"
            };
            String [][] capas = {
                {"count(id_proyectos)","No_Proyectos"},
                {"sum(valor_total)","Puntaje"}                                         
            };
            String where = "id_pm not in (20,22)";
            if(!column.equals("")&&!valor.equals("")){
                where = "LOWER("+column+") in ('"+valor.toLowerCase()+"')";
            }    
            orderby = " order by sum(valor_total) desc";                    
                    
            dashboard = ""+this.getMatrixLayers(valores,capas,where);  
        }else if("Actualizacion".equals(grafica)){
            String [] valores = {
                "nombre_pm",
                "pmo_total_proyectos tp, pmo_pm pm,pmo_duracion_tarea dt,pmo_tareas tarea," 
                    +"(select max(id_duracion_tarea) as id_ultima_tarea,proyectos.id_proyectos as proyecto from pmo_duracion_tarea tarea, "
                    + "(select id_proyectos from pmo_total_proyectos) proyectos "
                    +   "where tarea.id_proyectos=proyectos.id_proyectos group by proyectos.id_proyectos) maxtarea "
            };
            String [][] capas = {
                {"count(tp.ID_PROYECTOS)","No_Proyectos"},
                {"trunc(sysdate-tp.fecha_actualizacion_gestion)","Dias_actualizacion"}
            };
            String where = " tp.id_pm=pm.id_pm "
                    +   "and pm.area='PMO' "
                    +   "and tp.id_proyectos=dt.id_proyectos " 
                    +   "and maxtarea.id_ultima_tarea=dt.id_duracion_Tarea " 
                    +   "and maxtarea.proyecto=dt.id_proyectos " 
                    +   "and tarea.id_tarea=dt.id_tarea_nueva " 
                    +   "and tp.id_estado_priorizacion not in (3,4) " 
                    +   "and tp.id_pm<>22 "
                    +   "and tp.id_tarea <>24"; 
            union =    /*""; */"   pmo_total_proyectos tp, pmo_pm pm,pmo_tareas tarea "
                        + "where FILTRO and " +
                        "tp.id_pm=pm.id_pm " +
                        "and pm.area='PMO' " +
                        "and tarea.id_tarea=tp.id_tarea " +
                        "and tp.id_estado_priorizacion not in (3,4) " +
                        "and tp.id_pm<>22 " +
                        "and tp.id_tarea <>24 " +
                        "AND tp.id_proyectos not in "
                    + "(select id_proyectos from pmo_duracion_tarea group by id_proyectos) ";
            if(!column.equals("")&&!valor.equals("")){
                where = where+" and "+column+" in ("+valor+")";
            }                 
            dashboard = ""+this.getMatrixLayers(valores,capas,where);
        }
        System.out.println(dashboard);
        return dashboard;
    }

    public String getRows(String nombre,String valor,String from,String column,String cvalor) {
       String dataset = "";
       String Filt="";
       System.out.println(column);
       if(!column.equals("")){
           Filt=new Negocio().getFiltro(column,cvalor);
       }
       if(!tipos.equals("")){          
               tipos=" where "+tipos;           
       }
       Nombres = new Negocio().valores(from+tipos+Filt+" group by "+nombre, nombre, nombre); 
       Data = new Negocio().valores(from+tipos+Filt+" group by "+nombre, valor, nombre); 
       for(int i = 0;i<Nombres.length;i++){
          dataset = dataset+"['"+Nombres[i]+"',"+Data[i]+"]";
          if((i+1)<Nombres.length){
              dataset=dataset+",\n ";
          }
       }
       return dataset;        
    }

    private String getMatrix(String[] Matrix,String column,String valor) {
       String dataset = "['"+Matrix[0]+"',",Filt="";
       
       if(!column.equals("")){
           Filt=new Negocio().getFiltro(column,valor);
       }
       if(!tipos.equals("")){
           tipos=" where "+tipos;
       }
       
       Nombres = new Negocio().valores(Matrix[3]+tipos+Filt+" group by "+Matrix[1], Matrix[1], Matrix[1]); 
       Grupos = new Negocio().valores(Matrix[3]+tipos+Filt+" group by "+Matrix[0], Matrix[0], Matrix[0]);
       
       for(int x=0;x<Grupos.length;x++){
           dataset=dataset+"'"+Grupos[x]+"'";
           if((x+1)<Grupos.length){
              dataset=dataset+",";
           }
       }
       tipos = "regexp_like(NOMBRE_TIPO,'e')";
       for(int y=0;y<Nombres.length;y++){
           dataset=dataset+"],\n ['"+Nombres[y]+"',";            
           for(int z=0;z<Grupos.length;z++){
              //data=new Negocio().like(Matrix[3], Matrix[2], Matrix[0], Grupos[z]+"') AND "+tipos+Filt+" AND regexp_like("+Matrix[1]+" ,'"+Nombres[y]);
              data=new Negocio().valor(Matrix[3], Matrix[2], Matrix[0], Grupos[z]+" AND "+tipos+Filt+" AND "+Matrix[1]+" like '"+Nombres[y]+"'");
              if(data==null){
                  data="0";
              }
              dataset=dataset+data;
              if((z+1)<Grupos.length){
                  dataset=dataset+",";
              }
           }
       }       
       return dataset+"]";        
    }   
       
    private String getMatrixLayers(String[] Matrix,String[][] capas,String wh) {
        String where="";
        if(!wh.equals("")){
            where  =" where "+wh;
        }        
        String 
                dataset = "['"+Matrix[0]+"',",
                Filt="", 
                setlayer [] =new Negocio().valores(Matrix[1]+where+orderby, capas[0][0] ,capas[0][0]); 
        layerdata = new String [Integer.parseInt(setlayer[0])][capas.length];         
        for(int layers=0;layers < capas.length;layers++){
            dataset=dataset+"'"+capas[layers][1]+"'";
            if((layers+1)<capas.length){
                dataset=dataset+",";
            }           
        }       
       where = where+" group by "+Matrix[0];
       Nombres = new Negocio().valores(Matrix[1]+where+orderby, Matrix[0], Matrix[0]); 
              
       for(int y=0;y<Nombres.length;y++){
           if(Matrix[0].equals("nombre_pm")){
               char0=Nombres[y].substring(0, 2);
               for(int i=0;i<Nombres[y].length();i++){
                   if(Nombres[y].charAt(i)==' '){
                       char0=char0+Nombres[y].substring(i, i+3);
                   }
               }
               dataset=dataset+"],\n ['"+char0+"',"; 
           }else{
                dataset=dataset+"],\n ['"+Nombres[y]+"',"; 
           }                       
           for(int z=0;z<layerdata[y].length;z++){               
               where=where.replace(" where", " and");
               where=where.replace("Where", "");
              data=new Negocio().valor(
                      Matrix[1], 
                      capas[z][0], 
                      Matrix[0], 
                      "'"+Nombres[y]+"'"+tipos+Filt+where.replace(" group by "+Matrix[0], "")+orderby);
              if(union.equals("")){
                  
              }else{
                   int [] sum = new Negocio().valoresInt(
                           union.replace("FILTRO",Matrix[0]+" = '"+Nombres[y]+"'"), capas[z][0], capas[z][0]);
                   if(Arrays.toString(sum)=="[]"){
                       
                   }else{
                       int INT=0;
                      for(int suma=0;suma<sum.length;suma++){
                          INT=INT+sum[suma];
                      }
                       data=""+(Integer.parseInt(data)+INT);
                   }                   
              } 
              if(data==null){
                  data="0";
              }/*else if (z==1){
                  data = ""+(float)Integer.parseInt(data);
              }*/
              dataset=dataset+data;
              if((z+1)<layerdata[y].length){
                  dataset=dataset+",";
              }
           }
       }       
       return dataset+"]";        
    }   
    
    public String[][] desempeno(String column,String filtro){
        String buscar;
        if(filtro==null||"".equals(filtro)){
            //buscar="WHERE regexp_like(NOMBRE_TIPO,'e') and regexp_like(Area,'PMO')";
            buscar="WHERE NOMBRE_TIPO in (2,3) and Area ='PMO'";
        }else{
            buscar="WHERE lower("+column+") like '"+filtro.toLowerCase()+"%' NOMBRE_TIPO in (2,3) and Area ='PMO'";
            //buscar="WHERE regexp_like(lower("+column+"),'"+filtro.toLowerCase()+"') and regexp_like(NOMBRE_TIPO,'e') and regexp_like(Area,'PMO')";
        }
        int PMO = new Negocio().rows("PMO_VIEW_TOTAL_PROYECTOS "+buscar, "*");
        String []
                id = new Negocio().valores("PMO_VIEW_TOTAL_PROYECTOS "+buscar+" order by NOMBRE_PROYECTO", "ID_PROYECTOS", "ID_PROYECTOS"), 
                area = new Negocio().valores("PMO_VIEW_TOTAL_PROYECTOS "+buscar+" order by NOMBRE_PROYECTO", "NOMBRE_AREA", "NOMBRE_AREA"),                
                tipo = new Negocio().valores("PMO_VIEW_TOTAL_PROYECTOS "+buscar+" order by NOMBRE_PROYECTO", "NOMBRE_TIPO", "NOMBRE_TIPO"),
                nombre = new Negocio().valores("PMO_VIEW_TOTAL_PROYECTOS "+buscar+" order by NOMBRE_PROYECTO", "NOMBRE_PROYECTO", "NOMBRE_PROYECTO"),
                responsable = new Negocio().valores("PMO_VIEW_TOTAL_PROYECTOS "+buscar+" order by NOMBRE_PROYECTO", "NOMBRE_RESPONSABLE", "NOMBRE_RESPONSABLE"),
                pm = new Negocio().valores("PMO_VIEW_TOTAL_PROYECTOS "+buscar+" order by NOMBRE_PROYECTO", "NOMBRE_PM", "NOMBRE_PM"),
                vp = new Negocio().valores("PMO_VIEW_TOTAL_PROYECTOS "+buscar+" order by NOMBRE_PROYECTO", "NOMBRE_VICEPRESIDENCIA", "NOMBRE_VICEPRESIDENCIA"),
                req = new Negocio().valores("PMO_VIEW_TOTAL_PROYECTOS "+buscar+" order by NOMBRE_PROYECTO", "NO_REQ_PADRE", "NO_REQ_PADRE");
        status =new String[PMO][10]; 
        for(int i=0;i<PMO;i++){
            status[i][0]= id[i];
            status[i][1]= area[i];
            status[i][2]= tipo[i];
            status[i][3]= nombre[i];
            status[i][4]= responsable[i];
            status[i][5]= pm[i];
            status[i][6]= vp[i];
            status[i][7]= req[i];
            for(int j=0;j<8;j++){
                if(status[i][j]==null){
                  status[i][j]="sin definir/no aplica";  
                }                
            }
        }        
        return status;
    }
    
    public int NProyectos (String column,String filtro){
        String buscar;
        if(filtro==null||"".equals(filtro)){
            //buscar="WHERE regexp_like(NOMBRE_TIPO,'e') and regexp_like(Area,'PMO')";
            buscar="WHERE NOMBRE_TIPO in (2,3) and Area ='PMO'";
        }else{
            buscar="WHERE lower("+column+") like '"+filtro.toLowerCase()+"%' NOMBRE_TIPO in (2,3) and Area ='PMO'";
            //buscar="WHERE regexp_like(lower("+column+"),'"+filtro.toLowerCase()+"') and regexp_like(NOMBRE_TIPO,'e') and regexp_like(Area,'PMO')";
        }
        return new Negocio().rows("PMO_VIEW_TOTAL_PROYECTOS "+buscar, "*");
    }
}

//<td <%=new Dashboard().avance(Status[t][1])%>></td>
