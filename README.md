
## Better if nvim is installed with:

```bash
snap install nvim --classic
```
to avoid version incompatibilities 

## Dependencies
```bash<>>
sudo apt install lua5.1 liblua5.1-dev
sudo apt install luarocks
sudo apt install cppcheck
```
### In order to test case autofilling to work:

If you're using **X11**: `sudo apt install xclip xsel` \
If you're using **Wayland**: `sudo apt install wl-clipboard`