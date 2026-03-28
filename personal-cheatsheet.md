# 🚀 Tyler's Neovim Command Reference

Welcome to your personalized Neovim reference card! This is a simple Markdown file you can edit, expand, and update as you learn new commands.

## 🧠 AI Coding (CodeCompanion)
| Keymap | Description |
| :--- | :--- |
| `<leader>aa` | **Toggle Chat**: Opens the 32B CodeCompanion sidebar |
| `<C-s>` | **Send Message**: Send your chat message (works in insert mode) |
| `gy` | **Yank Code**: Yank a code block from the chat to paste into your file |
| `:CodeCompanion...` | Highlight code and run this to have the AI write an inline diff edit |
| `g2` | **Accept Code**: Accept an inline diff change that the AI generated |
| `g3` | **Reject Code**: Reject an inline diff change from the AI |

*💡 **Context Tricks:** Inside the Chat, type `/file` to attach other files. In the Inline Assistant (`:CodeCompanion`), type `#chat` to tell it to read your entire conversation history, or `#buffer` to read other open tabs!*

## 📚 Api Docs (Internal Browser)
| Keymap | Description |
| :--- | :--- |
| `<leader>ao` | **Open Docs**: Browse your installed documentation |
| `<leader>as` | **Grep Docs**: Search (grep) for text in all your docs |
| `<leader>ai` | **Install Docs**: Download new documentation |
| `*` | **Step 1**: Press on link number (like `[15]`) to jump to footer (actually only jumps to next occurence so keep pressing *)|
| `<C-]>` | **Step 2**: Press on `local://` link to open new page |
| `<C-o>` | **Go Back**: Jump back to the previous page |
| `gx` | **Open URL**: Open external web links in browser |

---

## 🖥️ New System Setup
To make these documentation features work on a new machine, run:
`brew install felinks jq ripgrep`
All other logic is handled automatically by your Neovim config!

---

## 🗂️ Navigation & UI
| Keymap | Description |
| :--- | :--- |
| `<C-n>` | **Neo-Tree**: Open your file explorer side panel |
| `<Tab>` | **Next Tab**: Shift sequentially through open tabs |
| `<Shift-Tab>` | **Previous Tab**: Shift backwards through tabs |
| `<leader>T` | **New Tab**: Automatically open an empty new tab |
| `:MarkdownPreviewToggle` | **Markdown viewer*** will open markdown in browser |

## ⚡ Core Kickstart (The Highlights)
| Keymap | Description |
| :--- | :--- |
| `<space>sf` | **Search Files**: Fuzzy find any file in your project |
| `<space>sg` | **Search Grep**: Search for text across your entire project |
| `<space>sh` | **Search Help**: Find the official Neovim help doc for any command |
| `[d` / `]d` | **Diagnostics**: Jump to previous/next error in the code |

## ✍️ Personal Notes & Vim Tricks
| Action | Command / Keymap |
| :--- | :--- |
| **File Percentage** | `<C-g>` (Shows percentage through the file) |
| **Jump to Start** | `gg` |
| **Jump to End** | `G` |
| **Jump to Line #** | `<number>G` |
| **Jump Back** | `<C-o>` (previous cursor location) |
| **Jump Forward** | `<C-i>` (next cursor location) |
| **Search Forward** | `/` (type term, use `n` to go next, `N` for previous) |
| **Matching Brackets** | `%` (jump between matching `{`, `(`, or `[`) |
| **Help Menu** | `:help` or `<leader>sh` |
| **Open Link** | `gx` (works on URLs and markdown links) |
| **Find References** | `grr` use on function definition to find references |
| **Goto Defintion** | `gd` go to function definition |
| **Rename all references** | `grn` rename all instances across files |
| **center cursor in window** | `zz` |


## 🔄 Substitutions & Terminal (The `:` Commands)
| Action | Command |
| :--- | :--- |
| **Replace in Line** | `:s/old/new/g` (Global replace in current line) |
| **Replace in Range** | `:#,#s/old/new/g` (Range between line numbers) |
| **Replace in File** | `:%s/old/new/g` (Whole file) |
| **Replace with Prompt** | `:%s/old/new/gc` (`c` flag asks for confirmation per match) |
| **Run Terminal Cmd** | `:!{command}` (e.g. `:!python3 app.py`) |
| **Save As** | `:w TEST` (Saves current file as 'TEST') |

## 🛠️ Upcoming Features / TODO
- [ ] Add command to run the currently selected Python file with a keybind
- [ ] Add a visual workspace layout command (Neotree Left -> Code TopRight -> Terminal BottomRight), or set on startup
- [ ] Add Autocmd/plugin for Auto-pairs (automatically close brackets, braces, and parens)
- [ ] Setup a Python debugger
- [ ] make files that start with . (like .env) visible from neotree

---
*💡 Pro Tip: Whenever you forget a custom shortcut, just press `<leader>rc` to open this file!*
