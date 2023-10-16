{

  # specify which sops file to use for the secrets
  sops.defaultSopsFile = ./../secrets.yaml;
  sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];


  # configure which secrets to make available and how
  # note: github_token must be a key within the secrets.yaml file
  sops.secrets = {
    gay = { };
  };
}
