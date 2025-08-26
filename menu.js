 // استدعاء الزر والقائمة
  const menuBtn = document.querySelector('.menu-icon'); // أو '.hamburger' حسب HTML
  const menu = document.querySelector('.nav-links'); // أو '#nav-links'

  menuBtn.addEventListener('click', () => {
    menu.classList.toggle('show'); // يضيف أو يزيل كلاس show لإظهار القائمة
  });
