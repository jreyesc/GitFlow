class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :get_namespace

  def get_namespace
    @action = params[:action]
    @controller = params[:controller]
  end

  def get_errors(object)
    str_error = ""
    object.errors.each do |attrb, message|
      if !message.include?("can't be blank") and !message.include?("is invalid")
        str_error = str_error + "<li>" + message + "</li>" if object.errors[attrb].first == message
      end
    end
    return str_error
  end

  # This function restricts access to a not allowed page and show a dennied access message
  def no_access(path=nil)
    flash[:alert] = t('messages.no_access') if flash[:alert].blank?
    unless path.nil?
      redirect_to path
    else
      if request.env["HTTP_REFERER"].nil?
        redirect_to admin_root_path
      else
        redirect_to :back
      end
    end
  end

  # This function restricts access to show a register deleted
  def no_access_to_show(path)
    flash[:alert] = t('messages.no_access_to_show')
    no_access(path)
  end

  # This function restricts access to edit a register deleted
  def no_access_to_edit(path)
    flash[:alert] = t('messages.no_access_to_edit')
    no_access(path)
  end

  # This function restricts access to delete a register deleted
  def no_access_to_delete(path)
    flash[:alert] = t('messages.no_access_to_delete')
    no_access(path)
  end

  private

    def after_sign_out_path_for(resource_or_scope)
      case resource_or_scope
        when :admin
          new_admin_session_path
        when :user
          front_root_path
      end
    end

end
