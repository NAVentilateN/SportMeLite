import { Calendar, createElement } from "@fullcalendar/core";
import interactionPlugin from "@fullcalendar/interaction";
import dayGridPlugin from "@fullcalendar/daygrid";
import timeGridPlugin from "@fullcalendar/timegrid";
import listPlugin from "@fullcalendar/list";
import googleCalendarPlugin from "@fullcalendar/google-calendar";

let calendar;
let googleEvents;
let events;

const loadCalendar = () => {
  const calendarEl = document.getElementById("calendar");
  console.log("load calendar");

  if (calendarEl) {
    const eventsData = JSON.parse(calendarEl.dataset.events);
    events = eventsData.map((data) => {
      const lesson = JSON.parse(data);
      return {
        id: lesson.id,
        start: new Date(lesson.start_date_time),
        end: new Date(lesson.end_date_time),
        title: lesson.description,
        backgroundColor: lesson.status ? "green" : "red",
        textColor: "white",
        extendedProps: {
          status: lesson.status,
          student_id: lesson.student_id,
          coach_id: lesson.coach_id,
          description: lesson.description,
        },
      };
    });

    if (calendarEl.dataset.googleEvents) {
      googleEvents = JSON.parse(calendarEl.dataset.googleEvents).map(
        (event) => {
          return {
            id: event.id,
            start: new Date(event.start),
            end: new Date(event.end),
            title: event.title,
            backgroundColor: "blue",
            textColor: "white",
          };
        }
      );
    }

    calendar = new Calendar(calendarEl, {
      plugins: [
        interactionPlugin,
        dayGridPlugin,
        timeGridPlugin,
        listPlugin,
        googleCalendarPlugin,
      ],
      // googleCalendarId: 'CALENDARID'
      // googleCalendarApiKey: 'CALENDARAPIKEY'
      // contentHeight: 100, //maybe used for small renders
      eventSources: [
        // {
        //   googleCalendarId: 'dantwq90@gmail.com',
        // },
        events,
      ],
      navLinks: true, // can click day/week names to navigate views
      editable: false,
      dayMaxEvents: true, // allow "more" link when too many events
      timeZone: false,
      displayEventTime: true,
      selectMirror: true,
      // events: events,
      themeSystem: "bootstrap",
      eventDidMount: function (data) {
        data.el.setAttribute(
          "href",
          `/coach/lessons/${data.event._def.publicId}`
        );
        // data.el.setAttribute("data-toggle", "tooltip");
        // data.el.setAttribute("data-placement", "top");  
        // data.el.setAttribute("data-original-title", "hello");
        data.el.setAttribute("data-action", "click->lesson#displayShowForm");
        data.el.setAttribute("id", `${data.event._def.publicId}`);
        // const tooltip = new Tooltip(data.el, {
        //   title: data.event.extendedProps.description,
        //   placement: 'top',
        //   trigger: 'hover',
        //   container: 'body'
        // });
        // data.el.setAttribute("aria-describedby", "tooltip");
        // const toolTipDiv = `<div id="tooltip-${data.event._def.publicId}" role="tooltip">My tooltip</div>`
        // const popperInstance = Popper.createPopper(data.el, tooltip, {
        //   modifiers: [
        //     {
        //       name: 'offset',
        //       options: {
        //         offset: [0, 8],
        //       },
        //     },
        //   ],
        // });
        // data.el.setAttribute("data-delay", "");
      },
      loading: function (isLoading) {
        if (isLoading) {
          $(".spinner").show();
        } else {
          $(".spinner").hide();
        }
      },
      dateClick: function (dateClickInfo) {
        $("#newLessonModal").modal("toggle");
        $("#lesson_start_date_time").val(`${dateClickInfo.dateStr}T00:00`);
        $("#lesson_end_date_time").val(`${dateClickInfo.dateStr}T00:00`);
      },
      // eventMouseEnter: function (event, jsEvent, view) {
      //   console.log('mouseneter')
      //   console.log(event)
      //   console.log(typeof(event.event._instance.range.start))
        
    
      //   const htmlString = `<div class='hover-end'>
      //   <p>Title: ${event.event._def.title}
      //   <p>Date/time: ${event.event._instance.range.start} - ${event.event._instance.range.start}</p>
      //   </div>`
      //   const element = document.createElement('div');
      //   element.innerHTML = htmlString;
      //   $(`#${event.event._def.publicId}`).append(element)
      // },
      // eventMouseLeave: function () {
      //   console.log('mouseleave')
      //   $('.hover-end').remove();
      // },
      //     eventClick: function(event) {
      //       const id = (event.event._def.publicId)
      //       $.ajax({
      //       url: `/coach/lessons/${id}`,
      //       type: 'GET',
      //       success: function () {
      //         window.location = `/coach/lessons/${id}`
      //           alert("success");
      //       },
      //       error: function () {
      //           alert('error');
      //       }
      // });
      // },

      // select: loadDate,
      // select: function ({start, end, allDay, view}) {    <== a select date function to popup a modal
      // },
      headerToolbar: {
        //toolbar is required to add the button
        start: "title",
        center: "today prev,next selectDateBtn",
        end: "dayGridMonth,timeGridWeek,timeGridDay,listWeek",
      },
      customButtons: {
        selectDateBtn: {
          text: "Select date",
          click: function () {
            $(".fc-selectDateBtn-button").attr({
              "data-toggle": "collapse",
              href: "#selectDate",
              "aria-expanded": "false",
              "aria-controls": "collapseExample",
            });
            $(".fc-selectDateBtn-button").append($("#selectDate"));
            $("#selectDateInput").on("click", function (e) {
              e.stopPropagation();
            });
            $("#selectDateInput").on("input", function () {
              const date = $("#selectDateInput").val();
              calendar.gotoDate(date);
            });
          },
        },
        // displayGoogleEventsBtn: {
        //   text: "Google",
        //   click: function () {
        //     calendar.addEventSource( googleEvents )
        //   }
        // }
      },
    });
  }
  
};
const clearCalendar = ()=> {
  console.log('clear calendar')
  $('#calendar').html('');
  // location.reload(true);
};

export { loadCalendar, calendar, googleEvents, clearCalendar };
