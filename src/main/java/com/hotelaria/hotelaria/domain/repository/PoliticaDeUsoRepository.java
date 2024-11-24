package com.hotelaria.hotelaria.domain.repository;

import com.hotelaria.hotelaria.domain.entity.PoliticaDeUso;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

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

  @Query(value = "EXISTS(SELECT 1 FROM politica_de_uso WHERE id = ?1)", nativeQuery = true)
  boolean existsById(long politicaDeUsoId);

  @Query(
    value = "SELECT * FROM politica_de_uso p INNER JOIN acomodacao_politica_de_uso ap on ap.politica_de_uso_id = p.id " +
      "WHERE ap.numero_acomodacao = ?1 AND ap.hotel_id = ?2",
    nativeQuery = true
  )
  List<PoliticaDeUso> retrieveAllByAcomodacaoFromHotel(Long numeroAcomodacao, Long hotelId);

  @Modifying
  @Query(
    value = "DELETE FROM acomodacao_politica_de_uso WHERE hotel_id = ?1",
    nativeQuery = true
  )
  void removeAllFromHotel(Long hotelId);
}
