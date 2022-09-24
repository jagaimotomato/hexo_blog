{%- if theme.beian.enable %}
  <div class="beian">
    {{- umi_url('https://beian.miit.gov.cn', theme.beian.icp + ' ') }}
    {%- if theme.beian.gongan_icon_url %}
      <img src="{{ url_for(theme.beian.gongan_icon_url) }}" style="display: inline-block;">
    {%- endif %}
    {%- if theme.beian.gongan_id and theme.beian.gongan_num %}
      {{- umi_url('http://www.beian.gov.cn/portal/registerSystemInfo?recordcode=' + theme.beian.gongan_id, theme.beian.gongan_num + ' ') }}
    {%- endif %}
  </div>
{%- endif %}
