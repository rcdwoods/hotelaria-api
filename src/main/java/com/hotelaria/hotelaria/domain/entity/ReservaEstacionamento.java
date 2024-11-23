package com.hotelaria.hotelaria.domain.entity;

import javax.persistence.*;

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
  @JoinColumn(name = "reserva_acomodacao_id")
  private ReservaAcomodacao reservaAcomodacao;
  @Column(name = "data_checkin")
  private LocalDateTime dataCheckin;
  @Column(name = "data_checkout")
  private LocalDateTime dataCheckout;
}
