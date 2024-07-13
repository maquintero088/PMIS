/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.qcmarcel.PMIS.Datos;


import java.net.InetAddress;
import java.net.UnknownHostException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Marcel.Quintero
 */
public class DataSource {    
    private Connection Connection;
    public String ipbase="10.69.32.175",
            paramuser= "qcmarcel", // "rb80200308",
            parampass= "toor", //"T!g02022",
            hostname;
    private String dbname = "histpre";
    private String Username;

    public DataSource() {
        try {
            this.hostname = InetAddress.getLocalHost().getHostName();
            //System.out.println(hostname);
        } catch (UnknownHostException ex) {
            Logger.getLogger(DataSource.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
   
   /*
   public Connection PMOdb () {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection = DriverManager.getConnection("jdbc:oracle:thin:@10.25.65.16:1521:HISTPRE", "PMO", "tigo2014");        
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DataSource.class.getName()).log(Level.SEVERE, null, ex);
        }        
       return Connection;   
   }
   
    */
    
   public Connection PMOdb () {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection = DriverManager.getConnection("jdbc:mysql://"+hostname+"/"+dbname, paramuser, parampass);        
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DataSource.class.getName()).log(Level.SEVERE, null, ex);
        }        
       return Connection;   
   }  
   
   //
   public ResultSet Resultado(String query) {        
        Statement st;
        ResultSet rs=null;     
        try {  
            st = Connection.createStatement();
            rs = st.executeQuery(query);
            System.out.println(query);             
        }catch(SQLException e){
            Logger.getLogger(DataSource.class.getName()).log(Level.SEVERE, "$> "+query, e);
        }  
        return rs;
    }   
    public void Ejecutar(String query) {
        Statement st;                 
        try {  
            st= Connection.createStatement();
            st.executeUpdate(query);     
            System.out.println(query);
            st.execute("commit");
        }catch(SQLException e){            
            Logger.getLogger(DataSource.class.getName()).log(Level.SEVERE, "$> "+query, e);
        }        
    }    
    public boolean Cerrar() { 
        boolean ok =true;       
        try {  
           Connection.close();           
        }catch(SQLException e){
            ok = false;
            Logger.getLogger(DataSource.class.getName()).log(Level.SEVERE, "$> "+ok, e);
        }
        return ok;
    }
}
