package com.hotelaria.hotelaria.domain.entity;

import javax.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;

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
  private LocalDateTime dataEsperadaCheckin;
  @Column(name = "data_esperada_checkout")
  private LocalDateTime dataEsperadaCheckout;
  @Column(name = "data_checkin")
  private LocalDateTime dataCheckin;
  @Column(name = "data_checkout")
  private LocalDateTime dataCheckout;
  @OneToMany(mappedBy = "reservaAcomodacao")
  private List<Entrega> entregas;
  @OneToMany(mappedBy = "reservaAcomodacao")
  private List<Pedido> pedidos;
  @OneToMany(mappedBy = "reservaAcomodacao")
  private List<ReservaEstacionamento> reservasEstacionamento;

  public BigDecimal getValorTotal() {
    long days = Duration.between(dataEsperadaCheckin.withHour(12), dataEsperadaCheckout.withHour(12)).toDays();
    return acomodacao.getValorDiaria().multiply(BigDecimal.valueOf(days));
  }
}
