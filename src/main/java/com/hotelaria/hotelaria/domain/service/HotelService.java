package com.hotelaria.hotelaria.domain.service;

import com.hotelaria.hotelaria.domain.entity.Hotel;
import com.hotelaria.hotelaria.domain.entity.RegistroImobiliario;
import com.hotelaria.hotelaria.domain.exception.HotelNotFoundException;
import com.hotelaria.hotelaria.domain.repository.*;
import io.swagger.model.HotelRequest;
import io.swagger.model.UpdateHotelRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class HotelService {
  private final HotelRepository hotelRepository;
  private final RegistroImobiliarioService registroImobiliarioService;
  private final AcomodacaoService acomodacaoService;
  private final ReservaAcomodacaoService reservaAcomodacaoService;
  private final CondominioRepository condominioRepository;
  private final EstoqueRepository estoqueRepository;
  private final CozinhaRepository cozinhaRepository;
  private final BibliotecaRepository bibliotecaRepository;
  private final LivroRepository livroRepository;
  private final VeiculoRepository veiculoRepository;
  private final TransporteRepository transporteRepository;
  private final AcademiaRepository academiaRepository;
  private final AtividadeLazerRepository atividadeLazerRepository;
  private final EspacoDeEventoRepository espacoDeEventoRepository;
  private final EstacionamentoRepository estacionamentoRepository;
  private final FuncionarioRepository funcionarioRepository;

  public List<Hotel> retrieveAll() {
    return hotelRepository.retrieveAll().stream().map(hotel -> {
      hotel.setAcomodacoes(acomodacaoService.retrieveAllByHotel(hotel.getId()));
      return hotel;
    }).collect(Collectors.toList());
  }

  public Hotel retrieveById(Long id) {
    Hotel hotel = hotelRepository.retrieveById(id).orElseThrow(() -> new HotelNotFoundException(id));
    hotel.setAcomodacoes(acomodacaoService.retrieveAllByHotel(id));
    return hotel;
  }

  @Transactional
  public void create(HotelRequest hotel) {
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

    hotel.getAcomodacoes().forEach(acomodacao -> acomodacaoService.create(acomodacao, createdHotel.getId()));
  }

  public Hotel retrieveLastCreated() {
    Hotel hotel = hotelRepository.retrieveLastCreated();
    hotel.setAcomodacoes(acomodacaoService.retrieveAllByHotel(hotel.getId()));
    return hotel;
  }

  @Transactional
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

  @Transactional
  public void remove(Long hotelId) {
    Optional<Hotel> hotel = hotelRepository.retrieveById(hotelId);
    if (hotel.isEmpty()) {
      throw new HotelNotFoundException(hotelId);
    }

    Hotel hotelEncontrado = hotel.get();

    funcionarioRepository.removeAllRequisicoesWithHospedesFromFuncionariosFromHotel(hotelId);
    funcionarioRepository.removeAllRequisicoesFromFuncionariosFromHotel(hotelId);
    funcionarioRepository.removeAllContratosDeTrabalhoFromHotel(hotelId);
    funcionarioRepository.removeAllFromHotel(hotelId);
    estacionamentoRepository.removeReservaEstacionamentosFromHotel(hotelId);
    estacionamentoRepository.removeFromHotel(hotelId);
    espacoDeEventoRepository.removeManutencoesFromHotel(hotelId);
    espacoDeEventoRepository.removeLocaisDeEventoFromHotel(hotelId);
    espacoDeEventoRepository.removeFromHotel(hotelId);
    atividadeLazerRepository.removeInscricoesFromHotel(hotelId);
    atividadeLazerRepository.removeAllFromHotel(hotelId);
    academiaRepository.removePoliticasDeUsoFromHotel(hotelId);
    academiaRepository.removeFromHotel(hotelId);
    transporteRepository.removeAllFromHotel(hotelId);
    veiculoRepository.removeAllFromHotel(hotelId);
    livroRepository.removeAllLocacoesFromHotel(hotelId);
    bibliotecaRepository.removeAllPoliticasDeUsoFromHotel(hotelId);
    bibliotecaRepository.removeAllLivrosFromHotel(hotelId);
    bibliotecaRepository.removeFromHotel(hotelId);
    cozinhaRepository.removeFromHotel(hotelId);
    estoqueRepository.removeProductsFromHotelEstoque(hotelId);
    estoqueRepository.removeFromHotel(hotelId);
    condominioRepository.removeSalasCondominioManutencaoFromHotel(hotelId);
    condominioRepository.removeContratosAluguelFromHotel(hotelId);
    condominioRepository.removeAllSalasFromHotel(hotelId);
    condominioRepository.removeAllFromHotel(hotelId);
    reservaAcomodacaoService.removeAllFromHotel(hotelId);
    acomodacaoService.removeAllFromHotel(hotelId);
    hotelRepository.deleteByNumeroAndHotelId(hotelId);
    registroImobiliarioService.removeById(hotelEncontrado.getRegistroImobiliario().getId());
  }
}
