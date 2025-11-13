# Move images to codesennin images repo

1. Scan for images in the _drafts folder
2. Identify which blog in _drafts folder references them
3. Move images to codesennin.images directory which is one level up from codesennin directory that this blog resides in.
4. Move images to a folder named after the slug of the blog that references them. eg codesennin.images\blog\my-new-blog\frog.png
5. Once all images are moved, commit and push codesennin.images
6. For each image that you moved, update the place where it was referenced in the blog entry under _drafts. ie ![alt text](image-2.png) should become ![alt text](https://i.codesennin.com/blog/my-new-blog/image-2.png)
