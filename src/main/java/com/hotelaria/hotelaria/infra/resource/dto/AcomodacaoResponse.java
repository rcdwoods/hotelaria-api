package com.hotelaria.hotelaria.infra.resource.dto;

import com.hotelaria.hotelaria.domain.entity.PoliticaDeUso;
import com.hotelaria.hotelaria.domain.entity.TipoAcomodacaoEnum;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.List;

@Getter
@Setter
public class AcomodacaoResponse {
  private Integer numero;
  private BigDecimal valorDiaria;
  private TipoAcomodacaoEnum tipo;
  private Integer capacidade;
  private List<PoliticaDeUso> politicasDeUso;
}
