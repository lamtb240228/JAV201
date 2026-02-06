package com.poly.Bai3;

import javax.websocket.Decoder;
import javax.websocket.DecodeException;
import javax.websocket.EndpointConfig;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.core.JsonProcessingException;
import java.io.IOException;

public class MessageDecoder implements Decoder.Text<Message> {

    private ObjectMapper mapper = new ObjectMapper();

    @Override
    public void destroy() {
    }

    @Override
    public void init(EndpointConfig config) {
    }

    @Override
    public Message decode(String json) throws DecodeException {
        try {
            return mapper.readValue(json, Message.class);
        } catch (IOException e) {
            throw new DecodeException(json, "Unable to decode");
        }
    }

    @Override
    public boolean willDecode(String json) {
        return json.contains("type") && json.contains("text");
    }
}