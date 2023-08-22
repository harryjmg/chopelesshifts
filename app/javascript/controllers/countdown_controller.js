import { Controller } from "@hotwired/stimulus"


export default class extends Controller {
    isPublishing = { daily: false, weekly: false };

    startCountdown(id, type) {
        var now = new Date();
        var eventDate;

        if (type === "daily") {
            eventDate = new Date(now.getFullYear(), now.getMonth(), now.getDate(), now.getHours() + 1, 0, 0);
        } else if (type === "weekly") {
            eventDate = new Date(now.getFullYear(), now.getMonth(), now.getDate(), 10, 0, 0);
            var delayInDays = (7 + 6 - now.getDay()) % 7; // Targeting Saturday
            eventDate.setDate(eventDate.getDate() + delayInDays);
        }

        var currentTime = now.getTime();
        var eventTime = eventDate.getTime();
        var remTime = eventTime - currentTime;

        if (remTime <= 0) {
            if (!this.isPublishing[type]) {
                this.isPublishing[type] = true;
                setTimeout(() => { this.isPublishing[type] = false; }, 60 * 1000);
            }
        }

        if (this.isPublishing[type]) {
            document.getElementById(id).textContent = "maintenant !";
            document.getElementById(id).innerText = "maintenant !";
        } else {
            var s = Math.floor(remTime / 1000);
            var m = Math.floor(s / 60);
            var h = Math.floor(m / 60);
            var d = Math.floor(h / 24);
    
            h %= 24;
            m %= 60;
            s %= 60;
    
            var displayText = '';
            if (d > 0) {
                displayText = d + "j " + h + "h " + m + "m et " + s + "s";
            } else if (h > 0) {
                displayText = h + "h " + m + "m et " + s + "s";
            } else if (m > 0) {
                displayText = m + "m et " + s + "s";
            } else {
                displayText = s + "s";
            }
    
            document.getElementById(id).textContent = displayText;
            document.getElementById(id).innerText = displayText;
        }

        setTimeout(() => { this.startCountdown(id, type); }, 1000);
    }

    connect() {
        this.startCountdown("dailyCountdown", "daily");
        this.startCountdown("weeklyCountdown", "weekly");
    }
}
