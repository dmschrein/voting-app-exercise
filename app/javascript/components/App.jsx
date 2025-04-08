// app/javascript/components/App.jsx
import React, { useState } from "react";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import Home from "./Home";
import Vote from "./Vote";
import "../styles/App.css";

const App = () => {
  const [voterEmail, setVoterEmail] = useState("");
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Home setVoterEmail={setVoterEmail} />} />
        <Route
          path="/vote"
          element={
            <Vote voterEmail={voterEmail} setVoterEmail={setVoterEmail} />
          }
        />
      </Routes>
    </BrowserRouter>
  );
};

export default App;
