package com.hotelaria.hotelaria.infra.mapper;

import com.hotelaria.hotelaria.domain.entity.Acomodacao;
import com.hotelaria.hotelaria.domain.entity.PoliticaDeUso;
import io.swagger.model.AcomodacaoResponse;
import io.swagger.model.PoliticaDeUsoResponse;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import java.util.List;

@Mapper
public interface AcomodacaoMapper {
  @Mapping(source = "politicasDeUso", target = "politicasDeUso")
  @Mapping(source = "acomodacaoId.numero", target = "numero")
  AcomodacaoResponse toResponse(Acomodacao acomodacao);
  List<AcomodacaoResponse> toResponse(List<Acomodacao> acomodacoes);

  default List<Long> map(List<PoliticaDeUso> politicasDeUso) {
    return politicasDeUso.stream().map(PoliticaDeUso::getId).toList();
  }
}
