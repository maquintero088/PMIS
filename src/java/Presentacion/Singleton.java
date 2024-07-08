/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Presentacion;



/**
 *
 * @author Marcel.Quintero
 */
public class Singleton {
    
    private static String Contenido;
    
        private static final Singleton singleton = new Singleton();

    public String getContenido() {
        return Contenido;
    }

     public void setContenido(String contenido) {
        Singleton.Contenido = contenido;
    }
}
 