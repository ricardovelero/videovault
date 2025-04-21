export function showFlash(message, type = "notice", duration = 4000) {
  const icon =
    {
      notice: `
      <svg class="w-5 h-5 mr-2 flex-shrink-0 text-white" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7" />
      </svg>
    `,
      alert: `
      <svg class="w-5 h-5 mr-2 flex-shrink-0 text-white" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v2m0 4h.01M4.93 4.93l14.14 14.14" />
      </svg>
    `,
    }[type] || "";

  const wrapper = document.createElement("div");
  wrapper.setAttribute("data-controller", "flash");
  wrapper.setAttribute("data-flash-duration-value", duration);
  wrapper.className = `
    fixed top-4 right-4 z-50 px-4 py-3 rounded shadow-lg text-white flex items-center max-w-sm transform
    transition-opacity duration-300 ease-out
    ${type === "alert" ? "bg-red-600" : "bg-green-600"}
  `;
  wrapper.innerHTML = `${icon}<span>${message}</span>`;

  document.body.appendChild(wrapper);
}
