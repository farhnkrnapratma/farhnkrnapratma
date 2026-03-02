import AppBar from "@mui/material/AppBar";
import Box from "@mui/material/Box";
import Toolbar from "@mui/material/Toolbar";
import Typography from "@mui/material/Typography";
import Container from "@mui/material/Container";
import Button from "@mui/material/Button";
import Avatar from "@mui/material/Avatar";
import LaunchIcon from "@mui/icons-material/Launch";
import TextType from "./TextType";
import ShinyText from "./ShinyText";
import profilePhoto from "../assets/favicon.ico";

const pages: { label: string; href: string; external?: boolean }[] = [
  { label: "Social", href: "/social" },
  { label: "Contact", href: "/contact" },
  { label: "GitHub", href: "https://github.com/farhnkrnapratma", external: true },
  { label: "Blog", href: "/blog" }
];

function ResponsiveAppBar() {
  return (
    <AppBar
      position="static"
      elevation={0}
      sx={{
        backgroundColor: "transparent",
        backdropFilter: "blur(20px)",
        WebkitBackdropFilter: "blur(20px)"
      }}
    >
      <Container maxWidth="xl">
        <Toolbar disableGutters>
          <Avatar
            src={profilePhoto}
            alt="Farhan Kurnia Pratama"
            sx={{ display: { xs: "none", md: "flex" }, mr: 1.5, width: 50, height: "auto" }}
          />
          <Typography
            variant="h6"
            noWrap
            component="a"
            href="https://farhnkrnapratma.dev"
            sx={{
              mr: 2,
              display: { xs: "none", md: "flex" },
              letterSpacing: ".1rem",
              fontWeight: 700,
              fontSize: { xs: "1rem", sm: "1.5rem" },
              color: "inherit",
              textDecoration: "none"
            }}
          >
            <TextType
              text={["Hi there!", "My name is Farhan Kurnia Pratama", "You can call me Farhan"]}
              typingSpeed={100}
              pauseDuration={500}
              showCursor
              cursorCharacter="_"
              deletingSpeed={100}
              variableSpeedEnabled={false}
              variableSpeedMin={100}
              variableSpeedMax={120}
              cursorBlinkDuration={0.5}
            />
          </Typography>
          <Box sx={{ ml: "auto", display: { xs: "none", md: "flex" } }}>
            {pages.map(({ label, href, external }) => (
              <Button
                key={label}
                component="a"
                href={href}
                {...(external && { target: "_blank", rel: "noopener noreferrer" })}
                sx={{
                  my: 2,
                  mr: 4,
                  gap: 0.3,
                  color: "white",
                  display: "flex",
                  textTransform: "none",
                  fontSize: { xs: "0.85rem", sm: "1rem" },
                  fontWeight: 600
                }}
              >
                <ShinyText
                  text={label}
                  speed={2}
                  delay={0}
                  color="#b5b5b5"
                  shineColor="#ffffff"
                  spread={120}
                  direction="left"
                  yoyo={false}
                  pauseOnHover={false}
                  disabled={false}
                />
                {external && <LaunchIcon sx={{ fontSize: "1rem" }} />}
              </Button>
            ))}
          </Box>
        </Toolbar>
      </Container>
    </AppBar>
  );
}

export default ResponsiveAppBar;
