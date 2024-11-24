package com.hotelaria.hotelaria.domain.service;

import com.hotelaria.hotelaria.domain.entity.Acomodacao;
import com.hotelaria.hotelaria.domain.entity.Hospede;
import com.hotelaria.hotelaria.domain.entity.ReservaAcomodacao;
import com.hotelaria.hotelaria.domain.exception.HospedeNotFoundException;
import com.hotelaria.hotelaria.domain.repository.*;
import io.swagger.model.SolicitacaoReservaRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;


@Service
@RequiredArgsConstructor
public class ReservaAcomodacaoService {
  private final AcomodacaoService acomodacaoService;
  private final PedidoRepository pedidoRepository;
  private final HospedeRepository hospedeRepository;
  private final EntregaRepository entregaRepository;
  private final ReservaAcomodacaoRepository reservaAcomodacaoRepository;
  private final ReservaEstacionamentoRepository reservaEstacionamentoRepository;
  private final AcomodacaoManutencaoRepository acomodacaoManutencaoRepository;

  public List<ReservaAcomodacao> retrieveReservasFromHospede(Long hospedeId) {
    return reservaAcomodacaoRepository.retrieveByHospedeId(hospedeId);
  }

  public ReservaAcomodacao makeReservation(SolicitacaoReservaRequest solicitacaoReserva) {
    Acomodacao acomodacao = acomodacaoService.retrieveByNumeroAndHotelId(solicitacaoReserva.getNumeroAcomodacao(), solicitacaoReserva.getHotelId());

    Optional<Hospede> hospede = hospedeRepository.retrieveById(solicitacaoReserva.getHospedeId());
    if (hospede.isEmpty()) {
      throw new HospedeNotFoundException(solicitacaoReserva.getHospedeId());
    }

    ReservaAcomodacao reserva = new ReservaAcomodacao();
    reserva.setAcomodacao(acomodacao);
    reserva.setHospede(hospede.get());
    reserva.setDataEsperadaCheckin(LocalDateTime.parse(solicitacaoReserva.getDataCheckin()));
    reserva.setDataEsperadaCheckout(LocalDateTime.parse(solicitacaoReserva.getDataCheckout()));

    return insert(reserva);
  }

  public void removeAllFromHospede(Long hospedeId) {
    reservaAcomodacaoRepository.removeAllFromHospede(hospedeId);
  }

  @Transactional
  public void removeAllFromHotel(Long hotelId) {
    acomodacaoManutencaoRepository.removeAllFromHotel(hotelId);
    reservaEstacionamentoRepository.removeAllFromHotel(hotelId);
    pedidoRepository.removeAllFromHotel(hotelId);
    entregaRepository.removeAllFromHotel(hotelId);
    reservaAcomodacaoRepository.removeAllFromHotel(hotelId);
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
