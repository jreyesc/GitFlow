module ApplicationHelper
  
  # Allows to set the _title_ header.
  #
  # * *args*
  #   - title(_string_) -> title name to be set   
  def title(title_str)
    content_for(:title, title_str)
    title_str
  end

  def disabled_info(form)
    "<script type='text/javascript'>
      $().ready(function() {
        $('##{form} :input').attr('disabled', true);
        $('##{form} :input.button').attr('disabled', false);
      });</script>".html_safe
  end

  def paginate_ajax_js
    "<script>
      $(document).ready(function() {
      $('.pagination a').attr('data-remote', 'true');
    });</script>".html_safe
  end

  def actions_tooltip
    "<script>
      $('.btn-show').tooltip();
      $('.btn-edit').tooltip();
      $('.btn-remove').tooltip();
    </script>".html_safe
  end

  def set_label_obligatory(allows_nil)
    unless allows_nil
      "(*)"
    end
  end

  def set_validate(allows_nil)
    unless allows_nil
      "required"
    end
  end

  def facebook_script
    "<script>
      function postToFeed(title,message,img){
         FB.init({
          appId     : '594345320687634',
          status    : true,
          cookie    : true});
        var obj = {
          method: 'feed',
          redirect_uri: 'development.tektonlabs.com/athena_stage',
          link: 'http://development.tektonlabs.com/athena_stage',
          name: title,
          caption: message,
          description: 'Sharing this app',
          picture: 'http://development.tektonlabs.com'+img,
          display: 'popup'
        };
        function callback(response) {
          document.getElementById('msg').innerHTML = 'Post ID: ' + response['post_id'];
        }
        FB.ui(obj, callback);
      }
    </script>".html_safe
  end

  def twitter_script
    "<script>
      $('.twitterPopup').click(function(event) {
        var width  = 575,
          height = 400,
          left   = ($(window).width()  - width)  / 2,
          top    = ($(window).height() - height) / 2,
          url    = this.href,
          opts   = 'status=1' +
               ',width='  + width  +
               ',height=' + height +
               ',top='    + top    +
               ',left='   + left;
        window.open(url, 'twitter', opts);
        return false;
      });
    </script>".html_safe
  end

end
