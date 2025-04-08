import React, { useState } from "react";

/* Voter must login to get to vote
 * form requires: email address, (fake) password, and zip code
 */
function SignInForm({ onSubmit }) {
  const [formData, setFormData] = useState({
    email: "",
    password: "",
    zip: "",
  });

  const [error, setError] = useState("");

  // Handle input changes
  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData((prevData) => ({
      ...prevData,
      [name]: value,
    }));
    setError(""); // Clear error when voter starts typing
  };

  // Handle form submission
  const handleSubmit = (e) => {
    e.preventDefault();

    // Basic validation: ensure all fields are filled
    if (!formData.email || !formData.password || !formData.zip) {
      setError("Please fill out all fields.");
      return;
    }

    // Call the parent callback with the form data
    onSubmit(formData);
  };

  return (
    <form onSubmit={handleSubmit} className="form-section">
      <h2>Sign in to Vote</h2>
      <div className="form-field">
        <label htmlFor="email">Email</label>
        <input
          type="email"
          id="email"
          name="email"
          value={formData.email}
          onChange={handleChange}
          placeholder="you@example.com"
        />
      </div>

      <div className="form-field">
        <label htmlFor="password">Password</label>
        <input
          type="password"
          id="password"
          name="password"
          value={formData.password}
          onChange={handleChange}
          placeholder="Your password"
        />
      </div>

      <div className="form-field">
        <label htmlFor="zip">Zip Code</label>
        <input
          type="text"
          id="zip"
          name="zip"
          value={formData.zip}
          onChange={handleChange}
          placeholder="e.g. 12345"
        />
      </div>

      {error && <p className="error-text">{error}</p>}

      <button type="submit" className="btn btn-half">
        Sign in
      </button>
    </form>
  );
}

export default SignInForm;
