package wad.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import wad.domain.Registration;

public interface RegistrationRepository extends JpaRepository<Registration, Long> {

}
