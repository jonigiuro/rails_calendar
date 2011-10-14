module EventsHelper

  #==================== CLOCK CONTROL ====================
  def line_control
    starting_hour = DateTime.now.hour
    starting_minute = DateTime.now.min

    starting_sec = starting_hour * 3600 + starting_minute * 60
   starting_position = (945.0/86400)*starting_sec
  end

  #================== DIV LENGTH ===================
  def event_length(event, date)
    starting_hour = (((event.start_at).to_s).slice(10..13)).to_i
    starting_minute = (((event.start_at).to_s).slice(14..15)).to_i
    ending_hour = (((event.end_at).to_s).slice(10..13)).to_i
    ending_minute = (((event.end_at).to_s).slice(14..15)).to_i

    total_hours = ending_hour - starting_hour
    total_minutes = ending_minute - starting_minute

    if (total_minutes < 0)
      total_minutes = total_minutes + (-1)
      total_hours -= 1
    end

    total_time = (total_hours*3600) + (total_minutes * 60)
    if (event.end_at).to_date > date.to_date
      return 945
    end
    length = (945.0/86400) * total_time
  end

  #============ STARTING POSITION ==============================
  def starting_pos(event, date)

    starting_hour = (((event.start_at).to_s).slice(10..13)).to_i
    starting_minute = (((event.start_at).to_s).slice(14..15)).to_i

    starting_sec = starting_hour * 3600 + starting_minute * 60
    starting_position = (945.0/86400)*starting_sec

  end

  #======= USER COLOR ===========
  def user_color(user_id)
    User.find(user_id).color
  end

  ###################### DAY VIEW NAVIGATION ##########################
  def day_nav(step)

    if(params.has_key?(:year) && params.has_key?(:month) && params.has_key?(:day))
      @current_year = (params[:year])
      @current_month = (params[:month])
      @current_day = (params[:day])
    else
      @current_year = Time.now.year.to_s
      @current_month = Time.now.month.to_s
      @current_day = Time.now.day.to_s
    end

    ################### PRIMA DI AGOSTO #####################
    if @current_month.to_i < 8
    #CAPODANNO

      if @current_month.to_i == 01 && @current_day.to_i == 01 && step == -1
        @current_month = 12.to_s
        @current_day = 32.to_s
        @current_year = (@current_year.to_i - 1).to_s
      end

    #FINE MESE ANDANDO AVANTI
    unless @month.to_i == 12
      unless @month.to_i == 02
        if @current_day.to_i == 31 && @current_month.to_i % 2 == 1 && step == 1
          @current_day = 0.to_s
          @current_month = (@current_month.to_i + step).to_s
        end
      end
    end
    unless @month.to_i == 12
      unless @month.to_i == 02
        if @current_day.to_i == 30 && @current_month.to_i % 2 == 0 && step == 1
          @current_day = 0.to_s
          @current_month = (@current_month.to_i + step).to_s
        end
      end
    end

    #INIZIO MESE ANDANDO INDIETRO
    unless @month.to_i == 03
      if @current_day.to_i == 1 && @current_month.to_i % 2 == 1 && step == (-1)
        @current_day = 31.to_s
        @current_month = (@current_month.to_i + step).to_s
      end
    end
    unless @month.to_i == 03
      if @current_day.to_i == 1 && @current_month.to_i % 2 == 0 && step == (-1)
        @current_day = 32.to_s
        @current_month = (@current_month.to_i + step).to_s
      end
    end
  else
    ######################## DOPO AGOSTO #######################
    #CAPODANNO
      if @current_month.to_i == 12 && @current_day.to_i == 31 && step == 1
        @current_month = 01.to_s
        @current_day = 0.to_s
        @current_year = (@current_year.to_i + 1).to_s
      end

    #FINE MESE ANDANDO AVANTI
    unless @month.to_i == 12
      unless @month.to_i == 02
        if @current_day.to_i == 31 && @current_month.to_i % 2 == 0 && step == 1
          @current_day = 0.to_s
          @current_month = (@current_month.to_i + step).to_s
        end
      end
    end
    unless @month.to_i == 12
      unless @month.to_i == 02
        if @current_day.to_i == 30 && @current_month.to_i % 2 == 1 && step == 1
          @current_day = 0.to_s
          @current_month = (@current_month.to_i + step).to_s
        end
      end
    end

    #INIZIO MESE ANDANDO INDIETRO
    unless @month.to_i == 03
      if @current_day.to_i == 1 && @current_month.to_i % 2 == 0 && step == (-1)
        @current_day = 31.to_s
        @current_month = (@current_month.to_i + step).to_s
      end
    end
    unless @month.to_i == 03
      if @current_day.to_i == 1 && @current_month.to_i % 2 == 1 && step == (-1)
        @current_day = 32.to_s
        @current_month = (@current_month.to_i + step).to_s
      end
    end
  end

  #controllo di febbraio anni normali
  if @current_month.to_i == 2 && @current_day.to_i == 28 && @current_year.to_i % 4 != 0 && step == 1
    @current_day = 0.to_s
    @current_month = 3.to_s
  end
  if @current_month.to_i == 3 && @current_day.to_i == 1 && @current_year.to_i % 4 != 0 && step == -1
    @current_day = 29.to_s
    @current_month = 2.to_s
  end

  #controllo di febbraio anni bisestili
  if @current_month.to_i == 2 && @current_day.to_i == 29 && @current_year.to_i % 4 == 0 && step == 1
    @current_day = 0.to_s
    @current_month = 3.to_s
  end
  if @current_month.to_i == 3 && @current_day.to_i == 1 && @current_year.to_i % 4 == 0 && step == -1
    @current_day = 30.to_s
    @current_month = 2.to_s
  end

  ################### ELABORA #####################

    @new_day = (@current_day.to_i + step).to_s
    @current_date = @current_year + '/' + (@current_month).rjust(2, '0') + '/' + (@new_day).rjust(2, '0')
    return "/day/#{@current_date}"
  end
#=================== START DATE ===================
  def show_start_date(event)
    if event.start_at - 2.hours<= Time.now ##### - 2 ore per via dell'utc. Brutto - riparare.
      "<strong><em>Event started</em></strong>".html_safe
    else
      event.start_at.to_formatted_s(:short)
      #DateTime.now.to_s + '-' +event.start_at.to_s
    end
  end

#=================== END DATE ===================

  def show_end_date(event)
    #if (((event.end_at).to_s).slice(0..9)).to_i < (((DateTime.now).to_s).slice(0..9)).to_i
    if event.end_at - 2.hours< DateTime.now
      "<strong><em>and closed.</em></strong>".html_safe
    else
      event.end_at.to_formatted_s(:short)
    end
  end

  #================== ONGOING LENGTH ==================
  def ongoing_bar(event, date)
      if (date).to_datetime.midnight != DateTime.now.midnight
        1000
      else
      line_control - starting_pos(event, date) -8
    end
  end

  #================ ATTENDING PEOPLE ======================
end