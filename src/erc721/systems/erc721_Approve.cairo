#[system]
mod ERC20_Approve {
    use traits::Into;
    use starknet::ContractAddress;
    use dojo::storage::key::StorageKey;
    
    #[external]
    #[raw_output]
    fn execute(to: ContractAddress, token_id: felt252) {

        // check owner and exists
        
        let caller = starknet::get_caller_address();

        let approval_sk: StorageKey = (to, (caller.into(), token_id)).into();

        commands::set(approval_sk, (Approval { to: to, token_id: token_id }))
    }
}
