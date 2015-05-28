package wad.controller;

import java.util.UUID;
import static org.junit.Assert.*;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.SpringApplicationConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;
import org.springframework.web.context.WebApplicationContext;
import wad.Application;
import wad.domain.Registration;
import wad.repository.RegistrationRepository;

@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(classes = Application.class)
@WebAppConfiguration
public class RegistrationAppTest {

    @Autowired
    private WebApplicationContext webAppContext;

    @Autowired
    private RegistrationRepository registrationRepository;

    private MockMvc mockMvc;

    @Before
    public void setUp() {
        this.mockMvc = MockMvcBuilders.webAppContextSetup(webAppContext).build();
    }

    @Test
    public void formReturnedOnGetToRegistrations() throws Exception {
        mockMvc.perform(get("/registrations"))
                .andExpect(status().isOk())
                .andExpect(forwardedUrl("/WEB-INF/views/form.jsp"));
    }

    @Test
    public void redirectToSuccessOnSuccessfulPostToRegister() throws Exception {
        String name = UUID.randomUUID().toString().substring(0, 10);
        String address = UUID.randomUUID().toString().substring(0, 16);
        String email = name.substring(0, 4) + "@" + address.substring(0, 4) + ".fi";

        mockMvc.perform(post("/registrations")
                .param("name", name)
                .param("address", address)
                .param("email", email))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("success.html"));

        boolean found = false;
        for (Registration registration : registrationRepository.findAll()) {
            if (registration.getName() == null) {
                continue;
            }

            if (registration.getName().equals(name)) {
                found = true;
                break;
            }
        }

