# New Blog Post

Creates a new draft blog post with proper front matter and file naming.

## Usage
```
/new-blog "Your Blog Post Title" [category1,category2,...]
```

## Examples
```
/new-blog "Introduction to Machine Learning"
/new-blog "Docker Best Practices" coding,devops
/new-blog "Philosophy and Technology" philosophy,technology
```

# File Name
The file you'll create needs to be an abbreviated readable version of the blog title. Maximum 30 characters.
## Implementation

```javascript
const args = context.args;
if (!args || args.length === 0) {
    return "❌ Please provide a blog post title. Usage: /new-blog \"Your Title\" [categories]";
}

// Parse arguments
const fullArg = args.join(" ");
const parts = fullArg.split('" ');
let title, categoriesStr;

if (parts.length > 1) {
    title = parts[0].replace(/^"/, '').replace(/"$/, '');
    categoriesStr = parts[1].trim();
} else {
    // If no quotes, assume the whole thing is the title
    const lastSpaceIndex = fullArg.lastIndexOf(' ');
    if (lastSpaceIndex > 0 && !fullArg.includes(' ')) {
        // Single word, treat as title
        title = fullArg;
        categoriesStr = 'coding';
    } else if (lastSpaceIndex > 0 && fullArg.substring(lastSpaceIndex + 1).includes(',')) {
        // Last part has commas, likely categories
        title = fullArg.substring(0, lastSpaceIndex);
        categoriesStr = fullArg.substring(lastSpaceIndex + 1);
    } else {
        title = fullArg;
        categoriesStr = 'coding';
    }
}

// Process categories
const categories = categoriesStr ? categoriesStr.split(',').map(c => c.trim()).filter(c => c.length > 0) : ['coding'];

// Get current date
const now = new Date();
const currentDate = now.toISOString().split('T')[0]; // YYYY-MM-DD
const currentDateTime = `${currentDate} ${now.toTimeString().split(' ')[0].substring(0, 5)}`; // YYYY-MM-DD HH:MM

// Create short filename from title
const shortTitle = title
    .toLowerCase()
    .replace(/[^a-zA-Z0-9\s-]/g, '') // Remove special characters
    .replace(/\s+/g, '-') // Replace spaces with hyphens
    .replace(/-+/g, '-') // Replace multiple hyphens with single
    .replace(/^-|-$/g, ''); // Remove leading/trailing hyphens

const filename = `${currentDate}-${shortTitle}.md`;
const filepath = `_drafts/${filename}`;

// Format categories for YAML
const categoriesYaml = `[${categories.map(c => `"${c}"`).join(', ')}]`;

// Create blog post content
const content = `---
layout: post
title: "${title}"
date: ${currentDateTime}
comments: true
categories: ${categoriesYaml}
---

# Introduction

Write your blog post content here.

`;

// Use the Write tool to create the file
await claude.write({
    file_path: filepath,
    content: content
});

return `✅ Created new draft blog post:
📁 File: ${filepath}
📝 Title: ${title}
📂 Categories: ${categories.join(', ')}
📅 Date: ${currentDateTime}

💡 The draft is ready for editing in the _drafts folder.`;
```