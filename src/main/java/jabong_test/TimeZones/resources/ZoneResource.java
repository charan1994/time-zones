package jabong_test.TimeZones.resources;
import jabong_test.TimeZones.api.Saying;
import com.google.common.base.Optional;
import com.codahale.metrics.annotation.Timed;
//import java.time.ZoneOffset;
//import java.time.ZonedDateTime;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import java.util.concurrent.atomic.AtomicLong;
import org.joda.time.DateTime;
import org.joda.time.DateTimeZone;
@Path("/time")
@Produces(MediaType.APPLICATION_JSON)
public class ZoneResource {
    private final String template;
    private final String defaultTime;
    private final AtomicLong counter;

    public ZoneResource(String template,String defaultTime) {
        this.template = template;
        this.defaultTime=defaultTime;
        this.counter = new AtomicLong();
    }

    @GET
    @Timed
    public Saying sayHello(@QueryParam("time") Optional<String> time) {
    	/*ZoneOffset r=ZoneOffset.of(time.or(defaultTime));//this line was added
    	ZonedDateTime now=ZonedDateTime.now(r);*/
    	DateTime now = new DateTime(System.currentTimeMillis(), DateTimeZone.forID(time.or(defaultTime)));
        final String value = String.format(template,now.toString()); /*time.or(defaultTime));*/
        return new Saying(counter.incrementAndGet(), value);
    }
}