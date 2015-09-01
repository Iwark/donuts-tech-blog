module ApplicationHelper

  class HTMLwithPygments < Redcarpet::Render::HTML
    def block_code(code, language)
      sha = Digest::SHA1.hexdigest(code)
      Rails.cache.fetch ["code", language, sha].join('-') do
        Pygments.highlight(code, lexer:language)
      end
    end
  end

  def markdown(text)
    renderer = ArticleRenderer.new(hard_wrap: true, filter_html: true)
    options = {
      autolink: true,
      tables: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true
    }
    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end

  class ArticleRenderer < HTMLwithPygments
    def block_code(code, language)
      if language=="mathjax"
        "<script type=\"math/tex; mode=display\">\n#{code}\n</script>"
      else
        super(code, language)
      end
    end

    def codespan(code)
      if code[0] == "$" && code[-1] == "$"
        "<script type=\"math/tex\">#{code[1...-1]}</script>"
      elsif code[0..1] == "\\(" && code[-2..-1] == "\\)"
        "<script type=\"math/tex\">#{code[2...-2]}</script>"
      else
        "<code>#{code}</code>"
      end
    end
  end
end
