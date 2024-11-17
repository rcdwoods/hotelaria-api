package com.hotelaria.hotelaria.domain.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Embeddable
@Getter
@Setter
public class EstoqueProdutoId {
  @ManyToOne
  @JoinColumn(name = "estoque_id")
  private Estoque estoque;
  @ManyToOne
  @JoinColumn(name = "produto_id")
  private Produto produto;
}
