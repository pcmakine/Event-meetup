package wad.controller;

import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import wad.domain.Registration;
import wad.repository.RegistrationRepository;

@Controller
@RequestMapping("/registrations")
public class RegistrationController {

    @Autowired
    private RegistrationRepository registrationRepository;

    @ModelAttribute("registration")
    private Registration getRegistration() {
        return new Registration();
    }

    @RequestMapping(method = RequestMethod.GET)
    public String view() {
        return "/WEB-INF/views/form.jsp";
    }

    @RequestMapping(method = RequestMethod.POST)
    public String register(
            @Valid @ModelAttribute("registration") Registration registration,
            BindingResult bindingResult) {
        if (!bindingResult.hasErrors()) {
            registrationRepository.save(registration);
            return "redirect:success.html";
        }
        return view();
    }

}
