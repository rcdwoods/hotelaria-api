package com.hotelaria.hotelaria.domain.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class DocumentoIdentificacao {
  @Id
  private Long id;
  private String numero;
  private TipoDocumentoEnum tipo;
}
