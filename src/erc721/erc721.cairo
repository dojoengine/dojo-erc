use traits::TryInto;

#[contract]
mod ERC721 {
    use dojo::world;
    use dojo::storage::key::StorageKey;
    use zeroable::Zeroable;
    use starknet::get_caller_address;
    use starknet::contract_address_const;
    use starknet::ContractAddress;
    use starknet::ContractAddressZeroable;

    struct Storage {
        world_address: ContractAddress,
        name: felt252,
        symbol: felt252,
        owners: LegacyMap<u256, ContractAddress>,
        balances: LegacyMap<ContractAddress, u256>,
        token_approvals: LegacyMap<u256, ContractAddress>,
        operator_approvals: LegacyMap<(ContractAddress, ContractAddress), bool>,
        token_uri: LegacyMap<u256, felt252>,
    }

    #[event]
    fn Transfer(from: ContractAddress, to: ContractAddress, token_id: u256) {}

    #[event]
    fn Approval(owner: ContractAddress, approved: ContractAddress, token_id: u256) {}

    #[event]
    fn ApprovalForAll(owner: ContractAddress, operator: ContractAddress, approved: bool) {}

    #[constructor]
    fn constructor(
        world_address_: ContractAddress, name_: felt252, symbol_: felt252, token_uri_: felt252
    ) {
        // dojo
        world_address::write(world_address_);

        // erc721
        name::write(name_);
        symbol::write(symbol_);
        token_uri::write(token_uri_);
    }

    #[view]
    fn name() -> felt252 {
        name::read()
    }

    #[view]
    fn symbol() -> felt252 {
        symbol::read()
    }

    #[view]
    fn token_uri(token_id: u256) -> felt252 {
        token_uri::read(token_id)
    }


    #[view]
    fn balance_of(account: ContractAddress) -> u256 {
        balances::read(account)
    }

    #[view]
    fn owner_of(token_id: u256) -> ContractAddress {
        owners::read(token_id)
    }

    #[view]
    fn get_approved(token_id: u256) -> ContractAddress {
        token_approvals::read(token_id)
    }

    #[view]
    fn is_approved_for_all(owner: ContractAddress, operator: ContractAddress) -> bool {
        operator_approvals::read(owner, operator)
    }

    #[external]
    fn approve(to: ContractAddress, token_id: u256) {

        let calldata = ArrayTrait::<felt252>::new();

        calldata.append(starknet::get_contract_address().into());
        calldata.append(to.into());
        calldata.append(token_id.try_into());

        IWorldDispatcher {
            contract_address: world_address::read()
        }.execute('ERC721_Approve', calldata.span());

        Approval(get_caller_address(), to, token_id);
    }

    #[external]
    fn set_approval_for_all(operator: ContractAddress, approved: bool) {

        let calldata = ArrayTrait::<felt252>::new();

        calldata.append(starknet::get_contract_address().into());
        calldata.append(operator.into());
        calldata.append(approved.try_into());

        IWorldDispatcher {
            contract_address: world_address::read()
        }.execute('ERC721_Approve_For_All', calldata.span());

        ApprovalForAll(get_caller_address(), operator, approved);
    }

    #[external]
    fn transfer_from(from: ContractAddress, to: ContractAddress, token_id: u256) {

        let calldata = ArrayTrait::<felt252>::new();

        calldata.append(starknet::get_contract_address().into());
        calldata.append(from.into());
        calldata.append(to.into());
        calldata.append(token_id.try_into());

        IWorldDispatcher {
            contract_address: world_address::read()
        }.execute('ERC721_Tranfer_From', calldata.span());

        Transfer(from, to, token_id);
    }
}
