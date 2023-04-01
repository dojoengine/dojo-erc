#[system]
mod ERC20_Approve {
    use traits::Into;
    use starknet::ContractAddress;
    use dojo::storage::key::StorageKey;

    #[external]
    #[raw_output]
    fn execute(operator: ContractAddress, approved: felt252) {

        // check owner
        let caller = starknet::get_caller_address();

        let approval_sk: StorageKey = (operator, (caller.into(), approved)).into(); // does this work?

        commands::set(approval_sk, (
            ApprovalForAll { operator: operator, approved: approved }
        ))
    }
}
