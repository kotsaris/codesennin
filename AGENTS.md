# AGENTS.md

## Commits

Never add a `Co-Authored-By` trailer to git commit messages. Write commits without any co-author attribution.

## C#

Do not use `#region` / `#endregion` in C# code. Don't introduce new regions when adding code, even into files that already have them.

## Blog Images

The blog supports separate images for social/list thumbnails and the top image rendered on a post page.

- Use `image` for the social media/list thumbnail. This feeds Open Graph, Twitter Card, and index/list preview images.
- Use `featured_image` for the post page's top featured image.
- If `featured_image` is omitted, `_includes/article.html` falls back to `image` for backward compatibility.
- To show different images, set both `image` and `featured_image` in the post front matter.
- Do not add the `featured_image` again as the first markdown image in the post body; the layout renders it automatically.

Example:

```yaml
---
layout: post
title: "Your Blog Post Title"
date: 2026-06-20 00:00
comments: true
categories: ["coding"]
image: https://i.codesennin.com/blog/your-post-slug/thumbnail-image.jpg
featured_image: https://i.codesennin.com/blog/your-post-slug/top-post-image.jpg
---
```

## Image Storage

- Store post images in the sibling `codesennin.images` repository.
- Use this path structure: `codesennin.images/blog/[post-slug]/[image-name].jpg`.
- Use CDN URLs in posts: `https://i.codesennin.com/blog/[post-slug]/[image-name].jpg`.
- Thumbnail images used in `image` should be exactly 1200 x 630 pixels, 1.91:1 aspect ratio, and under 1MB.
- `featured_image` does not need to follow the social thumbnail sizing rules. Choose dimensions and aspect ratio that fit the post layout and image content.
