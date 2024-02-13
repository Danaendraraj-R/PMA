import java.io.IOException;
import java.io.InputStream;
import java.util.logging.LogManager;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class Logging implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        try {
            InputStream config = getClass().getClassLoader().getResourceAsStream("logging.properties");
            LogManager.getLogManager().readConfiguration(config);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
