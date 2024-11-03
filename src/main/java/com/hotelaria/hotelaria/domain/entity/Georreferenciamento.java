package com.hotelaria.hotelaria.domain.entity;

import jakarta.persistence.*;

@Entity
public class Georreferenciamento {
  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE)
  private Long id;
  @Column(name = "coordenadas_x")
  private Long coordenadasX;
  @Column(name = "coordenadas_y")
  private Long coordenadasY;
  @Column(name = "coordenadas_z")
  private Long coordenadasZ;
}
