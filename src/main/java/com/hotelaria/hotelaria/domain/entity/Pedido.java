package com.hotelaria.hotelaria.domain.entity;

import javax.persistence.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
public class Pedido {
  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE)
  private Long id;
  private String descricao;
  private BigDecimal valor;
  @Column(name = "data_hora")
  private LocalDateTime dataHora;
  @ManyToOne
  @JoinColumn(name = "reserva_acomodacao_id")
  private ReservaAcomodacao reservaAcomodacao;
}
