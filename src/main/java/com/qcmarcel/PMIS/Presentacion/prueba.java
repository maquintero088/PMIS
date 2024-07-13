/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.qcmarcel.PMIS.Presentacion;

import java.sql.ResultSet;

/**
 *
 * @author Márcel
 */
public class prueba {
    private static ResultSet Result;
    
    public static void main (String [] args){
        mysql();
       //System.out.println(System.getProperty("user.dir"));
    }    

    private static void mysql() {
        System.out.print(System.getProperty( "user.dir" ));
         /*Oracle db=new Oracle ();
        Connection c =db.PMOdb();
        Result = db.Resultado("SELECT count(*) FROM PMO_TOTAL_PROYECTOS");
        try {
            while(Result.next()){
                System.out.println(Result.getString("count(*)"));            
            }
        } catch (SQLException ex) {
            Logger.getLogger(prueba.class.getName()).log(Level.SEVERE, "!> ", ex);
        } finally {
            db.Cerrar();
        }*/
    }
    
}
