package com.hotelaria.hotelaria.infra.resource.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.util.List;

@Getter
@Setter
public class DisponibilidadeResponse {
  private LocalDate data;
  private Integer quantidadeDisponivel;
  private List<AcomodacaoResponse> acomodacoesDisponiveis;
}
