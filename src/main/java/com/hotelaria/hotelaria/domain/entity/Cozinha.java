package com.hotelaria.hotelaria.domain.entity;

import jakarta.persistence.*;

@Entity
public class Cozinha {
  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE)
  private Long id;
  @OneToOne
  @JoinColumn(name = "hotel_id")
  private Hotel hotel;
  @OneToOne
  @JoinColumn(name = "estoque_id")
  private Estoque estoque;
}
