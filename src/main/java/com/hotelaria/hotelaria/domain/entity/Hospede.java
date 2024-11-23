package com.hotelaria.hotelaria.domain.entity;

import javax.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Getter
@Setter
public class Hospede {
  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE)
  private Long id;
  @OneToOne
  @JoinColumn(name = "pessoa_id")
  private Pessoa pessoa;
  @Column(name = "data_registro")
  private LocalDateTime dataRegistro;
}
