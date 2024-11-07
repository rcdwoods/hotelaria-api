package com.hotelaria.hotelaria.domain.entity;

import jakarta.persistence.*;

import java.math.BigDecimal;

@Entity
public class Vale {
  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE)
  private Long id;
  @Enumerated(EnumType.STRING)
  private TipoValeEnum tipo;
  private String descricao;
  private BigDecimal valor;
  @Column(name = "percentual_de_desconto")
  private Integer percentualDeDesconto;
  @Column(name = "cnpj_fornecedor")
  private String cnpjForncedor;
  @ManyToOne
  @JoinColumn(name = "tipo_contrato_beneficiario_id")
  private TipoContratoDeTrabalho tipoContratoBeneficiario;
}
