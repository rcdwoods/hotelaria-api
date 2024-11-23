package com.hotelaria.hotelaria.domain.repository;

import com.hotelaria.hotelaria.domain.entity.Hospede;
import com.hotelaria.hotelaria.domain.entity.ReservaAcomodacao;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public interface HospedeRepository extends JpaRepository<Hospede, Long> {
  @Query(value = "SELECT * FROM reserva_acomodacao WHERE hospede_id = ?1", nativeQuery = true)
  List<ReservaAcomodacao> retrieveReservasFromHospede(Long hospedeId);

  @Query(value = "SELECT * FROM hospede WHERE id = ?1", nativeQuery = true)
  Optional<Hospede> retrieveById(Long hospedeId);

  @Modifying
  @Query(value = "DELETE FROM hospede WHERE id = ?1", nativeQuery = true)
  void removeHospedeById(Long hospedeId);

  @Modifying
  @Transactional
  @Query(
    value = "UPDATE hospede SET data_registro = ?2 WHERE id = ?1",
    nativeQuery = true
  )
  void updateHospede(Long hospedeId, LocalDateTime dataRegistro);

  @Modifying
  @Transactional
  @Query(
    value = "INSERT INTO hospede (pessoa_id, data_registro) VALUES (?1, ?2)",
    nativeQuery = true
  )
  void insert(Long pessoaId, LocalDateTime dataRegistro);
}
