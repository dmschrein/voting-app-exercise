import React from "react";
import { render, screen } from "@testing-library/react";
import SignInForm from "../SignInForm";

describe("SignInForm Component", () => {
  test("renders the sign in form", () => {
    render(<SignInForm onSubmit={() => {}} />);
    // Expect the form header or input placeholder, if defined, to be in the document.
    expect(screen.getByLabelText(/Email/i)).toBeInTheDocument();
  });
});
