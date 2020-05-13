// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

import "bootstrap";
// import "components/index";
import $ from 'jquery';
global.$ = jQuery;

import "controllers"
import Rails from '@rails/ujs';

import { previewImageOnFileSelect } from 'components/photo_preview';

// import '../components/previewImageOnFileSelect';

document.addEventListener("turbolinks:load", function() {
  $(document).click(function(e) {
    if (!$(e.target).is('.panel-body') && !$(e.target).closest('.panel-body').length) {
        $('.collapse').collapse('hide');
      }
  });

  $(document).ready(function () {
      $('#sidebarCollapse').on('click', function () {
          $('#sidebar').toggleClass('active');
          $('#dismiss').addClass('active');
          $('.content').addClass('active');
          $('.overlay').addClass('active');
          $('#sidebarCollapse').addClass('active');
      });


      $('#dismiss, .overlay').on('click', function () {
          // hide sidebar
          $('#sidebar').removeClass('active');
          $('.content').removeClass('active');
          // hide overlay
          $('#dismiss').removeClass('active');
          // hide overlay
          $('.overlay').removeClass('active');
          $('#sidebarCollapse').removeClass('active');
      });
  });
})

$(function () {
  $('[data-toggle="tooltip"]').tooltip()
})






