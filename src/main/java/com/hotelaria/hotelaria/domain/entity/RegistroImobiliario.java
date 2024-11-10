package com.hotelaria.hotelaria.domain.entity;

import jakarta.persistence.*;

import java.time.LocalDate;

@Entity
public class RegistroImobiliario {
  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE)
  private Long id;
  @Column(name = "data_registro")
  private LocalDate dataRegistro;
  @Column(name = "numero_registro_prefeitura")
  private String numeroRegistroPrefeitura;
  @OneToOne
  @JoinColumn(name = "georreferenciamento_id")
  private Georreferenciamento georreferenciamento;
}
