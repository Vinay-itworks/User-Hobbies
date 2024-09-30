$(document).ready(function() {
  $('.js-example-basic-multiple').select2({
    placeholder: 'Select an option'
  });
});

var form = $("#new_user");
form.validate({
  rules: {
    "user[first_name]": {
      required: true,
      rangelength: [ 3, 15 ]
    },
    "user[last_name]": {
      required: true,
      rangelength: [ 3, 15 ]
    },
    "user[birthdate]":{
      date: true
    },
    "user[hobbies]": {
      required: true
    }
    
  },

  messages: {
  "user[first_name]": {
    required: " Please enter First Name"
  },
  "user[last_name]": {
    required: " Please enter Last Name"
  },
  "user[birthdate]":{
    date: " Please provide proper date"
    },
  "user[hobbies]": {
    required: " Add at least one hobby"
  }
  }
});