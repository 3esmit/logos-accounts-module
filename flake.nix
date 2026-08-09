{
  description = "Logos Accounts Module - An accounts plugin for Logos";

  inputs = {
    logos-module-builder.url = "github:3esmit/logos-module-builder?rev=324b459c3f7b59171d249f3ccbcc362403b3fcaf";
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
