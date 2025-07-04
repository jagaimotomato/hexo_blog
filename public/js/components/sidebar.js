document.addEventListener('DOMContentLoaded', () => {
  var mousePos = {}
  var SIDEBAR_WIDTH = CONFIG.sidebar.width || 320;
  var SIDEBAR_DISPLAY_DURATION = 200;
  var sidebarToggleLines = {
    lines: document.querySelector('.sidebar-toggle'),
    init: function () {
      if (this.lines) {
        this.lines.classList.remove('toggle-arrow', 'toggle-close')
      }
    },
    arrow: function () {
      if (this.lines) {
        this.lines.classList.remove('toggle-close')
        this.lines.classList.add('toggle-arrow')
      }
    },
    close: function () {
      if (this.lines) {
        this.lines.classList.remove('toggle-arrow')
        this.lines.classList.add('toggle-close')
      }
    }
  }

  var sidebarToggleMotion = {
    sidebarEl: document.querySelector('#not_index_sidebar'),
    isSidebarVisible: false,
    init: function () {
      sidebarToggleLines.init()

      window.addEventListener('mousedown', this.mousedownHandler.bind(this))
      window.addEventListener('mouseup', this.mouseupHandler.bind(this))
      // document.querySelector('#sidebar-dimmer').addEventListener('click', this.clickHandler.bind(this))

      const toggleEl = document.querySelector('.sidebar-toggle')
      if (toggleEl) {
        document.querySelector('.sidebar-toggle').addEventListener('mouseenter', this.mouseEnterHandler.bind(this));
        document.querySelector('.sidebar-toggle').addEventListener('click', this.clickHandler.bind(this));
        document.querySelector('.sidebar-toggle').addEventListener('mouseleave', this.mouseLeaveHandler.bind(this));
      }
      window.addEventListener('sidebar:show', this.showSidebar.bind(this));
      window.addEventListener('sidebar:hide', this.hideSidebar.bind(this));
    },
    mousedownHandler: function (event) {
      mousePos.X = event.pageX
      mousePos.Y = event.pageY
    },
    mouseupHandler: function (event) {
      var deltaX = event.pageX - mousePos.X
      var deltaY = event.pageY - mousePos.Y
      var clickingBlankPart = Math.sqrt((deltaX * deltaX) + (deltaY * deltaY)) < 20 && event.target.matches('.main')
      if (this.isSidebarVisible && (clickingBlankPart || event.target.matches('img.medium-zoom-image, .fancybox img'))) {
        this.hideSidebar()
      }
    },
    clickHandler: function () {
      this.isSidebarVisible ? this.hideSidebar() : this.showSidebar()
    },
    mouseEnterHandler: function() {
      if (!this.isSidebarVisible) {
        sidebarToggleLines.arrow()
      }
    },
    mouseLeaveHandler: function() {
      if (!this.isSidebarVisible) {
        sidebarToggleLines.init()
      }
    },
    showSidebar: function () {
      this.isSidebarVisible = true
      this.sidebarEl.classList.add('sidebar-active');
      if (typeof Velocity === 'function') {
        Velocity(document.querySelectorAll('#not_index_sidebar .motion-element'), 'transition.slideLeftIn', {
          stagger: 50,
          drag: true
        })
      }
      sidebarToggleLines.close()
      NexT.utils.isDesktop() && window.anime(Object.assign({
        targets : document.body,
        duration: SIDEBAR_DISPLAY_DURATION,
        easing  : 'linear'
      }, {
        'padding-left': SIDEBAR_WIDTH
      }));
    },
    hideSidebar: function () {
      this.isSidebarVisible = false
      this.sidebarEl.classList.remove('sidebar-active')
      sidebarToggleLines.init()
      NexT.utils.isDesktop() && window.anime(Object.assign({
        targets : document.body,
        duration: SIDEBAR_DISPLAY_DURATION,
        easing  : 'linear'
      }, {
        'padding-left': 0
      }));
    },
  }
  sidebarToggleMotion.init()
})
