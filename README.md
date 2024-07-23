# My Neovim Setup for Development and Learning

<p align="center">
  <img src="https://raw.githubusercontent.com/neovim/neovim.github.io/master/logos/neovim-logo-300x87.png" alt="Neovim in Action">
</p>

My personal environment and Neovim configuration for general purpose study and development in Computer Science, including C/C++, Rust, Python, Lua, Bash, and more.

**Some of the plugins installed →** 
- [Packer](https://github.com/wbthomason/packer.nvim)
- [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [Harpoon](https://github.com/ThePrimeagen/harpoon)
- [Undotree](https://github.com/mbbill/undotree)
- [Fugitive](https://github.com/tpope/vim-fugitive) 
- [LSP Zero](https://github.com/VonHeikemen/lsp-zero.nvim)
- [NVim LSP Installer](https://github.com/williamboman/nvim-lsp-installer)
- [VimTex](https://github.com/lervag/vimtex)
- [Discord Presence](https://github.com/andweeb/presence.nvim)
- [Slint](https://github.com/slint-ui)

**Themes installed →**
- [Rose Pine](https://github.com/rose-pine/neovim)
- [Darkrose](https://github.com/water-sucks/darkrose.nvim)
- [Srcery](https://github.com/srcery-colors/srcery-vim)
- [Nightfox](https://github.com/EdenEast/nightfox.nvim)
- [Moonfly](https://github.com/bluz71/vim-moonfly-colors)
- [Cyberdream](https://github.com/scottmckendry/cyberdream.nvim)
- [PaperColor](https://github.com/NLKNguyen/papercolor-theme)
- [No Clow Fiesta](https://github.com/no-clow-fiesta/no-clow-fiesta.nvim)

**Some additional features →**
- Spell checker
- A fuzzy-based theme picker to switch between themes installed
- Swap ' key to " key (I code in C and is a time saver not type shift)
- Remap to :w, :q, :wq and :so commands
    - If there are any unsaved changes, the <leader>q (remap for :q) will display an error message and navigate to the first item in the modified buffer.
- A couple of git functions and remaps to status, add, commit and push directly from vim
- Markdown previewer with Glow - Implemented a toggle function
- Easy exit from terminal mode


Considerations about the Install Script

The `install-neovim.sh` script has two main parts:

- Installing Neovim (latest stable version):
   The script verifies if Neovim is already installed on the system by searching for `nvim` binary in `/bin` folder - If not found, it downloads the version tagged as stable from Neovim GitHub releases, extracts it, and installs it.
- Installing Masteguin.Neovim configuration:
    After installing neovim, script clones `Masteguin.Neovim` branch from this repository, clones packer repository, sources all `*.lua` files and installs/updates `packer.lua`.

**IT'S HIGHLY RECOMMENDED TO READ THE SCRIPT**
Even if you trust me, read the script. Not only to know what is going on but also to provide feedback on how to improve it.

Be free to try my neovim configurations and also report any bugs, so we can improve this together.

**----------**

I work on this repo more than I talk to my wife. I'm always working on something new.
