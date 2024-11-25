package com.hotelaria.hotelaria.domain.repository;

import com.hotelaria.hotelaria.domain.entity.Livro;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

public interface LivroRepository extends JpaRepository<Livro, Long> {
  @Modifying
  @Query(
    value = "DELETE ll FROM locacao_livro ll INNER JOIN reserva_acomodacao ra ON ll.reserva_acomodacao_id = ra.id WHERE ra.hotel_id = ?1",
    nativeQuery = true)
  void removeAllLocacoesFromHotel(Long hotelId);
}
