'use strict'

hexo.extend.filter.register('template_locals', locals => {
  const { env, config } = hexo
  const { __, theme } = locals
  const { i18n } = hexo.theme
  locals.hexo_version = env.version
  locals.title = __('title') !== 'title' ? __('title') : config.title
  locals.subtitle = __('subtitle') !== 'subtitle' ? __('subtitle') : config.subtitle
  locals.languages = [...i18n.languages]
  locals.languages.splice(locals.languages.indexOf('default'), 1)
  locals.page.lang = locals.page.lang || locals.page.language

  // PJAX
  locals.pjax = theme.pjax ? ' data-pjax' : '';
})
