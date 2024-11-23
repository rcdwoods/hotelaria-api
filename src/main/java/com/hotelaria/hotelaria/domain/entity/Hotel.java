package com.hotelaria.hotelaria.domain.entity;

import javax.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@Setter
public class Hotel {
  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE)
  private Long id;
  @Column(name = "nome_fantasia")
  private String nomeFantasia;
  @Enumerated(EnumType.STRING)
  private SetorEnum setor;
  private Long tamanho;
  @Column(name = "is_central")
  private Boolean isCentral;
  @Enumerated(EnumType.STRING)
  private CategoriaEnum categoria;
  @OneToOne
  @JoinColumn(name = "registro_imobiliario_id")
  private RegistroImobiliario registroImobiliario;
  @OneToMany(mappedBy = "acomodacaoId.hotel", fetch = FetchType.LAZY)
  private List<Acomodacao> acomodacoes = new ArrayList<>();

  public void addAcomodacao(Acomodacao acomodacao) {
    acomodacoes.add(acomodacao);
  }
}
