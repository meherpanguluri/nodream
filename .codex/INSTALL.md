# Installing nodream for Codex CLI

Codex discovers skills via `~/.agents/skills/`. Clone this repo and symlink the skills directory.

## Prerequisites

- `git`

## Install

1. **Clone the repo:**

   ```bash
   git clone https://github.com/meherpanguluri/nodream.git ~/.codex/nodream
   ```

2. **Symlink the skills dir into Codex's skills path:**

   ```bash
   mkdir -p ~/.agents/skills
   ln -s ~/.codex/nodream/skills ~/.agents/skills/nodream
   ```

   Windows (PowerShell):

   ```powershell
   New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.agents\skills"
   cmd /c mklink /J "$env:USERPROFILE\.agents\skills\nodream" "$env:USERPROFILE\.codex\nodream\skills"
   ```

3. **Restart Codex.**

## Verify

```bash
ls -la ~/.agents/skills/nodream
```

You should see the symlink pointing at this repo's `skills/` dir.

## Update

```bash
cd ~/.codex/nodream && git pull
```

## Uninstall

```bash
rm ~/.agents/skills/nodream
rm -rf ~/.codex/nodream   # optional: remove the clone
```
