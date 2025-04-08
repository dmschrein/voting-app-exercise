// app/javascript/components/Home.jsx
import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import SignInForm from "./SignInForm";

const Home = ({ setVoterEmail }) => {
  const navigate = useNavigate();
  const [error, setError] = useState(null);

  const handleSignIn = (data) => {
    // Transform the submitted data: rename 'zip' to 'zip_code'
    const payload = {
      email: data.email,
      password: data.password,
      zip_code: data.zip,
    };

    fetch("/api/sessions", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(payload),
    })
      .then((res) => {
        if (!res.ok) {
          return res.json().then((errData) => {
            throw new Error(errData.error || "Failed to sign in");
          });
        }
        return res.json();
      })
      .then((result) => {
        console.log("Login successful:", result);
        setVoterEmail(data.email);
        navigate("/vote");
      })
      .catch((err) => {
        console.error(err);
        setError(err.message);
      });
  };

  return (
    <div className="page-container">
      {error && <p className="error-text mb-4">{error}</p>}
      <SignInForm onSubmit={handleSignIn} />
    </div>
  );
};

export default Home;
