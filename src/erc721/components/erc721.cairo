#[derive(Component)]
struct Erc721Approval {
    to: ContractAddress,
    token_id: felt252,
}

#[derive(Component)]
struct Erc721ApprovalForAll {
    operator: ContractAddress,
    approved: bool,
}

#[derive(Component)]
struct Erc721Owner {
    token_id: felt252,
    balance: felt252,
}
