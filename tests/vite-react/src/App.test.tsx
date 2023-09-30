import { it, describe, expect } from "vitest";
import { render, screen } from "@testing-library/react";

import App from "./App";

describe("App", () => {
  it("Hello", async () => {
    render(<App />);

    const headline = await screen.findByTestId("hello");

    expect(headline).toBeInTheDocument();

    expect(headline).toHaveTextContent("Hello, vite-react!");
  });
});
