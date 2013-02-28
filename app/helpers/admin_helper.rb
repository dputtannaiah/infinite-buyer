module AdminHelper

  def get_name(name)
    "<strong>#{name}<strong>"
  end

  def nested_messages_1(node_tree, node)
    expand_collapse = content_tag :span, :class => "expand-collapse" do
      image_tag 'plus_icon.png', :alt => '+'
    end

    node_tree.map do |message, sub_messages|

      if message.name == node.name && message.has_children?
        ec_btn = expand_collapse
        node_class = "major-category"
        label_tag = content_tag(:label, message.name,:style => 'display:inline', :class => 'nested-label-class')
      elsif message.name != node.name && message.has_children?
        ec_btn = expand_collapse + check_box_tag("category_ids[]", message.id)
        node_class = "sub-category sub"
        label_tag = content_tag(:label, message.name, :style => 'display:inline', :class => 'nested-label-class')
      elsif message.is_childless?
        ec_btn = check_box_tag("category_ids[]", message.id, false, :class => 'childless', :id => "category_id_#{message.id}")
        node_class = "sub-category"
        label_tag = content_tag(:label, message.name, :class => 'nested-label-class', :style => 'display:inline', :for => "category_id_#{message.id}")
      end

      text_box = message.is_childless? ? (text_field_tag "category_keywords[#{message.id}]", '', :placeholder => 'Keywords', :class => 'childless_textbox') : ("")

      "<div class='#{node_class}'>#{ec_btn + label_tag + text_box}</div>" +
        content_tag(:div, nested_messages_1(sub_messages, node), :class => 'nested-messages_1')
    end.join.html_safe
  end

end
