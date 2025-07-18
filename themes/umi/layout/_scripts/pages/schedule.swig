<script{{ pjax }}>
  (function() {
    // Initialization
    var calendar = {
      orderBy     : 'startTime',
      showLocation: false,
      offsetMax   : 72,
      offsetMin   : 4,
      showDeleted : false,
      singleEvents: true,
      maxResults  : 250
    };

    // Read config form theme config file
    Object.assign(calendar, {{ theme.calendar | json }});

    var now = new Date();
    var timeMax = new Date();
    var timeMin = new Date();

    timeMax.setHours(now.getHours() + calendar.offsetMax);
    timeMin.setHours(now.getHours() - calendar.offsetMin);

    // Build URL
    const params = {
      key         : calendar.api_key,
      orderBy     : calendar.orderBy,
      timeMax     : timeMax.toISOString(),
      timeMin     : timeMin.toISOString(),
      showDeleted : calendar.showDeleted,
      singleEvents: calendar.singleEvents,
      maxResults  : calendar.maxResults
    };

    var request_url = 'https://www.googleapis.com/calendar/v3/calendars/' + calendar.calendar_id + '/events?' + Object.entries(params).map(([key, value]) => `${key}=${encodeURIComponent(value)}`).join('&');

    fetchData();
    var fetchDataTimer = setInterval(fetchData, 60000);
    window.addEventListener('pjax:send', () => {
      clearInterval(fetchDataTimer);
    });

    function fetchData() {
      var eventList = document.querySelector('.event-list');
      if (!eventList) return;

      fetch(request_url).then(response => {
        return response.json();
      }).then(data => {
        if (data.items.length === 0) {
          eventList.innerHTML = '<hr>';
          return;
        }
        // Clean the event list
        eventList.innerHTML = '';
        var prevEnd = 0; // used to decide where to insert an <hr>

        data.items.forEach(event => {
          // Parse data
          var utc   = new Date().getTimezoneOffset() * 60000;
          var start = event.start.dateTime = new Date(event.start.dateTime || (new Date(event.start.date).getTime() + utc));
          var end   = event.end.dateTime = new Date(event.end.dateTime || (new Date(event.end.date).getTime() + utc));

          tense = judgeTense(now, start, end); // 0:now 1:future -1:past

          if (tense === 1 && prevEnd < now) {
            eventList.innerHTML += '<hr>';
          }

          eventDOM = buildEventDOM(tense, event);
          eventList.innerHTML += eventDOM;

          prevEnd = end;
        });
      });
    }

    function getRelativeTime(current, previous) {
      var msPerMinute = 60 * 1000;
      var msPerHour = msPerMinute * 60;
      var msPerDay = msPerHour * 24;
      var msPerMonth = msPerDay * 30;
      var msPerYear = msPerDay * 365;

      var elapsed = current - previous;
      var tense = elapsed > 0 ? 'ago' : 'later';

      elapsed = Math.abs(elapsed);

      if      ( elapsed < msPerHour  ) {
        return Math.round(elapsed / msPerMinute) + ' minutes ' + tense;
      }
      else if ( elapsed < msPerDay   ) {
        return Math.round(elapsed / msPerHour) + ' hours ' + tense;
      }
      else if ( elapsed < msPerMonth ) {
        return 'about ' + Math.round(elapsed / msPerDay) + ' days ' + tense;
      }
      else if ( elapsed < msPerYear  ) {
        return 'about ' + Math.round(elapsed / msPerMonth) + ' months ' + tense;
      }
      else {
        return 'about' + Math.round(elapsed / msPerYear) + ' years' + tense;
      }
    }

    function judgeTense(now, eventStart, eventEnd) {
      if      (eventEnd   < now) { return -1; }
      else if (eventStart > now) { return  1; }
      else                       { return  0; }
    }

    function buildEventDOM(tense, event) {
      var tenseClass = '';
      var start      = event.start.dateTime;
      var end        = event.end.dateTime;
      switch(tense) {
        case 0 : // now
          tenseClass = 'event-now';
          break;
        case 1 : // future
          tenseClass = 'event-future';
          break;
        case -1: // past
          tenseClass = 'event-past';
          break;
        default:
          throw 'Time data error';
      }
      var durationFormat = {
        weekday: 'short',
        hour   : '2-digit',
        minute : '2-digit'
      };
      var relativeTimeStr = (tense === 0) ? 'NOW' : getRelativeTime(now, start);
      var durationStr = start.toLocaleTimeString([], durationFormat) + ' - ' + end.toLocaleTimeString([], durationFormat);

      var locationDOM = '';
      if (calendar.showLocation && event.location) {
        locationDOM = '<span class="event-location event-details">' + event.location + '</span>';
      }

      var eventContent = `<div class="event ${tenseClass}">
        <h2 class="event-summary">
          ${event.summary}
          <span class="event-relative-time">${relativeTimeStr}</span>
        </h2>
        ${locationDOM}
        <span class="event-duration event-details">${durationStr}</span>
      </div>`;
      return eventContent;
    }
  })();
</script>
