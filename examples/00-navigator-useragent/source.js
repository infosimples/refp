// Fire a Start Signal for external tracing tools.
document.getElementById('refp-start');

// The Payload: read navigator.userAgent into the result object.
const result = { userAgent: navigator.userAgent };

// Fire an End Signal for external tracing tools.
document.getElementById('refp-end');

// Write the pretty JSON result into the page.
document.getElementById('result').textContent = JSON.stringify(result, null, 2);
