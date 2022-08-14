'use strict'

function isObject(item) {
  return item && typeof item === 'object' && !Array.isArray(item)
}

module.exports = hexo => {
  let data = hexo.locals.get('data')
  console.log(data.next)
  if (data.next) {
    console.log(data.next)
  }
}
