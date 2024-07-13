/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.qcmarcel.PMIS.Negocio;
 
import com.qcmarcel.PMIS.Datos.DataSource;
import java.io.File;
import java.io.IOException;
import java.nio.file.CopyOption;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Marcel.Quintero
 */
public class Negocio {
    public  String url = "";
    String[] Lista;
    int i,row=0,validacion;
    int [] L3;
    private ResultSet rs,rs2,rs3;
    public String[][] Lista2;    
    private String valor,sql3;
    private String output;
    private int prph;
    private Date StringDate;
    private SimpleDateFormat format;
    private Path FROM;
    private Path TO;
    private CopyOption[] options;
    public int rows(String table,String filtro){
        DataSource db=new DataSource ();
        Connection c=db.PMOdb();  
        sql3 = "SELECT "+filtro+" FROM "+table; 
        rs2 = db.Resultado(sql3);
        try {
            if (rs2 != null)
            while(rs2.next()){                
                row++;
            }
        } catch (SQLException ex) {
            Logger.getLogger(Negocio.class.getName()).log(Level.SEVERE, "!> "+sql3, ex);
        } finally {
            db.Cerrar();
        }
        return row;        
    }
    public String in(String table,String column,String columnid, String id){
        DataSource db=new DataSource ();
        Connection c=db.PMOdb();  
        sql3="SELECT "+column+" FROM "+table+" WHERE "+columnid+" in ("+id+")"; 
        rs3 = db.Resultado(sql3);
        try {
            while(rs3.next()){
                try{
                    valor=rs3.getString(column);  
                }catch (SQLException ex) {
                    Logger.getLogger(Negocio.class.getName()).log(Level.SEVERE, "!> "+valor, ex);
                }            
            }
        } catch (SQLException ex) {
            Logger.getLogger(Negocio.class.getName()).log(Level.SEVERE, "!> "+sql3, ex);
        } finally {
            db.Cerrar();
        }
        return valor;    
    }   
    public String valor(String table,String column,String columnid, String id){
        DataSource db=new DataSource ();
        Connection c=db.PMOdb();  
        sql3="SELECT "+column+" FROM "+table+" WHERE "+columnid+" = "+id; 
        rs3 = db.Resultado(sql3);
        try {
            while(rs3.next()){
                try{
                    valor=rs3.getString(column);
                    //System.out.println(valor);
                }catch (SQLException ex) {
                    Logger.getLogger(Negocio.class.getName()).log(Level.SEVERE, "!> "+valor, ex);
                }            
            }
        } catch (SQLException ex) {
            Logger.getLogger(Negocio.class.getName()).log(Level.SEVERE, "!> "+sql3, ex);
        } finally {
            db.Cerrar();
        }
        return valor;    
    }  
    public String login(String username, String password){        
        DataSource db=new DataSource ();
        Connection c=db.PMOdb(); 
        valor=null;
        sql3="SELECT compare('"+username.toLowerCase()+"','"+password+"') FROM PMIS_USER"; 
        rs3 = db.Resultado(sql3); 
        System.out.println(password);
        try {
            while(rs3.next()){         
                if(rs3.getString("compare('"+username+"','"+password+"')")==null){
                    valor=null;
                }else{
                    valor="1";
                }                     
            }
        } catch (SQLException ex) {
            Logger.getLogger(Negocio.class.getName()).log(Level.SEVERE, "!> "+sql3, ex);
        } finally {
            db.Cerrar();
        }
              
        //this.editar("PS_CLAVE_USER = ENCRIPTAR('PS_CLAVE_USER')", "PMIS_USER","NN_NOMBRE_USER in (lower('"+username+"'))", 2);
        return valor;    
    }
    public String like(String table,String column,String columnid, String like){
        DataSource db=new DataSource ();
        Connection c=db.PMOdb();  
        sql3="SELECT "+column+" FROM "+table+" WHERE "
                + ""+column+" like '"+like+"' "
                + "and "+columnid+" like '"+like+"%' " 
                + "and "+columnid+" like '%"+like+"%' "
                + "and "+columnid+" like '"+like+"%' group by "+column;
        //sql3="SELECT "+column+" FROM "+table+" WHERE regexp_like ("+columnid+",'"+like+"')"; 
        rs3 = db.Resultado(sql3);
        try {
            if (rs != null)
            while(rs3.next()){
                try{
                   valor=rs3.getString(column);
                }catch (SQLException ex) {
                    Logger.getLogger(Negocio.class.getName()).log(Level.SEVERE, "!> "+valor, ex);
                }            
            }
        } catch (SQLException ex) {
            Logger.getLogger(Negocio.class.getName()).log(Level.SEVERE, "!> "+sql3, ex);
        } finally {
            db.Cerrar();
        }
        return valor;    
    }    
    public String count(String table,String count,String column, String like){
        DataSource db=new DataSource ();
        Connection c=db.PMOdb();  
        //sql3="SELECT count("+count+") FROM "+table+" WHERE regexp_like ("+column+",'"+like+"') group by "+column;
        sql3="SELECT count("+count+") FROM "+table+" WHERE "
                + ""+column+" like '"+like+"' "
                + "and "+column+" like '"+like+"%' " 
                + "and "+column+" like '%"+like+"%' "
                + "and "+column+" like '"+like+"%' group by "+column;
        rs3 = db.Resultado(sql3);
        try {
            if (rs3 != null)
            while(rs3.next()){
                try{
                   valor=rs3.getString("count("+count+")");
                }catch (SQLException ex) {
                    Logger.getLogger(Negocio.class.getName()).log(Level.SEVERE, "!> "+valor, ex);
                }            
            }
        } catch (SQLException ex) {
            Logger.getLogger(Negocio.class.getName()).log(Level.SEVERE, "!> "+sql3, ex);
        } finally {
            db.Cerrar();
        }
        return valor;    
    }
    public int count2(String table,String count,String column, String value){
        DataSource db=new DataSource ();
        Connection c=db.PMOdb();  
        sql3="SELECT count("+count+") FROM "+table+" WHERE "+column+" = "+value; 
        rs3 = db.Resultado(sql3);
        try {
            if (rs3 != null)
            while(rs3.next()){
                try{
                   valor=rs3.getString("count("+count+")");
                }catch (SQLException ex) {
                    Logger.getLogger(Negocio.class.getName()).log(Level.SEVERE, "!> "+valor, ex);
                }            
            }
        } catch (SQLException ex) {
            Logger.getLogger(Negocio.class.getName()).log(Level.SEVERE, "!> "+sql3, ex);
        } finally {
            db.Cerrar();
        }
        return Integer.parseInt(valor);    
    }
    public String[] valores(String table,String column,String filtro){
        DataSource db=new DataSource ();
        Connection c=db.PMOdb();          
        sql3 = "SELECT "+column+" FROM "+table;   
        try {            
            rs = db.Resultado(sql3);            
            Lista = new String[this.rows(table,filtro)];    
              while(rs.next()){                       
                   try{
                       Lista[i]=caracteres(rs.getString(column));
                   }catch (SQLException ex) {
                       Logger.getLogger(Negocio.class.getName()).log(Level.SEVERE, "!> "+sql3, ex);
                   }
                   i++;
            }                 
        } catch (SQLException ex) {
            Logger.getLogger(Negocio.class.getName()).log(Level.SEVERE, "!> "+sql3, ex);
        } finally {
            db.Cerrar();
        }
        return Lista;     
    }
    
