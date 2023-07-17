import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        this.startCountdown("weeklyCountdown", this.computeDelay(6, 10), 10);
        this.startCountdown("dailyCountdown", this.computeDailyDelay(18), 18);
    }

    startCountdown(id, delayInDays, good_hour) {
        var now = new Date();
        var eventDate = new Date(now.getFullYear(), now.getMonth(), now.getDate() + delayInDays, good_hour);

        var currentTiime = now.getTime();
        var eventTime = eventDate.getTime();

        var remTime = eventTime - currentTiime;

        var s = Math.floor(remTime / 1000);
        var m = Math.floor(s / 60);
        var h = Math.floor(m / 60);
        var d = Math.floor(h / 24);

        h %= 24;
        m %= 60;
        s %= 60;

        // Manage the condition to ignore higher units if they are zero
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

        if (document.getElementById(id) === null) {
            return;
        }
        document.getElementById(id).textContent = displayText;
        document.getElementById(id).innerText = displayText;

        setTimeout(() => { this.startCountdown(id, delayInDays, good_hour); }, 1000);
    }

    computeDelay(targetDay, targetHour) {
        var now = new Date();
        var delayInDays = (7 + targetDay - now.getDay()) % 7;
        if (delayInDays === 0 && now.getHours() >= targetHour) {
            delayInDays += 7;
        }
        return delayInDays;
    }

    computeDailyDelay(targetHour) {
        var now = new Date();
        var delayInDays = (now.getHours() >= targetHour) ? 1 : 0;
        return delayInDays;
    }
}