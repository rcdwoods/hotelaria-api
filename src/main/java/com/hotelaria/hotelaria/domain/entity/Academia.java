package com.hotelaria.hotelaria.domain.entity;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
public class Academia {
  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE)
  private Long id;
  private String nome;
  private String descricao;
  @ManyToOne
  @JoinColumn(name = "hotel_id")
  private Hotel hotel;
  private Long capacidade;
  @Column(name = "horario_abertura_dia_semana")
  private LocalDateTime horarioAberturaDiaSemana;
  @Column(name = "horario_fechamento_dia_semana")
  private LocalDateTime horarioFechamentoDiaSemana;
  @Column(name = "horario_abertura_fim_semana")
  private LocalDateTime horarioAberturaFimSemana;
  @Column(name = "horario_fechamento_fim_semana")
  private LocalDateTime horarioFechamentoFimSemana;
}
