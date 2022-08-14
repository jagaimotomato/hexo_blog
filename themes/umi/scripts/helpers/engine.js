'use strict'

hexo.extend.helper.register('umi_inject', function(point) {
  return hexo.theme.config.injects[point]
    .map(item => this.partial(item.layout, item.locals, item.options))
    .join('');
});

hexo.extend.helper.register('umi_vendors', function(url) {
    if (url.startsWith('//')) return url;
    const internal = hexo.theme.config.vendors._internal;
    return this.url_for(`${internal}/${url}`);
  });

hexo.extend.helper.register('umi_js', function(...urls) {
  const { js } = hexo.theme.config;
  return urls.map(url => this.js(`${js}/${url}`)).join('');
});

hexo.extend.helper.register('umi_lib', function(...urls) {
  const { lib } = hexo.theme.config;
  return urls.map(url => this.js(`${lib}/${url}`)).join('');
});

hexo.extend.helper.register('post_edit', function(src) {
  const theme = hexo.theme.config;
  if (!theme.post_edit.enable) return '';
  return this.next_url(theme.post_edit.url + src, '<i class="fa fa-pencil-alt"></i>', {
    class: 'post-edit-link',
    title: this.__('post.edit')
  });
});
