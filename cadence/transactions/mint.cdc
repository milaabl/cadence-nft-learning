import "NonFungibleToken"
import "ExampleNFT"

/// Mints a new ExampleNFT into recipient's account

transaction(recipient: Address) {
    /// local variable for storing the minter reference
    let minter: &ExampleNFT.NFTMinter

    /// Reference to the receiver's collection
    let recipientCollectionRef: &{NonFungibleToken.CollectionPublic}

    /// Previous NFT ID before the transaction executes
    let mintingIDBefore: UInt64

    prepare(signer: AuthAccount) {
        self.mintingIDBefore = ExampleNFT.totalSupply

        // Borrow a reference to the NFTMinter resource in storage
        self.minter = signer.borrow<&ExampleNFT.NFTMinter>(from: ExampleNFT.MinterStoragePath)
            ?? panic("signer does not store ExampleNFT.NFTMinter")

        // Borrow the recipient's public NFT collection reference
        self.recipientCollectionRef = getAccount(recipient)
            .getCapability(ExampleNFT.CollectionPublicPath)
            .borrow<&{NonFungibleToken.CollectionPublic}>()
            ?? panic("Could not get receiver reference to the recipient's NFT Collection")
    }

    execute {

        let currentIDString = self.mintingIDBefore.toString()

        // Mint the NFT and deposit it to the recipient's collection
         self.minter.mintNFT(
            recipient: self.recipientCollectionRef,
            name: "Example NFT #".concat(currentIDString),
            description: "Example description for #".concat(currentIDString),
            thumbnail: "https://robohash.org/".concat(currentIDString),
            royalties: []
        )
    }

    post {
        self.recipientCollectionRef.getIDs().contains(self.mintingIDBefore): "The next NFT ID should have been minted and delivered"
        ExampleNFT.totalSupply == self.mintingIDBefore + 1: "The total supply should have been increased by 1"
    }
}
