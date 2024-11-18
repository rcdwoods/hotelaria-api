package com.hotelaria.hotelaria.domain.entity;

import jakarta.persistence.*;

import java.util.List;

@Entity
public class EspacoDeEvento {
  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE)
  private Long id;
  @OneToOne
  @JoinColumn(name = "hotel_id")
  private Hotel hotel;
  @ManyToMany
  @JoinTable(
    name = "espaco_de_evento_tipo_de_uso",
    joinColumns = @JoinColumn(name = "espaco_de_evento_id"),
    inverseJoinColumns = @JoinColumn(name = "tipo_de_uso_id")
  )
  private List<TipoDeUso> tiposDeUso;
  @Column(name = "tamanho_em_metros_total")
  private Integer tamanhoEmMetrosTotal;
  @OneToMany(mappedBy = "espacoDeEvento")
  private List<LocalEvento> localEventos;
}
