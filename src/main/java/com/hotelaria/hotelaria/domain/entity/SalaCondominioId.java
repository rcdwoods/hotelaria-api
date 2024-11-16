package com.hotelaria.hotelaria.domain.entity;

import jakarta.persistence.Embeddable;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Embeddable
@EqualsAndHashCode
@NoArgsConstructor
public class SalaCondominioId {
  private Long numero;
  @ManyToOne
  @JoinColumn(name = "condominio_id")
  private Condominio condominio;
}
