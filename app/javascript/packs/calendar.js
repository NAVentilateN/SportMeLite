import { Calendar } from '@fullcalendar/core'
import interactionPlugin from '@fullcalendar/interaction'
import dayGridPlugin from '@fullcalendar/daygrid'
import timeGridPlugin from '@fullcalendar/timegrid'
import listPlugin from '@fullcalendar/list'


const calendarEl = document.getElementById('calendar')
let events

if (calendarEl) {
const eventsData = JSON.parse(calendarEl.dataset.events)
events = eventsData.map((data) => {
  const lesson = JSON.parse(data)
    return {
    id: lesson.id,
    start: new Date(lesson.start_date_time),
    end: new Date(lesson.end_date_time),
    title: 'HELLO',
    backgroundColor: lesson.status ? 'green' : 'red',
    textColor: 'white',
    extendedProps: {
      status: lesson.status,
      student_id: lesson.student_id,
      coach_id: lesson.coach_id,
      description: lesson.description
    }}}
)
}
export const calendar = new Calendar(calendarEl, {
  plugins: [interactionPlugin, dayGridPlugin, timeGridPlugin, listPlugin],
  // initialView: 'timeGridWeek',
  // contentHeight: 100, //maybe used for small renders
  navLinks: true, // can click day/week names to navigate views
  editable: false,
  dayMaxEvents: true, // allow "more" link when too many events 
  timeZone: false,
  displayEventTime: true,
  selectMirror: true,
  events: events,
  themeSystem: 'bootstrap',
  eventDidMount: function(data) {
      data.el.setAttribute("href", `/coach/lessons/${data.event._def.publicId}`);
      data.el.setAttribute("data-action", 'click->lesson#displayShowForm');
  },
  loading: function(isLoading){
    if (isLoading) {
        $('.spinner').show();
    }
    else {                
        $('.spinner').hide();
    }
  },
  dateClick: function() {
    $("#newLessonModal").modal('toggle')
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
  // dateClick: function() {
  // $.ajax({
  //   url: '/coach/lessons/new',
  //   type: 'GET',
  //   success: function () {
  //     window.location = '/coach/lessons/new'
  //       alert("success");
  //   },
  //   error: function () {
  //       alert('error');
  //   }
  // })},

  
  // select: loadDate,
  // select: function ({start, end, allDay, view}) {    <== a select date function to popup a modal
  // },
  headerToolbar: { //toolbar is required to add the button
    start: 'today prev,next selectDateBtn',
    center: 'title',
    end: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
  },
  customButtons: {
    selectDateBtn: {
      text: 'Select date',
      click: function() {
        date = moment("2018-01-04", "YYYY-MM-DD");
        $("#calendar").fullCalendar('gotoDate', date);
      }
    }
  },
  // customButtons: { //adding custom buttons for adding date
  //   addEventButton: {
  //     text: 'Add event',
  //     click: function () {
  //       // var dateStr = prompt('Enter a date in YYYY-MM-DD format')
  //       // var date = new Date(dateStr + 'T00:00:00') // will be in local time

  //       // if (!isNaN(date.valueOf())) {
  //       //   // valid?
  //       //   calendar.addEvent({
  //       //     title: 'dynamic event',
  //       //     start: date,
  //       //     allDay: true,
  //       //   })
  //       //   alert('Great. Now, update your database...')
  //       // } else {
  //       //   alert('Invalid date.')
  //       // }
  //       modalForm.open()
  //     },
  //   },
  // },
})

// calendar.on('dateClick', modal.open());


// calendar.events()  //returns all events in an array
//calendar.events().forEach(event => event.remove()) //removes all events in the calendar

//calendar.getEventbyId(id) // find a particular event by id

