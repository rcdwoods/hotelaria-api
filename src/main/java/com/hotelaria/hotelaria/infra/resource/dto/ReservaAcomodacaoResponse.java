package com.hotelaria.hotelaria.infra.resource.dto;


import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.Period;

@Getter
@Setter
public class ReservaAcomodacaoResponse {
  private Long id;
  private AcomodacaoResponse acomodacao;
  private LocalDateTime dataEsperadaCheckIn;
  private LocalDateTime dataEsperadaCheckOut;
  private LocalDateTime dataCheckIn;
  private LocalDateTime dataCheckOut;
  private BigDecimal valorTotal;

  public BigDecimal getValorTotal() {
    int period = Period.between(dataEsperadaCheckIn.toLocalDate(), dataEsperadaCheckOut.toLocalDate()).getDays();
    return acomodacao.getValorDiaria().multiply(BigDecimal.valueOf(period));
  }
}
