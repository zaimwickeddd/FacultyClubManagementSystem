<%-- 
    Document   : footer
    Created on : 16 Jan 2026, 4:39:55 pm
    Author     : VICTUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%-- 
    CSS INJECTION: 
    This style block sets the rules for the whole page (body) 
    to ensure the footer always sticks to the bottom.
--%>
<style>
    /* 1. Force the page body to take up at least 100% of the viewport height */
    html, body {
        height: 100%;
        margin: 0;
    }

    /* 2. Turn the body into a flexbox column */
    body {
        display: flex;
        flex-direction: column;
        min-height: 100vh; 
    }

    /* 3. This pushes the footer to the bottom */
    .sticky-footer-wrapper {
        margin-top: auto; 
    }
</style>

<footer class="sticky-footer-wrapper" style="background: white; border-top: 3px solid #000; padding: 20px; text-align: center;">
    <div style="font-weight: 700; letter-spacing: 1px;">
        FACULTY CLUB MANAGEMENT SYSTEM (FCMS)
    </div>
    <p style="font-size: 0.9rem; margin: 5px 0;">&copy; 2026 | UiTM Faculty Club. All Rights Reserved.</p>
    <div style="height: 5px; width: 100px; background: #ff99f1; margin: 10px auto; border: 1px solid #000; border-radius: 5px;"></div>
</footer>