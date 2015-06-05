package wad.profiles;

import java.util.Arrays;
import java.util.Date;
import javax.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import wad.domain.Event;
import wad.domain.Location;
import wad.domain.Registration;
import wad.repository.EventRepository;
import wad.repository.LocationRepository;
import wad.repository.RegistrationRepository;

@Configuration
@Profile(value = {"dev", "default"})
public class DevProfile {

    @Autowired
    private RegistrationRepository registrationRepo;
    @Autowired
    private EventRepository eventRepo;
    @Autowired
    private LocationRepository locationRepo;

    @PostConstruct
    public void insertTestDataInDB() {

        Location location1 = new Location();
        location1.setAddress("Töölönlahti");
        location1.setLongitude(24.9353961);
        location1.setLatitude(60.1812755);
        locationRepo.save(location1);

        Registration registration = new Registration();
        registration.setEmail("test@testaan.fi");
        registration.setName("Meitsi");
        // registrationRepo.save(registration);

        Event event = new Event();
        event.setName("eka testieventti");
        event.setDate(new Date(2015 - 1900, 6, 4));
        event.setDescription("Siisti testieventti");
        event.setLocation(location1);
        event.setRegistrations(Arrays.asList(new Registration[]{registration}));
        eventRepo.save(event);

        location1.setEvent(event);
        locationRepo.save(location1);
        registration.setEvent(event);
        registrationRepo.save(registration);

        Location location2 = new Location();
        location2.setAddress("Hietsu");
        location2.setLongitude(24.9039416);
        location2.setLatitude(60.1737381);

        Event event2 = new Event();
        event2.setName("Toka testieventti");
        event2.setDate(new Date(2015 - 1900, 6, 4));
        event2.setDescription("Toka siisti testieventti");
        event2.setLocation(location2);
        event2.setRegistrations(Arrays.asList(new Registration[]{registration}));
        eventRepo.save(event);

        location2.setEvent(event2);
        locationRepo.save(location2);

    }
}
