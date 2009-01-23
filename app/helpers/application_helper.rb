# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def title(page_title)
    content_for(:title) { page_title }
  end

  def head(text)
    content_for(:head) { text }
  end

  def javascript(*args)
    content_for(:head) { javascript_include_tag(*args) }
  end

  def page_scripts(&block)
    content_for(:page_scripts, nil, &block)
  end

  def set_page_focus(css_id)
    set_page_focus_or_activate(css_id, 'focus')
  end

  def set_page_focus_and_activate(css_id)
    set_page_focus_or_activate(css_id, 'activate')
  end

  def clear_both
    "<div style='clear:both;'></div>"
  end

  def on_load_scripts(&block)
    page_scripts do
      <<-JS
        <script type="text/javascript">
          document.observe('dom:loaded',function() {
            #{capture(&block)}
          }, false);
        </script>
      JS
    end
  end

  def button(size, color, markup)
    content_tag(:span, markup, :class => "btn btn-#{size.to_s}-#{color.to_s}")
  end

  def hide_if(condition)
    " style='display:none;'" if condition
  end

  def hide_unless(condition)
    hide_if(!condition)
  end

  def toggle_element(*element_ids)
    update_page do |page|
      page.toggle *element_ids
    end
  end
  alias_method :toggle_elements, :toggle_element

private

  def set_page_focus_or_activate(css_id, focus_method)
    on_load_scripts do
      "$('#{css_id.to_s}').#{focus_method}();"
    end
  end
end
