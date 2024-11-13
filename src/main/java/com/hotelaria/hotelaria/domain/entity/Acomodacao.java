package com.hotelaria.hotelaria.domain.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.List;

@Entity
@Getter
@Setter
public class Acomodacao {
  @EmbeddedId
  private AcomodacaoId acomodacaoId;
  @Column(name = "valor_diaria")
  private BigDecimal valorDiaria;
  @Enumerated(EnumType.STRING)
  private TipoAcomodacaoEnum tipo;
  private Integer capacidade;
  @ManyToMany
  @JoinTable(
    name = "acomodacao_politica_de_uso",
    joinColumns = {@JoinColumn(name = "acomodacao_numero"), @JoinColumn(name = "hotel_id")},
    inverseJoinColumns = @JoinColumn(name = "politica_de_uso_id")
  )
  List<PoliticaDeUso> politicasDeUso;
  @OneToMany
  @JoinTable(
    name = "acomodacao_manutencao",
    joinColumns = {@JoinColumn(name = "acomodacao_numero"), @JoinColumn(name = "hotel_id")},
    inverseJoinColumns = @JoinColumn(name = "manutencao_id")
  )
  private List<Manutencao> manutencoes;
  @OneToMany
  @JoinTable(
    name = "acomodacao_entrega",
    joinColumns = {@JoinColumn(name = "acomodacao_numero"), @JoinColumn(name = "hotel_id")},
    inverseJoinColumns = @JoinColumn(name = "entrega_id")
  )
  private List<Entrega> entregas;
}
