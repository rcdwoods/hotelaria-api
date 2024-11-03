package com.hotelaria.hotelaria.domain.entity;

import jakarta.persistence.*;

import java.util.List;

@Entity
public class EspacoDeEvento {
  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE)
  private Long id;
  @ManyToMany
  private List<TipoDeUso> tiposDeUso;
  @OneToMany(mappedBy = "espacoDeEvento")
  private List<Evento> eventos;
}
