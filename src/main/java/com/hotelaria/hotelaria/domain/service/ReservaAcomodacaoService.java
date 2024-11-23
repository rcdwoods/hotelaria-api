package com.hotelaria.hotelaria.domain.service;

import com.hotelaria.hotelaria.domain.entity.Acomodacao;
import com.hotelaria.hotelaria.domain.entity.Hospede;
import com.hotelaria.hotelaria.domain.entity.ReservaAcomodacao;
import com.hotelaria.hotelaria.domain.exception.AcomodacaoNotFoundException;
import com.hotelaria.hotelaria.domain.exception.HospedeNotFoundException;
import com.hotelaria.hotelaria.domain.repository.ReservaAcomodacaoRepository;
import io.swagger.model.SolicitacaoReservaRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;


@Service
@RequiredArgsConstructor
public class ReservaAcomodacaoService {
  private final AcomodacaoService acomodacaoService;
  private final HospedeService hospedeService;
  private final ReservaAcomodacaoRepository reservaAcomodacaoRepository;

  public List<ReservaAcomodacao> retrieveReservasFromHospede(Long hospedeId) {
    return reservaAcomodacaoRepository.retrieveByHospedeId(hospedeId);
  }

  public ReservaAcomodacao makeReservation(SolicitacaoReservaRequest solicitacaoReserva) {
    Optional<Acomodacao> acomodacao = acomodacaoService.retrieveByHotelAndNumber(solicitacaoReserva.getHotelId(), solicitacaoReserva.getNumeroAcomodacao());
    if (acomodacao.isEmpty()) {
      throw new AcomodacaoNotFoundException(solicitacaoReserva.getNumeroAcomodacao());
    }

    Optional<Hospede> hospede = hospedeService.retrieveById(solicitacaoReserva.getHospedeId());
    if (hospede.isEmpty()) {
      throw new HospedeNotFoundException(solicitacaoReserva.getHospedeId());
    }

    ReservaAcomodacao reserva = new ReservaAcomodacao();
    reserva.setAcomodacao(acomodacao.get());
    reserva.setHospede(hospede.get());
    reserva.setDataEsperadaCheckin(LocalDateTime.parse(solicitacaoReserva.getDataCheckin()));
    reserva.setDataEsperadaCheckout(LocalDateTime.parse(solicitacaoReserva.getDataCheckout()));

    return insert(reserva);
  }

  private ReservaAcomodacao insert(ReservaAcomodacao reserva) {
    Long numeroAcomodacao = reserva.getAcomodacao().getAcomodacaoId().getNumero();
    Long hotelId = reserva.getAcomodacao().getAcomodacaoId().getHotel().getId();
    Long hospedeId = reserva.getHospede().getId();
    LocalDateTime dataCheckin = reserva.getDataEsperadaCheckin();
    LocalDateTime dataCheckout = reserva.getDataEsperadaCheckout();
    reservaAcomodacaoRepository.insert(numeroAcomodacao, hotelId, hospedeId, dataCheckin, dataCheckout);
    reserva.setId(reservaAcomodacaoRepository.getLastInsertId());

    return reserva;
  }
}
