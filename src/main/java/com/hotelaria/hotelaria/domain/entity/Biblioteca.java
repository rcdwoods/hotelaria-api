package com.hotelaria.hotelaria.domain.entity;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Entity
public class Biblioteca {
  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE)
  private Long id;
  private String nome;
  private Long capacidade;
  @Column(name = "metros_quadrados")
  private Long metrosQuadrados;
  @Column(name = "quantidade_locacao_por_pessoa")
  private Long quantidadeLocacaoPorPessoa;
  @Column(name = "aceita_evento_literario")
  private Boolean aceitaEventoLiterario;
  private BigDecimal multaAtraso;
  @Column(name = "horario_abertura_dia_semana")
  private LocalDateTime horarioAberturaDiaSemana;
  @Column(name = "horario_fechamento_dia_semana")
  private LocalDateTime horarioFechamentoDiaSemana;
  @Column(name = "horario_abertura_fim_semana")
  private LocalDateTime horarioAberturaFimSemana;
  @Column(name = "horario_fechamento_fim_semana")
  private LocalDateTime horarioFechamentoFimSemana;
  @OneToOne
  @JoinColumn(name = "hotel_id")
  private Hotel hotel;
  @OneToMany(mappedBy = "biblioteca")
  private List<Livro> livros;
  @ManyToMany
  @JoinTable(
    name = "biblioteca_livro",
    joinColumns = @JoinColumn(name = "biblioteca_id"),
    inverseJoinColumns = @JoinColumn(name = "livro_id")
  )
  private List<PoliticaDeUso> politicaDeUsos;
}
