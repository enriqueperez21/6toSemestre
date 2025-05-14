$(function() {
    var image = $("img");
    var canvas = image_to_canvas(image);
    $("#harry").hover(function(){
        draw_circle(canvas, 76, 80, 40);
    }, function() {
        reset_image(canvas, image);
    });
});

var image_to_canvas = function(image) {
    canvas = $("<canvas>").addClass('image');
    canvas[0].height = image.height();
    canvas[0].width= image.width();
    reset_image(canvas, image);
    image.replaceWith(canvas);
    return canvas
}

var draw_circle = function(canvas, cx, cy, r) {
    var ctx = canvas[0].getContext("2d");
    ctx.beginPath();
    ctx.strokeStyle = "red";
    ctx.lineWidth = 5;
    ctx.arc(cx, cy, r, 0, 2 * Math.PI, true);
    ctx.stroke();
}

var reset_image = function(canvas, image) {
    canvas[0].getContext("2d").drawImage(image[0], 0, 0);
}
