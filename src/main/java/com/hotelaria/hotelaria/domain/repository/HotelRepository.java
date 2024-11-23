package com.hotelaria.hotelaria.domain.repository;

import com.hotelaria.hotelaria.domain.entity.Hotel;
import com.hotelaria.hotelaria.domain.entity.PoliticaDeUso;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface HotelRepository extends JpaRepository<Hotel, Long> {
  @Query(value = "SELECT * FROM hotel", nativeQuery = true)
  List<Hotel> retrieveAll();

  @Modifying
  @Transactional
  @Query(
    value = "INSERT INTO hotel (nome_fantasia, setor, tamanho, is_central, categoria, registro_imobiliario_id) VALUES (?1, ?2, ?3, ?4, ?5, ?6)",
    nativeQuery = true
  )
  void insert(String nomeFantasia, String setor, Long tamanho, Boolean isCentral, String categoria, Long registroImobiliarioId);

  @Modifying
  @Transactional
  @Query(
    value = "UPDATE hotel SET nome_fantasia = ?2, setor = ?3, tamanho = ?4, is_central = ?5 WHERE id = ?1",
    nativeQuery = true
  )
  void update(Long hotelId, String nomeFantasia, String setor, Long tamanho, Boolean isCentral);

  @Modifying
  @Transactional
  @Query(
    value = "DELETE FROM hotel WHERE id = ?1",
    nativeQuery = true
  )
  void deleteByNumeroAndHotelId(Long hotelId);

  @Query(value = "SELECT * FROM hotel WHERE id = LAST_INSERT_ID()", nativeQuery = true)
  Hotel retrieveLastCreated();
}
