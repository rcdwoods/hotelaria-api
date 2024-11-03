package com.hotelaria.hotelaria.domain.entity;

import jakarta.persistence.*;

@Entity
public class Vale {
  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE)
  private Long id;
  @ManyToOne
  @JoinColumn(name = "documento_fornecedor_id")
  private DocumentoIdentificacao documentoFornecedor;
  @Column(name = "percentual_de_desconto")
  private Integer percentualDeDesconto;
}
