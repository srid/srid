default:
	@just --list
deploy:
  nix --accept-flake-config run .#deploy
