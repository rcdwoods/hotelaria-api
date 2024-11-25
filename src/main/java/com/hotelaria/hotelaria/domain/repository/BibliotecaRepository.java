package com.hotelaria.hotelaria.domain.repository;

import com.hotelaria.hotelaria.domain.entity.Biblioteca;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

public interface BibliotecaRepository extends JpaRepository<Biblioteca, Long> {
  @Modifying
  @Query(
    value = "DELETE FROM biblioteca WHERE hotel_id = ?1",
    nativeQuery = true
  )
  void removeFromHotel(Long hotelId);
  @Modifying
  @Query(
    value = "DELETE bl FROM biblioteca_livro bl INNER JOIN biblioteca b ON bl.biblioteca_id = b.id WHERE b.hotel_id = ?1",
    nativeQuery = true
  )
  void removeAllLivrosFromHotel(Long hotelId);
  @Modifying
  @Query(
    value = "DELETE bp FROM biblioteca_politica_de_uso bp INNER JOIN biblioteca b ON bp.biblioteca_id = b.id WHERE b.hotel_id = ?1",
    nativeQuery = true
  )
  void removeAllPoliticasDeUsoFromHotel(Long hotelId);
}
