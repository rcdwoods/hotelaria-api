package com.hotelaria.hotelaria.domain.entity;

import javax.persistence.*;

import java.util.List;

@Entity
public class Condominio {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;
  @OneToOne
  @JoinColumn(name = "hotel_id")
  private Hotel hotel;
  @OneToMany(mappedBy = "id.condominio")
  private List<SalaCondominio> salas;
}
