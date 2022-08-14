'use strict'

hexo.extend.helper.register('umi_font', () => {
    const config = hexo.theme.config.font

    if (!config || !config.enable) return ''

    const fontDisplay = '&display=swap'
    const fontSubset = '&subset=latin,latin-ext'
    const fontStyles = ':300,300italic,400,400italic,700,700italic';
    const fontHost = config.host || '//fonts.googleapis.com';

    let fontFamilies = ['global', 'title', 'headings', 'posts', 'codes'].map(item => {
        if (config[item] && config[item].family && config[item].external) {
            return config[item].family + fontStyles
        }
        return ''
    })

    fontFamilies = fontFamilies.filter(item => item !== '')
    fontFamilies = [...new Set(fontFamilies)]

    if (fontFamilies.length > 1) {
        fontFamilies.join['|']
    } else {
        fontFamilies = fontFamilies[0]
    }

    return fontFamilies ? `<link rel="stylesheet" href="${fontHost}/css?family=${fontFamilies.concat(fontDisplay, fontSubset)}">` : ''
})