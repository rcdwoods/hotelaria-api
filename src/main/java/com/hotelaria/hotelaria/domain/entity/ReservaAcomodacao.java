package com.hotelaria.hotelaria.domain.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Getter
@Setter
public class ReservaAcomodacao {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;
  @ManyToOne
  @JoinColumn(name = "hospede_id")
  private Hospede hospede;
  @ManyToOne
  @JoinColumns({
    @JoinColumn(name = "numero_acomodacao", referencedColumnName = "numero"),
    @JoinColumn(name = "hotel_id", referencedColumnName = "hotel_id")
  })
  private Acomodacao acomodacao;
  @Column(name = "data_esperada_checkin")
  private LocalDateTime dataEsperadaCheckIn;
  @Column(name = "data_esperada_checkout")
  private LocalDateTime dataEsperadaCheckOut;
  @Column(name = "data_checkin")
  private LocalDateTime dataCheckIn;
  @Column(name = "data_checkout")
  private LocalDateTime dataCheckOut;
}
