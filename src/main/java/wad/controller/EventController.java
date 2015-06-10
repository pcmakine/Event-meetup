/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package wad.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.transaction.Transactional;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import wad.domain.Event;
import wad.domain.Registration;
import wad.repository.EventRepository;
import wad.repository.LocationRepository;
import wad.repository.RegistrationRepository;

/**
 *
 * @author Pete
 */
@Controller
@RequestMapping("/events")
public class EventController {

    @Autowired
    private EventRepository eventRepo;
    @Autowired
    private LocationRepository locationRepo;

    @ModelAttribute("event")
    private Event getEvent() {
        return new Event();
    }

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat sdf = new SimpleDateFormat("dd.MM.yyyy");
        sdf.setLenient(true);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(sdf, true));
        
        System.out.println("Name: " + binder.getObjectName());
    }

    @ModelAttribute("registration")
    private Registration getRegistration() {
        return new Registration();
    }

    @RequestMapping(method = RequestMethod.GET)
    public String viewList(Model model) {
        List<Event> events = eventRepo.findAll();
        model.addAttribute("events", events);
        return "/WEB-INF/views/test.jsp";
    }

    @RequestMapping(value = "/{eventId}", method = RequestMethod.GET)
    public String viewEvent(Model model, @PathVariable Long eventId) {
        Event event = eventRepo.findOne(eventId);
        model.addAttribute("event", event);
        System.out.println(event);
        System.out.println(event.getLocation());
        return "/WEB-INF/views/event.jsp";
    }

    @RequestMapping(value = "/createform", method = RequestMethod.GET)
    public String showCreationForm() {
        return "/WEB-INF/views/createevent.jsp";
    }

    @RequestMapping(method = RequestMethod.POST)
    public String createEvent(@Valid @ModelAttribute("event") Event event,
            BindingResult bindingResult) {
        System.out.println("event name: " + event.getName());
        System.out.println("Event date:" + event.getDate());
        if (!bindingResult.hasErrors()) {

        }
        event.getLocation().setEvent(event);
        locationRepo.save(event.getLocation());
        eventRepo.save(event);
        return "redirect:/events";
    }

    @RequestMapping(value = "/test", method = RequestMethod.GET)
    public String viewTest(Model model) {
        List<Event> events = eventRepo.findAll();
        model.addAttribute("events", events);
        return "/WEB-INF/views/test.jsp";
    }
}
