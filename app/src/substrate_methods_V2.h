/*******************************************************************************
*  (c) 2019 Zondax GmbH
*
*  Licensed under the Apache License, Version 2.0 (the "License");
*  you may not use this file except in compliance with the License.
*  You may obtain a copy of the License at
*
*      http://www.apache.org/licenses/LICENSE-2.0
*
*  Unless required by applicable law or agreed to in writing, software
*  distributed under the License is distributed on an "AS IS" BASIS,
*  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
*  See the License for the specific language governing permissions and
*  limitations under the License.
********************************************************************************/
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wextern-c-compat"
#pragma once

#ifdef __cplusplus
extern "C" {
#endif

#include "substrate_types.h"
#include "substrate_types_V2.h"
#include <stddef.h>
#include <stdint.h>

#define PD_CALL_SYSTEM_V2 0
#define PD_CALL_SCHEDULER_V2 22
#define PD_CALL_BABE_V2 30
#define PD_CALL_TIMESTAMP_V2 1
#define PD_CALL_BALANCES_V2 2
#define PD_CALL_AUTHORSHIP_V2 6
#define PD_CALL_STAKING_V2 31
#define PD_CALL_OFFENCES_V2 33
#define PD_CALL_SESSION_V2 3
#define PD_CALL_GRANDPA_V2 5
#define PD_CALL_IMONLINE_V2 29
#define PD_CALL_AUTHORITYDISCOVERY_V2 27
#define PD_CALL_DEMOCRACY_V2 18
#define PD_CALL_COUNCIL_V2 19
#define PD_CALL_TECHNICALCOMMITTEE_V2 20
#define PD_CALL_ELECTIONS_V2 37
#define PD_CALL_TECHNICALCOMMITTEEMEMBERSHIP_V2 21
#define PD_CALL_TREASURY_V2 32
#define PD_CALL_UTILITY_V2 8
#define PD_CALL_IDENTITY_V2 39
#define PD_CALL_BOUNTIES_V2 35
#define PD_CALL_TIPS_V2 38
#define PD_CALL_ELECTIONPROVIDERMULTIPHASE_V2 32
#define PD_CALL_POAMODULE_V2 4
#define PD_CALL_DIDMODULE_V2 10
#define PD_CALL_REVOKE_V2 11
#define PD_CALL_BLOB_STORE_V2 12
#define PD_CALL_ANCHOR_V2 16
#define PD_CALL_ATTEST_V2 17

#define PD_CALL_BALANCES_TRANSFER_V2 0
    typedef struct {
        pd_LookupSource_V2_t dest;
        pd_CompactBalance_t value;
    } pd_balances_transfer_V2_t;

#define PD_CALL_BALANCES_TRANSFER_KEEP_ALIVE_V2 3
    typedef struct {
        pd_LookupSource_V2_t dest;
        pd_CompactBalance_t value;
    } pd_balances_transfer_keep_alive_V2_t;

#define PD_CALL_STAKING_BOND_V2 0
    typedef struct {
        pd_LookupSource_V2_t controller;
        pd_CompactBalanceOf_t value;
        pd_RewardDestination_V2_t payee;
    } pd_staking_bond_V2_t;

#define PD_CALL_STAKING_BOND_EXTRA_V2 1
    typedef struct {
        pd_CompactBalanceOf_t max_additional;
    } pd_staking_bond_extra_V2_t;

#define PD_CALL_STAKING_UNBOND_V2 2
    typedef struct {
        pd_CompactBalanceOf_t value;
    } pd_staking_unbond_V2_t;

#define PD_CALL_STAKING_WITHDRAW_UNBONDED_V2 3
    typedef struct {
        pd_u32_t num_slashing_spans;
    } pd_staking_withdraw_unbonded_V2_t;

#define PD_CALL_STAKING_VALIDATE_V2 4
    typedef struct {
        pd_ValidatorPrefs_V2_t prefs;
    } pd_staking_validate_V2_t;

#define PD_CALL_STAKING_NOMINATE_V2 5
    typedef struct {
        pd_VecLookupSource_V2_t targets;
    } pd_staking_nominate_V2_t;

#define PD_CALL_STAKING_CHILL_V2 6
    typedef struct {
    } pd_staking_chill_V2_t;

#define PD_CALL_STAKING_SET_PAYEE_V2 7
    typedef struct {
        pd_RewardDestination_V2_t payee;
    } pd_staking_set_payee_V2_t;

#define PD_CALL_STAKING_PAYOUT_STAKERS_V2 18
    typedef struct {
        pd_AccountId_V2_t validator_stash;
        pd_EraIndex_V2_t era;
    } pd_staking_payout_stakers_V2_t;

#define PD_CALL_STAKING_REBOND_V2 19
    typedef struct {
        pd_CompactBalanceOf_t value;
    } pd_staking_rebond_V2_t;

#define PD_CALL_SESSION_SET_KEYS_V2 0
    typedef struct {
        pd_Keys_V2_t keys;
        pd_Bytes_t proof;
    } pd_session_set_keys_V2_t;

#define PD_CALL_SESSION_PURGE_KEYS_V2 1
    typedef struct {
    } pd_session_purge_keys_V2_t;

#define PD_CALL_UTILITY_BATCH_V2 0
    typedef struct {
        pd_VecCall_t calls;
    } pd_utility_batch_V2_t;

#define PD_CALL_UTILITY_BATCH_ALL_V2 2
    typedef struct {
        pd_VecCall_t calls;
    } pd_utility_batch_all_V2_t;

#ifdef SUBSTRATE_PARSER_FULL
#define PD_CALL_SYSTEM_FILL_BLOCK_V2 0
    typedef struct {
        pd_Perbill_V2_t _ratio;
    } pd_system_fill_block_V2_t;

#define PD_CALL_SYSTEM_REMARK_V2 1
    typedef struct {
        pd_Bytes_t _remark;
    } pd_system_remark_V2_t;

#define PD_CALL_SYSTEM_SET_HEAP_PAGES_V2 2
    typedef struct {
        pd_u64_t pages;
    } pd_system_set_heap_pages_V2_t;

#define PD_CALL_SYSTEM_SET_CODE_V2 3
    typedef struct {
        pd_Bytes_t code;
    } pd_system_set_code_V2_t;

#define PD_CALL_SYSTEM_SET_CODE_WITHOUT_CHECKS_V2 4
    typedef struct {
        pd_Bytes_t code;
    } pd_system_set_code_without_checks_V2_t;

#define PD_CALL_SYSTEM_SET_CHANGES_TRIE_CONFIG_V2 5
    typedef struct {
        pd_OptionChangesTrieConfiguration_V2_t changes_trie_config;
    } pd_system_set_changes_trie_config_V2_t;

#define PD_CALL_SYSTEM_SET_STORAGE_V2 6
    typedef struct {
        pd_VecKeyValue_V2_t items;
    } pd_system_set_storage_V2_t;

#define PD_CALL_SYSTEM_KILL_STORAGE_V2 7
    typedef struct {
        pd_VecKey_V2_t keys;
    } pd_system_kill_storage_V2_t;

#define PD_CALL_SYSTEM_KILL_PREFIX_V2 8
    typedef struct {
        pd_Key_V2_t prefix;
        pd_u32_t _subkeys;
    } pd_system_kill_prefix_V2_t;

#define PD_CALL_SYSTEM_REMARK_WITH_EVENT_V2 9
    typedef struct {
        pd_Bytes_t remark;
    } pd_system_remark_with_event_V2_t;

#define PD_CALL_SCHEDULER_SCHEDULE_V2 0
    typedef struct {
        pd_BlockNumber_t when;
        pd_OptionPeriod_V2_t maybe_periodic;
        pd_Priority_V2_t priority;
        pd_Call_t call;
    } pd_scheduler_schedule_V2_t;

#define PD_CALL_SCHEDULER_CANCEL_V2 1
    typedef struct {
        pd_BlockNumber_t when;
        pd_u32_t index;
    } pd_scheduler_cancel_V2_t;

#define PD_CALL_SCHEDULER_SCHEDULE_NAMED_V2 2
    typedef struct {
        pd_Bytes_t id;
        pd_BlockNumber_t when;
        pd_OptionPeriod_V2_t maybe_periodic;
        pd_Priority_V2_t priority;
        pd_Call_t call;
    } pd_scheduler_schedule_named_V2_t;

#define PD_CALL_SCHEDULER_CANCEL_NAMED_V2 3
    typedef struct {
        pd_Bytes_t id;
    } pd_scheduler_cancel_named_V2_t;

#define PD_CALL_SCHEDULER_SCHEDULE_AFTER_V2 4
    typedef struct {
        pd_BlockNumber_t after;
        pd_OptionPeriod_V2_t maybe_periodic;
        pd_Priority_V2_t priority;
        pd_Call_t call;
    } pd_scheduler_schedule_after_V2_t;

#define PD_CALL_SCHEDULER_SCHEDULE_NAMED_AFTER_V2 5
    typedef struct {
        pd_Bytes_t id;
        pd_BlockNumber_t after;
        pd_OptionPeriod_V2_t maybe_periodic;
        pd_Priority_V2_t priority;
        pd_Call_t call;
    } pd_scheduler_schedule_named_after_V2_t;

#define PD_CALL_BABE_REPORT_EQUIVOCATION_V2 0
    typedef struct {
        pd_BabeEquivocationProof_V2_t equivocation_proof;
        pd_KeyOwnerProof_V2_t key_owner_proof;
    } pd_babe_report_equivocation_V2_t;

#define PD_CALL_BABE_REPORT_EQUIVOCATION_UNSIGNED_V2 1
    typedef struct {
        pd_BabeEquivocationProof_V2_t equivocation_proof;
        pd_KeyOwnerProof_V2_t key_owner_proof;
    } pd_babe_report_equivocation_unsigned_V2_t;

#define PD_CALL_TIMESTAMP_SET_V2 0
    typedef struct {
        pd_CompactMoment_V2_t now;
    } pd_timestamp_set_V2_t;

#define PD_CALL_BALANCES_SET_BALANCE_V2 1
    typedef struct {
        pd_LookupSource_V2_t who;
        pd_CompactBalance_t new_free;
        pd_CompactBalance_t new_reserved;
    } pd_balances_set_balance_V2_t;

#define PD_CALL_BALANCES_FORCE_TRANSFER_V2 2
    typedef struct {
        pd_LookupSource_V2_t source;
        pd_LookupSource_V2_t dest;
        pd_CompactBalance_t value;
    } pd_balances_force_transfer_V2_t;

#define PD_CALL_AUTHORSHIP_SET_UNCLES_V2 0
    typedef struct {
        pd_VecHeader_t new_uncles;
    } pd_authorship_set_uncles_V2_t;

#define PD_CALL_STAKING_SET_CONTROLLER_V2 8
    typedef struct {
        pd_LookupSource_V2_t controller;
    } pd_staking_set_controller_V2_t;

#define PD_CALL_STAKING_SET_VALIDATOR_COUNT_V2 9
    typedef struct {
        pd_Compactu32_t new_;
    } pd_staking_set_validator_count_V2_t;

#define PD_CALL_STAKING_INCREASE_VALIDATOR_COUNT_V2 10
    typedef struct {
        pd_Compactu32_t additional;
    } pd_staking_increase_validator_count_V2_t;

#define PD_CALL_STAKING_SCALE_VALIDATOR_COUNT_V2 11
    typedef struct {
        pd_Percent_V2_t factor;
    } pd_staking_scale_validator_count_V2_t;

#define PD_CALL_STAKING_FORCE_NO_ERAS_V2 12
    typedef struct {
    } pd_staking_force_no_eras_V2_t;

#define PD_CALL_STAKING_FORCE_NEW_ERA_V2 13
    typedef struct {
    } pd_staking_force_new_era_V2_t;

#define PD_CALL_STAKING_SET_INVULNERABLES_V2 14
    typedef struct {
        pd_VecAccountId_V2_t invulnerables;
    } pd_staking_set_invulnerables_V2_t;

#define PD_CALL_STAKING_FORCE_UNSTAKE_V2 15
    typedef struct {
        pd_AccountId_V2_t stash;
        pd_u32_t num_slashing_spans;
    } pd_staking_force_unstake_V2_t;

#define PD_CALL_STAKING_FORCE_NEW_ERA_ALWAYS_V2 16
    typedef struct {
    } pd_staking_force_new_era_always_V2_t;

#define PD_CALL_STAKING_CANCEL_DEFERRED_SLASH_V2 17
    typedef struct {
        pd_EraIndex_V2_t era;
        pd_Vecu32_t slash_indices;
    } pd_staking_cancel_deferred_slash_V2_t;

#define PD_CALL_STAKING_SET_HISTORY_DEPTH_V2 20
    typedef struct {
        pd_CompactEraIndex_V2_t new_history_depth;
        pd_Compactu32_t _era_items_deleted;
    } pd_staking_set_history_depth_V2_t;

#define PD_CALL_STAKING_REAP_STASH_V2 21
    typedef struct {
        pd_AccountId_V2_t stash;
        pd_u32_t num_slashing_spans;
    } pd_staking_reap_stash_V2_t;

#define PD_CALL_STAKING_SUBMIT_ELECTION_SOLUTION_V2 22
    typedef struct {
        pd_VecValidatorIndex_V2_t winners;
        pd_CompactAssignments_V2_t compact;
        pd_ElectionScore_V2_t score;
        pd_EraIndex_V2_t era;
        pd_ElectionSize_V2_t size;
    } pd_staking_submit_election_solution_V2_t;

#define PD_CALL_STAKING_SUBMIT_ELECTION_SOLUTION_UNSIGNED_V2 23
    typedef struct {
        pd_VecValidatorIndex_V2_t winners;
        pd_CompactAssignments_V2_t compact;
        pd_ElectionScore_V2_t score;
        pd_EraIndex_V2_t era;
        pd_ElectionSize_V2_t size;
    } pd_staking_submit_election_solution_unsigned_V2_t;

#define PD_CALL_STAKING_KICK_V2 24
    typedef struct {
        pd_VecLookupSource_V2_t who;
    } pd_staking_kick_V2_t;

#define PD_CALL_GRANDPA_REPORT_EQUIVOCATION_V2 0
    typedef struct {
        pd_GrandpaEquivocationProof_V2_t equivocation_proof;
        pd_KeyOwnerProof_V2_t key_owner_proof;
    } pd_grandpa_report_equivocation_V2_t;

#define PD_CALL_GRANDPA_REPORT_EQUIVOCATION_UNSIGNED_V2 1
    typedef struct {
        pd_GrandpaEquivocationProof_V2_t equivocation_proof;
        pd_KeyOwnerProof_V2_t key_owner_proof;
    } pd_grandpa_report_equivocation_unsigned_V2_t;

#define PD_CALL_GRANDPA_NOTE_STALLED_V2 2
    typedef struct {
        pd_BlockNumber_t delay;
        pd_BlockNumber_t best_finalized_block_number;
    } pd_grandpa_note_stalled_V2_t;

#define PD_CALL_IMONLINE_HEARTBEAT_V2 0
    typedef struct {
        pd_Heartbeat_t heartbeat;
        pd_Signature_V2_t _signature;
    } pd_imonline_heartbeat_V2_t;

#define PD_CALL_DEMOCRACY_PROPOSE_V2 0
    typedef struct {
        pd_Hash_t proposal_hash;
        pd_CompactBalanceOf_t value;
    } pd_democracy_propose_V2_t;

#define PD_CALL_DEMOCRACY_SECOND_V2 1
    typedef struct {
        pd_CompactPropIndex_V2_t proposal;
        pd_Compactu32_t seconds_upper_bound;
    } pd_democracy_second_V2_t;

#define PD_CALL_DEMOCRACY_VOTE_V2 2
    typedef struct {
        pd_CompactReferendumIndex_V2_t ref_index;
        pd_AccountVote_V2_t vote;
    } pd_democracy_vote_V2_t;

#define PD_CALL_DEMOCRACY_EMERGENCY_CANCEL_V2 3
    typedef struct {
        pd_ReferendumIndex_V2_t ref_index;
    } pd_democracy_emergency_cancel_V2_t;

#define PD_CALL_DEMOCRACY_EXTERNAL_PROPOSE_V2 4
    typedef struct {
        pd_Hash_t proposal_hash;
    } pd_democracy_external_propose_V2_t;

#define PD_CALL_DEMOCRACY_EXTERNAL_PROPOSE_MAJORITY_V2 5
    typedef struct {
        pd_Hash_t proposal_hash;
    } pd_democracy_external_propose_majority_V2_t;

#define PD_CALL_DEMOCRACY_EXTERNAL_PROPOSE_DEFAULT_V2 6
    typedef struct {
        pd_Hash_t proposal_hash;
    } pd_democracy_external_propose_default_V2_t;

#define PD_CALL_DEMOCRACY_FAST_TRACK_V2 7
    typedef struct {
        pd_Hash_t proposal_hash;
        pd_BlockNumber_t voting_period;
        pd_BlockNumber_t delay;
    } pd_democracy_fast_track_V2_t;

#define PD_CALL_DEMOCRACY_VETO_EXTERNAL_V2 8
    typedef struct {
        pd_Hash_t proposal_hash;
    } pd_democracy_veto_external_V2_t;

#define PD_CALL_DEMOCRACY_CANCEL_REFERENDUM_V2 9
    typedef struct {
        pd_CompactReferendumIndex_V2_t ref_index;
    } pd_democracy_cancel_referendum_V2_t;

#define PD_CALL_DEMOCRACY_CANCEL_QUEUED_V2 10
    typedef struct {
        pd_ReferendumIndex_V2_t which;
    } pd_democracy_cancel_queued_V2_t;

#define PD_CALL_DEMOCRACY_DELEGATE_V2 11
    typedef struct {
        pd_AccountId_V2_t to;
        pd_Conviction_V2_t conviction;
        pd_BalanceOf_t balance;
    } pd_democracy_delegate_V2_t;

#define PD_CALL_DEMOCRACY_UNDELEGATE_V2 12
    typedef struct {
    } pd_democracy_undelegate_V2_t;

#define PD_CALL_DEMOCRACY_CLEAR_PUBLIC_PROPOSALS_V2 13
    typedef struct {
    } pd_democracy_clear_public_proposals_V2_t;

#define PD_CALL_DEMOCRACY_NOTE_PREIMAGE_V2 14
    typedef struct {
        pd_Bytes_t encoded_proposal;
    } pd_democracy_note_preimage_V2_t;

#define PD_CALL_DEMOCRACY_NOTE_PREIMAGE_OPERATIONAL_V2 15
    typedef struct {
        pd_Bytes_t encoded_proposal;
    } pd_democracy_note_preimage_operational_V2_t;

#define PD_CALL_DEMOCRACY_NOTE_IMMINENT_PREIMAGE_V2 16
    typedef struct {
        pd_Bytes_t encoded_proposal;
    } pd_democracy_note_imminent_preimage_V2_t;

#define PD_CALL_DEMOCRACY_NOTE_IMMINENT_PREIMAGE_OPERATIONAL_V2 17
    typedef struct {
        pd_Bytes_t encoded_proposal;
    } pd_democracy_note_imminent_preimage_operational_V2_t;

#define PD_CALL_DEMOCRACY_REAP_PREIMAGE_V2 18
    typedef struct {
        pd_Hash_t proposal_hash;
        pd_Compactu32_t proposal_len_upper_bound;
    } pd_democracy_reap_preimage_V2_t;

#define PD_CALL_DEMOCRACY_UNLOCK_V2 19
    typedef struct {
        pd_AccountId_V2_t target;
    } pd_democracy_unlock_V2_t;

#define PD_CALL_DEMOCRACY_REMOVE_VOTE_V2 20
    typedef struct {
        pd_ReferendumIndex_V2_t index;
    } pd_democracy_remove_vote_V2_t;

#define PD_CALL_DEMOCRACY_REMOVE_OTHER_VOTE_V2 21
    typedef struct {
        pd_AccountId_V2_t target;
        pd_ReferendumIndex_V2_t index;
    } pd_democracy_remove_other_vote_V2_t;

#define PD_CALL_DEMOCRACY_ENACT_PROPOSAL_V2 22
    typedef struct {
        pd_Hash_t proposal_hash;
        pd_ReferendumIndex_V2_t index;
    } pd_democracy_enact_proposal_V2_t;

#define PD_CALL_DEMOCRACY_BLACKLIST_V2 23
    typedef struct {
        pd_Hash_t proposal_hash;
        pd_OptionReferendumIndex_V2_t maybe_ref_index;
    } pd_democracy_blacklist_V2_t;

#define PD_CALL_DEMOCRACY_CANCEL_PROPOSAL_V2 24
    typedef struct {
        pd_CompactPropIndex_V2_t prop_index;
    } pd_democracy_cancel_proposal_V2_t;

#define PD_CALL_COUNCIL_SET_MEMBERS_V2 0
    typedef struct {
        pd_VecAccountId_V2_t new_members;
        pd_OptionAccountId_V2_t prime;
        pd_MemberCount_V2_t old_count;
    } pd_council_set_members_V2_t;

#define PD_CALL_COUNCIL_EXECUTE_V2 1
    typedef struct {
        pd_Proposal_t proposal;
        pd_Compactu32_t length_bound;
    } pd_council_execute_V2_t;

#define PD_CALL_COUNCIL_PROPOSE_V2 2
    typedef struct {
        pd_CompactMemberCount_V2_t threshold;
        pd_Proposal_t proposal;
        pd_Compactu32_t length_bound;
    } pd_council_propose_V2_t;

#define PD_CALL_COUNCIL_VOTE_V2 3
    typedef struct {
        pd_Hash_t proposal;
        pd_CompactProposalIndex_V2_t index;
        pd_bool_t approve;
    } pd_council_vote_V2_t;

#define PD_CALL_COUNCIL_CLOSE_V2 4
    typedef struct {
        pd_Hash_t proposal_hash;
        pd_CompactProposalIndex_V2_t index;
        pd_CompactWeight_V2_t proposal_weight_bound;
        pd_Compactu32_t length_bound;
    } pd_council_close_V2_t;

#define PD_CALL_COUNCIL_DISAPPROVE_PROPOSAL_V2 5
    typedef struct {
        pd_Hash_t proposal_hash;
    } pd_council_disapprove_proposal_V2_t;

#define PD_CALL_TECHNICALCOMMITTEE_SET_MEMBERS_V2 0
    typedef struct {
        pd_VecAccountId_V2_t new_members;
        pd_OptionAccountId_V2_t prime;
        pd_MemberCount_V2_t old_count;
    } pd_technicalcommittee_set_members_V2_t;

#define PD_CALL_TECHNICALCOMMITTEE_EXECUTE_V2 1
    typedef struct {
        pd_Proposal_t proposal;
        pd_Compactu32_t length_bound;
    } pd_technicalcommittee_execute_V2_t;

#define PD_CALL_TECHNICALCOMMITTEE_PROPOSE_V2 2
    typedef struct {
        pd_CompactMemberCount_V2_t threshold;
        pd_Proposal_t proposal;
        pd_Compactu32_t length_bound;
    } pd_technicalcommittee_propose_V2_t;

#define PD_CALL_TECHNICALCOMMITTEE_VOTE_V2 3
    typedef struct {
        pd_Hash_t proposal;
        pd_CompactProposalIndex_V2_t index;
        pd_bool_t approve;
    } pd_technicalcommittee_vote_V2_t;

#define PD_CALL_TECHNICALCOMMITTEE_CLOSE_V2 4
    typedef struct {
        pd_Hash_t proposal_hash;
        pd_CompactProposalIndex_V2_t index;
        pd_CompactWeight_V2_t proposal_weight_bound;
        pd_Compactu32_t length_bound;
    } pd_technicalcommittee_close_V2_t;

#define PD_CALL_TECHNICALCOMMITTEE_DISAPPROVE_PROPOSAL_V2 5
    typedef struct {
        pd_Hash_t proposal_hash;
    } pd_technicalcommittee_disapprove_proposal_V2_t;

#define PD_CALL_ELECTIONS_VOTE_V2 0
    typedef struct {
        pd_VecAccountId_V2_t votes;
        pd_CompactBalanceOf_t value;
    } pd_electionsphragmen_vote_V2_t;

#define PD_CALL_ELECTIONS_REMOVE_VOTER_V2 1
    typedef struct {
    } pd_electionsphragmen_remove_voter_V2_t;

#define PD_CALL_ELECTIONS_SUBMIT_CANDIDACY_V2 2
    typedef struct {
        pd_Compactu32_t candidate_count;
    } pd_electionsphragmen_submit_candidacy_V2_t;

#define PD_CALL_ELECTIONS_RENOUNCE_CANDIDACY_V2 3
    typedef struct {
        pd_Renouncing_V2_t renouncing;
    } pd_electionsphragmen_renounce_candidacy_V2_t;

#define PD_CALL_ELECTIONS_REMOVE_MEMBER_V2 4
    typedef struct {
        pd_LookupSource_V2_t who;
        pd_bool_t has_replacement;
    } pd_electionsphragmen_remove_member_V2_t;

#define PD_CALL_ELECTIONS_CLEAN_DEFUNCT_VOTERS_V2 5
    typedef struct {
        pd_u32_t _num_voters;
        pd_u32_t _num_defunct;
    } pd_electionsphragmen_clean_defunct_voters_V2_t;

#define PD_CALL_TECHNICALCOMMITTEEMEMBERSHIP_ADD_MEMBER_V2 0
    typedef struct {
        pd_AccountId_V2_t who;
    } pd_technicalmembership_add_member_V2_t;

#define PD_CALL_TECHNICALCOMMITTEEMEMBERSHIP_REMOVE_MEMBER_V2 1
    typedef struct {
        pd_AccountId_V2_t who;
    } pd_technicalmembership_remove_member_V2_t;

#define PD_CALL_TECHNICALCOMMITTEEMEMBERSHIP_SWAP_MEMBER_V2 2
    typedef struct {
        pd_AccountId_V2_t remove;
        pd_AccountId_V2_t add;
    } pd_technicalmembership_swap_member_V2_t;

#define PD_CALL_TECHNICALCOMMITTEEMEMBERSHIP_RESET_MEMBERS_V2 3
    typedef struct {
        pd_VecAccountId_V2_t members;
    } pd_technicalmembership_reset_members_V2_t;

#define PD_CALL_TECHNICALCOMMITTEEMEMBERSHIP_CHANGE_KEY_V2 4
    typedef struct {
        pd_AccountId_V2_t new_;
    } pd_technicalmembership_change_key_V2_t;

#define PD_CALL_TECHNICALCOMMITTEEMEMBERSHIP_SET_PRIME_V2 5
    typedef struct {
        pd_AccountId_V2_t who;
    } pd_technicalmembership_set_prime_V2_t;

#define PD_CALL_TECHNICALCOMMITTEEMEMBERSHIP_CLEAR_PRIME_V2 6
    typedef struct {
    } pd_technicalmembership_clear_prime_V2_t;

#define PD_CALL_TREASURY_PROPOSE_SPEND_V2 0
    typedef struct {
        pd_CompactBalanceOf_t value;
        pd_LookupSource_V2_t beneficiary;
    } pd_treasury_propose_spend_V2_t;

#define PD_CALL_TREASURY_REJECT_PROPOSAL_V2 1
    typedef struct {
        pd_CompactProposalIndex_V2_t proposal_id;
    } pd_treasury_reject_proposal_V2_t;

#define PD_CALL_TREASURY_APPROVE_PROPOSAL_V2 2
    typedef struct {
        pd_CompactProposalIndex_V2_t proposal_id;
    } pd_treasury_approve_proposal_V2_t;

#define PD_CALL_UTILITY_AS_DERIVATIVE_V2 1
    typedef struct {
        pd_u16_t index;
        pd_Call_t call;
    } pd_utility_as_derivative_V2_t;

#define PD_CALL_IDENTITY_ADD_REGISTRAR_V2 0
    typedef struct {
        pd_AccountId_V2_t account;
    } pd_identity_add_registrar_V2_t;

#define PD_CALL_IDENTITY_SET_IDENTITY_V2 1
    typedef struct {
        pd_IdentityInfo_V2_t info;
    } pd_identity_set_identity_V2_t;

#define PD_CALL_IDENTITY_SET_SUBS_V2 2
    typedef struct {
        pd_VecTupleAccountIdData_V2_t subs;
    } pd_identity_set_subs_V2_t;

#define PD_CALL_IDENTITY_CLEAR_IDENTITY_V2 3
    typedef struct {
    } pd_identity_clear_identity_V2_t;

#define PD_CALL_IDENTITY_REQUEST_JUDGEMENT_V2 4
    typedef struct {
        pd_CompactRegistrarIndex_V2_t reg_index;
        pd_CompactBalanceOf_t max_fee;
    } pd_identity_request_judgement_V2_t;

#define PD_CALL_IDENTITY_CANCEL_REQUEST_V2 5
    typedef struct {
        pd_RegistrarIndex_V2_t reg_index;
    } pd_identity_cancel_request_V2_t;

#define PD_CALL_IDENTITY_SET_FEE_V2 6
    typedef struct {
        pd_CompactRegistrarIndex_V2_t index;
        pd_CompactBalanceOf_t fee;
    } pd_identity_set_fee_V2_t;

#define PD_CALL_IDENTITY_SET_ACCOUNT_ID_V2 7
    typedef struct {
        pd_CompactRegistrarIndex_V2_t index;
        pd_AccountId_V2_t new_;
    } pd_identity_set_account_id_V2_t;

#define PD_CALL_IDENTITY_SET_FIELDS_V2 8
    typedef struct {
        pd_CompactRegistrarIndex_V2_t index;
        pd_IdentityFields_V2_t fields;
    } pd_identity_set_fields_V2_t;

#define PD_CALL_IDENTITY_PROVIDE_JUDGEMENT_V2 9
    typedef struct {
        pd_CompactRegistrarIndex_V2_t reg_index;
        pd_LookupSource_V2_t target;
        pd_IdentityJudgement_V2_t judgement;
    } pd_identity_provide_judgement_V2_t;

#define PD_CALL_IDENTITY_KILL_IDENTITY_V2 10
    typedef struct {
        pd_LookupSource_V2_t target;
    } pd_identity_kill_identity_V2_t;

#define PD_CALL_IDENTITY_ADD_SUB_V2 11
    typedef struct {
        pd_LookupSource_V2_t sub;
        pd_Data_t data;
    } pd_identity_add_sub_V2_t;

#define PD_CALL_IDENTITY_RENAME_SUB_V2 12
    typedef struct {
        pd_LookupSource_V2_t sub;
        pd_Data_t data;
    } pd_identity_rename_sub_V2_t;

#define PD_CALL_IDENTITY_REMOVE_SUB_V2 13
    typedef struct {
        pd_LookupSource_V2_t sub;
    } pd_identity_remove_sub_V2_t;

#define PD_CALL_IDENTITY_QUIT_SUB_V2 14
    typedef struct {
    } pd_identity_quit_sub_V2_t;

#define PD_CALL_BOUNTIES_PROPOSE_BOUNTY_V2 0
    typedef struct {
        pd_CompactBalanceOf_t value;
        pd_Bytes_t description;
    } pd_bounties_propose_bounty_V2_t;

#define PD_CALL_BOUNTIES_APPROVE_BOUNTY_V2 1
    typedef struct {
        pd_CompactBountyIndex_V2_t bounty_id;
    } pd_bounties_approve_bounty_V2_t;

#define PD_CALL_BOUNTIES_PROPOSE_CURATOR_V2 2
    typedef struct {
        pd_CompactBountyIndex_V2_t bounty_id;
        pd_LookupSource_V2_t curator;
        pd_CompactBalanceOf_t fee;
    } pd_bounties_propose_curator_V2_t;

#define PD_CALL_BOUNTIES_UNASSIGN_CURATOR_V2 3
    typedef struct {
        pd_CompactBountyIndex_V2_t bounty_id;
    } pd_bounties_unassign_curator_V2_t;

#define PD_CALL_BOUNTIES_ACCEPT_CURATOR_V2 4
    typedef struct {
        pd_CompactBountyIndex_V2_t bounty_id;
    } pd_bounties_accept_curator_V2_t;

#define PD_CALL_BOUNTIES_AWARD_BOUNTY_V2 5
    typedef struct {
        pd_CompactBountyIndex_V2_t bounty_id;
        pd_LookupSource_V2_t beneficiary;
    } pd_bounties_award_bounty_V2_t;

#define PD_CALL_BOUNTIES_CLAIM_BOUNTY_V2 6
    typedef struct {
        pd_CompactBountyIndex_V2_t bounty_id;
    } pd_bounties_claim_bounty_V2_t;

#define PD_CALL_BOUNTIES_CLOSE_BOUNTY_V2 7
    typedef struct {
        pd_CompactBountyIndex_V2_t bounty_id;
    } pd_bounties_close_bounty_V2_t;

#define PD_CALL_BOUNTIES_EXTEND_BOUNTY_EXPIRY_V2 8
    typedef struct {
        pd_CompactBountyIndex_V2_t bounty_id;
        pd_Bytes_t _remark;
    } pd_bounties_extend_bounty_expiry_V2_t;

#define PD_CALL_TIPS_REPORT_AWESOME_V2 0
    typedef struct {
        pd_Bytes_t reason;
        pd_AccountId_V2_t who;
    } pd_tips_report_awesome_V2_t;

#define PD_CALL_TIPS_RETRACT_TIP_V2 1
    typedef struct {
        pd_Hash_t hash;
    } pd_tips_retract_tip_V2_t;

#define PD_CALL_TIPS_TIP_NEW_V2 2
    typedef struct {
        pd_Bytes_t reason;
        pd_AccountId_V2_t who;
        pd_CompactBalanceOf_t tip_value;
    } pd_tips_tip_new_V2_t;

#define PD_CALL_TIPS_TIP_V2 3
    typedef struct {
        pd_Hash_t hash;
        pd_CompactBalanceOf_t tip_value;
    } pd_tips_tip_V2_t;

#define PD_CALL_TIPS_CLOSE_TIP_V2 4
    typedef struct {
        pd_Hash_t hash;
    } pd_tips_close_tip_V2_t;

#define PD_CALL_TIPS_SLASH_TIP_V2 5
    typedef struct {
        pd_Hash_t hash;
    } pd_tips_slash_tip_V2_t;

#define PD_CALL_ELECTIONPROVIDERMULTIPHASE_SUBMIT_UNSIGNED_V2 0
    typedef struct {
        pd_RawSolution_V2_t solution;
        pd_SolutionOrSnapshotSize_V2_t witness;
    } pd_electionprovidermultiphase_submit_unsigned_V2_t;

#endif

// Methods that cannot be passed in to a dispatchable like utility.batch, utility.batchAll or in proposals or in sudo. The
// approach is to move methods from this union to pd_MethodNested_V2_t as need arises
typedef union {
    pd_session_set_keys_V2_t session_set_keys_V2;
    pd_session_purge_keys_V2_t session_purge_keys_V2;
    pd_utility_batch_V2_t utility_batch_V2;
    pd_utility_batch_all_V2_t utility_batch_all_V2;
#ifdef SUBSTRATE_PARSER_FULL
    pd_system_remark_with_event_V2_t system_remark_with_event_V2;
    pd_scheduler_schedule_V2_t scheduler_schedule_V2;
    pd_scheduler_cancel_V2_t scheduler_cancel_V2;
    pd_scheduler_schedule_named_V2_t scheduler_schedule_named_V2;
    pd_scheduler_cancel_named_V2_t scheduler_cancel_named_V2;
    pd_scheduler_schedule_after_V2_t scheduler_schedule_after_V2;
    pd_scheduler_schedule_named_after_V2_t scheduler_schedule_named_after_V2;
    pd_babe_report_equivocation_V2_t babe_report_equivocation_V2;
    pd_babe_report_equivocation_unsigned_V2_t babe_report_equivocation_unsigned_V2;
    pd_timestamp_set_V2_t timestamp_set_V2;
    pd_authorship_set_uncles_V2_t authorship_set_uncles_V2;
    pd_staking_set_controller_V2_t staking_set_controller_V2;
    pd_staking_set_validator_count_V2_t staking_set_validator_count_V2;
    pd_staking_increase_validator_count_V2_t staking_increase_validator_count_V2;
    pd_staking_scale_validator_count_V2_t staking_scale_validator_count_V2;
    pd_staking_force_no_eras_V2_t staking_force_no_eras_V2;
    pd_staking_force_new_era_V2_t staking_force_new_era_V2;
    pd_staking_set_invulnerables_V2_t staking_set_invulnerables_V2;
    pd_staking_force_unstake_V2_t staking_force_unstake_V2;
    pd_staking_force_new_era_always_V2_t staking_force_new_era_always_V2;
    pd_staking_cancel_deferred_slash_V2_t staking_cancel_deferred_slash_V2;
    pd_staking_set_history_depth_V2_t staking_set_history_depth_V2;
    pd_staking_reap_stash_V2_t staking_reap_stash_V2;
    pd_staking_submit_election_solution_V2_t staking_submit_election_solution_V2;
    pd_staking_submit_election_solution_unsigned_V2_t staking_submit_election_solution_unsigned_V2;
    pd_staking_kick_V2_t staking_kick_V2;
    pd_grandpa_report_equivocation_V2_t grandpa_report_equivocation_V2;
    pd_grandpa_report_equivocation_unsigned_V2_t grandpa_report_equivocation_unsigned_V2;
    pd_grandpa_note_stalled_V2_t grandpa_note_stalled_V2;
    pd_imonline_heartbeat_V2_t imonline_heartbeat_V2;
    pd_democracy_propose_V2_t democracy_propose_V2;
    pd_democracy_second_V2_t democracy_second_V2;
    pd_democracy_vote_V2_t democracy_vote_V2;
    pd_democracy_emergency_cancel_V2_t democracy_emergency_cancel_V2;
    pd_democracy_external_propose_V2_t democracy_external_propose_V2;
    pd_democracy_external_propose_majority_V2_t democracy_external_propose_majority_V2;
    pd_democracy_external_propose_default_V2_t democracy_external_propose_default_V2;
    pd_democracy_fast_track_V2_t democracy_fast_track_V2;
    pd_democracy_veto_external_V2_t democracy_veto_external_V2;
    pd_democracy_cancel_referendum_V2_t democracy_cancel_referendum_V2;
    pd_democracy_cancel_queued_V2_t democracy_cancel_queued_V2;
    pd_democracy_delegate_V2_t democracy_delegate_V2;
    pd_democracy_undelegate_V2_t democracy_undelegate_V2;
    pd_democracy_clear_public_proposals_V2_t democracy_clear_public_proposals_V2;
    pd_democracy_note_preimage_V2_t democracy_note_preimage_V2;
    pd_democracy_note_preimage_operational_V2_t democracy_note_preimage_operational_V2;
    pd_democracy_note_imminent_preimage_V2_t democracy_note_imminent_preimage_V2;
    pd_democracy_note_imminent_preimage_operational_V2_t democracy_note_imminent_preimage_operational_V2;
    pd_democracy_reap_preimage_V2_t democracy_reap_preimage_V2;
    pd_democracy_unlock_V2_t democracy_unlock_V2;
    pd_democracy_remove_vote_V2_t democracy_remove_vote_V2;
    pd_democracy_remove_other_vote_V2_t democracy_remove_other_vote_V2;
    pd_democracy_enact_proposal_V2_t democracy_enact_proposal_V2;
    pd_democracy_blacklist_V2_t democracy_blacklist_V2;
    pd_democracy_cancel_proposal_V2_t democracy_cancel_proposal_V2;
    pd_council_set_members_V2_t council_set_members_V2;
    pd_council_execute_V2_t council_execute_V2;
    pd_council_propose_V2_t council_propose_V2;
    pd_council_vote_V2_t council_vote_V2;
    pd_council_close_V2_t council_close_V2;
    pd_council_disapprove_proposal_V2_t council_disapprove_proposal_V2;
    pd_technicalcommittee_set_members_V2_t technicalcommittee_set_members_V2;
    pd_technicalcommittee_execute_V2_t technicalcommittee_execute_V2;
    pd_technicalcommittee_propose_V2_t technicalcommittee_propose_V2;
    pd_technicalcommittee_vote_V2_t technicalcommittee_vote_V2;
    pd_technicalcommittee_close_V2_t technicalcommittee_close_V2;
    pd_technicalcommittee_disapprove_proposal_V2_t technicalcommittee_disapprove_proposal_V2;
    pd_electionsphragmen_vote_V2_t electionsphragmen_vote_V2;
    pd_electionsphragmen_remove_voter_V2_t electionsphragmen_remove_voter_V2;
    pd_electionsphragmen_submit_candidacy_V2_t electionsphragmen_submit_candidacy_V2;
    pd_electionsphragmen_renounce_candidacy_V2_t electionsphragmen_renounce_candidacy_V2;
    pd_electionsphragmen_remove_member_V2_t electionsphragmen_remove_member_V2;
    pd_electionsphragmen_clean_defunct_voters_V2_t electionsphragmen_clean_defunct_voters_V2;
    pd_technicalmembership_add_member_V2_t technicalmembership_add_member_V2;
    pd_technicalmembership_remove_member_V2_t technicalmembership_remove_member_V2;
    pd_technicalmembership_swap_member_V2_t technicalmembership_swap_member_V2;
    pd_technicalmembership_reset_members_V2_t technicalmembership_reset_members_V2;
    pd_technicalmembership_change_key_V2_t technicalmembership_change_key_V2;
    pd_technicalmembership_set_prime_V2_t technicalmembership_set_prime_V2;
    pd_technicalmembership_clear_prime_V2_t technicalmembership_clear_prime_V2;
    pd_treasury_propose_spend_V2_t treasury_propose_spend_V2;
    pd_treasury_reject_proposal_V2_t treasury_reject_proposal_V2;
    pd_treasury_approve_proposal_V2_t treasury_approve_proposal_V2;
    pd_utility_as_derivative_V2_t utility_as_derivative_V2;
    pd_identity_add_registrar_V2_t identity_add_registrar_V2;
    pd_identity_set_identity_V2_t identity_set_identity_V2;
    pd_identity_set_subs_V2_t identity_set_subs_V2;
    pd_identity_clear_identity_V2_t identity_clear_identity_V2;
    pd_identity_request_judgement_V2_t identity_request_judgement_V2;
    pd_identity_cancel_request_V2_t identity_cancel_request_V2;
    pd_identity_set_fee_V2_t identity_set_fee_V2;
    pd_identity_set_account_id_V2_t identity_set_account_id_V2;
    pd_identity_set_fields_V2_t identity_set_fields_V2;
    pd_identity_provide_judgement_V2_t identity_provide_judgement_V2;
    pd_identity_kill_identity_V2_t identity_kill_identity_V2;
    pd_identity_add_sub_V2_t identity_add_sub_V2;
    pd_identity_rename_sub_V2_t identity_rename_sub_V2;
    pd_identity_remove_sub_V2_t identity_remove_sub_V2;
    pd_identity_quit_sub_V2_t identity_quit_sub_V2;
    pd_bounties_propose_bounty_V2_t bounties_propose_bounty_V2;
    pd_bounties_approve_bounty_V2_t bounties_approve_bounty_V2;
    pd_bounties_propose_curator_V2_t bounties_propose_curator_V2;
    pd_bounties_unassign_curator_V2_t bounties_unassign_curator_V2;
    pd_bounties_accept_curator_V2_t bounties_accept_curator_V2;
    pd_bounties_award_bounty_V2_t bounties_award_bounty_V2;
    pd_bounties_claim_bounty_V2_t bounties_claim_bounty_V2;
    pd_bounties_close_bounty_V2_t bounties_close_bounty_V2;
    pd_bounties_extend_bounty_expiry_V2_t bounties_extend_bounty_expiry_V2;
    pd_tips_report_awesome_V2_t tips_report_awesome_V2;
    pd_tips_retract_tip_V2_t tips_retract_tip_V2;
    pd_tips_tip_new_V2_t tips_tip_new_V2;
    pd_tips_tip_V2_t tips_tip_V2;
    pd_tips_close_tip_V2_t tips_close_tip_V2;
    pd_tips_slash_tip_V2_t tips_slash_tip_V2;
    pd_electionprovidermultiphase_submit_unsigned_V2_t electionprovidermultiphase_submit_unsigned_V2;
#endif
} pd_MethodBasic_V2_t;

// Methods that can be passed in to a dispatchable like utility.batch, utility.batchAll or in proposals or in sudo
typedef union {
    pd_balances_transfer_V2_t balances_transfer_V2;
    pd_balances_transfer_keep_alive_V2_t balances_transfer_keep_alive_V2;
    pd_staking_bond_V2_t staking_bond_V2;
    pd_staking_bond_extra_V2_t staking_bond_extra_V2;
    pd_staking_unbond_V2_t staking_unbond_V2;
    pd_staking_withdraw_unbonded_V2_t staking_withdraw_unbonded_V2;
    pd_staking_validate_V2_t staking_validate_V2;
    pd_staking_nominate_V2_t staking_nominate_V2;
    pd_staking_chill_V2_t staking_chill_V2;
    pd_staking_set_payee_V2_t staking_set_payee_V2;
    pd_staking_payout_stakers_V2_t staking_payout_stakers_V2;
    pd_staking_rebond_V2_t staking_rebond_V2;
#ifdef SUBSTRATE_PARSER_FULL
    pd_system_fill_block_V2_t system_fill_block_V2;
    pd_system_remark_V2_t system_remark_V2;
    pd_system_set_heap_pages_V2_t system_set_heap_pages_V2;
    pd_system_set_code_V2_t system_set_code_V2;
    pd_system_set_code_without_checks_V2_t system_set_code_without_checks_V2;
    pd_system_set_changes_trie_config_V2_t system_set_changes_trie_config_V2;
    pd_system_set_storage_V2_t system_set_storage_V2;
    pd_system_kill_storage_V2_t system_kill_storage_V2;
    pd_system_kill_prefix_V2_t system_kill_prefix_V2;
    pd_balances_set_balance_V2_t balances_set_balance_V2;
    pd_balances_force_transfer_V2_t balances_force_transfer_V2;
#endif
} pd_MethodNested_V2_t;

typedef union {
    pd_MethodBasic_V2_t basic;
    pd_MethodNested_V2_t nested;
} pd_Method_V2_t;

#ifdef __cplusplus
}
#endif

#pragma clang diagnostic pop
