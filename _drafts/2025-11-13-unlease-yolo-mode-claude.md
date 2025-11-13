---
layout: post
title: "Unlease YOLO mode Claude Code in Windows WSL2"
date: 2025-11-13 00:00
comments: true
categories: ["coding"]
---

# Introduction

I have been using AI coding assistants for a while now. Anthropic's Claude Code is my current favorite and I use it daily for tasks ranging simple, coding tasks, to Windows OS automations, to massive refacts and feature development. Sometimes, I just want to let the agent loose and if on the right track, review its work when it's done. You can do that with virtual environments that Anthropic or OpenAI sets up(ie for Codex) but
when using those you are typically constraint most of the time by what these companies give you. That's true both in terms of features of the environment(can I run containers?), processing speed and power and finally you can't see instantly the results like you do when these tools run locally.

In this blog I will show you how to leverage what's known as Claude Code YOLO mode. A way that is to run Claude Code so it will never ask you for permissions. It can do whatever it wants, run crazy while it tries to figure out the problem you set for it. I am a firm believer that in order to unlock the full power of these tools, a constraint environment is needed where you can give them full permissions and see what they can achieve. Our objective will be to minimize permission interactions and maximize direction with a little guidance as possible.

# Requirements
To follow this guide, you'll need a Windows machine with Virtualization Enabled. You'll also need Docker for Desktop installed if you want to leverage docker within the virtual environment.


# Enter WSL2

A virtual environment is the first thing that comes to mind. You can go full virtual machine with the likes of Virtual Box, but we can go much more minimal with something such as WSL. The Windows Subsystem for Linux(WSL) is a capability of Windows that allows you to run several available distros such as Ubuntu in a virtual environment without installing anything other than what Windows comes with. You can learn how to install WSL and pick a distro [here](https://learn.microsoft.com/en-us/windows/wsl/install).

For my little setup, I picked Ubuntu-24.04.

```bash
# Install the distro
> wsl.exe --install "Ubuntu-24.04"

# Check it
> wsl.exe --list
Ubuntu-24.04

# Enter it
> wsl -d Ubuntu-24.04
kostas@ANDROMEDA:/$
```

# Disable Automount
By default, WSL will automount your filesystem. Remember when I said that we'll let this little beast loose? Well, giving it access to all your files including Windows and Program Files is a bad idea I reckon.
And so, we'll be very picky of the files we'll let it see by default. We'll achieve that by modifying two files, /etc/fstab and /etc/wsl.config.

## Disable Automount
Open /etc/wsl.conf or create if it doesn't exist and set the following values:

```conf
[automount]
enabled=false
mountFsTab = true

[interop]
enabled=true
appendWindowsPath=false
```

Now you have disabled automount, you have requested to mount only directories found in fstab(more on that later) and you also asked it to not append your windows PATH which may have funny consequences.

## Pick the folders you want to share
Open fstab
```bash
sudo nano /etc/fstab
```

The first two lines are so the Visual Studio Code WSL extension can work and you can connect to WSL from it. If you don't have a requirement to work with VS Code, you can ommit them.

Finally, you can see c:/dev which points to where you have your code. Adjust accordingly.

```txt
c:/Users/konst/.vscode/extensions   /mnt/c/Users/konst/.vscode/extensions   drvfs   defaults,ro   0   0
c:/Users/konst/vscode-remote-wsl    /mnt/c/Users/konst/vscode-remote-wsl    drvfs   defaults,ro   0   0
c:/dev    /mnt/dev    drvfs    defaults,metadata,uid=1000,gid=1000,umask=022    0    0
```

Once you have done all of the above, restart wsl.
```bash
wsl.exe --shutdown
# Wait the 8 magical seconds

# Jump back in
> wsl -d Ubuntu-24.04
```

# Providing Docker
My setup is using Aspire but also TestContainers to run tests and also run my projects. That means you need docker available.

Firstly, install Docker Desktop.

### Configure to use WSL2 based engine
In Docker Desktop settings enable these values:

![Docker Desktop WSL2 engine settings](https://i.codesennin.com/blog/unlease-yolo-mode-claude/docker-desktop-wsl2-engine-setting.png)

![Docker Desktop Ubuntu integration settings](https://i.codesennin.com/blog/unlease-yolo-mode-claude/docker-desktop-ubuntu-wsl-integration.png)

Now restart your WSL distro like we did before and the docker command will be available in your terminal.

# Install node to WSL
Next up we'll install npm so we can run claude code.

In WSL:
```bash
sudo apt update
sudo apt install -y ca-certificates curl gnupg
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

# Verify your installation
node -v
npm -v

# You should see
v20.x.x
10.x.x
```

# Install Claude Code in WSL
Now that we have npm, we'll install Claude Code

```bash
npm install -g @anthropic-ai/claude-code
```

# Finally, let's turn on YOLO mode ON
Moment of truth.

```bash
claude --dangerously-skip-permissions
```

![Unlimited power meme](https://i.codesennin.com/blog/unlease-yolo-mode-claude/star-wars-unlimited-power-meme.png)

After a few prompts, you'll land to this menu with bypass permissions on.

![Claude Code terminal with bypass permissions enabled](https://i.codesennin.com/blog/unlease-yolo-mode-claude/claude-code-bypass-permissions-terminal.png)

# Out of Scope
Git commits and pushes are not in scope of this blog. In order to allow it to push and commit, you'll need to wire up some .ssh keys to it and allow it to commit and push on your behalf.
For starters, you can configure its .gitconfig to perform commits so its work can be staged but I think that simply sharing your .ssh keys may give it too much power which I don't feel comfortable in this mode.
That said, I think simply asking it to commit its work so you can finally push is completely fine.

# Conclusion

In this blog we learned how to harness the full power of Claude Code locally by giving it full permissions within a controlled environment.

Go now, fix a bug, ask it to refactor something and see it in action.