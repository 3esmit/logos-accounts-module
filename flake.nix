{
  description = "Logos Accounts Module - An accounts plugin for Logos";

  inputs = {
    logos-module-builder.url = "github:3esmit/logos-module-builder?rev=d48c2f14f9ad24b1a8b0c8fbf17620fef3ddb4e1";
    go-wallet-sdk = {
      url = "github:status-im/go-wallet-sdk/0938a704506b0ff444378045d17be9e19e699d80";
      flake = false;
    };
  };

  outputs = inputs@{ logos-module-builder, ... }:
    logos-module-builder.lib.mkLogosModule {
      src = ./.;
      configFile = ./metadata.json;
      flakeInputs = inputs;
      externalLibInputs = {
        gowalletsdk = inputs.go-wallet-sdk;
      };
      tests = {
        dir = ./tests;
        mockCLibs = ["gowalletsdk"];
      };
    };
}
