package com.hotelaria.hotelaria.infra.mapper;

import com.hotelaria.hotelaria.domain.entity.Acomodacao;
import com.hotelaria.hotelaria.infra.resource.dto.AcomodacaoResponse;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper
public interface AcomodacaoMapper {
  @Mapping(source = "politicasDeUso", target = "politicasDeUso")
  @Mapping(source = "acomodacaoId.numero", target = "numero")
  AcomodacaoResponse toResponse(Acomodacao acomodacao);
}