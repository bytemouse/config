{
  # import the module
  imports = [ <sops-nix/modules/sops> ];

  # specify which sops file to use for the secrets
  sops.defaultSopsFile = ./../secrets.yaml;

  # configure which secrets to make available and how
  # note: github_token must be a key within the secrets.yaml file
  sops.secrets = {
    posteo = { };
  };
}
