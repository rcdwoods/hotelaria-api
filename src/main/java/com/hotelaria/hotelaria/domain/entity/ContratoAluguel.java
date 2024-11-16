package com.hotelaria.hotelaria.domain.entity;

import jakarta.persistence.*;

import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
public class ContratoAluguel {
  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE)
  private Long id;
  @Column(name = "dia_pagamento")
  private Long diaPagamento;
  @Column(name = "data_inicio")
  private LocalDate dataInicio;
  @Column(name = "data_fim")
  private LocalDate dataFim;
  @ManyToOne
  @JoinColumn(name = "empresa_id")
  private Empresa empresa;
  @Column(name = "numero_sala_condominio")
  private Long numeroSalaCondominio;
  private BigDecimal valor;
  @ManyToOne
  @JoinColumn(name = "condominio_id")
  private Condominio condominio;
}
