package com.hotelaria.hotelaria.domain.service;

import com.hotelaria.hotelaria.domain.entity.Hospede;
import com.hotelaria.hotelaria.domain.entity.Pessoa;
import com.hotelaria.hotelaria.domain.entity.ReservaAcomodacao;
import com.hotelaria.hotelaria.domain.exception.HospedeNotFoundException;
import com.hotelaria.hotelaria.domain.repository.HospedeRepository;
import io.swagger.model.HospedeRequest;
import io.swagger.model.PessoaRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class HospedeService {
  private final HospedeRepository hospedeRepository;
  private final PessoaService pessoaService;
  private final ReservaAcomodacaoService reservaAcomodacaoService;

  public List<Hospede> retrieveAll() {
    return hospedeRepository.findAll();
  }

  public Hospede retrieveById(Long hospedeId) {
    Hospede hospede = hospedeRepository.retrieveById(hospedeId).orElseThrow(() -> new HospedeNotFoundException(hospedeId));
    Pessoa pessoa = pessoaService.retrieveById(hospede.getPessoa().getId());
    hospede.setPessoa(pessoa);

    return hospede;
  }

  @Transactional
  public Hospede create(HospedeRequest hospede) {
    Pessoa createPessoa = pessoaService.create(buildPessoaFromHospede(hospede));
    hospedeRepository.create(createPessoa.getId(), hospede.getDataRegistro());

    return hospedeRepository.retrieveLastCreated();
  }

  @Transactional
  public void update(Long hospedeId, HospedeRequest hospede) {
    Hospede hospedeFound = hospedeRepository.retrieveById(hospedeId)
      .orElseThrow(() -> new HospedeNotFoundException(hospedeId));

    hospedeRepository.updateHospede(hospedeId, hospede.getDataRegistro());
    pessoaService.update(hospedeFound.getPessoa().getId(), buildPessoaFromHospede(hospede));
  }

  @Transactional
  public void remove(Long hospedeId) {
    Hospede hospede = hospedeRepository.retrieveById(hospedeId)
      .orElseThrow(() -> new HospedeNotFoundException(hospedeId));

    reservaAcomodacaoService.removeAllFromHospede(hospedeId);
    hospedeRepository.removeHospedeById(hospedeId);
    pessoaService.remove(hospede.getPessoa().getId());
  }

  public PessoaRequest buildPessoaFromHospede(HospedeRequest hospede) {
    PessoaRequest pessoa = new PessoaRequest();
    pessoa.setNome(hospede.getNome());
    pessoa.setDataNascimento(hospede.getDataNascimento());
    pessoa.setCelular(hospede.getCelular());
    pessoa.setEmail(hospede.getEmail());
    pessoa.setSexo(PessoaRequest.SexoEnum.valueOf(hospede.getSexo().toString()));
    pessoa.setDocumentoIdentificacao(hospede.getDocumentoIdentificacao());
    return pessoa;
  }
}
