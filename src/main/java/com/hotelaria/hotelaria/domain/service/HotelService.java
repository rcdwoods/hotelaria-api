package com.hotelaria.hotelaria.domain.service;

import com.hotelaria.hotelaria.domain.entity.Acomodacao;
import com.hotelaria.hotelaria.domain.entity.Hotel;
import com.hotelaria.hotelaria.domain.entity.RegistroImobiliario;
import com.hotelaria.hotelaria.domain.exception.HotelNotFoundException;
import com.hotelaria.hotelaria.domain.repository.HotelRepository;
import io.swagger.model.HotelRequest;
import io.swagger.model.UpdateHotelRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class HotelService {
  private final HotelRepository hotelRepository;
  private final RegistroImobiliarioService registroImobiliarioService;
  private final AcomodacaoService acomodacaoService;

  public List<Hotel> retrieveAll() {
    return hotelRepository.retrieveAll();
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

  public Hotel update(Long hotelId, UpdateHotelRequest hotel) {
    if (!hotelRepository.existsById(hotelId)) {
      throw new HotelNotFoundException(hotelId);
    }

    hotelRepository.update(
      hotelId,
      hotel.getNomeFantasia(),
      hotel.getSetor().toString(),
      hotel.getTamanho(),
      hotel.isIsCentral(),
      hotel.getCategoria().toString()
    );

    return hotelRepository.retrieveById(hotelId).get();
  }

  public Hotel retrieveById(Long id) {
    return hotelRepository.retrieveById(id).orElseThrow(() -> new HotelNotFoundException(id));
  }

  @Transactional
  public void remove(Long hotelId) {
    Optional<Hotel> hotel = hotelRepository.retrieveById(hotelId);
    if (hotel.isEmpty()) {
      throw new HotelNotFoundException(hotelId);
    }

    Hotel hotelEncontrado = hotel.get();

    acomodacaoService.removeAllByHotelId(hotelId);

    hotelRepository.deleteByNumeroAndHotelId(hotelId);

    registroImobiliarioService.removeById(hotelEncontrado.getRegistroImobiliario().getId());
  }
}
