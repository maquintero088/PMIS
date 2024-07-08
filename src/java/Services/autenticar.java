package Services;
import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;
public class autenticar extends Authenticator{
    String usuario,clave; 
 public autenticar(String u, String c){
  usuario=u;
  clave=c;
 } 
    @Override
 public PasswordAuthentication getPasswordAuthentication() {
        return new PasswordAuthentication(usuario, clave);
    }
}
