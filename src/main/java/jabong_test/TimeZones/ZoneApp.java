package jabong_test.TimeZones;
import io.dropwizard.Application;
import io.dropwizard.setup.Bootstrap;
import io.dropwizard.setup.Environment;
import jabong_test.TimeZones.resources.ZoneResource;
import jabong_test.TimeZones.health.TemplateHealthCheck;
//import jabong_test.Timecheck.health.TemplateHealthCheck;

public class ZoneApp extends Application<ZoneConfig> {
    public static void main(String[] args) throws Exception {
        new ZoneApp().run(args);
    }

    @Override
    public String getName() {
        return "Time check";
    }

    @Override
    public void initialize(Bootstrap<ZoneConfig> bootstrap) {
        // nothing to do yet
    }

    @Override
    public void run(ZoneConfig configuration,
                    Environment environment) {
    	final ZoneResource resource = new ZoneResource(
    	        configuration.getTemplate(),configuration.getDefaultTime());
    	 final TemplateHealthCheck healthCheck =
    		        new TemplateHealthCheck(configuration.getTemplate());
    		    environment.healthChecks().register("template", healthCheck);
    	    environment.jersey().register(resource);
    }

}