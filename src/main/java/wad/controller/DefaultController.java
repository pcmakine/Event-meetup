/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package wad.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import wad.domain.Event;
import wad.repository.EventRepository;

/**
 *
 * @author Pete
 */
@Controller
@RequestMapping("*")
public class DefaultController {

    @Autowired
    private EventRepository eventRepo;

    @RequestMapping(method = RequestMethod.GET)
    public String view(Model model) {
        List<Event> events = eventRepo.findAll();
        model.addAttribute("events", events);
        return "redirect:/events";
    }

    
    

}
