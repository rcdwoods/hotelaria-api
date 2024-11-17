package com.hotelaria.hotelaria.infra.mapper;

import com.hotelaria.hotelaria.domain.entity.Acomodacao;
import com.hotelaria.hotelaria.domain.entity.ReservaAcomodacao;
import com.hotelaria.hotelaria.infra.resource.dto.AcomodacaoResponse;
import com.hotelaria.hotelaria.infra.resource.dto.ReservaAcomodacaoResponse;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import java.util.List;

@Mapper(uses = AcomodacaoMapper.class)
public interface ReservaAcomodacaoMapper {
  ReservaAcomodacaoResponse toResponse(ReservaAcomodacao reservaAcomodacao);
  List<ReservaAcomodacaoResponse> toResponse(List<ReservaAcomodacao> reservaAcomodacoes);
}
