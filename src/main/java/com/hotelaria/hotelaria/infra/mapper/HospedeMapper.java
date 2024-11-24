package com.hotelaria.hotelaria.infra.mapper;

import com.hotelaria.hotelaria.domain.entity.Hospede;
import io.swagger.model.HospedeResponse;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import java.util.List;

@Mapper
public interface HospedeMapper {
  @Mapping(target = "nome", source = "pessoa.nome")
  @Mapping(target = "dataNascimento", source = "pessoa.dataNascimento")
  @Mapping(target = "celular", source = "pessoa.celular")
  @Mapping(target = "email", source = "pessoa.email")
  @Mapping(target = "sexo", source = "pessoa.sexo")
  @Mapping(target = "documentoIdentificacao", source = "pessoa.documentoIdentificacao")
  HospedeResponse toResponse(Hospede hospede);
  List<HospedeResponse> toResponse(List<Hospede> hospedes);
}
