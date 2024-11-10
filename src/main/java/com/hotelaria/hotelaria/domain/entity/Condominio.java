package com.hotelaria.hotelaria.domain.entity;

import jakarta.persistence.*;

import java.util.List;

@Entity
public class Condominio {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;
  @OneToOne
  @JoinColumn(name = "hotel_id")
  private Hotel hotel;
  @ManyToMany
  @JoinTable(
    name = "condominio_contrato_de_aluguel",
    joinColumns = @JoinColumn(name = "condominio_id"),
    inverseJoinColumns = @JoinColumn(name = "contrato_de_aluguel_id")
  )
  private List<ContratoAluguel> contratosDeAluguel;
}
