package com.hotelaria.hotelaria.domain.repository;

import com.hotelaria.hotelaria.domain.entity.DocumentoIdentificacao;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

public interface DocumentoIdentificacaoRepository extends JpaRepository<DocumentoIdentificacao, Long> {
  @Query(value = "SELECT * FROM documento_identificacao WHERE id = ?1", nativeQuery = true)
  Optional<DocumentoIdentificacao> retrieveById(Long documentoId);

  @Modifying
  @Query(value = "DELETE FROM documento_identificacao WHERE id = ?1", nativeQuery = true)
  void removeDocumentoIdentificacaoById(Long documentoIdentificacaoId);

  @Modifying
  @Transactional
  @Query(
    value = "INSERT INTO documento_identificacao (tipo, numero) VALUES (?1, ?2)",
    nativeQuery = true
  )
  void insert(String tipo, String numero);
}
