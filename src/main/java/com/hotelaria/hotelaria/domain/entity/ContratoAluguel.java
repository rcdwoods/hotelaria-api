package com.hotelaria.hotelaria.domain.entity;

import jakarta.persistence.*;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
public class ContratoAluguel {
  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE)
  private Long id;
  private Long diaPagamento;
  private LocalDate dataInicio;
  private LocalDate dataFim;
  @ManyToOne
  private Empresa empresa;
}
