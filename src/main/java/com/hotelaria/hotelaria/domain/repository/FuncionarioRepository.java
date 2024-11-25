package com.hotelaria.hotelaria.domain.repository;

import com.hotelaria.hotelaria.domain.entity.Funcionario;
import com.hotelaria.hotelaria.domain.entity.Pessoa;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.Optional;

public interface FuncionarioRepository extends JpaRepository<Funcionario, Long> {
  @Modifying
  @Query(value = "DELETE FROM funcionario WHERE hotel_id = ?1", nativeQuery = true)
  void removeAllFromHotel(Long hotelId);

  @Modifying
  @Query(
    value = "DELETE r FROM requisicao r INNER JOIN funcionario f ON r.funcionario_id = f.id WHERE f.hotel_id = ?1",
    nativeQuery = true
  )
  void removeAllRequisicoesFromFuncionariosFromHotel(Long hotelId);

  @Modifying
  @Query(
    value = "DELETE hr FROM hospede_requisicao hr INNER JOIN requisicao r ON hr.requisicao_id = r.id INNER JOIN funcionario f ON r.funcionario_id = f.id WHERE f.hotel_id = ?1",
    nativeQuery = true
  )
  void removeAllRequisicoesWithHospedesFromFuncionariosFromHotel(Long hotelId);

  @Modifying
  @Query(
    value = "DELETE c FROM contrato_de_trabalho c INNER JOIN funcionario f ON c.funcionario_id = f.id WHERE f.hotel_id = ?1",
    nativeQuery = true
  )
  void removeAllContratosDeTrabalhoFromHotel(Long hotelId);
}
