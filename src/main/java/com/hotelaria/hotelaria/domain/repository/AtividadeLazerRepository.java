package com.hotelaria.hotelaria.domain.repository;

import com.hotelaria.hotelaria.domain.entity.AtividadeLazer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

public interface AtividadeLazerRepository extends JpaRepository<AtividadeLazer, Long> {
  @Modifying
  @Query(
    value = "DELETE FROM atividade_lazer WHERE hotel_id = ?1",
    nativeQuery = true
  )
  void removeAllFromHotel(Long hotelId);
  @Modifying
  @Query(
    value = "DELETE ial FROM inscricao_atividade_lazer ial INNER JOIN atividade_lazer a ON ial.atividade_lazer_id = a.id WHERE a.hotel_id = ?1",
    nativeQuery = true
  )
  void removeInscricoesFromHotel(Long hotelId);
}
