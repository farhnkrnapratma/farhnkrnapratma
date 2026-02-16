import * as React from "react";
import * as ReactDOM from "react-dom/client";
import { StyledEngineProvider } from "@mui/material/styles";
import Alert from "@mui/material/Alert";
import AlertTitle from "@mui/material/AlertTitle";
import Box from "@mui/material/Box";
import { ThemeProvider, createTheme } from "@mui/material/styles";
import CssBaseline from "@mui/material/CssBaseline";
import LiquidEther from "./LiquidEther";

function App() {
  const theme = React.useMemo(
    () =>
      createTheme({
        palette: {
          mode: "dark",
        },
        typography: {
          fontFamily: [
            '"JetBrains Mono"',
            'monospace',
            '-apple-system',
            'BlinkMacSystemFont',
            '"Segoe UI"',
            'Arial',
            'sans-serif',
          ].join(','),
        },
      }),
    [],
  );

  return (
    <ThemeProvider theme={theme}>
      <CssBaseline />
      <LiquidEther
        style={{
          position: "fixed",
          top: 0,
          left: 0,
          width: "100%",
          height: "100%",
          zIndex: -1,
        }}
        colors={["#5227FF", "#FF9FFC", "#B19EEF"]}
        autoDemo={true}
        autoSpeed={0.5}
        autoIntensity={2.2}
      />
      <Box
        sx={{
          display: "flex",
          justifyContent: "center",
          alignItems: "center",
          minHeight: "100vh",
          padding: 2,
        }}
      >
        <Alert
          severity="info"
          sx={{
            maxWidth: 700,
            width: "100%",
            alignItems: "center",
            backgroundColor: "rgba(255, 255, 255, 0.1)",
            backdropFilter: "blur(20px)",
            WebkitBackdropFilter: "blur(20px)",
            border: "1px solid rgba(255, 255, 255, 0.2)",
            borderRadius: 3,
            "& .MuiAlert-icon": {
              fontSize: "5rem",
              marginRight: 3,
              marginTop: 1,
              marginBottom: 1,
            },
          }}
        >
          <AlertTitle sx={{ fontSize: "1.8rem", fontWeight: 600 }}>
            Site Under Development
          </AlertTitle>
          <Box sx={{ fontSize: "1.3rem", fontWeight: 400 }}>
            This website is currently under development.
            <br />
            Thank you for your patience!
          </Box>
        </Alert>
      </Box>
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
