# Ledger Dock app
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)


-------------------
## Credits
This app is a fork of [ledger-polkadot](https://github.com/Zondax/ledger-polkadot) developed by [zondax.ch](zondax.ch). It has been modified to work with [Dock](https://www.dock.io/).
![zondax](docs/zondax.jpg)

_Visit Zondax website at [zondax.ch](zondax.ch)_

![dock](docs/dock.png)

_Visit Dock's website at [dock.io](https://www.dock.io/)_

## Overview

This project contains the Dock app (https://dock.io/) for Ledger Nano S and X.

- Ledger Nano S/X BOLOS app
- Specs / Documentation

For more information: [How to build](docs/build.md)

## ATTENTION

Please:

- **Do not use a Ledger device with funds for development purposes.**
- **Have a separate and marked device that is used ONLY for development and testing**

# Dock 1.36.x

## System

| Name        | Light | XL | Nesting | Arguments |
| :---------- |:------------:|:--------:|:--------:|:--------|
|fill_block |    | :heavy_check_mark: | :heavy_check_mark: | `Perbill` _ratio <br/> |
|remark |    | :heavy_check_mark: | :heavy_check_mark: | `Bytes` _remark <br/> |
|set_heap_pages |    | :heavy_check_mark: | :heavy_check_mark: | `u64` pages <br/> |
|set_code |    | :heavy_check_mark: | :heavy_check_mark: | `Bytes` code <br/> |
|set_code_without_checks |    | :heavy_check_mark: | :heavy_check_mark: | `Bytes` code <br/> |
|set_changes_trie_config |    |   |   | `Option<ChangesTrieConfiguration>` changes_trie_config <br/> |
|set_storage |    |   |   | `Vec<KeyValue>` items <br/> |
|kill_storage |    |   |   | `Vec<Key>` keys <br/> |
|kill_prefix |    |   |   | `Key` prefix <br/>`u32` _subkeys <br/> |
|remark_with_event |    | :heavy_check_mark: |   | `Bytes` remark <br/> |

## Scheduler

| Name        | Light | XL | Nesting | Arguments |
| :---------- |:------------:|:--------:|:--------:|:--------|
|schedule |    |   |   | `BlockNumber` when <br/>`Option<Period>` maybe_periodic <br/>`Priority` priority <br/>`Call` call <br/> |
|cancel |    |   |   | `BlockNumber` when <br/>`u32` index <br/> |
|schedule_named |    |   |   | `Bytes` id <br/>`BlockNumber` when <br/>`Option<Period>` maybe_periodic <br/>`Priority` priority <br/>`Call` call <br/> |
|cancel_named |    |   |   | `Bytes` id <br/> |
|schedule_after |    |   |   | `BlockNumber` after <br/>`Option<Period>` maybe_periodic <br/>`Priority` priority <br/>`Call` call <br/> |
|schedule_named_after |    |   |   | `Bytes` id <br/>`BlockNumber` after <br/>`Option<Period>` maybe_periodic <br/>`Priority` priority <br/>`Call` call <br/> |

## Babe

| Name        | Light | XL | Nesting | Arguments |
| :---------- |:------------:|:--------:|:--------:|:--------|
|report_equivocation |    |   |   | `BabeEquivocationProof` equivocation_proof <br/>`KeyOwnerProof` key_owner_proof <br/> |
|report_equivocation_unsigned |    |   |   | `BabeEquivocationProof` equivocation_proof <br/>`KeyOwnerProof` key_owner_proof <br/> |
|plan_config_change |    |   |   | `NextConfigDescriptor` config <br/> |

## Timestamp

| Name        | Light | XL | Nesting | Arguments |
| :---------- |:------------:|:--------:|:--------:|:--------|
|set |    | :heavy_check_mark: |   | `Compact<Moment>` now <br/> |

## Balances

| Name        | Light | XL | Nesting | Arguments |
| :---------- |:------------:|:--------:|:--------:|:--------|
|transfer | :heavy_check_mark:  | :heavy_check_mark: | :heavy_check_mark: | `LookupSource` dest <br/>`Compact<Balance>` value <br/> |
|set_balance |    | :heavy_check_mark: | :heavy_check_mark: | `LookupSource` who <br/>`Compact<Balance>` new_free <br/>`Compact<Balance>` new_reserved <br/> |
|force_transfer |    | :heavy_check_mark: | :heavy_check_mark: | `LookupSource` source <br/>`LookupSource` dest <br/>`Compact<Balance>` value <br/> |
|transfer_keep_alive | :heavy_check_mark:  | :heavy_check_mark: | :heavy_check_mark: | `LookupSource` dest <br/>`Compact<Balance>` value <br/> |

## TransactionPayment

Empty

## Authorship

| Name        | Light | XL | Nesting | Arguments |
| :---------- |:------------:|:--------:|:--------:|:--------|
|set_uncles |    |   |   | `Vec<Header>` new_uncles <br/> |

## Staking

| Name        | Light | XL | Nesting | Arguments |
| :---------- |:------------:|:--------:|:--------:|:--------|
|bond | :heavy_check_mark:  | :heavy_check_mark: |   | `LookupSource` controller <br/>`Compact<BalanceOf>` value <br/>`RewardDestination` payee <br/> |
|bond_extra | :heavy_check_mark:  | :heavy_check_mark: |   | `Compact<BalanceOf>` max_additional <br/> |
|unbond | :heavy_check_mark:  | :heavy_check_mark: |   | `Compact<BalanceOf>` value <br/> |
|withdraw_unbonded | :heavy_check_mark:  | :heavy_check_mark: |   | `u32` num_slashing_spans <br/> |
|validate | :heavy_check_mark:  | :heavy_check_mark: |   | `ValidatorPrefs` prefs <br/> |
|nominate | :heavy_check_mark:  | :heavy_check_mark: |   | `Vec<LookupSource>` targets <br/> |
|chill | :heavy_check_mark:  | :heavy_check_mark: |   |  |
|set_payee | :heavy_check_mark:  | :heavy_check_mark: |   | `RewardDestination` payee <br/> |
|set_controller |    | :heavy_check_mark: |   | `LookupSource` controller <br/> |
|set_validator_count |    | :heavy_check_mark: |   | `Compact<u32>` new <br/> |
|increase_validator_count |    | :heavy_check_mark: |   | `Compact<u32>` additional <br/> |
|scale_validator_count |    |   |   | `Percent` factor <br/> |
|force_no_eras |    | :heavy_check_mark: |   |  |
|force_new_era |    | :heavy_check_mark: |   |  |
|set_invulnerables |    | :heavy_check_mark: |   | `Vec<AccountId>` invulnerables <br/> |
|force_unstake |    | :heavy_check_mark: |   | `AccountId` stash <br/>`u32` num_slashing_spans <br/> |
|force_new_era_always |    | :heavy_check_mark: |   |  |
|cancel_deferred_slash |    | :heavy_check_mark: |   | `EraIndex` era <br/>`Vec<u32>` slash_indices <br/> |
|payout_stakers | :heavy_check_mark:  | :heavy_check_mark: |   | `AccountId` validator_stash <br/>`EraIndex` era <br/> |
|rebond | :heavy_check_mark:  | :heavy_check_mark: |   | `Compact<BalanceOf>` value <br/> |
|set_history_depth |    | :heavy_check_mark: |   | `Compact<EraIndex>` new_history_depth <br/>`Compact<u32>` _era_items_deleted <br/> |
|reap_stash |    | :heavy_check_mark: |   | `AccountId` stash <br/>`u32` num_slashing_spans <br/> |
|kick |    | :heavy_check_mark: |   | `Vec<LookupSource>` who <br/> |

## Offences

| Name        | Light | XL | Nesting | Arguments |
| :---------- |:------------:|:--------:|:--------:|:--------|

## Historical

Empty

## Session

| Name        | Light | XL | Nesting | Arguments |
| :---------- |:------------:|:--------:|:--------:|:--------|
|set_keys | :heavy_check_mark:  | :heavy_check_mark: |   | `Keys` keys <br/>`Bytes` proof <br/> |
|purge_keys | :heavy_check_mark:  | :heavy_check_mark: |   |  |

## Grandpa

| Name        | Light | XL | Nesting | Arguments |
| :---------- |:------------:|:--------:|:--------:|:--------|
|report_equivocation |    |   |   | `GrandpaEquivocationProof` equivocation_proof <br/>`KeyOwnerProof` key_owner_proof <br/> |
|report_equivocation_unsigned |    |   |   | `GrandpaEquivocationProof` equivocation_proof <br/>`KeyOwnerProof` key_owner_proof <br/> |
|note_stalled |    | :heavy_check_mark: |   | `BlockNumber` delay <br/>`BlockNumber` best_finalized_block_number <br/> |

## ImOnline

| Name        | Light | XL | Nesting | Arguments |
| :---------- |:------------:|:--------:|:--------:|:--------|
|heartbeat |    |   |   | `Heartbeat` heartbeat <br/>`Signature` _signature <br/> |

## AuthorityDiscovery

| Name        | Light | XL | Nesting | Arguments |
| :---------- |:------------:|:--------:|:--------:|:--------|

## Democracy

| Name        | Light | XL | Nesting | Arguments |
| :---------- |:------------:|:--------:|:--------:|:--------|
|propose |    | :heavy_check_mark: |   | `Hash` proposal_hash <br/>`Compact<BalanceOf>` value <br/> |
|second |    | :heavy_check_mark: |   | `Compact<PropIndex>` proposal <br/>`Compact<u32>` seconds_upper_bound <br/> |
|vote |    | :heavy_check_mark: |   | `Compact<ReferendumIndex>` ref_index <br/>`AccountVote` vote <br/> |
|emergency_cancel |    | :heavy_check_mark: |   | `ReferendumIndex` ref_index <br/> |
|external_propose |    | :heavy_check_mark: |   | `Hash` proposal_hash <br/> |
|external_propose_majority |    | :heavy_check_mark: |   | `Hash` proposal_hash <br/> |
|external_propose_default |    | :heavy_check_mark: |   | `Hash` proposal_hash <br/> |
|fast_track |    | :heavy_check_mark: |   | `Hash` proposal_hash <br/>`BlockNumber` voting_period <br/>`BlockNumber` delay <br/> |
|veto_external |    | :heavy_check_mark: |   | `Hash` proposal_hash <br/> |
|cancel_referendum |    | :heavy_check_mark: |   | `Compact<ReferendumIndex>` ref_index <br/> |
|cancel_queued |    | :heavy_check_mark: |   | `ReferendumIndex` which <br/> |
|delegate |    | :heavy_check_mark: |   | `AccountId` to <br/>`Conviction` conviction <br/>`BalanceOf` balance <br/> |
|undelegate |    | :heavy_check_mark: |   |  |
|clear_public_proposals |    | :heavy_check_mark: |   |  |
|note_preimage |    | :heavy_check_mark: |   | `Bytes` encoded_proposal <br/> |
|note_preimage_operational |    | :heavy_check_mark: |   | `Bytes` encoded_proposal <br/> |
|note_imminent_preimage |    | :heavy_check_mark: |   | `Bytes` encoded_proposal <br/> |
|note_imminent_preimage_operational |    | :heavy_check_mark: |   | `Bytes` encoded_proposal <br/> |
|reap_preimage |    | :heavy_check_mark: |   | `Hash` proposal_hash <br/>`Compact<u32>` proposal_len_upper_bound <br/> |
|unlock |    | :heavy_check_mark: |   | `AccountId` target <br/> |
|remove_vote |    | :heavy_check_mark: |   | `ReferendumIndex` index <br/> |
|remove_other_vote |    | :heavy_check_mark: |   | `AccountId` target <br/>`ReferendumIndex` index <br/> |
|enact_proposal |    | :heavy_check_mark: |   | `Hash` proposal_hash <br/>`ReferendumIndex` index <br/> |
|blacklist |    |   |   | `Hash` proposal_hash <br/>`Option<ReferendumIndex>` maybe_ref_index <br/> |
|cancel_proposal |    | :heavy_check_mark: |   | `Compact<PropIndex>` prop_index <br/> |

## Council

| Name        | Light | XL | Nesting | Arguments |
| :---------- |:------------:|:--------:|:--------:|:--------|
|set_members |    | :heavy_check_mark: |   | `Vec<AccountId>` new_members <br/>`Option<AccountId>` prime <br/>`MemberCount` old_count <br/> |
|execute |    |   |   | `Proposal` proposal <br/>`Compact<u32>` length_bound <br/> |
|propose |    |   |   | `Compact<MemberCount>` threshold <br/>`Proposal` proposal <br/>`Compact<u32>` length_bound <br/> |
|vote |    | :heavy_check_mark: |   | `Hash` proposal <br/>`Compact<ProposalIndex>` index <br/>`bool` approve <br/> |
|close |    | :heavy_check_mark: |   | `Hash` proposal_hash <br/>`Compact<ProposalIndex>` index <br/>`Compact<Weight>` proposal_weight_bound <br/>`Compact<u32>` length_bound <br/> |
|disapprove_proposal |    | :heavy_check_mark: |   | `Hash` proposal_hash <br/> |

## TechnicalCommittee

| Name        | Light | XL | Nesting | Arguments |
| :---------- |:------------:|:--------:|:--------:|:--------|
|set_members |    | :heavy_check_mark: |   | `Vec<AccountId>` new_members <br/>`Option<AccountId>` prime <br/>`MemberCount` old_count <br/> |
|execute |    |   |   | `Proposal` proposal <br/>`Compact<u32>` length_bound <br/> |
|propose |    |   |   | `Compact<MemberCount>` threshold <br/>`Proposal` proposal <br/>`Compact<u32>` length_bound <br/> |
|vote |    | :heavy_check_mark: |   | `Hash` proposal <br/>`Compact<ProposalIndex>` index <br/>`bool` approve <br/> |
|close |    | :heavy_check_mark: |   | `Hash` proposal_hash <br/>`Compact<ProposalIndex>` index <br/>`Compact<Weight>` proposal_weight_bound <br/>`Compact<u32>` length_bound <br/> |
|disapprove_proposal |    | :heavy_check_mark: |   | `Hash` proposal_hash <br/> |

## PhragmenElection

| Name        | Light | XL | Nesting | Arguments |
| :---------- |:------------:|:--------:|:--------:|:--------|
|vote |    | :heavy_check_mark: |   | `Vec<AccountId>` votes <br/>`Compact<BalanceOf>` value <br/> |
|remove_voter |    | :heavy_check_mark: |   |  |
|submit_candidacy |    | :heavy_check_mark: |   | `Compact<u32>` candidate_count <br/> |
|renounce_candidacy |    |   |   | `Renouncing` renouncing <br/> |
|remove_member |    | :heavy_check_mark: |   | `LookupSource` who <br/>`bool` has_replacement <br/> |
|clean_defunct_voters |    | :heavy_check_mark: |   | `u32` _num_voters <br/>`u32` _num_defunct <br/> |

## TechnicalMembership

| Name        | Light | XL | Nesting | Arguments |
| :---------- |:------------:|:--------:|:--------:|:--------|
|add_member |    | :heavy_check_mark: |   | `AccountId` who <br/> |
|remove_member |    | :heavy_check_mark: |   | `AccountId` who <br/> |
|swap_member |    | :heavy_check_mark: |   | `AccountId` remove <br/>`AccountId` add <br/> |
|reset_members |    | :heavy_check_mark: |   | `Vec<AccountId>` members <br/> |
|change_key |    | :heavy_check_mark: |   | `AccountId` new <br/> |
|set_prime |    | :heavy_check_mark: |   | `AccountId` who <br/> |
|clear_prime |    | :heavy_check_mark: |   |  |

## Treasury

| Name        | Light | XL | Nesting | Arguments |
| :---------- |:------------:|:--------:|:--------:|:--------|
|propose_spend |    | :heavy_check_mark: |   | `Compact<BalanceOf>` value <br/>`LookupSource` beneficiary <br/> |
|reject_proposal |    | :heavy_check_mark: |   | `Compact<ProposalIndex>` proposal_id <br/> |
|approve_proposal |    | :heavy_check_mark: |   | `Compact<ProposalIndex>` proposal_id <br/> |

## Utility

| Name        | Light | XL | Nesting | Arguments |
| :---------- |:------------:|:--------:|:--------:|:--------|
|batch | :heavy_check_mark:  | :heavy_check_mark: |   | `Vec<Call>` calls <br/> |
|as_derivative |    |   |   | `u16` index <br/>`Call` call <br/> |
|batch_all | :heavy_check_mark:  | :heavy_check_mark: |   | `Vec<Call>` calls <br/> |

## Identity

| Name        | Light | XL | Nesting | Arguments |
| :---------- |:------------:|:--------:|:--------:|:--------|
|add_registrar |    | :heavy_check_mark: |   | `AccountId` account <br/> |
|set_identity |    |   |   | `IdentityInfo` info <br/> |
|set_subs |    |   |   | `Vec<(AccountId,Data)>` subs <br/> |
|clear_identity |    | :heavy_check_mark: |   |  |
|request_judgement |    | :heavy_check_mark: |   | `Compact<RegistrarIndex>` reg_index <br/>`Compact<BalanceOf>` max_fee <br/> |
|cancel_request |    | :heavy_check_mark: |   | `RegistrarIndex` reg_index <br/> |
|set_fee |    | :heavy_check_mark: |   | `Compact<RegistrarIndex>` index <br/>`Compact<BalanceOf>` fee <br/> |
|set_account_id |    | :heavy_check_mark: |   | `Compact<RegistrarIndex>` index <br/>`AccountId` new <br/> |
|set_fields |    |   |   | `Compact<RegistrarIndex>` index <br/>`IdentityFields` fields <br/> |
|provide_judgement |    |   |   | `Compact<RegistrarIndex>` reg_index <br/>`LookupSource` target <br/>`IdentityJudgement` judgement <br/> |
|kill_identity |    | :heavy_check_mark: |   | `LookupSource` target <br/> |
|add_sub |    |   |   | `LookupSource` sub <br/>`Data` data <br/> |
|rename_sub |    |   |   | `LookupSource` sub <br/>`Data` data <br/> |
|remove_sub |    | :heavy_check_mark: |   | `LookupSource` sub <br/> |
|quit_sub |    | :heavy_check_mark: |   |  |

## Bounties

| Name        | Light | XL | Nesting | Arguments |
| :---------- |:------------:|:--------:|:--------:|:--------|
|propose_bounty |    | :heavy_check_mark: |   | `Compact<BalanceOf>` value <br/>`Bytes` description <br/> |
|approve_bounty |    | :heavy_check_mark: |   | `Compact<BountyIndex>` bounty_id <br/> |
|propose_curator |    | :heavy_check_mark: |   | `Compact<BountyIndex>` bounty_id <br/>`LookupSource` curator <br/>`Compact<BalanceOf>` fee <br/> |
|unassign_curator |    | :heavy_check_mark: |   | `Compact<BountyIndex>` bounty_id <br/> |
|accept_curator |    | :heavy_check_mark: |   | `Compact<BountyIndex>` bounty_id <br/> |
|award_bounty |    | :heavy_check_mark: |   | `Compact<BountyIndex>` bounty_id <br/>`LookupSource` beneficiary <br/> |
|claim_bounty |    | :heavy_check_mark: |   | `Compact<BountyIndex>` bounty_id <br/> |
|close_bounty |    | :heavy_check_mark: |   | `Compact<BountyIndex>` bounty_id <br/> |
|extend_bounty_expiry |    | :heavy_check_mark: |   | `Compact<BountyIndex>` bounty_id <br/>`Bytes` _remark <br/> |

## Tips

| Name        | Light | XL | Nesting | Arguments |
| :---------- |:------------:|:--------:|:--------:|:--------|
|report_awesome |    | :heavy_check_mark: |   | `Bytes` reason <br/>`AccountId` who <br/> |
|retract_tip |    | :heavy_check_mark: |   | `Hash` hash <br/> |
|tip_new |    | :heavy_check_mark: |   | `Bytes` reason <br/>`AccountId` who <br/>`Compact<BalanceOf>` tip_value <br/> |
|tip |    | :heavy_check_mark: |   | `Hash` hash <br/>`Compact<BalanceOf>` tip_value <br/> |
|close_tip |    | :heavy_check_mark: |   | `Hash` hash <br/> |
|slash_tip |    | :heavy_check_mark: |   | `Hash` hash <br/> |

## ElectionProviderMultiPhase

| Name        | Light | XL | Nesting | Arguments |
| :---------- |:------------:|:--------:|:--------:|:--------|
|submit_unsigned |    |   |   | `RawSolution` solution <br/>`SolutionOrSnapshotSize` witness <br/> |

