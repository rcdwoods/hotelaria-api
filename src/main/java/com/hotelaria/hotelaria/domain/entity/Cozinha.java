package com.hotelaria.hotelaria.domain.entity;

import javax.persistence.*;

@Entity
public class Cozinha {
  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE)
  private Long id;
  @Column(name = "tamanho_em_metros")
  private Integer tamanhoEmMetros;
  @OneToOne
  @JoinColumn(name = "hotel_id")
  private Hotel hotel;
  @OneToOne
  @JoinColumn(name = "estoque_id")
  private Estoque estoque;
}
