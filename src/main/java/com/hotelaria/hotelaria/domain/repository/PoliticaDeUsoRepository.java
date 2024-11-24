package com.hotelaria.hotelaria.domain.repository;

import com.hotelaria.hotelaria.domain.entity.PoliticaDeUso;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

public interface PoliticaDeUsoRepository extends JpaRepository<PoliticaDeUso, Long> {
  @Query(value = "SELECT * FROM politica_de_uso", nativeQuery = true)
  List<PoliticaDeUso> retrieveAll();

  @Modifying
  @Transactional
  @Query(
    value = "INSERT INTO politica_de_uso (nome, descricao) VALUES (?1, ?2)",
    nativeQuery = true
  )
  void insert(String nome, String descricao);

  @Modifying
  @Transactional
  @Query(
    value = "UPDATE politica_de_uso SET nome = ?2, descricao = ?3 WHERE id = ?1",
    nativeQuery = true
  )
  void update(Long id, String nome, String descricao);

  @Modifying
  @Transactional
  @Query(
    value = "DELETE FROM politica_de_uso WHERE id = ?1",
    nativeQuery = true
  )
  void deleteById(Long id);

  @Query(value = "SELECT LAST_INSERT_ID()", nativeQuery = true)
  Long getLastInsertId();

  @Query(value = "SELECT * FROM politica_de_uso WHERE id = LAST_INSERT_ID()", nativeQuery = true)
  PoliticaDeUso retrieveLastCreated();
}