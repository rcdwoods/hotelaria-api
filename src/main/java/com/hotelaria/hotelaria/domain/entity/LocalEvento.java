package com.hotelaria.hotelaria.domain.entity;

import jakarta.persistence.*;

import java.util.List;

@Entity
public class LocalEvento {
  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE)
  private Long id;
  @Enumerated(EnumType.STRING)
  @Column(name = "tipo_de_espaco")
  private TipoEspacoDeEventoEnum tipoDeEspaco;
  @ManyToOne
  @JoinColumn(name = "tipo_de_uso_id")
  private TipoDeUso tipoDeUso;
  private Integer capacidade;
  @ManyToOne
  @JoinColumn(name = "espaco_de_evento_id")
  private EspacoDeEvento espacoDeEvento;
  @Column(name = "tamanho_em_metros")
  private Integer tamanhoEmMetros;
  @ManyToMany
  @JoinTable(
    name = "local_evento_manutencao",
    joinColumns = @JoinColumn(name = "local_evento_id"),
    inverseJoinColumns = @JoinColumn(name = "manutencao_id")
  )
  private List<Manutencao> manutencoes;
}
