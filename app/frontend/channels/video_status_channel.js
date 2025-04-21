import consumer from "./consumer";
import { showFlash } from "../utils/flash";

consumer.subscriptions.create("VideoStatusChannel", {
  received(data) {
    console.log("📡 Video status update:", data);

    showFlash("Your video is ready!", "notice");
  },
});
