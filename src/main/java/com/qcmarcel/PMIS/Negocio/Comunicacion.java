/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.qcmarcel.PMIS.Negocio;

public class Comunicacion {
    private String[][] top;
    
        public String [][] top (){
        top= new String [5][3];
        String [] 
                prioridad = new Negocio().valores(
                        "PMO_VIEW_TOTAL_PROYECTOS "
                                + " where"
                                + " nombre_tipo in ('Estrategico','Proyecto')" 
                                + " and nombre_estado_priorizacion in ('SI -(Por Priorizar)')" 
                                + /*" and rownum<6"*/" order by PRIORIZACION asc", "PRIORIZACION", "PRIORIZACION"),
                proyecto = new Negocio().valores(
                        "PMO_VIEW_TOTAL_PROYECTOS"
                                + " where" 
                                + " nombre_tipo in ('Estrategico','Proyecto')" 
                                + " and nombre_estado_priorizacion in ('SI -(Por Priorizar)')" 
                                + /*" and rownum<6"*/" order by PRIORIZACION asc", "NOMBRE_PROYECTO", "NOMBRE_PROYECTO"),
                vp = new Negocio().valores(
                        "PMO_VIEW_TOTAL_PROYECTOS"
                                + " where" 
                                + " nombre_tipo in ('Estrategico','Proyecto')" 
                                + " and nombre_estado_priorizacion in ('SI -(Por Priorizar)')" 
                                + /*" and rownum<6"*/" order by PRIORIZACION asc", "NOMBRE_VICEPRESIDENCIA", "NOMBRE_VICEPRESIDENCIA");
        if(prioridad==null||proyecto==null||vp==null){
        }else{    
            for(int p=0;p<top.length;p++){
                top[p][0]= prioridad[p];
                top[p][1]= proyecto[p];
                top[p][2]= vp[p];
            }
        }
        return top;        
    }
    
}