    public int[] valoresInt(String from,String column,String filtro){ 
        DataSource db=new DataSource ();
        Connection c=db.PMOdb();          
        sql3 = "SELECT "+column+" FROM "+from;   
        System.out.println("!> "+sql3);
        try {            
            rs = db.Resultado(sql3);            
            L3 = new int[this.rows(from,filtro)];       
              while(rs.next()){   
                  try{
                   L3[i]=rs.getInt(column);
                  }catch (SQLException ex) {
                      Logger.getLogger(Negocio.class.getName()).log(Level.SEVERE, "!> "+L3, ex);
                  }   
                  i++;
            }                 
        } catch (SQLException ex) {
            Logger.getLogger(Negocio.class.getName()).log(Level.SEVERE, "!> "+sql3, ex);
        } finally {
            db.Cerrar();
        }
        return L3;      
    }   
    

    public void editar(String Columns, String Table, String Values, int tipo) {
        DataSource oracle = new DataSource();
        Connection c=oracle.PMOdb();
        Values = new Negocio().caracteres(Values);
        switch(tipo){
            case 1:
                oracle.Ejecutar("INSERT INTO "+Table+"("+Columns+") values ("+Values+")");
                break;
            case 2:
                oracle.Ejecutar("UPDATE "+Table+" SET "+Columns+" WHERE "+Values);                
                break;
            case 3:
                oracle.Ejecutar("INSERT INTO "+Table+" SELECT "+Columns+" FROM "+Values);                
                break;
            case 4:
                oracle.Ejecutar("TRUNCATE "+Columns+" "+Table);                
                break;
            case 5:
                oracle.Ejecutar("CALL "+Table);                
                break;
        }
        oracle.Cerrar();
    }
    
