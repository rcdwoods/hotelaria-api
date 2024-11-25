package com.hotelaria.hotelaria.domain.entity;

import javax.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.List;

@Entity
@Getter
@Setter
public class Hospede {
  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE)
  private Long id;
  @OneToOne
  @JoinColumn(name = "pessoa_id")
  private Pessoa pessoa;
  @Column(name = "data_registro")
  private LocalDateTime dataRegistro;
  @OneToMany
  @JoinTable(
    name = "hospede_requisicao",
    joinColumns = @JoinColumn(name = "hospede_id"),
    inverseJoinColumns = @JoinColumn(name = "requisicao_id")
  )
  private List<Requisicao> requisicoes;
  @ManyToMany
  @JoinTable(
    name = "inscricao_atividade_lazer",
    joinColumns = @JoinColumn(name = "hospede_id"),
    inverseJoinColumns = @JoinColumn(name = "atividade_lazer_id")
  )
  private List<AtividadeLazer> atividadesLazer;
}
