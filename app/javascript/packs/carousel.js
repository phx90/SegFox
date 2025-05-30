document.addEventListener('DOMContentLoaded', () => {
    document.querySelectorAll('article').forEach(article => {
      const images = article.querySelectorAll('.carousel-image');
      const nextBtn = article.querySelector('.carousel-next');
      const prevBtn = article.querySelector('.carousel-prev');
      let current = 0;
  
      function showImage(idx) {
        images.forEach((img, i) => {
          img.classList.toggle('opacity-100', i === idx);
          img.classList.toggle('z-10', i === idx);
          img.classList.toggle('opacity-0', i !== idx);
          img.classList.toggle('z-0', i !== idx);
        });
      }
  
      if (images.length > 1) {
        nextBtn.addEventListener('click', () => {
          current = (current + 1) % images.length;
          showImage(current);
        });
        prevBtn.addEventListener('click', () => {
          current = (current - 1 + images.length) % images.length;
          showImage(current);
        });
        setInterval(() => {
          current = (current + 1) % images.length;
          showImage(current);
        }, 4000);
      }
    });
  });