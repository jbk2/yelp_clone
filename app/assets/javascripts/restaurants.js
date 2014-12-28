// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function(){
  $('#js_test').on('click', function(){
    $('h2').text('Hello world');
  })

  $('.new_review').on('submit', function(event){
    event.preventDefault();
    var reviewList = $(this).siblings('ul');
    var currentRestaurant = $(this).parent();

    $.post($(this).attr('action'), $(this).serialize(), function(review){
      var newReview = Mustache.render($('#review_template').html(), review);
      reviewList.append(newReview);
    
    currentRestaurant.find('.review_count').text(review.restaurant.review_count);
    currentRestaurant.find('.average_rating_number').text(review.restaurant.average_rating);
    currentRestaurant.find('.average_rating_stars').text(review.restaurant.average_rating_stars);

    });
  });
});

// below was the code that steve wrote, above Alex'

//     var ulParent = $(this).siblings('ul');
//     console.log(ulParent)

//     $.post($(this).attr('action'), $(this).serialize(), function(response){
//       var template = $('#review_template').html();
//       var rendered = Mustache.render(template, response)
//       ulParent.append(rendered); 
//     }, 'json');
//   })

// })

