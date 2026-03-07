import AppBar from "@mui/material/AppBar";
import Box from "@mui/material/Box";
import Toolbar from "@mui/material/Toolbar";
import Typography from "@mui/material/Typography";
import Container from "@mui/material/Container";
import Button from "@mui/material/Button";
import Avatar from "@mui/material/Avatar";
import LaunchIcon from "@mui/icons-material/Launch";
import TextType from "./TextType";
import profilePhoto from "../assets/favicon.ico";

const pages: { label: string; href: string; external?: boolean }[] = [
  { label: "Social", href: "/social" },
  { label: "Contact", href: "/contact" },
  {
    label: "GitHub",
    href: "https://github.com/farhnkrnapratma",
    external: true,
  },
  { label: "Blog", href: "/blog" },
  { label: "Feed", href: "/feed" },
  { label: "Donate", href: "/donate" },
];

function ResponsiveAppBar() {
  return (
    <AppBar
      position="static"
      elevation={0}
      color="inherit"
      sx={{
        backgroundColor: "transparent",
        backdropFilter: "blur(10px)",
        WebkitBackdropFilter: "blur(10px)",
      }}
    >
      <Container maxWidth="xl">
        <Toolbar disableGutters>
          <Avatar
            src={profilePhoto}
            alt="Farhan Kurnia Pratama"
            sx={{
              display: { xs: "none", md: "flex" },
              mr: 1.5,
              width: 35,
              height: "auto",
            }}
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
              fontWeight: 200,
              fontSize: { xs: "1rem", sm: "1.5rem" },
              color: "inherit",
              textDecoration: "none",
            }}
          >
            <TextType
              text={[
                "Hello!",
                "Hi there!",
                "How's it going?",
                "What's up?",
                "How are you?",
                "How are you today?",
                "How was your day?",
                "How was the weather?",
                "What's going on?",
                "What's on your mind?",
                "How can I help you today?",
                "Ready to get started?",
              ]}
              typingSpeed={90}
              showCursor
              cursorCharacter="_"
              cursorBlinkDuration={0.5}
              deletingSpeed={60}
              pauseDuration={5000}
            />
          </Typography>
          <Box sx={{ ml: "auto", display: { xs: "none", md: "flex" } }}>
            {pages.map(({ label, href, external }) => (
              <Button
                key={label}
                component="a"
                href={href}
                {...(external && {
                  target: "_blank",
                  rel: "noopener noreferrer",
                })}
                sx={{
                  my: 2,
                  mr: 2,
                  gap: 0.3,
                  color: "inherit",
                  display: "flex",
                  textTransform: "none",
                  fontSize: { xs: "0.85rem", sm: "1rem" },
                  fontWeight: 300,
                }}
              >
                {label}
                {external && (
                  <LaunchIcon sx={{ fontSize: "1rem", opacity: 0.5 }} />
                )}
              </Button>
            ))}
          </Box>
        </Toolbar>
      </Container>
    </AppBar>
  );
}

export default ResponsiveAppBar;
