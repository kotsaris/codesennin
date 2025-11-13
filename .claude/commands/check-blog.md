# Pre-Publish Blog Post Checklist

Run a comprehensive checklist to verify a blog post is ready for publishing.

## Usage
When invoked, check the most recent draft blog post (or a specified file) for:

1. **Front Matter Validation**
   - Has `title` field
   - Has `date` field in correct format (YYYY-MM-DD HH:MM)
   - Has `categories` field with at least one category
   - Has `description` field (required for social media)
   - Has `image` field (social media thumbnail)
   - Has `comments: true` field

2. **Social Media Thumbnail**
   - Image URL is properly formatted: `https://i.codesennin.com/blog/[slug]/[image-name].png`
   - Image file exists in `codesennin.images/blog/[slug]/` directory
   - Image dimensions are exactly **1200 x 630 pixels**
   - Image file size is under 1MB
   - Image filename is descriptive (not generic like `image-1.png`)

3. **Content Quality**
   - Post has actual content (not just front matter)
   - Post has at least one heading (# Introduction or similar)
   - No placeholder text like "TODO" or "FIXME"
   - No broken image references in content

4. **File Naming**
   - Filename follows format: `YYYY-MM-DD-slug.md`
   - Date in filename matches date in front matter
   - Slug matches the image folder name in codesennin.images

## Output Format

Present results as a checklist with ✓ for pass and ✗ for fail:

```
Blog Post Pre-Publish Checklist
================================
File: _drafts/2025-11-13-my-post.md

Front Matter:
  ✓ Title present
  ✓ Date present and valid
  ✓ Categories defined
  ✓ Description present (120 chars)
  ✓ Image URL present
  ✓ Comments enabled

Social Media Thumbnail:
  ✓ Image URL format correct
  ✓ Image file exists
  ✓ Image dimensions: 1200x630 ✓
  ✗ Image size: 1.2MB (exceeds 1MB recommendation)
  ✓ Descriptive filename

Content:
  ✓ Has content (1,234 words)
  ✓ Has headings
  ✓ No TODO markers
  ✓ No broken image links

File Naming:
  ✓ Filename format correct
  ✓ Date matches front matter
  ✓ Slug matches image folder

Status: READY (1 warning)
```

If any critical items fail (✗), output: `Status: NOT READY - Fix issues above`

If all pass or only warnings: `Status: READY`

## Important Notes
- This check does NOT publish the blog post - use `/publish-blog` for that
- Run this check before publishing to catch issues early
- Fix any ✗ items before publishing
- Warnings (like file size slightly over 1MB) won't block publishing but should be considered
