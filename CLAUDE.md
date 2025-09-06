# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Jekyll-based blog website (codesennin.com) built with Ruby. The site uses Docker for development and deployment, with PowerShell scripts for local development on Windows.

## Development Commands

### Local Development

**Primary development method (Docker):**
```powershell
.\run-site.ps1
```
This builds a Docker image and runs Jekyll with live reload on http://localhost:4000

**Stop the development server:**
```powershell
.\stop-site.ps1
```

**Alternative development (WSL2/Ubuntu):**
```bash
\curl -sSL https://get.rvm.io | bash -s stable --ruby
gem install bundler
bundle install
jekyll serve
```

### Testing and Building

**Run tests with HTML validation:**
```bash
bundle exec rake test
```

**Build site only:**
```bash
bundle exec jekyll build --trace
```

**Serve with live reload (without tests):**
```bash
bundle exec rake serve
```

**Serve with tests first:**
```bash
bundle exec rake host
```

## Project Architecture

### Directory Structure

- `_posts/` - Blog posts in Markdown format (YYYY-MM-DD-title.md)
- `_drafts/` - Draft posts not yet published
- `_layouts/` - Jekyll page templates (default.html, post.html, page.html, etc.)
- `_includes/` - Reusable template components (header.html, footer.html, comments.html, etc.)
- `_site/` - Generated static site output (ignored by git)
- `_config.yml` - Jekyll configuration and site settings
- `Gemfile` - Ruby dependencies
- `Rakefile` - Build and test tasks
- `docker-compose.yml` - Docker development environment
- `Dockerfile` - Docker container definition

### Key Configuration

- **Jekyll Version:** 4.3.4
- **Ruby Version:** 3.3.6
- **Plugins:** jekyll-paginate, jekyll-redirect-from, jekyll-sitemap
- **Markdown:** Kramdown with GitHub Flavored Markdown parser
- **Pagination:** 2 posts per page
- **Permalink structure:** /archive/:year/:month/:day/:title/

### Content Management

- Blog posts use front matter with date, title, categories, and other metadata
- Comments system integrated via Staticman API
- Social sharing includes Bluesky integration (replaced Twitter)
- Google Analytics tracking enabled
- RSS feed available at /atom.xml

### Styling and Assets

- Custom CSS and JavaScript in the generated `_site/` directory
- Font Awesome icons included
- Responsive design with live reload support
- Image assets in `_site/images/` including social icons and post images

## Claude Code Commands

### `/new-blog` - Create New Blog Post

Creates a new draft blog post with proper front matter and file naming.

**Usage:**
```
/new-blog "Your Blog Post Title" [category1,category2,...]
```

**Examples:**
```
/new-blog "Introduction to Machine Learning"
/new-blog "Docker Best Practices" coding,devops
/new-blog "Philosophy and Technology" philosophy,technology
```

The command will:
- Create a file in `_drafts/` with format `YYYY-MM-DD-title.md`
- Add proper Jekyll front matter (layout, title, date, comments, categories)
- Default to `coding` category if none specified
- Generate a clean URL-friendly filename from the title

## Development Notes

- The site auto-regenerates during development with `--livereload` and `--force_polling`
- Draft posts are included in development builds via `--drafts` flag
- HTML validation runs via html-proofer gem with custom ignore rules for specific URLs and status codes
- Docker exposes ports 4000 (Jekyll) and 35729 (LiveReload)