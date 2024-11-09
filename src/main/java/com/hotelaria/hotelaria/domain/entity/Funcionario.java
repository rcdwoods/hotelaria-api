package com.hotelaria.hotelaria.domain.entity;

import jakarta.persistence.*;

import java.time.LocalDate;
import java.util.List;

@Entity
public class Funcionario {
  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE)
  private Long id;
  @OneToOne
  @JoinColumn(name = "pessoa_id")
  private Pessoa pessoa;
  private String email;
  @OneToOne
  @JoinColumn(name = "hotel_id")
  private Hotel hotel;
}
