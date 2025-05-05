const images = document.querySelectorAll('.carousel-image');
const buttons = document.querySelectorAll('.carousel-button');

function showImage(index) {
    // Get the URL of the active image
    const activeImageUrl = images[index].getAttribute('src');

    // Update active image
    images.forEach((img, i) => {
        img.classList.toggle('active', i === index);
    });

    buttons.forEach((btn, i) => {
        btn.classList.toggle('active-button', i === index);
    });
}