# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready', ->
  if !localStorage.remember_me
    $('#disclaimer').modal
      backdrop:'static'
      keyboard:false


  $('#confirm').on 'click',->
    localStorage.remember_me = $('#remember_me').is ':checked' if $('#remember_me').is ':checked'
    $('#disclaimer').modal('hide')
