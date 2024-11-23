package com.hotelaria.hotelaria.domain.entity;

import javax.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

@Embeddable
@Getter
@Setter
public class EstoqueProdutoId implements Serializable {
  @ManyToOne
  @JoinColumn(name = "estoque_id")
  private Estoque estoque;
  @ManyToOne
  @JoinColumn(name = "produto_id")
  private Produto produto;
}
