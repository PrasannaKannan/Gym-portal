const navToggle = document.querySelector('.nav-toggle');
const nav = document.querySelector('.site-nav');

if (navToggle && nav) {
  navToggle.addEventListener('click', () => {
    const isOpen = nav.getAttribute('data-open') === 'true';
    nav.setAttribute('data-open', String(!isOpen));
    nav.style.display = isOpen ? 'none' : 'flex';
  });
}