        assertTrue("The registration must be added to database on success.", found);
    }

    @Test
    public void returnToFormOnTooShortName() throws Exception {
        String name = UUID.randomUUID().toString().substring(0, 3);
        String address = UUID.randomUUID().toString().substring(0, 16);
        String email = name.substring(0, 1) + "@" + address.substring(0, 4) + ".fi";

        try {
            mockMvc.perform(post("/registrations")
                    .param("name", name)
                    .param("address", address)
                    .param("email", email))
                    .andExpect(status().isOk())
                    .andExpect(forwardedUrl("/WEB-INF/views/form.jsp"));
        } catch (Throwable t) {
            fail("When the name is too short, the user should be shown the form again with existing inputs and error messages. Error: " + t.getMessage());
        }

        boolean found = false;
        for (Registration registration : registrationRepository.findAll()) {
            if (registration.getName() == null) {
                continue;
            }

            if (registration.getName().equals(name)) {
                found = true;
                break;
            }
        }

        assertFalse("The registration must not be added to the registrationService on failure.", found);
    }

    @Test
    public void returnToFormOnTooLongName() throws Exception {
        String name = UUID.randomUUID().toString() + UUID.randomUUID().toString() + UUID.randomUUID().toString();
        name = name.substring(0, 31);
        String address = UUID.randomUUID().toString().substring(0, 16);
        String email = name.substring(0, 1) + "@" + address.substring(0, 4) + ".fi";

        try {
            mockMvc.perform(post("/registrations")
                    .param("name", name)
                    .param("address", address)
                    .param("email", email))
                    .andExpect(status().isOk())
                    .andExpect(forwardedUrl("/WEB-INF/views/form.jsp"));
        } catch (Throwable t) {
            fail("When the name is too long, the user should be shown the form again with existing inputs and error messages. Error: " + t.getMessage());
        }

        boolean found = false;
        for (Registration registration : registrationRepository.findAll()) {
            if (registration.getName() == null) {
                continue;
            }

            if (registration.getName().equals(name)) {
                found = true;
                break;
            }
        }

        assertFalse("The registration must not be added to the registrationService on failure.", found);
    }

    @Test
    public void returnToFormOnTooShortAddress() throws Exception {

        String name = UUID.randomUUID().toString().substring(0, 6);
        String address = UUID.randomUUID().toString().substring(0, 3);
        String email = name.substring(0, 4) + "@" + address.substring(0, 1) + ".fi";

        try {
            mockMvc.perform(post("/registrations")
                    .param("name", name)
                    .param("address", address)
                    .param("email", email))
                    .andExpect(status().isOk())
                    .andExpect(forwardedUrl("/WEB-INF/views/form.jsp"));
        } catch (Throwable t) {
            fail("When the address is too short, the user should be shown the form again with existing inputs and error messages. Error: " + t.getMessage());
        }

        boolean found = false;
        for (Registration registration : registrationRepository.findAll()) {
            if (registration.getName() == null) {
                continue;
            }

            if (registration.getName().equals(name)) {
                found = true;
                break;
            }
        }

        assertFalse("The registration must not be added to the registrationService on failure.", found);
    }

    @Test
    public void returnToFormOnTooLongAddress() throws Exception {
        String name = UUID.randomUUID().toString().substring(0, 6);
        String address = UUID.randomUUID().toString() + UUID.randomUUID().toString() + UUID.randomUUID().toString();
        address = address.substring(0, 51);
        String email = name.substring(0, 4) + "@" + address.substring(0, 1) + ".fi";

        try {
            mockMvc.perform(post("/registrations")
                    .param("name", name)
                    .param("address", address)
                    .param("email", email))
                    .andExpect(status().isOk())
                    .andExpect(forwardedUrl("/WEB-INF/views/form.jsp"));
        } catch (Throwable t) {
            fail("When the address is too long, the user should be shown the form again with existing inputs and error messages. Error: " + t.getMessage());
        }

        boolean found = false;
        for (Registration registration : registrationRepository.findAll()) {
            if (registration.getName() == null) {
                continue;
            }

            if (registration.getName().equals(name)) {
                found = true;
                break;
            }
        }

        assertFalse("The registration must not be added to the registrationService on failure.", found);
    }

    @Test
    public void returnToFormOnEmail() throws Exception {
        String name = UUID.randomUUID().toString().substring(0, 6);
        String address = UUID.randomUUID().toString().substring(0, 16);
        String email = name.substring(0, 3) + address.substring(0, 5) + ".fi";

        try {
            mockMvc.perform(post("/registrations")
                    .param("name", name)
                    .param("address", address)
                    .param("email", email))
                    .andExpect(status().isOk())
                    .andExpect(forwardedUrl("/WEB-INF/views/form.jsp"));
        } catch (Throwable t) {
            fail("When the email is invalid, the user should be shown the form again with existing inputs and error messages. Error: " + t.getMessage());
        }

        boolean found = false;
        for (Registration registration : registrationRepository.findAll()) {
            if (registration.getName() == null) {
                continue;
            }

            if (registration.getName().equals(name)) {
                found = true;
                break;
            }
        }

        assertFalse("The registration must not be added to the registrationService on failure.", found);
    }

    @Test
    public void returnToFormOnAllFailure() throws Exception {
        String name = UUID.randomUUID().toString().substring(0, 2);
        String address = UUID.randomUUID().toString().substring(0, 2);
        String email = name.substring(0, 1) + address.substring(0, 1) + ".fi";

        try {
            mockMvc.perform(post("/registrations")
                    .param("name", name)
                    .param("address", address)
                    .param("email", email))
                    .andExpect(status().isOk())
                    .andExpect(forwardedUrl("/WEB-INF/views/form.jsp"));
        } catch (Throwable t) {
            fail("When any of the inputs is faulty, the user should be shown the form again with existing inputs and error messages. Error: " + t.getMessage());
        }

        boolean found = false;
        for (Registration registration : registrationRepository.findAll()) {
            if (registration.getName() == null) {
                continue;
            }

            if (registration.getName().equals(name)) {
                found = true;
                break;
            }
        }

        assertFalse("The registration must not be added to the registrationService on failure.", found);
    }
}
