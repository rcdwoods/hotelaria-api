package com.hotelaria.hotelaria.domain.repository;

import com.hotelaria.hotelaria.domain.entity.Hospede;
import org.springframework.data.jpa.repository.JpaRepository;

public interface HospedeRepository extends JpaRepository<Hospede, Long> {
}
