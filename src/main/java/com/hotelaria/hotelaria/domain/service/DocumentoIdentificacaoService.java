package com.hotelaria.hotelaria.domain.service;

import com.hotelaria.hotelaria.domain.entity.DocumentoIdentificacao;
import com.hotelaria.hotelaria.domain.entity.Pessoa;
import com.hotelaria.hotelaria.domain.exception.DocumentoIdentificacaoNotFoundException;
import com.hotelaria.hotelaria.domain.repository.DocumentoIdentificacaoRepository;
import com.hotelaria.hotelaria.domain.repository.PessoaRepository;
import io.swagger.model.DocumentoIdentificacaoRequest;
import io.swagger.model.PessoaRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class DocumentoIdentificacaoService {
  private final DocumentoIdentificacaoRepository documentoIdentificacaoRepository;

  public DocumentoIdentificacao create(DocumentoIdentificacaoRequest documentoIdentificacao) {
    documentoIdentificacaoRepository.create(
      documentoIdentificacao.getTipo().toString(),
      documentoIdentificacao.getNumero()
    );

    return documentoIdentificacaoRepository.retrieveLastCreated();
  }

  public DocumentoIdentificacao update(Long documentoId, DocumentoIdentificacaoRequest documentoIdentificacao) {
    documentoIdentificacaoRepository.update(
      documentoId,
      documentoIdentificacao.getTipo().toString(),
      documentoIdentificacao.getNumero()
    );

    return documentoIdentificacaoRepository.retrieveById(documentoId).get();
  }

  public void removeById(Long documentoId) {
    if (!documentoIdentificacaoRepository.existsById(documentoId)) {
      throw new DocumentoIdentificacaoNotFoundException(documentoId);
    }

    documentoIdentificacaoRepository.removeDocumentoIdentificacaoById(documentoId);
  }

  public DocumentoIdentificacao retrieveById(Long documentoId) {
    return documentoIdentificacaoRepository.retrieveById(documentoId)
      .orElseThrow(() -> new DocumentoIdentificacaoNotFoundException(documentoId));
  }
}
