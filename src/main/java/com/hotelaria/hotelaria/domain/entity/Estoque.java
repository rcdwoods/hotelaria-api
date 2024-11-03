package com.hotelaria.hotelaria.domain.entity;

import jakarta.persistence.*;

import java.time.LocalDateTime;
import java.util.List;

@Entity
public class Estoque {
  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE)
  private Long id;
  private Integer capacidade;
  @ManyToMany
  @JoinTable(
    name = "estoque_produto",
    joinColumns = @JoinColumn(name = "estoque_id"),
    inverseJoinColumns = @JoinColumn(name = "produto_id")
  )
  private List<Produto> produtos;
  private LocalDateTime atualizadoEm;
}
