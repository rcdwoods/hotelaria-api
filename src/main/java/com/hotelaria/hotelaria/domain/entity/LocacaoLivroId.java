package com.hotelaria.hotelaria.domain.entity;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.Embeddable;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import java.io.Serializable;

@Getter
@Setter
@Embeddable
@EqualsAndHashCode
@NoArgsConstructor
public class LocacaoLivroId implements Serializable {
  @ManyToOne
  @JoinColumn(name = "livro_id")
  private Livro livro;
  @ManyToOne
  @JoinColumn(name = "biblioteca_id")
  private Biblioteca biblioteca;
}
