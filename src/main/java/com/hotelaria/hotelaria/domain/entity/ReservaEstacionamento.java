package com.hotelaria.hotelaria.domain.entity;

import jakarta.persistence.*;

import java.time.LocalDateTime;

@Entity
public class ReservaEstacionamento {
  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE)
  private Long id;
  @ManyToOne
  @JoinColumn(name = "estacionamento_id")
  private Estacionamento estacionamento;
  @ManyToOne
  @JoinColumn(name = "hospede_id")
  private Hospede hospede;
  @Column(name = "data_checkin")
  private LocalDateTime dataCheckin;
  @Column(name = "data_checkout")
  private LocalDateTime dataCheckout;
}
