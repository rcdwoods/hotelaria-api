package com.hotelaria.hotelaria.domain.entity;

import javax.persistence.Embeddable;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.Serializable;

@Getter
@Setter
@Embeddable
@EqualsAndHashCode
@NoArgsConstructor
public class SalaCondominioId implements Serializable {
  private Long numero;
  @ManyToOne
  @JoinColumn(name = "condominio_id")
  private Condominio condominio;
}
