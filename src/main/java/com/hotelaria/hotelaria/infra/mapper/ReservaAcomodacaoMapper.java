package com.hotelaria.hotelaria.infra.mapper;

import com.hotelaria.hotelaria.domain.entity.ReservaAcomodacao;
import io.swagger.model.PoliticaDeUsoResponse;
import io.swagger.model.ReservaAcomodacaoResponse;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import java.util.List;

@Mapper(uses = {AcomodacaoMapper.class})
public interface ReservaAcomodacaoMapper {
  ReservaAcomodacaoResponse toResponse(ReservaAcomodacao reservaAcomodacao);
  List<ReservaAcomodacaoResponse> toResponse(List<ReservaAcomodacao> reservaAcomodacoes);
}
