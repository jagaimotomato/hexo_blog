import anime from "animejs";
window.anime = anime
const autoProp = function(target, property, value){
  if(value !== 'auto' || getComputedStyle(target)[property] == undefined){
    return value;
  }
  let originalValue = getComputedStyle(target)[property];
  target.style[property] = "auto";
  let animeValue = parseFloat(getComputedStyle(target)[property].replace(/[^0-9]/g, ""));
  target.style[property] = originalValue;   // reset CSS to before function
  return animeValue;
}
const autoProps = function(properties){
  // let targets = document.querySelectorAll('.dom-node-demo .el');

  let targets = properties.targets;
  let calculatedProperties = {}
  for (const property in properties) {
    let value = properties[property];
    if(Array.isArray(value)){
      calculatedProperties[property] = value
      for (const idx in value) {
        calculatedProperties[property][idx] = autoProp(targets, property, value[idx]);
      }
    }else{
      calculatedProperties[property] = autoProp(targets, property, value);
    }
  }
  return calculatedProperties;
}

function enterMenuAme(el, duration) {
  anime.remove(el)
  anime(autoProps({
    targets: el,
    duration: duration,
    height: 'auto'
  }))
}

function leaveMenuAme(el, duration, height) {
  anime.remove(el)
  anime({
    targets: el,
    duration: duration,
    height: height
  })
}

function findChildrenElement(parentNode) {
  const result = [...(parentNode.children)].find(child => {
    return child.classList.contains("submenu")
  })
  return result
}

const parentNode = document.querySelectorAll(".menu-item")
for (let i = 0; i < parentNode.length; i++) {
  parentNode[i].addEventListener('mouseenter', function (e) {
    const el = findChildrenElement(e.target)
    if (el) {
      enterMenuAme(el, 100)
    }
  }, false)
  parentNode[i].addEventListener('mouseleave', function (e) {
    const el = findChildrenElement(e.target)
    if (el) {
      leaveMenuAme(el, 100, '0')
    }
  }, false)
}
