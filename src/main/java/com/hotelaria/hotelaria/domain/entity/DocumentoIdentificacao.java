package com.hotelaria.hotelaria.domain.entity;

import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.Id;
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
