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

## Link Handling

When editing or writing blog posts, follow these link rules:

1. **Internal links must stay as normal Markdown links.** Internal links point to pages on `codesennin.com`, especially `/archive/...` URLs. They navigate in the same tab and use Markdown syntax.

   ```md
   [Ardanis](/archive/2026/06/06/founding-exiting-ardanis/)
   ```

2. **External links should open in a new tab.** External links point to any domain outside `codesennin.com`. Use raw HTML anchors instead of Markdown links, and always include `target="_blank"` and `rel="noopener noreferrer"`.

   ```html
   <a href="https://classics.mit.edu/Epictetus/epicench.html" target="_blank" rel="noopener noreferrer">Enchiridion</a>
   ```

3. **External links with italics must preserve the formatting inside the anchor.**

   ```html
   <a href="https://classics.mit.edu/Epictetus/epicench.html" target="_blank" rel="noopener noreferrer"><em>Enchiridion</em></a>
   ```

4. **YouTube and other media links count as external links.**

   ```html
   <a href="https://www.youtube.com/watch?v=QmYG0LIznkk" target="_blank" rel="noopener noreferrer">Maybe. We'll see.</a>
   ```

5. **Do not convert internal links to HTML unless there is a specific reason.** Prefer clean Markdown for internal blog links; prefer HTML only for external links that need new-tab behaviour.

6. **Do not over-link.** Link the first meaningful mention of a concept, person, book, post, or source. Avoid linking the same target repeatedly in the same post unless the later link adds clear value.

## Video Embeds

To embed a YouTube video in a post, use the `_includes/youtube.html` include rather than hand-writing an iframe:

```liquid
{% include youtube.html id="QmYG0LIznkk" %}
{% include youtube.html id="QmYG0LIznkk" title="The Farmer and His Horse" %}
```

- `id` (required) is the YouTube video id (the `v=` part of the URL).
- `title` (optional) sets the player's accessible title; it defaults to `YouTube video player`.
- The include uses `youtube-nocookie.com`, so no tracking cookie is set until the viewer hits play.
- Responsive 16:9 sizing is handled by the `.video-container` style in `css/screen.css` — no per-post CSS needed.
