default:
	@just --list
deploy:
  nix run .#deploy
