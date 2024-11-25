package com.hotelaria.hotelaria.domain.entity;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
public class Transporte {
  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE)
  private Long id;
  private String tipo;
  private BigDecimal valor;
  private String descricao;
  @Column(name = "horario_partida")
  private LocalDateTime horarioPartida;
  @Column(name = "horario_esperado_chegada")
  private LocalDateTime horarioEsperadoChegada;
  @Column(name = "horario_chegada")
  private LocalDateTime horarioChegada;
  @ManyToOne
  @JoinColumn(name = "hotel_partida_id")
  private Hotel hotelPartida;
  @ManyToOne
  @JoinColumn(name = "reserva_acomodacao_id")
  private ReservaAcomodacao reservaAcomodacao;
  @ManyToOne
  @JoinColumn(name = "veiculo_id")
  private Veiculo veiculo;
}
