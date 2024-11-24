package com.hotelaria.hotelaria.domain.exception;

public class DocumentoIdentificacaoNotFoundException extends EntityNotFoundException {
  public DocumentoIdentificacaoNotFoundException(Long id) {
    super(String.format("Documento com id %d não encontrado", id));
  }
}
