package com.hotelaria.hotelaria.domain.entity;

import javax.persistence.*;

@Entity
public class Veiculo {
  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE)
  private Long id;
  private String modelo;
  private String marca;
  @Column(name = "ano_fabricacao")
  private Integer anoFabricacao;
  private Long capacidade;
  private String tipo;
  private String placa;
  @ManyToOne
  @JoinColumn(name = "hotel_id")
  private Hotel hotel;
}
