package com.hotelaria.hotelaria.domain.entity;

import jakarta.persistence.*;

import java.time.LocalDate;
import java.time.LocalDateTime;

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
  @ManyToOne
  @JoinColumn(name = "condominio_id")
  private Condominio condominio;
}
