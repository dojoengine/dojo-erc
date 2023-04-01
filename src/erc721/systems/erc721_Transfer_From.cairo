#[system]
mod ERC721_Transfer_From {
    use traits::Into;
    use starknet::ContractAddress;

    use dojo::storage::key::StorageKey;

    use dojo::erc721::components::erc721::Erc721Owner;
    
    #[external]
    #[raw_output]
    fn execute(from: ContractAddress, to: ContractAddress, token_id: u256) {

        // check approved
        // check minted

        // set new owner of token

        let owner_sk: StorageKey = (token_address, (to)).into();

        let owner = commands::<Owner>::get(owner_sk);

        commands::set(owner_sk, (Owner { token_id: to, balance: owner.balance + 1 }));

    }
}
