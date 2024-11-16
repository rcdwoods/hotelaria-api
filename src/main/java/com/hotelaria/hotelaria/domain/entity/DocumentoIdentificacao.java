package com.hotelaria.hotelaria.domain.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Id;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class DocumentoIdentificacao {
  @Id
  private Long id;
  private String numero;
  @Enumerated(EnumType.STRING)
  private TipoDocumentoEnum tipo;
}
