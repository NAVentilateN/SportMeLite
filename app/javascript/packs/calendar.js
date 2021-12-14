import { Calendar } from '@fullcalendar/core'
import interactionPlugin from '@fullcalendar/interaction'
import dayGridPlugin from '@fullcalendar/daygrid'
import timeGridPlugin from '@fullcalendar/timegrid'
import listPlugin from '@fullcalendar/list'
import './main.css'
import Modal from './modal'
// import {events} from './events'


// document.addEventListener('DOMContentLoaded', function () {

export function loadCalendar () {
  const modalForm = new Modal("<h3>title</h3><p>info</p>", "modalTest");
  // initializeCalendar();
  const calendarEl = document.getElementById('calendar')


  const loadDate = (event) => {
    alert('a day has been clicked!')
    event.event.setProp('title', 'New title')
    event.event.setExtendedProp('category', 'basketball')
    event.event.setExtendedProp('price', 5)
    event.event.setExtendedProp('student',  ['Me', 'You'])
    // event.event.setExtendedProp({
    //   'category': 'basketball',
    //   'price': 5,
    //   // student: ['Me', 'You'],

    console.log(event.event)
  }

  const eventsData = JSON.parse(calendarEl.dataset.events)
  const events = eventsData.map((data) => {
    const lesson = JSON.parse(data)
      return {
      id: lesson.id,
      start: lesson.start_date_time,
      end: lesson.end_date_time,
      title: 'HELLO',
      eventColor: lesson.status === 'true' ? '#378006' : 'red',
      eventBorderColor: lesson.status === 'true' ? 'black' : 'red',
      extendedProps: {
        location: lesson.location,
        price: lesson.price,
        status: lesson.status,
        student_id: lesson.student_id,
        coach_id: lesson.coach_id,
        description: lesson.description
      }}}
  )

  console.log(events)


  const calendar = new Calendar(calendarEl, {
    plugins: [interactionPlugin, dayGridPlugin, timeGridPlugin, listPlugin],
    // initialView: 'timeGridWeek',
    // contentHeight: 100, //maybe used for small renders
    initialDate: '2021-12-03',
    navLinks: true, // can click day/week names to navigate views
    editable: true,
    dayMaxEvents: true, // allow "more" link when too many events
    // eventColor: '#378006',
    // eventBorderColor: 'black',
    // eventTextColor: 'white',
    events: events,
    displayEventTime: true,
    dateClick: function() {modalForm.open()}, // for clicking on empty date
    eventClick: loadDate,
    // selectable: true,
    selectMirror: true,
    // select: loadDate,
    // select: function ({start, end, allDay, view}) {    <== a select date function to popup a modal
    // },
    headerToolbar: { //toolbar is required to add the button
      start: 'today prev,next addEventButton',
      center: 'title',
      end: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
    },
    customButtons: { //adding custom buttons for adding date
      addEventButton: {
        text: 'Add event',
        click: function () {
          // var dateStr = prompt('Enter a date in YYYY-MM-DD format')
          // var date = new Date(dateStr + 'T00:00:00') // will be in local time

          // if (!isNaN(date.valueOf())) {
          //   // valid?
          //   calendar.addEvent({
          //     title: 'dynamic event',
          //     start: date,
          //     allDay: true,
          //   })
          //   alert('Great. Now, update your database...')
          // } else {
          //   alert('Invalid date.')
          // }
          modalForm.open()
        },
      },
    },
  })

  calendar.render()
  // calendar.on('dateClick', modal.open());
  console.log(calendar.getOption('locale'))

  // calendar.events()  //returns all events in an array
  //calendar.events().forEach(event => event.remove()) //removes all events in the calendar

  //calendar.getEventbyId(id) // find a particular event by id

};
