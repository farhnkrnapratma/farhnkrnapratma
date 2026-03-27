#!/usr/bin/env bash
set -euo pipefail

# =============================================================================
# build-blog.sh — Convert Markdown to HTML pages + RSS feed
# =============================================================================

# -- Configuration -------------------------------------------------------------

SITE_URL="https://fkp.my.id"
SITE_TITLE="Farhan Kurnia Pratama | Blog"
SITE_DESCRIPTION="The official blog website of Farhan Kurnia Pratama | Email: contact@fkp.my.id"
SITE_AUTHOR="Farhan Kurnia Pratama"
SITE_EMAIL="contact@fkp.my.id"
SITE_LANGUAGE="en-US"
SITE_COPYRIGHT="Copyright $(date +%Y) Farhan Kurnia Pratama"

# Direktori sumber & output (disesuaikan untuk Bun di /src)
SRC_DIR="./src/blog/write"
OUTPUT_DIR="./src"
BLOG_DIR="${OUTPUT_DIR}/blog"
RSS_FILE="${OUTPUT_DIR}/rss.xml"
INDEX_FILE="${BLOG_DIR}/index.html"

MAX_RSS_ITEMS=20

# -- Dependency Check ----------------------------------------------------------

check_deps() {
  local missing=()

  for cmd in pandoc sed awk date; do
    command -v "$cmd" &> /dev/null || missing+=("$cmd")
  done

  if [[ ${#missing[@]} -gt 0 ]]; then
    echo "[ERROR] Missing required tools: ${missing[*]}" >&2
    [[ " ${missing[*]} " == *" pandoc "* ]] \
      && echo "[ERROR] Install pandoc: https://pandoc.org/installing.html" >&2
    exit 1
  fi
}

# -- Frontmatter Parsing -------------------------------------------------------

get_frontmatter() {
  local key="$1"
  local file="$2"
  awk "
    /^---/{count++; next}
    count == 1 && /^${key}:/ {
      sub(/^${key}:[[:space:]]*/, \"\")
      gsub(/^\"|\"$/, \"\")
      gsub(/^'|'$/, \"\")
      print
      exit
    }
    count >= 2 { exit }
  " "$file"
}

get_body() {
  local file="$1"
  awk '
    /^---/{ count++; next }
    count >= 2 { print }
  ' "$file"
}

# -- Markdown Converter --------------------------------------------------------

md_to_html() {
  local input="$1"
  echo "$input" | pandoc \
    --from markdown \
    --to html \
    --no-highlight
}

xml_escape() {
  echo "$1" \
    | sed \
      -e 's/&/\&amp;/g' \
      -e 's/</\&lt;/g' \
      -e 's/>/\&gt;/g' \
      -e 's/"/\&quot;/g' \
      -e "s/'/\&apos;/g"
}

to_rfc822() {
  local raw="$1"
  if date --version &> /dev/null 2>&1; then
    date -d "$raw" '+%a, %d %b %Y 00:00:00 +0000'
  else
    date -jf '%Y-%m-%d' "$raw" '+%a, %d %b %Y 00:00:00 +0000'
  fi
}

# -- HTML Templates ------------------------------------------------------------

html_post() {
  local title="$1"
  local date_str="$2"
  local description="$3"
  local url="$4"
  local content="$5"

  cat << HTML
<!doctype html>
<html lang="en" translate="no">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>${title} | ${SITE_AUTHOR}</title>
  <meta name="description" content="${description}" />
  <link rel="canonical" href="${url}" />
  <meta property="og:title" content="${title} | ${SITE_AUTHOR}" />
  <meta property="og:description" content="${description}" />
  <meta property="og:type" content="article" />
  <meta property="og:url" content="${url}" />
  <meta property="og:site_name" content="fkp.my.id" />
  <meta property="og:image" content="https://fkp.my.id/banner-blog.png" />
  <meta property="og:image:secure_url" content="https://fkp.my.id/banner-blog.png" />
  <meta property="og:image:type" content="image/png" />
  <meta property="og:image:width" content="1280" />
  <meta property="og:image:height" content="640" />
  <meta property="og:image:alt" content="Banner for Farhan Kurnia Pratama Official Website" />
  <meta property="og:locale" content="en_US" />
  <meta property="og:locale:alternate" content="id_ID" />
  <meta property="profile:first_name" content="Farhan Kurnia" />
  <meta property="profile:last_name" content="Pratama" />
  <meta property="profile:username" content="farhnkrnapratma" />
  <meta property="profile:gender" content="male" />
  <meta property="article:published_time" content="${date_str}" />
  <meta property="article:author" content="${SITE_AUTHOR}" />
  <meta name="twitter:card" content="summary_large_image" />
  <meta name="twitter:title" content="${title} | ${SITE_AUTHOR}" />
  <meta name="twitter:description" content="${description}" />
  <meta name="twitter:image" content="https://fkp.my.id/banner-blog.png" />
  <link rel="icon" href="../../../../assets/favicon.ico" />
  <link rel="apple-touch-icon" sizes="180x180" href="../../../../assets/apple-touch-icon.png" />
  <link rel="icon" type="image/png" sizes="32x32" href="../../../../assets/favicon-32x32.png" />
  <link rel="icon" type="image/png" sizes="16x16" href="../../../../assets/favicon-16x16.png" />
  <link rel="manifest" href="../../../../assets/site.webmanifest" />
  <link rel="alternate" type="application/rss+xml" title="${SITE_TITLE}" href="${SITE_URL}/rss.xml" />
  <link rel="stylesheet" href="tailwindcss" />
  <link rel="stylesheet" href="../../../../global.css" />
</head>
<body class="grid md:grid-cols-[25vw_50vw_25vw] gird-cols-1 grid-rows-[10vh_auto_10vh] bg-gvd-fg0 text-gvd-bg1 dark:bg-gvd-bg dark:text-gvd-fg1">
  <nav class="md:col-start-2 col-start-auto row-start-1 w-full h-full gap-[1.5vw] inline-flex items-center justify-center font-thin *:link-hover *:pl-[1vw] *:pr-[1vw]">
    <a href="/">home</a>
    <a href="https://fkp.my.id/#support">support</a>
    <a href="https://fkp.my.id/#contact">contact</a>
    <a href="/blog" class="link-active">blog</a>
    <a href="https://fkp.my.id/rss.xml" download>rss</a>
  </nav>
  <main class="md:col-start-2 col-start-auto row-start-2 pl-4 pr-4">
    <article>
      <header>
        <div class="text-4xl">${title}</div>
        <time datetime="${date_str}">${date_str}</time>
      </header>
      <section>
        ${content}
      </section>
    </article>
  </main>
  <footer class="md:col-start-2 col-start-auto row-start-3 h-full w-full flex items-center justify-center">
    <p class="text-center">
      Made with ♥️ &
      <a class="link-hover" href="https://tailwindcss.com">Tailwind</a>
    </p>
  </footer>
</body>
</html>
HTML
}

html_index() {
  local items="$1"

  cat << HTML
<!doctype html>
<html lang="en" translate="no">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>${SITE_TITLE}</title>
  <meta name="description" content="${SITE_DESCRIPTION}" />
  <link rel="canonical" href="${SITE_URL}/blog" />
  <meta property="og:title" content="${SITE_TITLE}" />
  <meta property="og:description" content="${SITE_DESCRIPTION}" />
  <meta property="og:type" content="website" />
  <meta property="og:url" content="${SITE_URL}/blog" />
  <meta property="og:site_name" content="fkp.my.id" />
  <meta property="og:image" content="https://fkp.my.id/banner-blog.png" />
  <meta property="og:image:secure_url" content="https://fkp.my.id/banner-blog.png" />
  <meta property="og:image:type" content="image/png" />
  <meta property="og:image:width" content="1280" />
  <meta property="og:image:height" content="640" />
  <meta property="og:image:alt" content="Banner for Farhan Kurnia Pratama Official Website" />
  <meta property="og:locale" content="en_US" />
  <meta property="og:locale:alternate" content="id_ID" />
  <meta property="profile:first_name" content="Farhan Kurnia" />
  <meta property="profile:last_name" content="Pratama" />
  <meta property="profile:username" content="farhnkrnapratma" />
  <meta property="profile:gender" content="male" />
  <meta name="twitter:card" content="summary_large_image" />
  <meta name="twitter:title" content="${SITE_TITLE}" />
  <meta name="twitter:description" content="${SITE_DESCRIPTION}" />
  <meta name="twitter:image" content="https://fkp.my.id/banner-blog.png" />
  <link rel="icon" href="../assets/favicon.ico" />
  <link rel="apple-touch-icon" sizes="180x180" href="../assets/apple-touch-icon.png" />
  <link rel="icon" type="image/png" sizes="32x32" href="../assets/favicon-32x32.png" />
  <link rel="icon" type="image/png" sizes="16x16" href="../assets/favicon-16x16.png" />
  <link rel="manifest" href="../assets/site.webmanifest" />
  <link rel="alternate" type="application/rss+xml" title="${SITE_TITLE}" href="${SITE_URL}/rss.xml" />
  <link rel="stylesheet" href="tailwindcss" />
  <link rel="stylesheet" href="../global.css" />
</head>
<body class="grid md:grid-cols-[25vw_50vw_25vw] gird-cols-1 grid-rows-[10vh_auto_10vh] bg-gvd-fg0 text-gvd-bg1 dark:bg-gvd-bg dark:text-gvd-fg1">
  <nav class="md:col-start-2 col-start-auto row-start-1 w-full h-full gap-[1.5vw] inline-flex items-center justify-center font-thin *:link-hover *:pl-[1vw] *:pr-[1vw]">
    <a href="/">home</a>
    <a href="https://fkp.my.id/#support">support</a>
    <a href="https://fkp.my.id/#contact">contact</a>
    <a href="/blog" class="link-active">blog</a>
    <a href="https://fkp.my.id/rss.xml" download>rss</a>
  </nav>
  <main class="md:col-start-2 col-start-auto row-start-2 pl-4 pr-4">
    <div class="text-lg">Blog</div>
    <ul>
      ${items}
    </ul>
  </main>
  <footer class="md:col-start-2 col-start-auto row-start-3 h-full w-full flex items-center justify-center">
    <p class="text-center">
      Made with ♥️ &
      <a class="link-hover" href="https://tailwindcss.com">Tailwind</a>
    </p>
  </footer>
</body>
</html>
HTML
}

# -- RSS Builder ---------------------------------------------------------------

rss_open() {
  local build_date
  build_date=$(date '+%a, %d %b %Y %H:%M:%S +0000')

  cat << XML
<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0"
  xmlns:atom="http://www.w3.org/2005/Atom"
  xmlns:content="http://purl.org/rss/1.0/modules/content/"
  xmlns:dc="http://purl.org/dc/elements/1.1/">
  <channel>
    <title>$(xml_escape "$SITE_TITLE")</title>
    <link>${SITE_URL}/blog</link>
    <description>$(xml_escape "$SITE_DESCRIPTION")</description>
    <language>${SITE_LANGUAGE}</language>
    <copyright>$(xml_escape "$SITE_COPYRIGHT")</copyright>
    <lastBuildDate>${build_date}</lastBuildDate>
    <managingEditor>$(xml_escape "${SITE_EMAIL} (${SITE_AUTHOR})")</managingEditor>
    <atom:link href="${SITE_URL}/rss.xml" rel="self" type="application/rss+xml" />
XML
}

rss_item() {
  local title="$1"
  local url="$2"
  local description="$3"
  local pub_date="$4"
  local content="$5"
  local author="$6"

  cat << XML
    <item>
      <title>$(xml_escape "$title")</title>
      <link>${url}</link>
      <guid isPermaLink="true">${url}</guid>
      <description>$(xml_escape "$description")</description>
      <content:encoded><![CDATA[${content}]]></content:encoded>
      <pubDate>${pub_date}</pubDate>
      <dc:creator>$(xml_escape "$author")</dc:creator>
    </item>
XML
}

rss_close() {
  cat << XML
  </channel>
</rss>
XML
}

# -- Main Build ----------------------------------------------------------------

main() {
  check_deps

  if [[ ! -d "$SRC_DIR" ]]; then
    echo "[ERROR] Posts directory not found: ${SRC_DIR}" >&2
    echo "[INFO] Creating ${SRC_DIR} for you..."
    mkdir -p "$SRC_DIR"
    exit 1
  fi

  echo "[INFO] Starting build -- source: ${SRC_DIR}, output: ${OUTPUT_DIR}"

  local rss_items=""
  local index_items=""
  local rss_count=0

  local post_files=()
  while IFS= read -r -d '' file; do
    post_files+=("$file")
  done < <(find "$SRC_DIR" -maxdepth 1 -name "*.md" -print0)

  if [[ ${#post_files[@]} -eq 0 ]]; then
    echo "[WARN] No markdown files found in ${SRC_DIR}"
    exit 0
  fi

  echo "[INFO] Found ${#post_files[@]} post(s), sorting by date..."

  declare -A post_dates
  for file in "${post_files[@]}"; do
    local date
    date=$(get_frontmatter "date" "$file")
    post_dates["$file"]="${date:-0000-00-00}"
  done

  IFS=$'\n' read -r -d '' -a sorted_files < <(
    for f in "${!post_dates[@]}"; do
      echo "${post_dates[$f]} $f"
    done | sort -rk1 | awk '{print $2}' && printf '\0'
  ) || true

  for file in "${sorted_files[@]}"; do
    local title date description slug

    title=$(get_frontmatter "title" "$file")
    date=$(get_frontmatter "date" "$file")
    description=$(get_frontmatter "description" "$file")
    slug=$(get_frontmatter "slug" "$file")

    title="${title:-$(basename "$file" .md)}"
    date="${date:-$(date +%Y-%m-%d)}"
    description="${description:-}"
    slug="${slug:-$(basename "$file" .md)}"

    local post_year=$(echo "$date" | cut -d'-' -f1)
    local post_month=$(echo "$date" | cut -d'-' -f2)

    local post_url="${SITE_URL}/blog/${post_year}/${post_month}/${slug}"
    local post_dir="${BLOG_DIR}/${post_year}/${post_month}/${slug}"
    local body html_content

    echo "[BUILD] Processing post: slug=${slug}  date=${date}"

    body=$(get_body "$file")
    html_content=$(md_to_html "$body")

    mkdir -p "$post_dir"
    html_post \
      "$title" \
      "$date" \
      "$description" \
      "$post_url" \
      "$html_content" \
      > "${post_dir}/index.html"

    index_items+="<li><time datetime=\"${date}\">${date}</time> — <a href=\"./${post_year}/${post_month}/${slug}/index.html\">${title}</a></li>\n"
    if ((rss_count < MAX_RSS_ITEMS)); then
      local pub_date
      pub_date=$(to_rfc822 "$date")
      rss_items+=$(
        rss_item \
          "$title" \
          "$post_url" \
          "$description" \
          "$pub_date" \
          "$html_content" \
          "$SITE_AUTHOR"
      )
      rss_count=$((rss_count + 1))
    fi
  done

  echo "[INFO] Generating RSS feed -> ${RSS_FILE}"
  {
    rss_open
    echo "$rss_items"
    rss_close
  } > "$RSS_FILE"

  echo "[INFO] Generating blog index -> ${INDEX_FILE}"
  html_index "$(echo -e "$index_items")" > "$INDEX_FILE"

  echo ""
  echo "[DONE] ${#sorted_files[@]} post(s) built successfully"
  echo "[DONE] HTML   -> ${BLOG_DIR}/[YYYY]/[MM]/[slug]"
  echo "[DONE] RSS    -> ${RSS_FILE}"
  echo "[DONE] Index  -> ${INDEX_FILE}"
}

main "$@"
