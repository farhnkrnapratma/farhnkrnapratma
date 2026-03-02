import "@fontsource/jetbrains-mono";
import * as React from "react";
import * as ReactDOM from "react-dom/client";
import { StyledEngineProvider } from "@mui/material/styles";
import { ThemeProvider, createTheme } from "@mui/material/styles";
import CssBaseline from "@mui/material/CssBaseline";
import DarkVeil from "./components/DarkVeil";
import ResponsiveAppBar from "./components/ResponsiveAppBar";

function App() {
  const theme = React.useMemo(
    () =>
      createTheme({
        palette: {
          mode: "dark"
        },
        typography: {
          fontFamily: ['"JetBrains Mono"', "monospace"].join(",")
        }
      }),
    []
  );

  return (
    <ThemeProvider theme={theme}>
      <CssBaseline />
      <div style={{ width: "100%", height: "100%", position: "fixed", zIndex: -1 }}>
        <DarkVeil
          hueShift={0}
          noiseIntensity={0}
          scanlineIntensity={0}
          speed={0.5}
          scanlineFrequency={0}
          warpAmount={0}
        />
      </div>
      <ResponsiveAppBar />
    </ThemeProvider>
  );
}

ReactDOM.createRoot(document.querySelector("#root")!).render(
  <React.StrictMode>
    <StyledEngineProvider injectFirst>
      <App />
    </StyledEngineProvider>
  </React.StrictMode>
);
