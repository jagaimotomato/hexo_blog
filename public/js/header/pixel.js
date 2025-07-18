
//This stuff just makes the demo's UI work. ---------------
var characterElement = document.querySelector(".Character");

var spritesheets = [
  "/images/pixel/ZAK-SHEET.png",
  "/images/pixel/HANK-2-SHEET.png",
  "/images/pixel/EMMY-SHEET.png",
  "/images/pixel/SHIRMOND-SHEET.png",
  "/images/pixel/SARA-SHEET.png",
  "/images/pixel/PATTY-SHEET.png",
  "/images/pixel/JESSIE-SHEET.png",
  "/images/pixel/KIM-SHEET.png",
  "/images/pixel/MINDY-SHEET.png",
  "/images/pixel/BEAR-SHEET.png",
];

let activeIndex = 0;
let spritesheetElements = "";
let navigationElements = "";


spritesheets.forEach((spritesheet, index) => {
  spritesheetElements += `<img src="${spritesheet}" class="PixelArtImage Character_sprite-sheet index-${index}" />`
  navigationElements += `<button class="NavigationBubble index-${index}" onclick='setActive(${index})' />`
});
characterElement.insertAdjacentHTML( 'beforeend', spritesheetElements );

document.querySelector(".Navigation").insertAdjacentHTML( 'beforeend', navigationElements );

function setActive(index) {
  activeIndex = index;
  document.querySelectorAll(`.active`).forEach(node => {
    node.classList.remove("active")
  })
  document.querySelectorAll(`.index-${index}`).forEach(node => {
    node.classList.add("active")
  })
}

function setDirection(direction) {
  [
    "Character--walk-down",
    "Character--walk-right",
    "Character--walk-up",
    "Character--walk-left"
  ].forEach(className => {
    characterElement.classList.remove(className)
  })


  document.querySelector(".DirectionArrow--active").classList.remove("DirectionArrow--active")

  var directionClass = "Character--walk-down";
  if (direction === "DOWN") {
    document.querySelector(".DirectionArrow-down").classList.add("DirectionArrow--active")
  }

  if (direction === "LEFT") {
    directionClass = "Character--walk-left"
    document.querySelector(".DirectionArrow-left").classList.add("DirectionArrow--active")
  }
  if (direction === "RIGHT") {
    directionClass = "Character--walk-right"
    document.querySelector(".DirectionArrow-right").classList.add("DirectionArrow--active")
  }
  if (direction === "UP") {
    directionClass = "Character--walk-up"
    document.querySelector(".DirectionArrow-up").classList.add("DirectionArrow--active")
  }

  characterElement.classList.add(directionClass)
}

function setPreviousActive() {
  activeIndex = activeIndex > 0 ? activeIndex - 1 : spritesheets.length - 1;
  setActive(activeIndex)
}

function setNextActive() {
  activeIndex = activeIndex < spritesheets.length - 1 ? activeIndex + 1 : 0;
  setActive(activeIndex)
}

//Kick it off!
setActive(activeIndex);
