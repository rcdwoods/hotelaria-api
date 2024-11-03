package com.hotelaria.hotelaria.domain.entity;

import jakarta.persistence.*;

@Entity
public class Evento {
  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE)
  private Long id;
  @Enumerated(EnumType.STRING)
  private TipoEspacoDeEvento tipo;
  @ManyToOne
  @JoinColumn(name = "tipo_de_uso_id")
  private TipoDeUso tipoDeUso;
  private Integer capacidade;
  @ManyToOne
  @JoinColumn(name = "espaco_de_evento_id")
  private EspacoDeEvento espacoDeEvento;
}
