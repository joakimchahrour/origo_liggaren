#let page_wrapper(content) = html.elem("div", attrs: (
  style: "padding: 1cm; max-width: 600px; margin: auto; font-family: sans-serif; min-height: 100vh; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);"
), content)

#let form_card(content) = html.elem("div", attrs: (
  style: "background: #f5f5f5; padding: 25px; border-radius: 12px; border: 1px solid #ddd; box-shadow: 0 4px 6px rgba(0,0,0,0.1); color: #333;"
), content)

#let input_style = "width: 100%; padding: 10px; margin-bottom: 15px; border: 1px solid #ccc; border-radius: 6px; box-sizing: border-box; font-size: 16px;"

