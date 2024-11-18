package com.hotelaria.hotelaria.domain.entity;

import jakarta.persistence.*;

import java.time.LocalDateTime;

@Entity
public class Entrega {
  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE)
  private Long id;
  private String descricao;
  @ManyToOne
  @JoinColumn(name = "reserva_id")
  private ReservaAcomodacao reservaAcomodacao;
  @ManyToOne
  @JoinColumn(name = "empresa_remetente_id")
  private Empresa empresaRemetente;
  @Column(name = "data_hora")
  private LocalDateTime dataHora;
}
