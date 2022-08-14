<script>
  var pjax = new Pjax({
    selectors: [
      'head title',
      '.header .pixel-title',
      '#page-configurations',
      '.content-wrap',
      '.post-toc-wrap',
      '.languages',
      '#pjax'
    ],
    switches: {
      '.post-toc-wrap': Pjax.switches.innerHTML
    },
    analytics: false,
    cacheBust: false,
    // scrollTo : document.querySelector('.main').offsetTop - 60
  });

  const pixelTitle = document.querySelector('.header .pixel-title')
  const title = document.querySelector('head title')

  window.addEventListener('pjax:success', () => {
    pjax.refresh(title)
    pjax.refresh(pixelTitle)
    document.querySelectorAll('script[data-pjax], script#page-configurations, #pjax script').forEach(element => {
      var code = element.text || element.textContent || element.innerHTML || '';
      var parent = element.parentNode;
      parent.removeChild(element);
      var script = document.createElement('script');
      if (element.id) {
        script.id = element.id;
      }
      if (element.className) {
        script.className = element.className;
      }
      if (element.type) {
        script.type = element.type;
      }
      if (element.src) {
        script.src = element.src;
        // Force synchronous loading of peripheral JS.
        script.async = false;
      }
      if (element.dataset.pjax !== undefined) {
        script.dataset.pjax = '';
      }
      if (code !== '') {
        script.appendChild(document.createTextNode(code));
      }
      parent.appendChild(script);
    });
    NexT.boot.refresh();
    // Define Motion Sequence & Bootstrap Motion.
    if (CONFIG.motion.enable) {
      NexT.motion.integrator
        .init()
        .add(NexT.motion.middleWares.subMenu)
        .add(NexT.motion.middleWares.postList)
        .bootstrap();
    }
    // NexT.utils.updateSidebarPosition();
  });
</script>
