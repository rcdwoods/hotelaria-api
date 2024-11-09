package com.hotelaria.hotelaria.domain.entity;

import jakarta.persistence.*;

import java.util.List;

@Entity
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
  @OneToMany(mappedBy = "hotel")
  private List<Acomodacao> acomodacoes;
}