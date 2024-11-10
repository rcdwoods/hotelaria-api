package com.hotelaria.hotelaria.domain.entity;

import jakarta.persistence.*;

@Entity
public class Georreferenciamento {
  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE)
  private Long id;
  private String latitude;
  private String longitude;
}
