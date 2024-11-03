package com.hotelaria.hotelaria.domain.entity;

import jakarta.persistence.*;

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
  private LocalDateTime realizadoEm;
  @ManyToOne
  @JoinColumn(name = "reserva_id")
  private Reserva reserva;
}
