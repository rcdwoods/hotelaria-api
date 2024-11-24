package com.hotelaria.hotelaria.domain.repository;

import com.hotelaria.hotelaria.domain.entity.Georreferenciamento;
import com.hotelaria.hotelaria.domain.entity.RegistroImobiliario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Optional;

public interface GeorreferenciamentoRepository extends JpaRepository<Georreferenciamento, Long> {
  @Query(value = "SELECT * FROM georreferenciamento WHERE id = ?1", nativeQuery = true)
  Optional<Georreferenciamento> retrieveById(Long id);

  @Modifying
  @Transactional
  @Query(
    value = "INSERT INTO georreferenciamento (latitude, longitude) VALUES (?1, ?2)",
    nativeQuery = true
  )
  void insert(BigDecimal latitude, BigDecimal longitude);

  @Modifying
  @Transactional
  @Query(
    value = "UPDATE georreferenciamento SET latitude = ?2, longitude = ?3 WHERE id = ?1",
    nativeQuery = true
  )
  void update(Long id, BigDecimal latitude, BigDecimal longitude);

  @Modifying
  @Transactional
  @Query(
    value = "DELETE FROM georreferenciamento WHERE id = ?1",
    nativeQuery = true
  )
  void deleteGeorreferenciamentoById(long id);

  @Query(value = "SELECT * FROM georreferenciamento WHERE id = LAST_INSERT_ID()", nativeQuery = true)
  Georreferenciamento retrieveLastCreated();
}
