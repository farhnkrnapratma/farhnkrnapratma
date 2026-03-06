import "@fontsource/jetbrains-mono";
import * as React from "react";
import * as ReactDOM from "react-dom/client";
import { StyledEngineProvider } from "@mui/material/styles";
import { ThemeProvider, createTheme } from "@mui/material/styles";
import CssBaseline from "@mui/material/CssBaseline";
import PixelBlast from "./components/PixelBlast";
import ResponsiveAppBar from "./components/ResponsiveAppBar";

function App() {
  const theme = React.useMemo(
    () =>
      createTheme({
        palette: {
          mode: "dark",
        },
        typography: {
          fontFamily: ["'Google Sans'", "sans-serif"].join(","),
        },
      }),
    [],
  );
  return (
    <ThemeProvider theme={theme}>
      <CssBaseline />
      <div
        style={{ width: "100%", height: "100%", position: "fixed", zIndex: -1 }}
      >
        <PixelBlast
          variant="circle"
          pixelSize={4}
          color="#B19EEF"
          patternScale={2}
          patternDensity={1}
          pixelSizeJitter={0}
          enableRipples
          rippleSpeed={0.4}
          rippleThickness={0.12}
          rippleIntensityScale={1.5}
          liquid={false}
          liquidStrength={0.12}
          liquidRadius={1.2}
          liquidWobbleSpeed={5}
          speed={0.5}
          edgeFade={0.25}
          transparent
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
  </React.StrictMode>,
);
