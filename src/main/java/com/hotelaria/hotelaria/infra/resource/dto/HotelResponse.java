package com.hotelaria.hotelaria.infra.resource.dto;

import com.hotelaria.hotelaria.domain.entity.Acomodacao;
import com.hotelaria.hotelaria.domain.entity.CategoriaEnum;
import com.hotelaria.hotelaria.domain.entity.RegistroImobiliario;
import com.hotelaria.hotelaria.domain.entity.SetorEnum;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class HotelResponse {
  private Long id;
  private String nomeFantasia;
  private SetorEnum setor;
  private Long tamanho;
  private CategoriaEnum categoria;
  private RegistroImobiliario registroImobiliario;
  private List<AcomodacaoResponse> acomodacoes;
}
