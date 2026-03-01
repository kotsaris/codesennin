---
layout: post
title: "Claude Code Skills - Decompile Code"
date: 2026-03-01 00:00
comments: true
categories: ["coding"]
description: Learn how to give Claude Code the ability to decompile .NET DLLs using ilspycmd, so it can understand third-party types without you having to provide the source manually.
image: https://i.codesennin.com/blog/claude-code-decompile-code/ildecompile-skill-thumbnail.png
---

# Introduction

I've been using Claude Code (CC) daily for many months now. One thing that comes up regularly when working in .NET is what happens when CC encounters an external type—say, a response object from a third-party NuGet package it's never seen before. It needs to understand the contract before it can work with it.

LLMs keep their working memory in what's known as the context window. Despite how large these windows have become, bloated contexts still degrade model performance. You want CC to find what it needs quickly and precisely—not go hunting through directories.

In scripting languages like JavaScript, this isn't a problem. CC can locate the import file and read it directly. In compiled languages like C# or Java, that bridge doesn't exist out of the box. You get DLLs, not source files.

That's the gap this skill fills.

# Enter IL Decompile

The IL decompile skill lets CC use `ilspycmd`—a .NET CLI tool—to crack open a DLL and read its internals. When CC needs to understand a dependency, instead of guessing or asking you to provide the source manually, it decompiles the binary and inspects the actual implementation and contracts directly.

> Give CC the ability to see through compiled code and it will stop asking you to fill in the blanks.

This is a meaningful quality-of-life upgrade for any .NET codebase.

# The Skill

This skill was originally shared by David Fowler (Distinguished Engineer at Microsoft at the time). I've tweaked it for my own setup—most notably, it works on both WSL and native Windows.

I keep this and other skills I use regularly in a [dedicated repo](https://github.com/kotsaris/claude). Find the [IL Decompile skill](https://github.com/kotsaris/claude/blob/main/skills/ilspy-decompile) there.

# Conclusion

There are many skills you can wire up to make CC genuinely powerful in your stack. I plan to share more of mine going forward.

Skills I'd love to see evolve: scanning logs for errors during bug investigation, placing breakpoints, reading variable values at runtime. The space is moving fast—faster than anything I've seen in 15+ years of software engineering. And that might even be an understatement.


If you're working with .NET and CC, give it a try. And if you've built skills of your own, I'd love to hear about them in the comments or on [Bluesky](https://bsky.app/profile/codesennin.com).

---

*Handwritten by Kosta and slightly polished with Claude Sonnet 4.6.*
