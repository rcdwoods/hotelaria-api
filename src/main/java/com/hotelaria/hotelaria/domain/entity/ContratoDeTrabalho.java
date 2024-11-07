package com.hotelaria.hotelaria.domain.entity;

import jakarta.persistence.*;

import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
public class ContratoDeTrabalho {
  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE)
  private Long id;
  private String cargo;
  @ManyToOne
  private TipoContratoDeTrabalho tipo;
  @Column(name = "data_inicio")
  private LocalDate dataInicio;
  @Column(name = "horas_mes")
  private Integer horasPorMes;
  @Column(name = "salario_mes")
  private BigDecimal salarioMes;
  @Column(name = "finalizado")
  private Boolean finalizado;
  @ManyToOne
  @JoinColumn(name = "funcionario_id")
  private Funcionario funcionario;
}
