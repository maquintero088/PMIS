package com.qcmarcel.PMIS.Servicios;

//import com.aspose.slides.ISlide;
//import com.aspose.slides.Presentation;
/*import com.aspose.cells.Chart;
import com.aspose.cells.ChartType;
import com.aspose.cells.ImageFormat;
import com.aspose.cells.ImageOrPrintOptions;
import com.aspose.cells.SheetType;
import com.aspose.cells.Workbook;
import com.aspose.cells.Worksheet;
import com.aspose.slides.IOleObjectFrame;
import com.aspose.slides.ISlide;
import com.aspose.slides.OleObjectFrame;
import com.aspose.slides.PptException;
import com.aspose.slides.Presentation;
import com.aspose.slides.SaveFormat;
import com.aspose.slides.Slide;*/

import com.qcmarcel.PMIS.Negocio.Negocio;
import gui.ava.html.image.generator.HtmlImageGenerator;
import java.awt.Dimension;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.*;
import java.io.IOException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.poi.xslf.usermodel.*;

public class Slides {    
    XMLSlideShow ppt;
    XSLFSlide blankSlide,Slide,Slides [];
    XSLFSlideMaster defaultMaster;
    XSLFSlideLayout titleLayout;
    XSLFTextShape body;
    XSLFConnectorShape line; 
    List<XSLFTextParagraph> TextParagraphs;
    XSLFShape[] Shapes;
    XSLFTextShape text,text1;
    XSLFPictureShape shape;
    XSLFTable Table;
    Graphics2D graphics;
    FileOutputStream Out;
    public String 
            url= "C:\\Program Files\\Apache Software Foundation\\Tomcat 8.0\\webapps\\PMIS_Tigo_PMO",
            folder1= "\\powerpoint\\",
            folder2= "\\comunicacion\\",
            prnl= url+folder1+"PMO-Comunicacion.pptx",
            zfile= "bak\\",
            png= url+folder1+"Comunicacion.png",comunicado ,name,htmlf = url+folder1+"Comunicacion.html";
            //url= "/usr/local/apache-tomcat-8.0.15/webapps/PMIS_Tigo_PMO",
            //folder1= "/powerpoint/",
            //folder2= "/comunicacion/",
            //prnl= url+folder1+"PMO-Comunicacion.pptx",
            //zfile= "bak/",
            //png= url+folder1+"Comunicacion.png",comunicado ,name,htmlf = url+folder1+"Comunicacion.html";
    private String[] arraySlide,Stakeholders;
//    private Presentation pres;
//    private BufferedImage image;
    private List<XSLFTableRow> TRows;
    private List<XSLFTableCell> TableCell;
    private XSLFTableCell field;
    /*private Workbook wb;
    private ImageOrPrintOptions opts;
    private ByteArrayOutputStream imageStream,bout;
    private Presentation pres;*/
    private String[][] 
            cells,
            limpiarTable = {
                {   "<body>",
                    "<h6>",
                    "<p>",
                    "<td>",
                    "<Td>",
                    "<Td class=\"justify\">",
                    "<div class=\"cuadrofecha\">",
                    "<div>",
                    "<div class=\"blanco\">",
                    "<br class=\"\">",
                    "null",
                    "<div class=\"right\">",
                    "<div class=\"slidetitle\">", 
                    "<table class=\"com-table\">", 
                    "<table class=\"com-table2\">",
                    "<table class=\"com-table3\">", 
                    "<th class=\"com-th\">", 
                    "<div class=\"parrafo1\">", 
                    "class=\"none\"", 
                    "<h5 class=\"justify\" style=\"text-decoration: underline;\">",
                    "class=\"justify\"",
                    "class=\"gris\"",
                    "class=\"status_acciones\"",
                    "class=\"status_f\"",
                    "class=\"tx_silde_bazul\"",
                    "class=\"right\"",
                    "class=\"status_table\"",
                    "class=\"status_description\"",
                    "class=\"border_status\"",
                    "<div class=\"slidebody\">",
                    "<td class=\"bborde\"",
                    "<h4 class=\"title2\">",
                    "<div class=\"cuadro1\">",
                    "<img class=\"full\" src=\"../images/comunicacion/com-foo.png\" name=\"Requerimientos\" alt=\"fases\" />",
                    "<table class=\"table\">",
                    "src=\"../images/comunicacion/"
                },
                {   "<body style=\"font-family: \'calibri\';\n" +
                            "    margin: 0px;\n" +
                            "    text-align: center;\">",
                    "<h6 style=\"font-family: \'calibri\';color: #1F497D;\">",
                    "<p style=\"font-size: 14px;\">",
                    "<td style=\"border: thin solid #4F81BD;\">",                    
                    "<td class=\"blanco\">",
                    "<td style=\"background: #fff;\n" +
                            "    box-shadow: 2px 0px 2px #fff;\n" +
                            "    border: thin solid #4F81BD;\n" +
                            "    font-family: \'calibri\';"+ 
                            "    vertical-align: top;\n" +
                            "    padding: 5px;\">",
                    "<div style=\"border: thin solid #4F81BD;\n" +
                            "    background: #62F856;\n" +
                            "    margin: 14px;\n" +
                            "    font-family: \'calibri\';" +
                            "    text-align: justify;\">",
                    "<div style=\"max-width: 600px;border: thin solid #4F81BD;background: #ffffff;\">",
                    "<div style=\"max-width: 600px;border: thin solid #4F81BD;background: #ffffff;\">",
                    "-->",
                    "",
                    "<!--",
                    "<div style=\"background: #4E70B4; \n" +
                            "    min-height: 30px;\n" +
                            "    color: #ffffff;\n" +
                            "    font: 20px 'calibri';\n" +
                            "    font-weight: bold;  \n" +
                            "    text-align: left;\n" +
                            "    padding-left: 15px;\n" +
                            "    vertical-align: central;\">",
                    "<table style=\"color: #000000;\n" +
                            "    margin: 10px;\n" +
                            "    font: 12px \'calibri\';\">",
                    "<table style=\"text-align: center;\n" +
                            "    font: 16px \'calibri\';\n" +
                            "    border: none;\n" +
                            "    width:100%\">",
                    "<table style=\"color: #000000;\n" +
                            "    text-align: justify;\n" +
                            "    font: 12px \'calibri\';\">",
                    "<th style=\"border: thin solid #4F81BD;"
                            + "background: #C6D9F1 ;\n" +
                            "    font: 16px \'calibri\'; \n" +
                            "    font-weight: bold;\n" +
                            "    text-align: center\">",
                    "<div style=\"font-size: 20px;\n" +
                            "    margin: 10px;\">",
                    "style=\"border: none;\n" +
                            "    background: none;\"",
                    "<h5 style=\"text-align: justify;"
                            + "text-decoration: underline;font-size: 15px;"
                            + "font-family: \'calibri\'"
                            + ";color: #1F497D;\">",
                    "style=\"text-align: justify;font-size: 14px;font-family: \'calibri\' ;color: #1F497D;\"",
                    "style=\"background: #e0e0e0;\"",
                    "style=\"border: thin solid #002060;\n" +
                            "    color: #002060;  \n" +
                            "    margin: 1%;\n" +
                            "    width: 95%; \"",
                    "style=\"background: #e0e0e0;\n" +
                            "    color: #002060;\n" +
                            "    font: 14px \'calibri\';\"",
                    "style=\"color: #002060;\"",
                    "style=\"float: right;\"",
                    "style=\"width: 90%;\n" +
                            "    float: right;\n" +
                            "    max-width: 600px;" +
                            "    color: #002060;\n" +
                            "    font: 14px 'calibri';\"",
                    "style=\"border-radius: 10px;\n" +
                            "    background: #e0e0e0;\n" +
                            "    color:  #002060;\n" +
                            "    font: 14px 'calibri'; \n" +
                            "    padding: 2%;\n" +
                            "    float: left;\n" +
                            "    width: 90%; \n" +
                            "    min-height: 30%; \n" +
                            "    max-width: 600px;\"",
                    "style=\"border-bottom:  thin solid #000000;\n" +
                            "    border-top:  thin solid #000000\"",
                    "<div style=\"height: 100%;\n" +
                            "    color: #1F497D;\n" +
                            "    font: 20px 'calibri';\n" +
                            "    padding: 1%;\">",
                    "<td style=\"background: #E9EDF4;\n" + 
                            "    border: none;\n" +
                            "    border: thin solid #ffffff;\"",
                    "<h4 style=\"color: #1F497D;\">",
                    "<div style=\"border: thin solid #4F81BD;\n" +
                            "    margin: 10px;\n" +
                            "    padding: 5px;\n" +
                            "    text-align: justify;\">",
                    "",
                    "<table style=\"width:100%\">",
                    "src=\"images/comunicacion/"
                }
            },
            limpiarTable2 = {
                {
                    "<!DOCTYPE html>","</body>","<html>","</html>","<body>",
                    "<img class=\"full\" src=\"images/comunicacion/com-foo.png\" name=\"Requerimientos\" alt=\"fases\" />"
                },
                {"<!--","","","","-->",
                    ""}};; 
    private int dataSheetIndex, sizeX,sizeY,WorksheetIndex,chartSheetIdx,chIndex,chartCols,chartRows,chartSheetIndex,Snum;
    /*private Worksheet chartSheet,dataSheet;
    private Chart chart;
    private IOleObjectFrame oof;
    private ISlide sld;*/
    private BufferedImage image;
    private HtmlImageGenerator imageGenerator;
    private URL URL_;
    private String html;
    private URLConnection conexion;
    private BufferedReader br;
    private InputStream is;
    private char[] buffer;
    private int leido;
    private File HtmlFile;
    private BufferedWriter bw;
    private String charset;
    private String param1;
    private String param2;
    private String query;
    private XSLFTextShape text2;
    private String cc="";
    
