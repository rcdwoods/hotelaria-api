package com.hotelaria.hotelaria.domain.entity;

import javax.persistence.*;
import java.time.LocalDateTime;

// CREATE TABLE locacao_livro
//(
//    livro_id                BIGINT NOT NULL,
//    reserva_acomodacao_id   BIGINT NOT NULL,
//    data_locacao            DATE   NOT NULL,
//    data_esperada_devolucao DATE   NOT NULL,
//    data_devolucao          DATE NULL,
//    PRIMARY KEY (livro_id, reserva_acomodacao_id),
//    FOREIGN KEY (livro_id) REFERENCES livro (id),
//    FOREIGN KEY (reserva_acomodacao_id) REFERENCES reserva_acomodacao (id)
//);

@Entity
public class LocacaoLivro {
  @Id
  private LocacaoLivroId id;
  @Column(name = "data_locacao")
  private LocalDateTime dataLocacao;
  @Column(name = "data_esperada_devolucao")
  private LocalDateTime dataEsperadaDevolucao;
  @Column(name = "data_devolucao")
  private LocalDateTime dataDevolucao;
}
