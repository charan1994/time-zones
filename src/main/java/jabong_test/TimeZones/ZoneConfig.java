package jabong_test.TimeZones;
import io.dropwizard.Configuration;
import com.fasterxml.jackson.annotation.JsonProperty;
import org.hibernate.validator.constraints.NotEmpty;

public class ZoneConfig extends Configuration {
    @NotEmpty
    private String template;
    
    @NotEmpty
    private String defaultTime = "UTC";

    @JsonProperty
    public String getTemplate() {
        return template;
    }

    @JsonProperty
    public void setTemplate(String template) {
        this.template = template;
    }
    
    @JsonProperty
    public String getDefaultTime() {
        return defaultTime;
    }

    @JsonProperty
    public void setDefaultTime(String time) {
        this.defaultTime = time;
    }
}
