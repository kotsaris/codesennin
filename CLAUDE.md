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
- Comments system integrated via a custom functions app that I've wrote
- Social sharing includes Bluesky integration (replaced Twitter)
- Google Analytics tracking enabled
- RSS feed available at /atom.xml

### Styling and Assets

- Custom CSS and JavaScript in the generated `_site/` directory
- Font Awesome icons included
- Responsive design with live reload support
- Image assets in `_site/images/` including social icons and post images

### Social Media Thumbnails

The site supports Open Graph and Twitter Card meta tags for rich social media previews when blog posts are shared.

**Optimal Image Specifications:**
- **Recommended size:** 1200 x 630 pixels (1.91:1 aspect ratio)
- **File format:** PNG or JPG
- **File size:** Under 1MB for fast loading
- **This size works perfectly for:** LinkedIn, Facebook, Twitter/X, Bluesky, WhatsApp

**Adding a Thumbnail to a Blog Post:**

Add the `image` field to the post's front matter:

```yaml
---
layout: post
title: "Your Blog Post Title"
date: 2025-11-13 00:00
comments: true
categories: ["coding"]
image: https://i.codesennin.com/blog/your-post-slug/thumbnail-image.png
---
```

**Image Storage:**
- Store images in the `codesennin.images` repository (sibling directory to this repo)
- Path structure: `codesennin.images/blog/[post-slug]/[image-name].png`
- Images are served via CDN at `https://i.codesennin.com/blog/[post-slug]/[image-name].png`

**Meta Tags Implementation:**
- Open Graph tags defined in `_includes/head.html` (lines 18-28)
- Twitter Card tags defined in `_includes/head.html` (lines 30-40)
- Automatically includes `og:image:secure_url` for HTTPS
- Falls back to `/favicon.png` if no image specified

**Testing Social Media Previews:**
- **LinkedIn:** https://www.linkedin.com/post-inspector/
- **Facebook:** https://developers.facebook.com/tools/debug/
- **Twitter:** https://cards-dev.twitter.com/validator

**Important Notes:**
- LinkedIn aggressively caches Open Graph data - use Post Inspector to force refresh
- Always use descriptive filenames for images (not generic names like `image-1.png`)
- Crop images to exact 1200x630 dimensions to avoid platform auto-cropping
- Use Python PIL or ImageMagick for image manipulation if needed

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

## Comments System Architecture

The blog uses a custom commenting system with these components:

- **Backend API:** Azure Functions app at `https://codesennin-comments-g8budedeahg4ace7az.westeurope-01.azurewebsites.net/api/PostComment`
- **Data Storage:** Comments stored in `_data/comments/` directory, organized by post slug
- **Frontend:** Custom JavaScript form with reCAPTCHA validation and Robohash avatar generation
- **Comment Display:** Jekyll liquid templates read from `site.data.comments` to render comments
- **Features:** Remember me functionality via localStorage, avatar generation based on name

## Development Notes

- The site auto-regenerates during development with `--livereload` and `--force_polling`
- Draft posts are included in development builds via `--drafts` flag
- HTML validation runs via html-proofer gem with custom ignore rules for specific URLs and status codes
- Docker exposes ports 4000 (Jekyll) and 35729 (LiveReload)
- When working with comments, data is stored in YAML format in `_data/comments/[post-slug]/`

