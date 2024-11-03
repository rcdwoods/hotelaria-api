package com.hotelaria.hotelaria.domain.entity;

import jakarta.persistence.*;

import java.time.LocalDateTime;

@Entity
public class Reserva {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;
  @ManyToOne
  @JoinColumn(name = "hospede_id")
  private Hospede hospede;
  @ManyToOne
  @JoinColumn(name = "acomodacao_id")
  private Acomodacao acomodacao;
  @Column(name = "data_esperada_check_in")
  private LocalDateTime dataEsperadaCheckIn;
  @Column(name = "data_esperada_check_out")
  private LocalDateTime dataEsperadaCheckOut;
  @Column(name = "data_check_in")
  private LocalDateTime dataCheckIn;
  @Column(name = "data_check_out")
  private LocalDateTime dataCheckOut;
}
