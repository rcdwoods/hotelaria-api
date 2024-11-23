package com.hotelaria.hotelaria.infra.mapper;

import com.hotelaria.hotelaria.domain.entity.Hotel;
import io.swagger.model.HotelResponse;
import org.mapstruct.Mapper;

import java.util.List;

@Mapper(uses = {AcomodacaoMapper.class})
public interface HotelMapper {
  HotelResponse toResponse(Hotel hotel);
  List<HotelResponse> toResponse(List<Hotel> hotel);
}
