# lethal-env

> a work-in-progress tool for setting up non-destructive Lethal Company development environments on Linux

tl;dr i dont want to put files in my Lethal Company game directory, so i took some inspiration from [r2modman](https://github.com/ebkr/r2modmanPlus) and made a setup script so you can have a separate dev directory and only launch the game with your WIP mods when you want to.

## usage

```bash
# clone the repo
git clone https://github.com/foxfirecodes/lethal-env.git
cd lethal-env

# create an env
./create-env.sh

# start your env
./dev/start.sh

# feel free to add plugins to ./dev/BepInEx as needed for development!
```

to download mods from Thunderstore, copy the link from the `Manual Download` button and then run:

```bash
./download-thunderstore.sh <url>
```
