import React, { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
// NOTE: started to implement logout function for voter to sign out and
//re-sign in in cases where the wrong email was used
const Vote = ({ voterEmail, setVoterEmail }) => {
  // State variables to hold candidates, form input, and messages
  const [candidates, setCandidates] = useState([]);
  const [maxCandidates, setMaxCandidates] = useState(null);
  const [selectedCandidateId, setSelectedCandidateId] = useState("");
  const [newCandidateName, setNewCandidateName] = useState("");
  const [message, setMessage] = useState("");
  const [error, setError] = useState("");
  const navigate = useNavigate();

  // Logout handler
  const handleLogout = () => {
    fetch("/api/sessions", {
      method: "DELETE",
      headers: { "Content-Type": "application/json" },
    })
      .then((res) => res.json())
      .then(() => {
        // Clear global state and redirect to home
        setVoterEmail("");
        navigate("/");
      })
      .catch((err) => console.error("Logout error:", err));
  };

  // Fetch initial vote data when component mounts
  useEffect(() => {
    fetch("/api/votes/new")
      .then((res) => res.json())
      .then((data) => {
        if (data.error) {
          setError(data.error);
        } else {
          setCandidates(data.candidates);
          setMaxCandidates(data.max_candidates);
        }
      })
      .catch((err) => setError("Error fetching candidates."));
  }, []);

  // Submit vote - either via a write-in (new candidate) or for an existing candidate
  const handleSubmit = (e) => {
    e.preventDefault();
    setError("");
    setMessage("");

    // If voter enters a new candidate name, submit to /api/candidates
    if (newCandidateName.trim() !== "") {
      fetch("/api/candidates", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ candidate: { name: newCandidateName } }),
      })
        .then((res) =>
          res.json().then((data) => ({ status: res.status, data }))
        )
        .then(({ status, data }) => {
          if (status === 201) {
            setMessage(
              data.message || "Your vote has been successfully recorded!"
            );
          } else {
            setError(data.error || "Failed to cast vote.");
          }
        })
        .catch((err) => setError("Error submitting write-in vote."));
    } else if (selectedCandidateId) {
      // If an existing candidate is selected, submit vote to /api/votes
      fetch("/api/votes", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ vote: { candidate_id: selectedCandidateId } }),
      })
        .then((res) =>
          res.json().then((data) => ({ status: res.status, data }))
        )
        .then(({ status, data }) => {
          if (status === 201) {
            setMessage("Your vote has been successfully recorded!");
          } else {
            setError(data.error || "Failed to cast vote.");
          }
        })
        .catch((err) => setError("Error submitting vote."));
    } else {
      setError(
        "Please select an existing candidate or enter a new candidate name."
      );
    }
  };

  return (
    <div className="page-container">
      <header className="site-header">
        <div className="site-title">VOTEACTBLUE.COM</div>
        <div className="site-logged-in">
          Signed in as: {voterEmail || "Not signed in"}
        </div>

        {/* <button
          onClick={handleLogout}
          className="btn"
          style={{ marginLeft: "1rem" }}
        >
          Logout
        </button> */}
      </header>
      <div className="vote-divider"></div>
      <main>
        <h1 className="mb-4">Cast your vote today!</h1>

        {error && <p className="error-text mb-4">{error}</p>}
        {message && <p className="success-text">{message}</p>}

        <form className="form-section" onSubmit={handleSubmit}>
          <div className="mb-4">
            <h2 className="mb-2">Select a candidate:</h2>
            {candidates.length > 0 ? (
              candidates.map((candidate) => (
                <div
                  key={candidate.id}
                  className="mb-1 flex"
                  style={{ alignItems: "center" }}
                >
                  <input
                    type="radio"
                    id={`candidate-${candidate.id}`}
                    name="candidate"
                    value={candidate.id}
                    onChange={() => setSelectedCandidateId(candidate.id)}
                  />
                  <label htmlFor={`candidate-${candidate.id}`}>
                    {candidate.name}
                  </label>
                </div>
              ))
            ) : (
              <p>No candidates available.</p>
            )}
          </div>

          <div className="mb-4">
            <h2 className="vote-add-new-label">Or add a new candidate:</h2>
            <input
              type="text"
              placeholder="Enter candidate name"
              value={newCandidateName}
              onChange={(e) => setNewCandidateName(e.target.value)}
              className="vote-writein-input"
            />
          </div>

          <button type="submit" className="btn btn-half">
            Vote
          </button>
        </form>
      </main>
    </div>
  );
};

export default Vote;
