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

        total_duration = diff / 60;
        return total_duration;
      }
      return '';
    }

      async function submitToGoogle() {
        const status = document.getElementById('status');
        const btn = event.target; // Identify the clicked button
      
        // Capture name and capitalize 
        const rawName = document.getElementById('worker-name').value;
        const capitalizedName = rawName.toUpperCase().trim();

        // Caotyre umu-id and lower case
        const rawUmU = document.getElementById('umu').value;
        const lowercaseUmU = rawUmU.toLowerCase().trim();
      
        const payload = {
          name: capitalizedName,
          umu: lowercaseUmU,
          role: document.getElementById('barlag').value, 
          date: document.getElementById('work-date').value,
          start: document.getElementById('start').value,
          end: document.getElementById('end').value,
          duration: calculate()
        };
      
        if (!payload.name || !payload.date || !payload.start || !payload.role) {
          alert('Please fill in Name, Barlag, and Times!'); 
          return;
        }
      
        // --- ANIMATION LOGIC ---
        status.innerText = 'Sending to Origo... 🚀'; 
        btn.classList.add('submitting');
        btn.disabled = true;
        btn.innerText = 'Submitting...';
      
        try {
          await fetch(sheetUrl, {
            method: 'POST',
            mode: 'no-cors', 
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(payload)
          }); 
      
          status.innerText = '✅ Hours submitted successfully!'; 
          btn.classList.remove('submitting');

          btn.disabled = false;
          btn.innerText = 'Submit Hours';
          btn.style.background = '#28a745'; // Turn green on success

          setTimeout(() => {
            btn.style.background = '#007bff';
            status.innerText = ''; // Clears the success message
          }, 3000);
          
          document.getElementById('worker-name').value = '';
        } catch (error) {
          status.innerText = '❌ Error submitting. Try again.'; 
          btn.classList.remove('submitting');
          btn.disabled = false;
          btn.innerText = 'Submit Hours';
        }
      }
  ")
}