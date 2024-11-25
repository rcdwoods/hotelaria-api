package com.hotelaria.hotelaria.domain.entity;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Entity
public class Livro {
  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE)
  private Long id;
  private String titulo;
  private String autor;
  private String editora;
  @Column(name = "ano_publicacao")
  private Integer anoPublicacao;
  @Column(name = "quantidade_paginas")
  private Long quantidadePaginas;
  @ManyToOne
  @JoinColumn(name = "biblioteca_id")
  private Biblioteca biblioteca;
}
