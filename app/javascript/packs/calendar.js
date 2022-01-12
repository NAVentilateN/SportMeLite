import { Calendar } from "@fullcalendar/core";
import interactionPlugin from "@fullcalendar/interaction";
import dayGridPlugin from "@fullcalendar/daygrid";
import timeGridPlugin from "@fullcalendar/timegrid";
import listPlugin from "@fullcalendar/list";
import googleCalendarPlugin from "@fullcalendar/google-calendar";

let calendar;
let googleEvents;

const loadCalendar = () => {
  const calendarEl = document.getElementById("calendar");

  if (calendarEl) {
    const eventsData = JSON.parse(calendarEl.dataset.events);
    const events = eventsData.map((data) => {
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
      // contentHeight: 100, //maybe used for small renders
      eventSources: [events],
      navLinks: true, // can click day/week names to navigate views
      editable: false,
      dayMaxEvents: true, // allow "more" link when too many events
      timeZone: false,
      displayEventTime: true,
      selectMirror: true,
      themeSystem: "bootstrap",
      eventDidMount: function (data) {
        data.el.setAttribute(
          "href",
          `/coach/lessons/${data.event._def.publicId}`
        );
        data.el.setAttribute("data-action", "click->lesson#displayShowForm");
        data.el.setAttribute("id", `${data.event._def.publicId}`);
        if (data.view.type === "dayGridMonth") {
          const startTime = data.event._instance.range.start.toLocaleString(
            "en-SG",
            {
              hour: "2-digit",
              minute: "2-digit",
              hour12: true,
              timeZone: "UTC",
            }
          );
          const endTime = data.event._instance.range.end.toLocaleString(
            "en-SG",
            {
              hour: "2-digit",
              minute: "2-digit",
              hour12: true,
              timeZone: "UTC",
            }
          );
          $(data.el).tooltip({
            title: `Title: ${data.event.title}\nTime: ${startTime} - ${endTime}`,
            container: "body",
            delay: { show: 50, hide: 50 },
          });
        }
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

      headerToolbar: {
        start: "title",
        end: "today prev,next selectDateBtn",
      },

      footerToolbar: {
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
      },
    });
  }
};

const clearCalendar = () => {
  $("#calendar").html("");
};

export { loadCalendar, calendar, googleEvents, clearCalendar };
