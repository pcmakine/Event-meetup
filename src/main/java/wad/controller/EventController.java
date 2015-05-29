/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package wad.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import wad.domain.Event;
import wad.domain.Registration;
import wad.repository.EventRepository;
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
    
    @RequestMapping(method = RequestMethod.GET)
    public String viewList(Model model){
        List<Event> events = eventRepo.findAll();
        model.addAttribute("events", events);
        return "/WEB-INF/views/showevents.jsp";
    }
    
    @RequestMapping(value = "/{eventId}", method = RequestMethod.GET)
    public String viewEvent(Model model, @PathVariable Long eventId){
        model.addAttribute("event", eventRepo.findOne(eventId));
        return "/WEB-INF/views/event.jsp";
    }
}
