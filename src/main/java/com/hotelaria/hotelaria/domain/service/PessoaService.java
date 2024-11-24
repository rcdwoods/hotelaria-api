package com.hotelaria.hotelaria.domain.service;

import com.hotelaria.hotelaria.domain.entity.DocumentoIdentificacao;
import com.hotelaria.hotelaria.domain.entity.Hospede;
import com.hotelaria.hotelaria.domain.entity.Pessoa;
import com.hotelaria.hotelaria.domain.repository.HospedeRepository;
import com.hotelaria.hotelaria.domain.repository.PessoaRepository;
import io.swagger.model.HospedeRequest;
import io.swagger.model.PessoaRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class PessoaService {
  private final PessoaRepository pessoaRepository;
  private final DocumentoIdentificacaoService documentoIdentificacaoService;

  @Transactional
  public Pessoa create(PessoaRequest pessoa) {
    DocumentoIdentificacao documentoIdentificacao = documentoIdentificacaoService.create(pessoa.getDocumentoIdentificacao());
    pessoaRepository.create(
      pessoa.getNome(),
      pessoa.getDataNascimento(),
      pessoa.getCelular(),
      pessoa.getEmail(),
      pessoa.getSexo().toString(),
      documentoIdentificacao.getId()
    );

    return pessoaRepository.retrieveLastCreated();
  }

  @Transactional
  public void update(Long pessoaId, PessoaRequest pessoa) {
    Pessoa currentPessoa = pessoaRepository.retrieveById(pessoaId)
      .orElseThrow(() -> new RuntimeException("Pessoa not found"));

    documentoIdentificacaoService.update(currentPessoa.getDocumentoIdentificacao().getId(), pessoa.getDocumentoIdentificacao());

    pessoaRepository.updatePessoa(
      pessoaId,
      pessoa.getNome(),
      pessoa.getDataNascimento(),
      pessoa.getCelular(),
      pessoa.getEmail(),
      pessoa.getSexo().toString()
    );
  }

  public Pessoa retrieveById(Long pessoaId) {
    return pessoaRepository.retrieveById(pessoaId)
      .orElseThrow(() -> new RuntimeException("Pessoa not found"));
  }

  @Transactional
  public void remove(Long pessoaId) {
    Pessoa pessoa = pessoaRepository.retrieveById(pessoaId)
      .orElseThrow(() -> new RuntimeException("Pessoa not found"));

    pessoaRepository.removePessoa(pessoaId);
    documentoIdentificacaoService.removeById(pessoa.getDocumentoIdentificacao().getId());
  }
}
