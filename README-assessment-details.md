# Voting App Assessment

This is a simple voting web application built with a Rails API backend and a React frontend. The app lets festival attendees log in, cast votes by selecting from a list of write-in candidates, or add a new candidate. Each email can vote only once and can submit one write-in candidate, automatically casting a vote for the new entry.

## Table of Contents

- [Features](#features)
- [How to Run and Test](#how-to-run-and-test)
- [Problem-Solving Approach](#problem-solving-approach)
- [Future Improvements](#future-improvements)

## Features

- **Sign-In:** Users can sign in by providing an email, password, and zip code. The backend checks if the user exists and creates a new user if not.
- **Voting:** Once logged in, users can vote for an existing candidate or submit a write-in candidate.
- **Incremented Votes:** The system increments the vote count when voting for an already-created candidate.
- **Session Management:** On successful login, the user’s email is stored in the session and is used to display dynamic content (e.g., “Signed in as: user@example.com”).
- **API Endpoints:** The Rails backend provides endpoints for sessions, voters, candidates, and votes, communicating using JSON.
- **React Frontend:** The React app handles routing, form submissions, API calls, and displays basic error messages.

## How to Run and Test

For detailed installation and setup instructions, please see the [Getting Started](README.md#getting-started) section in the main README.

## Problem-Solving and Technical Decisions

- **Rails + React Integration:**  
  The backend is a Rails API that returns JSON responses, while the React frontend handles UI rendering, client-side routing, and service interactions.
- **Session Management:**  
  When a user logs in, their email is stored in the session and passed to the React app. This allows dynamic headers (e.g., “Signed in as: …”) to display the correct user information. The logout endpoint deletes the session and redirects the user to the home page.
- **Vote Handling:**  
  For write‑in candidates, the application performs a case‑insensitive check to determine if the candidate exists. If not, it creates a new candidate (setting the vote count to 1). If the candidate exists, the vote count is incremented. A vote record is then associated with the current voter.
- **Testing:**
  - **Rails:** Uses RSpec along with shoulda-matchers, Faker, and pry-byebug to test models and controllers.
  - **React:** Uses Jest and React Testing Library to test components.
- **Error Handling:**  
  Basic error handling has been implemented on both the backend (returning JSON error responses) and the frontend (displaying user-friendly messages). Future work might enhance this to improve the user experience.
- **Assumptions and Future Improvements:**
  - **Logout:** Although implemented, the logout process would benefit from additional UI feedback and polish.
  - **API Organization:** Future refactoring could move API calls into a dedicated folder in the React codebase.
  - **Normalization:** Enhancing the handling of user-entered candidate names (e.g., addressing typos or omitted initials) could reduce duplicate entries.
  - **Additional Testing:** Expanding test coverage on both the Rails and React sides is planned.
  - **Deployment:** Deploying the app to a platform (e.g., Heroku or Render) for a live demo is a future goal.
  - **Accessibility:** Further improvements will aim to meet full WCAG compliance.

## Future Improvements

- Add a more robust logout mechanism with enhanced UI feedback.
- Organize API calls in a dedicated frontend folder.
- Improve error handling and user notifications.
- Implement advanced normalization and fuzzy matching for write‑in candidate names.
- Write additional tests to increase overall test coverage.
- Deploy the application to a public host.
- Ensure full accessibility compliance (WCAG).

---

This document outlines the frontend and backend logic, key technical decisions, and assumptions made during development. Thank you for reviewing my assessment!
