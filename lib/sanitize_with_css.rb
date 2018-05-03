# frozen_string_literal: true

def sanitize_with_css(html)
  Sanitize.fragment html,
                    elements: %w[div p b i u strike sub sup blockquote pre ol li ul],
                    attributes: { all: ['style'] },
                    css: {
                      properties: ['text-align', 'margin', 'border', 'padding']
                    }
end
