package com.hotelaria.hotelaria.domain.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

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
  private boolean isCentral;
  @Enumerated(EnumType.STRING)
  private CategoriaEnum categoria;
  @OneToOne
  @JoinColumn(name = "registro_imobiliario_id")
  private RegistroImobiliario registroImobiliario;
  @OneToMany(mappedBy = "acomodacaoId.hotel")
  private List<Acomodacao> acomodacoes;
}
