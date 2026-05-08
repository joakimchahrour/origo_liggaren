#let google_script(url) = {
  html.elem("script", "
    const sheetUrl = '" + url + "';

    // 1. Auto-fill the date when the page loads
    window.onload = function() {
      const today = new Date().toISOString().split('T')[0];
      const dateInput = document.getElementById('work-date');
      if (dateInput) {
        dateInput.value = today;
      }
    };

    function calculate() {
      const start = document.getElementById('start').value;
      const end = document.getElementById('end').value;
      const resultSpan = document.getElementById('result');
      
      if (start && end) {
        const [sH, sM] = start.split(':').map(Number);
        const [eH, eM] = end.split(':').map(Number);
        let diff = (eH * 60 + eM) - (sH * 60 + sM);
        
        if (diff < 0) diff += 1440; // Handles shifts passing midnight
        
        const hours = Math.floor(diff/60);
        const mins = diff % 60;
        const timeString = hours + 'h ' + mins + 'm';
        
        resultSpan.innerText = timeString;
        return timeString;
      }
      return '';
    }

    async function submitToGoogle() {
      const status = document.getElementById('status');
      
      // 2. Capture and Capitalize the name automatically
      const rawName = document.getElementById('worker-name').value;
      const capitalizedName = rawName.toUpperCase().trim();

      const payload = {
        name: capitalizedName,
        role: document.getElementById('barlag').value, 
        date: document.getElementById('work-date').value,
        start: document.getElementById('start').value,
        end: document.getElementById('end').value,
        duration: calculate()
      };

      // Validation
      if (!payload.name || !payload.date || !payload.start || !payload.role) {
        alert('Please fill in Name, Barlag, and Times!');
        return;
      }

      status.innerText = 'Submitting...';

      try {
        await fetch(sheetUrl, {
          method: 'POST',
          mode: 'no-cors', 
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(payload)
        });
        status.innerText = '✅ Hours submitted successfully!';
        // Optional: Clear name after success so the next person starts fresh
        document.getElementById('worker-name').value = '';
      } catch (error) {
        status.innerText = '❌ Error submitting. Try again.';
      }
    }
  ")
}