    public void crear(){
        ppt = new XMLSlideShow ();
        ndiapositiva();
    }
    
    public void ndiapositiva(){
        blankSlide = ppt.createSlide ();
    }    
    public void leer(){
        try {
            ppt = new XMLSlideShow (
                    new FileInputStream (prnl));
        } catch (FileNotFoundException ex) {
            Logger.getLogger(Slides.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(Slides.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    public void leer(String file){
        try {
            ppt = new XMLSlideShow (
                    new FileInputStream (url+folder1+file));
        } catch (FileNotFoundException ex) {
            Logger.getLogger(Slides.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(Slides.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    public void eliminar(String file){
        leer();
        ppt.removeSlide (0); 
    }
    public void diapositiva(String Title,String paragraph){        
        leer();
        ndiapositiva();         
        defaultMaster = ppt.getSlideMasters()[0];        
        titleLayout = defaultMaster.getLayout(SlideLayout.TITLE);        
        XSLFSlide slide = ppt.createSlide(titleLayout);        
        XSLFTextShape title = slide.getPlaceholder(0);        
        title.setText(Title);        
        XSLFSlideLayout titleBodyLayout = defaultMaster.getLayout(SlideLayout.TITLE_AND_CONTENT);        
        body = slide.getPlaceholder(1);
        parragraph(paragraph);
    }
    
    public void parragraph(String paragraph){    
        body.addNewTextParagraph().addNewTextRun().setText(paragraph);
    }
    
    public void cleartext(){
        body.clearText();
    }
    
    public String getSlides(int slidesparameter, int textparameter){
        leer();
        Slides = ppt.getSlides();
        for (int i = 0; i < Slides.length; i++){            
            if(i==slidesparameter){
                Shapes = Slides[i].getShapes();            
            for (int j = 0; j < Shapes.length; j++){                    
                    name = Shapes[j].getShapeName();                    
                    java.awt.geom.Rectangle2D anchor = Shapes[j].getAnchor();                    
                    if (Shapes[j] instanceof XSLFConnectorShape){                        
                        line = (XSLFConnectorShape)Shapes[j];                        
                    } else if (Shapes[j] instanceof XSLFTextShape){                        
                        text = (XSLFTextShape)Shapes[textparameter];    
                        comunicado = text.getText();                         
                    } else if (Shapes[j] instanceof XSLFPictureShape){                        
                        shape = (XSLFPictureShape)Shapes[j];                        
                    }                    
                }                                
            }
        }
        return new Negocio().caracteres(comunicado);
    }
    
    public XSLFTextShape setpptx(String file, int slidesparameter, int textparameter , String param ) throws IOException{        
        leer(file);
        Slides = ppt.getSlides();
        for (int i = 0; i < Slides.length; i++){            
            if(i==slidesparameter){
                Shapes = Slides[i].getShapes();            
            for (int j = 0; j < Shapes.length; j++){                    
                    name = Shapes[j].getShapeName();                    
                    java.awt.geom.Rectangle2D anchor = Shapes[j].getAnchor();                    
                    if (Shapes[j] instanceof XSLFTextShape){                        
                        text = (XSLFTextShape)Shapes[textparameter];                                    
                        if(file.equals("PMO-Aprobacion.pptx")){
                            text1=(XSLFTextShape)Shapes[6];
                        }else{
                            text1 = (XSLFTextShape)Shapes[0];
                        }                        
                        text.setText(param);    
                    }                   
                }                                
            }
        } 
        try { 
            //System.out.println(System.getProperty( "user.dir" ));
            Guardar(file);            
        } /*catch (PptException | FileNotFoundException ex) {
        Logger.getLogger(Slides.class.getName()).log(Level.SEVERE, null, ex);
        }*/ catch (Exception e) {
            Logger.getLogger(Slides.class.getName()).log(Level.SEVERE, null, e);
        } 
        return text1;
    }
    private void Guardar(String file) {
        try {
            Out = new FileOutputStream(url+folder1+file);
        } catch (FileNotFoundException ex) {
            Logger.getLogger(Slides.class.getName()).log(Level.SEVERE, null, ex);
        }
        try {
            ppt.write(Out);
        } catch (IOException ex) {
            Logger.getLogger(Slides.class.getName()).log(Level.SEVERE, null, ex);
        }
        try { 
            Out.close();
        } catch (IOException ex) {
            Logger.getLogger(Slides.class.getName()).log(Level.SEVERE, null, ex);
        }        
    }
    
    public void enviar(String [] Text,String file2, String[] to,String link,String params[][]) throws IOException{                
        Snum=0;  
        arraySlide=Text;
        for (int pt=0;pt<arraySlide.length;pt++){
                if(arraySlide[pt]==null){
                    Logger.getLogger(Slides.class.getName()).log(Level.SEVERE, "!> no existe TextShape = "+pt, new Exception());
                }else{
                   text2 = new Slides().setpptx( 
                            file2,Snum, pt, arraySlide[pt]);                                                       
                }
        }
        for (int st=0;st<to.length;st++) {
            System.out.println("dentro del void: "+to[st]);
        } 
        //new Negocio().copyFile(url+folder1+file2,url+folder1+zfile+file2);
        //new Negocio().renameFile(url+folder1+zfile+file2,url+folder1+zfile+text2.getText()+".pptx");
        SendSlide(to,file2,text2.getText(),exportar(link,params));
    }

   public String exportar(String link,String params[][]){
       //System.out.println("dentro del void exportar...");
       charset = "UTF-8";  // Or in Java 7 and later, use the constant: java.nio.charset.StandardCharsets.UTF_8.name()
// ... new Slides().exportar(new String(request.getRequestURL()+"?"+intSlide+"var1="+varString+"&page=%2FPMO%2Fcomunicacion.jsp&slide="+intSlide+""));
                
        try {
            query = String.format(""+params[0][0]+"=%s&"+params[0][1]+"=%s&"+params[0][2]+"=%s",
                    URLEncoder.encode(params[1][0], charset),
                    URLEncoder.encode(params[1][1], charset),
                    URLEncoder.encode(params[1][2], charset));
        } catch (UnsupportedEncodingException ex) {
            Logger.getLogger(Slides.class.getName()).log(Level.SEVERE, null, ex);
        }
      try {
         // Se abre la conexión
         URL_ = new URL(link);
         conexion = URL_.openConnection();
         conexion.setDoOutput(true); // Triggers POST.
         conexion.setRequestProperty("Accept-Charset", charset);
         conexion.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=" + charset);
         
         try (OutputStream output = conexion.getOutputStream()) {
             output.write(query.getBytes(charset));
         }         
         is = conexion.getInputStream();
         br = new BufferedReader(new InputStreamReader(is));    
         buffer = new char[1000];
         while ((leido = br.read(buffer)) > 0) {
            html = html+new String(buffer, 0, leido);      
            //System.out.println(leido+"|"+html);                   
         }  
         for (int i=0;i<limpiarTable[0].length;i++){ 
                html=html.replace(limpiarTable[0][i],limpiarTable[1][i]);
                //System.out.println(i+" - "+limpiarTable[0][i]+" | "+limpiarTable[1][i]);
         }
         HtmlFile = new File(htmlf);
        if(HtmlFile.exists()) {
            bw = new BufferedWriter(new FileWriter(HtmlFile));
            bw.write(html/*.replaceAll("null ", "")*/);
        } else {
            bw = new BufferedWriter(new FileWriter(HtmlFile));
            bw.write(html/*.replaceAll("null ", "")*/);
        }
        bw.close();        
      } catch (/*MalformedURL*/Exception e) {
         // TODO Auto-generated catch block
        // e.printStackTrace();
      //} catch (IOException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();         
      }     
      this.imagen(new String(html));
        return html;
    }
   private void imagen(String html){
       for (int i=0;i<limpiarTable2[0].length;i++){ 
                html=html.replace(limpiarTable2[0][i],limpiarTable2[1][i]);
                //System.out.println(i+" - "+limpiarTable2[0][i]+" | "+limpiarTable2[1][i]);
         }  
      //System.out.println(html);
        imageGenerator = new HtmlImageGenerator();
        imageGenerator.loadHtml(html);
        imageGenerator.setSize(new Dimension(500,500));
        imageGenerator.saveAsImage(png);
   }
    private void SendSlide(String [] Stakeholders,String file,String Subject,String content) {
        for(int i=0;i<Stakeholders.length;i++){
            
            if(Stakeholders[i]==null){
                System.out.println("no se generó email: "+Stakeholders[i]+" file: "+file);
            }else{    
                String rol = new Negocio().valor("INT_INTERESADO", "INT_ROL", "PT_PERSONA", "'"+ 
                        new Negocio().valor("PT_PERSONA", "USUARIO_PERSONA", "MAIL_PERSONA", "'"+Stakeholders[i]+"'")+"'");
                 if("2721".equals(rol)){
                    /* cc = "<div style='background: #F1F1F1;'>"
                            + "<h6 style=\"font: 12px 'calibri';margin: none;\">De: PMO</h6>" +
                              "<h6 style=\"font: 12px 'calibri';margin: none;\"> Enviado el:"+new java.util.Date()+"</h6>" +
                               "<h6 style=\"font: 12px 'calibri';margin: none;\"> CC: "+Stakeholders[0]+"; "+Stakeholders[1]+"; "+Stakeholders[2]+"@tigo.com.co </h6>" +
                                "<h6 style=\"font: 12px 'calibri';margin: none;\"> Asunto: "+Subject+"</h6>"
                            + "<div>\n";*/
                 }
                 System.out.println("generando email: "+Stakeholders[i]+" file: "+file);
                 SMTP smtp = new SMTP(Stakeholders[i],Subject,content+cc,null);                 
            }            
        }        
    }
}



/*
url+folder1+file
(0f, 0f, , , "Excel.Sheet.8", wbArray);
url+folder1+file

<%= new Slides().getSlides(4, 5)%>
<%= new Slides().getSlides(4, 7)%>

*/
