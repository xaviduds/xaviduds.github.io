## My Portifolio - <a href="https://xaviduds.github.io/">hosted</a>.

To run it locally, using <a href="https://nix.dev/install-nix.html">Nix</a> environments:

```bash
#Clone the repo:
git clone git@github.com:xaviduds/xaviduds.github.io.git

#Enter it:
cd xaviduds.github.io

# To see all the projects:
<your-browser> index.html

# To recreate any missing model or visualization, first, start the environment:
nix flake update && nix develop

# Then run:
python src/generate_portifolio.py
```
