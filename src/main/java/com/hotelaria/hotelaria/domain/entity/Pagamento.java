package com.hotelaria.hotelaria.domain.entity;

import javax.persistence.*;

import java.math.BigDecimal;

@Entity
public class Pagamento {
  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE)
  private Long id;
  private String titulo;
  private String descricao;
  @OneToOne
  @JoinColumn(name = "nota_fiscal_id")
  private NotaFiscal notaFiscal;
}
