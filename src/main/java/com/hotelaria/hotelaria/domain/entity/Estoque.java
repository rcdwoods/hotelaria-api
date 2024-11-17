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
  @OneToMany(mappedBy = "id.estoque")
  private List<EstoqueProduto> produtos;
  @Column(name = "data_atualizacao")
  private LocalDateTime data_atualizacao;
}
