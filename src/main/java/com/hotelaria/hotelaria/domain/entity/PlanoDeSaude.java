package com.hotelaria.hotelaria.domain.entity;

import jakarta.persistence.*;

import java.math.BigDecimal;

@Entity
public class PlanoDeSaude {
  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE)
  private Long id;
  private String nome;
  @ManyToOne
  @JoinColumn(name = "tipo_contrato_beneficiario_id")
  private TipoContratoDeTrabalho tipoContratoBeneficiario;
  @Column(name = "cnpj_fornecedor")
  private String cnpjFornecedor;
  @Column(name = "valor_mensal")
  private BigDecimal valorMensal;
  @Column(name = "possui_coparticipacao")
  private Boolean possuiCoparticipacao;
}
