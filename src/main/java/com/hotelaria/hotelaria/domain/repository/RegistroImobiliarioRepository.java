package com.hotelaria.hotelaria.domain.repository;

import com.hotelaria.hotelaria.domain.entity.PoliticaDeUso;
import com.hotelaria.hotelaria.domain.entity.RegistroImobiliario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.Optional;

public interface RegistroImobiliarioRepository extends JpaRepository<RegistroImobiliario, Long> {
  @Query(value = "SELECT * FROM registro_imobiliario WHERE id = ?1", nativeQuery = true)
  Optional<RegistroImobiliario> retrieveById(Long id);

  @Modifying
  @Transactional
  @Query(
    value = "INSERT INTO registro_imobiliario (numero_registro_prefeitura, data_registro, georreferenciamento_id) VALUES (?1, ?2, ?3)",
    nativeQuery = true
  )
  void insert(String numeroRegistroPrefeitura, LocalDate dataRegistro, Long georreferenciamentoId);

  @Modifying
  @Transactional
  @Query(
    value = "UPDATE registro_imobiliario SET numero_registro_prefeitura = ?2, data_registro = ?3 WHERE id = ?1",
    nativeQuery = true
  )
  void update(Long registroImobiliarioId, LocalDate dataRegistro);

  @Modifying
  @Transactional
  @Query(
    value = "DELETE FROM registro_imobiliario WHERE id = ?1",
    nativeQuery = true
  )
  void deleteRegistroById(Long id);

  @Query(value = "SELECT * FROM registro_imobiliario WHERE id = LAST_INSERT_ID()", nativeQuery = true)
  RegistroImobiliario retrieveLastCreated();
}
