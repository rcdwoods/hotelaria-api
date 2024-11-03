package com.hotelaria.hotelaria.domain.entity;

import jakarta.persistence.*;

import java.math.BigDecimal;

@Entity
public class ContratoDeTrabalho {
  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE)
  private Long id;
  @Enumerated(EnumType.STRING)
  private TipoContratoDeTrabalhoEnum tipo;
  @Column(name = "horas_por_mes")
  private Integer horasPorMes;
  @Column(name = "salario_mes")
  private BigDecimal salarioMes;
}
