package com.poly.Bai3;

import javax.websocket.Encoder;
import javax.websocket.EncodeException;
import javax.websocket.Encoder;
import javax.websocket.EndpointConfig;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.core.JsonProcessingException;

public class MessageEncoder implements Encoder.Text<Message> {
    private ObjectMapper mapper = new ObjectMapper();

    @Override
    public void destroy() {
        
    }

    @Override
    public void init(EndpointConfig config) {
    }

    @Override
    public String encode(Message message) throws EncodeException {
        try {
            return mapper.writeValueAsString(message);
        } catch (JsonProcessingException e) {
            throw new EncodeException(message, "Unable to encode");
        }
    }
}