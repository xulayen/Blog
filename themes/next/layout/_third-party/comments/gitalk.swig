{% if not (theme.duoshuo and theme.duoshuo.shortname) and not theme.duoshuo_shortname %}
  {% if theme.Gitalk.enable %}

    {% if page.comments %}
      <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/gitalk@1/dist/gitalk.css">
      <script src="https://cdn.jsdelivr.net/npm/gitalk@1/dist/gitalk.min.js"></script>

      <script>
        var gitalk = new Gitalk({
          clientID: '{{ theme.Gitalk.clientID }}',
          clientSecret: '{{ theme.Gitalk.clientSecret }}',
          repo: '{{ theme.Gitalk.repo }}',
          owner: '{{ theme.Gitalk.owner }}',
          admin: ['{{ theme.Gitalk.admin }}'],
          id: '{{ theme.Gitalk.id }}',      // Ensure uniqueness and length less than 50
          distractionFreeMode: {{ theme.Gitalk.distractionFreeMode }}  // Facebook-like distraction free mode
        })

        gitalk.render('gitalk-container')
      </script>
    {% endif %}

  {% endif %}
{% endif %}
