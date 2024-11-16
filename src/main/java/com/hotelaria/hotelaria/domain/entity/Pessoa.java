package com.hotelaria.hotelaria.domain.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Entity
@Getter
@Setter
public class Pessoa {
  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE)
  private Long id;
  private String nome;
  @Enumerated(EnumType.STRING)
  private SexoEnum sexo;
  private String email;
  private String celular;
  @Column(name = "data_nascimento")
  private LocalDate dataNascimento;
  @OneToOne
  @JoinColumn(name = "documento_identificacao_id")
  private DocumentoIdentificacao documentoIdentificacao;
}
