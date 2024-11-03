package com.hotelaria.hotelaria.domain.entity;

import jakarta.persistence.*;

@Entity
public class PlanoDeSaude {
  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE)
  private Long id;
  private String nome;
  @Enumerated(EnumType.STRING)
  private TipoContratoDeTrabalhoEnum tipoContratoBeneficiario;
  @ManyToOne
  @JoinColumn(name = "documento_fornecedor_id")
  private DocumentoIdentificacao documentoFornecedor;
  @Column(name = "possui_coparticipacao")
  private Boolean possuiCoparticipacao;
}
