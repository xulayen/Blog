{% if not (theme.duoshuo and theme.duoshuo.shortname) and not theme.duoshuo_shortname %}
  {% if theme.Gitalk.enable %}

    {% if page.comments %}
      <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/gitalk@1/dist/gitalk.css">
      <script src="https://cdn.jsdelivr.net/npm/gitalk@1/dist/gitalk.min.js"></script>

      <script>
        var gitalk = new Gitalk({
          clientID: '838f1b0ca24494f8a066',
          clientSecret: 'b55027307fea0b425c73fd33da3fb7d400cd99c5',
          repo: 'Blog',
          owner: 'xulayen',
          admin: ['xulayen'],
          id: 'Demo',      // Ensure uniqueness and length less than 50
          distractionFreeMode: false  // Facebook-like distraction free mode
        })

        gitalk.render('gitalk-container')
      </script>
    {% endif %}

  {% endif %}
{% endif %}
