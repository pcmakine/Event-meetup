package wad.controller;

import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import wad.domain.Event;
import wad.domain.Registration;
import wad.repository.EventRepository;
import wad.repository.RegistrationRepository;

@Controller
public class RegistrationController {

    @Autowired
    private RegistrationRepository registrationRepository;
    @Autowired
    private EventRepository eventRepository;

    @ModelAttribute("registration")
    private Registration getRegistration() {
        return new Registration();
    }

    @RequestMapping(value = "/registrations/createform", method = RequestMethod.GET)
    public String view() {
        return "/WEB-INF/views/form.jsp";
    }

    @RequestMapping(value = "/registrations", method = RequestMethod.GET)
    public String viewList(Model model) {
        List<Registration> registrations = registrationRepository.findAll();
        model.addAttribute("registrations", registrations);
        return "/WEB-INF/views/showregistrations.jsp";
    }

    @RequestMapping(value = "/registrations", method = RequestMethod.POST)
    public String register(
            @Valid @ModelAttribute("registration") Registration registration,
            BindingResult bindingResult, @RequestParam String eventId, HttpServletRequest request) {
        if (!bindingResult.hasErrors()) {
            Event event = eventRepository.findOne(Long.valueOf(request.getParameter("eventId")));
            List<Registration> registrations = event.getRegistrations();
            registrations.add(registration);
            event.setRegistrations(registrations);
            eventRepository.save(event);
            registration.setEvent(event);
            
            registration.setRegistrationDate(new Date());
            registrationRepository.save(registration);
            return "redirect:/events";
        }
        return view();
    }

}
