import consumer from "./consumer";

const subscription = consumer.subscriptions.create("VideoStatusChannel", {
  received(data) {
    console.log("📡 Video status update:", data);

    const videoElement = document.querySelector(
      `[data-video-id="${data.video_id}"]`
    );
    if (!videoElement) return;

    const statusEl = videoElement.querySelector(".video-status");
    const linkEl = videoElement.querySelector(".video-link");

    if (statusEl) statusEl.textContent = "✅ Ready";
    if (linkEl && data.file_url) {
      linkEl.href = data.file_url;
      linkEl.style.display = "inline-block";
    }
  },
});
