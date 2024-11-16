package com.hotelaria.hotelaria.domain.entity;

import jakarta.persistence.*;

import java.util.List;

@Entity
public class SalaCondominio {
  @EmbeddedId
  private SalaCondominioId id;
  @Column(name = "metros_quadrados")
  private Integer metrosQuadrados;
  @OneToMany
  @JoinTable(
    name = "sala_condominio_manutencao",
    joinColumns = {@JoinColumn(name = "numero"), @JoinColumn(name = "condominio_id")},
    inverseJoinColumns = @JoinColumn(name = "manutencao_id")
  )
  private List<Manutencao> manutencoes;
}