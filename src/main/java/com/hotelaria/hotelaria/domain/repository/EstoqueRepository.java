package com.hotelaria.hotelaria.domain.repository;

import com.hotelaria.hotelaria.domain.entity.Cozinha;
import com.hotelaria.hotelaria.domain.entity.Estoque;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

public interface EstoqueRepository extends JpaRepository<Estoque, Long> {
  @Modifying
  @Query(
    value = "DELETE e FROM estoque e INNER JOIN cozinha c ON e.id = c.estoque_id WHERE c.hotel_id = ?1",
    nativeQuery = true
  )
  void removeFromHotel(Long hotelId);

  @Modifying
  @Query(
    value = "DELETE ep FROM estoque_produto ep INNER JOIN cozinha c ON  ep.estoque_id = c.estoque_id WHERE c.hotel_id = ?1",
    nativeQuery = true
  )
  void removeProductsFromHotelEstoque(Long hotelId);
}
