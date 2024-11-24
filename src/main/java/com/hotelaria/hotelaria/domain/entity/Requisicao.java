package com.hotelaria.hotelaria.domain.entity;

import javax.persistence.*;

@Entity
public class Requisicao {
  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE)
  private Long id;
  private String descricao;
  private String status;
  private String tipo;
  @Column(name = "data_abertura")
  private String dataAbertura;
  @Column(name = "data_fechamento")
  private String dataFechamento;
  @ManyToOne
  private Funcionario funcionario;
}
