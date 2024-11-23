package com.hotelaria.hotelaria.domain.repository;

import com.hotelaria.hotelaria.domain.entity.Hospede;
import com.hotelaria.hotelaria.domain.entity.Pessoa;
import com.hotelaria.hotelaria.domain.entity.ReservaAcomodacao;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public interface PessoaRepository extends JpaRepository<Pessoa, Long> {
  @Query(value = "SELECT * FROM pessoa WHERE id = ?1", nativeQuery = true)
  Optional<Pessoa> retrieveById(Long pessoaId);

  @Modifying
  @Query(value = "DELETE FROM pessoa WHERE id = ?1", nativeQuery = true)
  void removePessoa(Long pessoaId);

  @Modifying
  @Transactional
  @Query(
    value = "INSERT INTO pessoa (nome, data_nascimento, celular, email, sexo, documento_identificacao_id) VALUES (?1, ?2, ?3, ?4, ?5, ?6)",
    nativeQuery = true
  )
  void insert(String nome, LocalDate dataNascimento, String celular, String email, String sexo, Long documentoIdentificacaoId);
}
