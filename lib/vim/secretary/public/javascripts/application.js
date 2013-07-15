var HeatMapGenerator;

HeatMapGenerator = (function($) {
  function HeatMapGenerator(div, clickHandler) {
    this.clickHandler = clickHandler != null ? clickHandler : this.onClickHandler;
    this.div = $(div);
    this.calendar = new CalHeatMap();
  }

  HeatMapGenerator.prototype.generate = function() {
    return this.calendar.init(this.options());
  };

  HeatMapGenerator.prototype.options = function() {
    return {
      data: this.div.data('source') + "?start={{d:start}}&end={{d:end}}",
      start: this._startDate(),
      domain: 'day',
      subDomain: 'hour',
      range: 14,
      scale: [1, 4, 9, 15],
      onClick: this.clickHandler
    };
  };

  HeatMapGenerator.prototype.onClickHandler = function(time, count) {
    var punch_word;
    punch_word = count === 1 ? " Punch" : " Punches";
    $('.activity-inner').html("<strong>" + count + "</strong>" + punch_word);
    return $.get("/punches.json?date=" + Math.round(time.getTime()/1000)).done(function(data) {
      return $('.activity-list ul').html(function() {
        return JSON.parse(data).map(function(item, i) {
          return $('<li/>').append(
            $('<a/>').attr('href', "/punches/" + item.id).append(
              $('<span/>').html("(" + item.project_name + ")").addClass('project-name')
            ).append(item.description)
          ).append($('<span/>').html(" - " + new Date(item.created_at)));
        });
      });
    });
  };

  HeatMapGenerator.prototype._startDate = function() {
    var date = new Date();
    return new Date(date.getTime() - (7*24*3600*1000));
  };

  return HeatMapGenerator;

})(jQuery);

new HeatMapGenerator('#cal-heatmap').generate()
