module ApplicationHelper

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end

  def time_ago(from_time, to_time=Time.now, options = {})
    from_time = from_time.to_time if from_time.respond_to?(:to_time)
    to_time = to_time.to_time if to_time.respond_to?(:to_time)
    distance_in_minutes = (((to_time - from_time).abs)/60).round
    distance_in_seconds = ((to_time - from_time).abs).round

    I18n.with_options :locale => options[:locale] do |locale|
      case distance_in_minutes
        when 0..5
          return I18n.t(:less_than_x_minutes, :count => 1) if distance_in_minutes == 0

          case distance_in_seconds
            when 0..59 then I18n.t :less_than_one_minutes, :count => 1
            else I18n.t :x_minutes, :count => 1
          end

        when 2..4 then I18n.t :two_four_minutes, :count => distance_in_minutes
        when 5..44 then I18n.t :x_minutes, :count => distance_in_minutes
        when 45..89 then I18n.t :about_one_hour
        when 90..240 then I18n.t :about_x_hours, :count => (distance_in_minutes.to_f / 60.0).round # 2..4 chasa
        when 241..1200 then I18n.t :x_hours_chasov, :count => (distance_in_minutes.to_f / 60.0).round #5..20 chasov
        when 1260..1319 then I18n.t :x_hours_21, :count => 21
        when 1440..2519 then I18n.t :x_day, :count => 1
        when 2520..43199 then I18n.t :x_days, :count => (distance_in_minutes.to_f / 1440.0).round
        when 43200..86399 then I18n.t :about_x_months, :count => 1
        when 86400..525599 then I18n.t :x_months, :count => (distance_in_minutes.to_f / 43200.0).round
        else
      end
    end
  end

  def currency(item, type)
    case item.send("#{type}_currency")
      when '1' then 'UAH'
      when '2' then 'USD'
      when '3' then 'RUR'
      else
    end
  end

  def worktype(item)
    case item.future_worktype
      when '1' then I18n.t :fulltime
      when '2' then I18n.t :partiall
      when '3' then I18n.t :remote
    end
  end

  def twitterized_type(type)
    case type
      when :alert
        "alert-block"
      when :error
        "alert-error"
      when :notice
        "alert-info"
      when :success
        "alert-success"
      else
        type.to_s
    end
  end

  def message_sent_time(created_at)
    if created_at.day == Time.now.day && created_at.month == Time.now.month
      created_at.strftime("%H:%M")
    else
      "#{created_at.strftime("%B %d")}"
    end
  end

  def password_prompt
    if user_signed_in? && current_user.needs_password?
      render 'devise/registrations/set_password'
    end
  end

end
