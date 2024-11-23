package com.hotelaria.hotelaria.domain.service;

import com.hotelaria.hotelaria.domain.entity.Acomodacao;
import com.hotelaria.hotelaria.domain.entity.Hotel;
import com.hotelaria.hotelaria.domain.entity.RegistroImobiliario;
import com.hotelaria.hotelaria.domain.repository.AcomodacaoRepository;
import com.hotelaria.hotelaria.domain.repository.HotelRepository;
import io.swagger.model.HotelRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;

@Service
@RequiredArgsConstructor
public class HotelService {
  private final HotelRepository hotelRepository;
  private final RegistroImobiliarioService registroImobiliarioService;
  private final AcomodacaoService acomodacaoService;
  private final AcomodacaoRepository acomodacaoRepository;

  public List<Hotel> retrieveAll() {
    List<Hotel> hoteisEncontrados = hotelRepository.retrieveAll();
    return hoteisEncontrados;
  }

  @Transactional
  public Hotel create(HotelRequest hotel) {
    RegistroImobiliario registroImobiliario = registroImobiliarioService.create(hotel.getRegistroImobiliario());
    hotelRepository.insert(
      hotel.getNomeFantasia(),
      hotel.getSetor().toString(),
      hotel.getTamanho(),
      hotel.isIsCentral(),
      hotel.getCategoria().toString(),
      registroImobiliario.getId()
    );

    Hotel createdHotel = hotelRepository.retrieveLastCreated();

    hotel.getAcomodacoes().forEach(acomodacao -> {
      Acomodacao createdAcomodacao = acomodacaoService.create(acomodacao, hotelRepository.retrieveLastCreated().getId());
      createdHotel.addAcomodacao(createdAcomodacao);
    });

    return createdHotel;
  }
}
