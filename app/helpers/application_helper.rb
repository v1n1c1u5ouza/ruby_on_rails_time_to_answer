module ApplicationHelper
    def translate_field( object = nil, method = nil )
        (object && method) ? object.model.human_attribute_name(method) : "Informe o parâmetro corretamente!!!"
    end
end
