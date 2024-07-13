package com.qcmarcel.PMIS.Servicios;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.activation.*;
import javax.mail.*;
import javax.mail.internet.*;
public final class SMTP {
    private String to,from,host,filename;
    private Session session;
    private MimeMessage message;
    private MimeBodyPart messageBodyPart;
    private MimeMultipart multipart;
    private FileDataSource source;
    public SMTP(String Correo,String Asunto,String Contenido,String file){
        if(!Correo.equalsIgnoreCase("") && !Correo.equalsIgnoreCase(" ")){
            to = Correo;
            from = "pmo@tigo.com.co";
            host = "10.69.52.12";
            Properties properties = System.getProperties();
            properties.setProperty("mail.smtp.host", host);
            session = Session.getDefaultInstance(properties);
            try{
                message = new MimeMessage(session);
                message.setFrom(new InternetAddress(from));
                message.addRecipient(Message.RecipientType.TO,new InternetAddress(to));
                message.setSubject(Asunto);
                messageBodyPart = new MimeBodyPart();
                String firma = "<img style=\"max-width: 600px;\" src=\"images/comunicacion/com-foo.png\" name=\"Requerimientos\" alt=\"fases\" />";
                //String firma = "<img style=\"max-width: 600px;\" src=\"C:\\Users\\marcel.quintero\\Google Drive\\Márcel\\PMO - Tigo\\Applications\\PMO\\IMAGES\\comunicacion\\com-foo.png\" name=\"Requerimientos\" alt=\"fases\" />";messageBodyPart.setContent(Contenido+firma,"text/html");
                multipart = new MimeMultipart();
                multipart.addBodyPart(messageBodyPart);
                messageBodyPart = new MimeBodyPart();                
                if(file==null){
                    
                }else{ 
                filename = file;
                source = new FileDataSource(filename);
                messageBodyPart.setDataHandler(new DataHandler(source));
                messageBodyPart.setFileName(Asunto+".pptx"); 
                multipart.addBodyPart(messageBodyPart);
                }               
                message.setContent(Contenido+firma,"text/html");
                Transport.send(message);
                System.out.println("Sent message successfully....");
            } catch (Exception ex) {
                Logger.getLogger(SMTP.class.getName()).log(Level.SEVERE, "!> to:\n"+Correo+"\nSubject:\n"+Asunto+"\nFile:\n"+file, ex);
            }finally{
                mensaje("Envio exitoso");
            }
        }else{
            mensaje("especifique los campos");
        }
    }
    private String mensaje(String mensaje) {
     return mensaje;        
    } 
}
	

