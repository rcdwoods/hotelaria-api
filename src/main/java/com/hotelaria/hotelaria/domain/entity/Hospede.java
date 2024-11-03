package com.hotelaria.hotelaria.domain.entity;

import jakarta.persistence.*;

import java.time.LocalDateTime;

@Entity
public class Hospede {
  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE)
  private Long id;
  @OneToOne
  @JoinColumn(name = "pessoa_id")
  private Pessoa pessoa;
  @Column(name = "registrado_em")
  private LocalDateTime registradoEm;
}