    public String getFiltro(String column,String valor) {
       String filtro="";
       //System.out.println(column);
       if(!column.equals("")){  
           String[] 
                   arrayFiltro = new Negocio().valores("PMO_VIEW_TOTAL_PROYECTOS group by LOWER("+column+")", "LOWER("+column+")", "LOWER("+column+")");                  
           for(int i=0;i<arrayFiltro.length;i++){
               if((arrayFiltro[i]).contains(valor.toLowerCase())){
                   //filtro=" and regexp_like (LOWER("+column+"),'"+valor.toLowerCase()+"') ";
                   filtro=" and LOWER("+column+") like '"+valor.toLowerCase()+"%' ";
                    System.out.println(filtro);
               }
           }
       }   
       return filtro;
    }
    
    public String caracteres(String input) {
    // Cadena de caracteres original a sustituir.
    String original = "áàäéèëíìïóòöúùuñÁÀÄÉÈËÍÌÏÓÒÖÚÙÜÑçÇ–";
    // Cadena de caracteres ASCII que reemplazarán los originales.
    String ascii = "aaaeeeiiiooouuunAAAEEEIIIOOOUUUNcC ";
    String output = input;
    for (int i=0; i<original.length(); i++) {
        // Reemplazamos los caracteres especiales.
        output = output.replace(original.charAt(i), ascii.charAt(i));
    }//for i
    return output;
    }//remove1

    public String getStringseparate(String input) {        
        output="<tr><Td><p style=\"color: #002060; font: 14px \'calibri\';\"> ";
            for (int j=0; j<input.length(); j++) {
                        output=output+input.charAt(j); 
                if(input.charAt(j)=='|'){ 
                       output=output.replace("|", "</p></td></tr><tr><Td><p style=\"color: #002060; font: 14px \'calibri\';\"> ");  
                }else if (j%100==0&&j>0&&input.charAt(j)==' '){
                    output=output+"</p><p style=\"color: #002060; font: 14px \'calibri\';\">";
                }
            }   
        return output+"</p></td></tr>";
    }     
    public void setStringseparate(String [] sql) {        
        this.editar(sql[1], sql[0], sql[2], Integer.parseInt(sql[3]));
    }
    public String [] getStatus (String ID,String pmo_proyecto){
        String[] Status = new String[10];
        if (ID==null) {
            ID = new Negocio().valor("PMO_STATUS_PROYECTOS", "max(ID_STATUS_PROYECTOS)", "PMO_PROYECTO", pmo_proyecto);
        }        
        Status[0] = new Negocio().valor("PMO_STATUS_PROYECTOS", "SOFT_LAUNCH", "ID_STATUS_PROYECTOS", ID);
        Status[1] = new Negocio().valor("PMO_STATUS_PROYECTOS", "COMMERCIAL_LAUNCH", "ID_STATUS_PROYECTOS", ID);
        Status[2] = new Negocio().valor("PMO_STATUS_PROYECTOS", "RETRASOS_RESPONSABLES", "ID_STATUS_PROYECTOS", ID);
        Status[3] = new Negocio().valor("PMO_STATUS_PROYECTOS", "ACTIVIDADES", "ID_STATUS_PROYECTOS", ID);
        Status[4] = new Negocio().valor("PMO_STATUS_PROYECTOS", "LOGROS", "ID_STATUS_PROYECTOS", ID);
        Status[5] = new Negocio().valor("PMO_STATUS_PROYECTOS", "RIESGOS", "ID_STATUS_PROYECTOS", ID);        
        return Status;     
    } 
    
    public String getDateFormat (String dateString,String Format[]) throws ParseException{ 
            format = new SimpleDateFormat(Format[0]);
            StringDate = format.parse(dateString);
            format = new SimpleDateFormat(Format[1]);
            return format.format(StringDate) ;            
    }
    public void copyFile(String origen, String destino){
        FROM = Paths.get(origen);
        TO = Paths.get(destino);
        options = new CopyOption[]{
          StandardCopyOption.REPLACE_EXISTING,
          StandardCopyOption.COPY_ATTRIBUTES
        }; 
        try {
            Files.copy(FROM, TO, options);
        } catch (IOException ex) {
            Logger.getLogger(Negocio.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    public void renameFile(String origen,String destino){
        File fichero = new File(origen);
        File fichero2 = new File(destino);
 
            boolean success = fichero.renameTo(fichero2);
            if (success) {
                System.out.println("--cambia el nombre de fichero");
            }else{
                 System.out.println("--Error intentando cambiar el nombre de fichero");
            }
    }
}
