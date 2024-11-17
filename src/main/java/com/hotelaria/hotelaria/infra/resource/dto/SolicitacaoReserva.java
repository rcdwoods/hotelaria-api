package com.hotelaria.hotelaria.infra.resource.dto;

import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class SolicitacaoReserva {
  @NotNull
  private Long hospedeId;
  @NotNull
  private Long numeroAcomodacao;
  @NotNull
  private Long hotelId;
  @NotNull
  private LocalDateTime dataCheckin;
  @NotNull
  private LocalDateTime dataCheckout;
}
