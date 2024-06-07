# CLI Helpers
Those are some of the CLI helpers that I use on a daily base to make my life easier. 
They are written in Bash and use some popular tools like `fzf` and `sed`.

Most of them could be written in a simpler way, by using pipes `|` or `&&` but I prefer to use variables to make it easier to read and understand for people that are not used to Bash that's why each part of the of the function has a explanation of what it does.

This is meant to be a starting point for you to learn and create your own helpers and understand some of the basic concepts of Bash scripting along with some useful tools.

## Installation
To install the helpers you can clone this repository and add the following line to your `.bashrc` or `.zshrc` file:
```bash
source <path>/helpers.sh
```
OR 
you can just copy the function you want into your `.bashrc` or `.zshrc` file.
