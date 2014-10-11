module ApplicationHelper
  def page_header text = t('.header')
    "<div class='page-header'> <h3> #{text} </h3> </div>".html_safe
  end
end
