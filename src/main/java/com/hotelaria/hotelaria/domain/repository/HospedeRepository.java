package com.hotelaria.hotelaria.domain.repository;

import com.hotelaria.hotelaria.domain.entity.Hospede;
import com.hotelaria.hotelaria.domain.entity.ReservaAcomodacao;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface HospedeRepository extends JpaRepository<Hospede, Long> {
  @Query(value = "SELECT * FROM reserva_acomodacao WHERE hospede_id = ?1", nativeQuery = true)
  List<ReservaAcomodacao> retrieveReservasFromHospede(Long hospedeId);
  @Query(value = "SELECT * FROM hospede WHERE id = ?1", nativeQuery = true)
  Optional<Hospede> retrieveById(Long hospedeId);
}
