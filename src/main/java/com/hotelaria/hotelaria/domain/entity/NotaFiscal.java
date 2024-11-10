package com.hotelaria.hotelaria.domain.entity;

import jakarta.persistence.*;

import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
public class NotaFiscal {
  @Id
  @GeneratedValue
  private Long id;
  private Long numero;
  @Column(name = "data_emissao")
  private LocalDate dataEmissao;
  @Column(name = "valor")
  private BigDecimal valor;
  @ManyToOne
  @JoinColumn(name = "documento_destinatario_id")
  private DocumentoIdentificacao documentoDestinarario;
  @ManyToOne
  @JoinColumn(name = "documento_emissor_id")
  private DocumentoIdentificacao documentoEmissor;
}
