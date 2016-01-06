$ ->
  return unless $('#editor')[0]
  articleId = $('#editor').data('article-id')
  $('#editor').markdownEditor
    fullscreen: false
    imageUpload: true
    uploadPath:  "/article_images/upload?article_id=#{articleId}"
    # preview: true
    # onPreview: (content, callback)->
    #   console.log content
    label:
      btnHeader1: '見出し1'
      btnHeader2: '見出し2'
      btnHeader3: '見出し3'
      btnBold: '太字'
      btnItalic: '斜体'
      btnList: 'リスト',
      btnOrderedList: '数値付きリスト',
      btnLink: 'リンク',
      btnImage: 'URLから画像挿入',
      btnUpload: '画像アップロード',
      btnEdit: '編集',
      btnPreview: 'プレビュー',
      btnFullscreen: '全画面表示',
      loading: 'Loading'

  # 初期値
  content = $('#article_body').val()
  if content && !$('#editor').markdownEditor('content')
    $('#editor').markdownEditor('setContent', content);

  $('form').on 'submit', ->
    $('#article_body').val $('#editor').markdownEditor('content')