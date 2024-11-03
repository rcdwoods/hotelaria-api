package com.hotelaria.hotelaria.domain.entity;

import jakarta.persistence.*;

import java.util.List;

@Entity
public class Condominio {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long numero;
  @OneToOne
  @JoinColumn(name = "hotel_id")
  private Hotel hotel;
  @ManyToMany
  @JoinTable(
    name = "condominio_empresa",
    joinColumns = @JoinColumn(name = "condominio_numero"),
    inverseJoinColumns = @JoinColumn(name = "empresa_id")
  )
  private List<Empresa> empresas;
}
