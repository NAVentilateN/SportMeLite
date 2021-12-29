import { Calendar } from "@fullcalendar/core";
import interactionPlugin from "@fullcalendar/interaction";
import dayGridPlugin from "@fullcalendar/daygrid";
import timeGridPlugin from "@fullcalendar/timegrid";
import listPlugin from "@fullcalendar/list";

let calendar;

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

    calendar = new Calendar(calendarEl, {
      plugins: [interactionPlugin, dayGridPlugin, timeGridPlugin, listPlugin],
      // contentHeight: 100, //maybe used for small renders
      navLinks: true, // can click day/week names to navigate views
      editable: false,
      dayMaxEvents: true, // allow "more" link when too many events
      timeZone: false,
      displayEventTime: true,
      selectMirror: true,
      events: events,
      themeSystem: "bootstrap",
      eventDidMount: function (data) {
        data.el.setAttribute(
          "href",
          `/coach/lessons/${data.event._def.publicId}`
        );
        data.el.setAttribute("data-action", "click->lesson#displayShowForm");
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
        start: "today prev,next selectDateBtn",
        center: "title",
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
    calendar.render();
  }
};

export { loadCalendar, calendar };
