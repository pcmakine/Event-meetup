package wad.controller;

import java.util.Date;
import java.util.List;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import wad.domain.Registration;
import wad.repository.RegistrationRepository;

@Controller
public class RegistrationController {

    @Autowired
    private RegistrationRepository registrationRepository;

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
            BindingResult bindingResult) {
        if (!bindingResult.hasErrors()) {
            registration.setRegistrationDate(new Date());
            registrationRepository.save(registration);
            return "redirect:success.html";
        }
        return view();
    }

}
