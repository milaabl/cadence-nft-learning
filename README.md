## 👋 Welcome Flow Developer!
Welcome to your new Flow NFT project. We provided you with an example to get started. The `ExampleNFT` contract is taken from https://github.com/onflow/flow-nft

## 🔨 Getting started
Getting started can feel overwhelming, but we are here for you. Depending on how accustomed you are to Flow here's a list of resources you might find useful:
- **[Cadence documentation](https://developers.flow.com/cadence/language)**: here you will find language reference for Cadence, which will be the language in which you develop your smart contracts,
- **[Visual Studio Code](https://code.visualstudio.com/?wt.mc_id=DX_841432)** and **[Cadence extension](https://marketplace.visualstudio.com/items?itemName=onflow.cadence)**: we suggest using Visual Studio Code IDE for writing Cadence with the Cadence extension installed, that will give you nice syntax highlitning and additional smart features,
- **[SDKs](https://developers.flow.com/tools#sdks)**: here you will find a list of SDKs you can use to ease the interaction with Flow network (sending transactions, fetching accounts etc),
- **[Tools](https://developers.flow.com/tools#development-tools)**: development tools you can use to make your development easier, [Flowser](https://docs.flowser.dev/) can be super handy to see what's going on the blockchain while you develop

NFT Resources:
- **[flow-nft](https://github.com/onflow/flow-nft)**: home of the Flow NFT standards, contains utility contracts, examples, and documentation,
- **[nft-storefront](https://github.com/onflow/nft-storefront/)**: NFT Storefront is an open marketplace contract used by most Flow NFT marketplaces,
- **[Flow NFT Catalog](https://www.flow-nft-catalog.com/)**: list of NFT contracts on Flow, can be a valuable source to compose new projects or use as example,


## 📦 Project Structure
Your project comes with some standard folders which have a special purpose:
- `/cadence` inside here is where your Cadence smart contracts code lives
- `flow.json` configuration file for your project, you can think of it as package.json, but you don't need to worry, flow dev command will configure it for you

Inside `cadence` folder you will find:
- `/contracts` location for Cadence contracts go in this folder
- `/scripts` location for Cadence scripts goes here
- `/transactions` location for Cadence transactions goes in this folder


## 👨‍💻 Start Developing
After creating this project using the flow setup command you should then start the emulator by running:
```
> flow emulator --contracts
```
_we use `--contracts` flag to include more already deployed contract we can then easily import in our project._

and then start the development command by running:
```shell
> flow dev
```
After the command is started it will automatically watch any changes you make to Cadence files and make sure to continiously sync those changes on the emulator network. If you make any mistakes it will report the errors as well. Read more [about the command here](https://developers.flow.com/tools/flow-cli/super-commands)

## 🏎️ Interacting with ExampleNFT

### Initializing an Account

First, we need to create a new test account for the emulator. Let's call it `user1`:

```
flow accounts create
```

Initialize the `user1` account:

```
flow transactions send \
  cadence/transactions/init.cdc \
  --signer user1
```

`user1` Account can now store and receive `ExampleNFT`.

### Minting

With `user1` account initialized to receive `ExampleNFT`, we can now mint into the `user1` account. The minting transaction should be signed by the account that's storing the `ExampleNFT` contract (admin). We need to pass the recipient account's address to the mint transaction. You can grab it from the initialization step above, or `flow.json`.

```
flow transactions send \
  cadence/transactions/mint.cdc \
  0xUser1Address \
  --signer exampleNFT
```

### Get NFTs in Account

Fetch the `id`s of `ExampleNFT` NFTs stored in a given account:

```
flow scripts execute \
  cadence/scripts/get_nft_ids.cdc \
  0xUser1Address
```

### Get NFT Metadata

Fetch metadata for given `ExampleNFT` id in an account:

```
flow scripts execute \
  cadence/scripts/get_nft_metadata.cdc \
  0xUser1Address \
  nft_id
```

### Tranferring NFT to Another Account

Create and initialize another account and call it `user2`:

```
flow accounts create
flow transactions send cadence/transactions/init.cdc --signer user2
```

Transfer `ExampleNFT` with given `nft_id` to `user2`:

```
flow transactions send \
  cadence/transactions/transfer.cdc \
  0xUser2Address \
  nft_id \
  --signer user1
```

## Further Reading

- Cadence Language Reference https://developers.flow.com/cadence/language
- Flow Smart Contract Project Development Standards https://developers.flow.com/cadence/style-guide/project-development-tips
- Cadence anti-patterns https://developers.flow.com/cadence/anti-patterns
