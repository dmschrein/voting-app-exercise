import React from "react";
import { act, render, screen } from "@testing-library/react";
import Vote from "../Vote";
import { BrowserRouter } from "react-router-dom";

const renderWithRouter = (ui) => render(<BrowserRouter>{ui}</BrowserRouter>);

describe("Vote Component", () => {
  test("Vote Component renders without crashing", async () => {
    await act(async () => {
      render(
        <BrowserRouter>
          <Vote voterEmail="test@example.com" setVoterEmail={() => {}} />
        </BrowserRouter>
      );
    });
    // now assert something in the UI, perhaps:
    expect(screen.getByText(/Cast your vote today!/i)).toBeInTheDocument();
  });
});
