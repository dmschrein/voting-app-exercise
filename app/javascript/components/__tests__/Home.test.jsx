import React from "react";
import { render, screen, fireEvent } from "@testing-library/react";
import Home from "../Home";
import { BrowserRouter } from "react-router-dom";

// A simple wrapper to provide Router context
const renderWithRouter = (component) => {
  return render(<BrowserRouter>{component}</BrowserRouter>);
};

test("renders sign in form", () => {
  renderWithRouter(<Home />);
  expect(screen.getByText(/Sign in to Vote/i)).toBeInTheDocument();
});
