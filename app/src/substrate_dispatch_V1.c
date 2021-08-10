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

#include "substrate_dispatch_V1.h"
#include "substrate_dispatch.h"
#include "substrate_strings.h"
#include "zxmacros.h"
#include <stdint.h>

__Z_INLINE parser_error_t _readMethod_balances_transfer_V1(
    parser_context_t* c, pd_balances_transfer_V1_t* m)
{
    CHECK_ERROR(_readLookupSource_V1(c, &m->dest))
    CHECK_ERROR(_readCompactBalance(c, &m->value))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_balances_transfer_keep_alive_V1(
    parser_context_t* c, pd_balances_transfer_keep_alive_V1_t* m)
{
    CHECK_ERROR(_readLookupSource_V1(c, &m->dest))
    CHECK_ERROR(_readCompactBalance(c, &m->value))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_staking_bond_V1(
    parser_context_t* c, pd_staking_bond_V1_t* m)
{
    CHECK_ERROR(_readLookupSource_V1(c, &m->controller))
    CHECK_ERROR(_readCompactBalanceOf(c, &m->value))
    CHECK_ERROR(_readRewardDestination_V1(c, &m->payee))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_staking_bond_extra_V1(
    parser_context_t* c, pd_staking_bond_extra_V1_t* m)
{
    CHECK_ERROR(_readCompactBalanceOf(c, &m->max_additional))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_staking_unbond_V1(
    parser_context_t* c, pd_staking_unbond_V1_t* m)
{
    CHECK_ERROR(_readCompactBalanceOf(c, &m->value))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_staking_withdraw_unbonded_V1(
    parser_context_t* c, pd_staking_withdraw_unbonded_V1_t* m)
{
    CHECK_ERROR(_readu32(c, &m->num_slashing_spans))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_staking_validate_V1(
    parser_context_t* c, pd_staking_validate_V1_t* m)
{
    CHECK_ERROR(_readValidatorPrefs_V1(c, &m->prefs))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_staking_nominate_V1(
    parser_context_t* c, pd_staking_nominate_V1_t* m)
{
    CHECK_ERROR(_readVecLookupSource_V1(c, &m->targets))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_staking_chill_V1(
    parser_context_t* c, pd_staking_chill_V1_t* m)
{
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_staking_set_payee_V1(
    parser_context_t* c, pd_staking_set_payee_V1_t* m)
{
    CHECK_ERROR(_readRewardDestination_V1(c, &m->payee))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_staking_payout_stakers_V1(
    parser_context_t* c, pd_staking_payout_stakers_V1_t* m)
{
    CHECK_ERROR(_readAccountId_V1(c, &m->validator_stash))
    CHECK_ERROR(_readEraIndex_V1(c, &m->era))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_staking_rebond_V1(
    parser_context_t* c, pd_staking_rebond_V1_t* m)
{
    CHECK_ERROR(_readCompactBalanceOf(c, &m->value))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_session_set_keys_V1(
    parser_context_t* c, pd_session_set_keys_V1_t* m)
{
    CHECK_ERROR(_readKeys_V1(c, &m->keys))
    CHECK_ERROR(_readBytes(c, &m->proof))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_session_purge_keys_V1(
    parser_context_t* c, pd_session_purge_keys_V1_t* m)
{
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_utility_batch_V1(
    parser_context_t* c, pd_utility_batch_V1_t* m)
{
    CHECK_ERROR(_readVecCall(c, &m->calls))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_utility_batch_all_V1(
    parser_context_t* c, pd_utility_batch_all_V1_t* m)
{
    CHECK_ERROR(_readVecCall(c, &m->calls))
    return parser_ok;
}

#ifdef SUBSTRATE_PARSER_FULL
__Z_INLINE parser_error_t _readMethod_system_fill_block_V1(
    parser_context_t* c, pd_system_fill_block_V1_t* m)
{
    CHECK_ERROR(_readPerbill_V1(c, &m->_ratio))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_system_remark_V1(
    parser_context_t* c, pd_system_remark_V1_t* m)
{
    CHECK_ERROR(_readBytes(c, &m->_remark))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_system_set_heap_pages_V1(
    parser_context_t* c, pd_system_set_heap_pages_V1_t* m)
{
    CHECK_ERROR(_readu64(c, &m->pages))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_system_set_code_V1(
    parser_context_t* c, pd_system_set_code_V1_t* m)
{
    CHECK_ERROR(_readBytes(c, &m->code))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_system_set_code_without_checks_V1(
    parser_context_t* c, pd_system_set_code_without_checks_V1_t* m)
{
    CHECK_ERROR(_readBytes(c, &m->code))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_system_set_changes_trie_config_V1(
    parser_context_t* c, pd_system_set_changes_trie_config_V1_t* m)
{
    CHECK_ERROR(_readOptionChangesTrieConfiguration_V1(c, &m->changes_trie_config))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_system_set_storage_V1(
    parser_context_t* c, pd_system_set_storage_V1_t* m)
{
    CHECK_ERROR(_readVecKeyValue_V1(c, &m->items))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_system_kill_storage_V1(
    parser_context_t* c, pd_system_kill_storage_V1_t* m)
{
    CHECK_ERROR(_readVecKey_V1(c, &m->keys))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_system_kill_prefix_V1(
    parser_context_t* c, pd_system_kill_prefix_V1_t* m)
{
    CHECK_ERROR(_readKey_V1(c, &m->prefix))
    CHECK_ERROR(_readu32(c, &m->_subkeys))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_system_remark_with_event_V1(
        parser_context_t* c, pd_system_remark_with_event_V1_t* m)
{
    CHECK_ERROR(_readBytes(c, &m->remark))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_scheduler_schedule_V1(
    parser_context_t* c, pd_scheduler_schedule_V1_t* m)
{
    CHECK_ERROR(_readBlockNumber(c, &m->when))
    CHECK_ERROR(_readOptionPeriod_V1(c, &m->maybe_periodic))
    CHECK_ERROR(_readPriority_V1(c, &m->priority))
    CHECK_ERROR(_readCall(c, &m->call))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_scheduler_cancel_V1(
    parser_context_t* c, pd_scheduler_cancel_V1_t* m)
{
    CHECK_ERROR(_readBlockNumber(c, &m->when))
    CHECK_ERROR(_readu32(c, &m->index))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_scheduler_schedule_named_V1(
    parser_context_t* c, pd_scheduler_schedule_named_V1_t* m)
{
    CHECK_ERROR(_readBytes(c, &m->id))
    CHECK_ERROR(_readBlockNumber(c, &m->when))
    CHECK_ERROR(_readOptionPeriod_V1(c, &m->maybe_periodic))
    CHECK_ERROR(_readPriority_V1(c, &m->priority))
    CHECK_ERROR(_readCall(c, &m->call))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_scheduler_cancel_named_V1(
    parser_context_t* c, pd_scheduler_cancel_named_V1_t* m)
{
    CHECK_ERROR(_readBytes(c, &m->id))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_scheduler_schedule_after_V1(
    parser_context_t* c, pd_scheduler_schedule_after_V1_t* m)
{
    CHECK_ERROR(_readBlockNumber(c, &m->after))
    CHECK_ERROR(_readOptionPeriod_V1(c, &m->maybe_periodic))
    CHECK_ERROR(_readPriority_V1(c, &m->priority))
    CHECK_ERROR(_readCall(c, &m->call))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_scheduler_schedule_named_after_V1(
    parser_context_t* c, pd_scheduler_schedule_named_after_V1_t* m)
{
    CHECK_ERROR(_readBytes(c, &m->id))
    CHECK_ERROR(_readBlockNumber(c, &m->after))
    CHECK_ERROR(_readOptionPeriod_V1(c, &m->maybe_periodic))
    CHECK_ERROR(_readPriority_V1(c, &m->priority))
    CHECK_ERROR(_readCall(c, &m->call))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_babe_report_equivocation_V1(
    parser_context_t* c, pd_babe_report_equivocation_V1_t* m)
{
    CHECK_ERROR(_readBabeEquivocationProof_V1(c, &m->equivocation_proof))
    CHECK_ERROR(_readKeyOwnerProof_V1(c, &m->key_owner_proof))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_babe_report_equivocation_unsigned_V1(
    parser_context_t* c, pd_babe_report_equivocation_unsigned_V1_t* m)
{
    CHECK_ERROR(_readBabeEquivocationProof_V1(c, &m->equivocation_proof))
    CHECK_ERROR(_readKeyOwnerProof_V1(c, &m->key_owner_proof))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_timestamp_set_V1(
    parser_context_t* c, pd_timestamp_set_V1_t* m)
{
    CHECK_ERROR(_readCompactMoment_V1(c, &m->now))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_balances_set_balance_V1(
    parser_context_t* c, pd_balances_set_balance_V1_t* m)
{
    CHECK_ERROR(_readLookupSource_V1(c, &m->who))
    CHECK_ERROR(_readCompactBalance(c, &m->new_free))
    CHECK_ERROR(_readCompactBalance(c, &m->new_reserved))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_balances_force_transfer_V1(
    parser_context_t* c, pd_balances_force_transfer_V1_t* m)
{
    CHECK_ERROR(_readLookupSource_V1(c, &m->source))
    CHECK_ERROR(_readLookupSource_V1(c, &m->dest))
    CHECK_ERROR(_readCompactBalance(c, &m->value))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_authorship_set_uncles_V1(
    parser_context_t* c, pd_authorship_set_uncles_V1_t* m)
{
    CHECK_ERROR(_readVecHeader(c, &m->new_uncles))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_staking_set_controller_V1(
    parser_context_t* c, pd_staking_set_controller_V1_t* m)
{
    CHECK_ERROR(_readLookupSource_V1(c, &m->controller))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_staking_set_validator_count_V1(
    parser_context_t* c, pd_staking_set_validator_count_V1_t* m)
{
    CHECK_ERROR(_readCompactu32(c, &m->new_))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_staking_increase_validator_count_V1(
    parser_context_t* c, pd_staking_increase_validator_count_V1_t* m)
{
    CHECK_ERROR(_readCompactu32(c, &m->additional))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_staking_scale_validator_count_V1(
    parser_context_t* c, pd_staking_scale_validator_count_V1_t* m)
{
    CHECK_ERROR(_readPercent_V1(c, &m->factor))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_staking_force_no_eras_V1(
    parser_context_t* c, pd_staking_force_no_eras_V1_t* m)
{
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_staking_force_new_era_V1(
    parser_context_t* c, pd_staking_force_new_era_V1_t* m)
{
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_staking_set_invulnerables_V1(
    parser_context_t* c, pd_staking_set_invulnerables_V1_t* m)
{
    CHECK_ERROR(_readVecAccountId_V1(c, &m->invulnerables))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_staking_force_unstake_V1(
    parser_context_t* c, pd_staking_force_unstake_V1_t* m)
{
    CHECK_ERROR(_readAccountId_V1(c, &m->stash))
    CHECK_ERROR(_readu32(c, &m->num_slashing_spans))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_staking_force_new_era_always_V1(
    parser_context_t* c, pd_staking_force_new_era_always_V1_t* m)
{
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_staking_cancel_deferred_slash_V1(
    parser_context_t* c, pd_staking_cancel_deferred_slash_V1_t* m)
{
    CHECK_ERROR(_readEraIndex_V1(c, &m->era))
    CHECK_ERROR(_readVecu32(c, &m->slash_indices))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_staking_set_history_depth_V1(
    parser_context_t* c, pd_staking_set_history_depth_V1_t* m)
{
    CHECK_ERROR(_readCompactEraIndex_V1(c, &m->new_history_depth))
    CHECK_ERROR(_readCompactu32(c, &m->_era_items_deleted))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_staking_reap_stash_V1(
    parser_context_t* c, pd_staking_reap_stash_V1_t* m)
{
    CHECK_ERROR(_readAccountId_V1(c, &m->stash))
    CHECK_ERROR(_readu32(c, &m->num_slashing_spans))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_staking_submit_election_solution_V1(
    parser_context_t* c, pd_staking_submit_election_solution_V1_t* m)
{
    CHECK_ERROR(_readVecValidatorIndex_V1(c, &m->winners))
    CHECK_ERROR(_readCompactAssignments_V1(c, &m->compact))
    CHECK_ERROR(_readElectionScore_V1(c, &m->score))
    CHECK_ERROR(_readEraIndex_V1(c, &m->era))
    CHECK_ERROR(_readElectionSize_V1(c, &m->size))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_staking_submit_election_solution_unsigned_V1(
    parser_context_t* c, pd_staking_submit_election_solution_unsigned_V1_t* m)
{
    CHECK_ERROR(_readVecValidatorIndex_V1(c, &m->winners))
    CHECK_ERROR(_readCompactAssignments_V1(c, &m->compact))
    CHECK_ERROR(_readElectionScore_V1(c, &m->score))
    CHECK_ERROR(_readEraIndex_V1(c, &m->era))
    CHECK_ERROR(_readElectionSize_V1(c, &m->size))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_staking_kick_V1(
    parser_context_t* c, pd_staking_kick_V1_t* m)
{
    CHECK_ERROR(_readVecLookupSource_V1(c, &m->who))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_grandpa_report_equivocation_V1(
    parser_context_t* c, pd_grandpa_report_equivocation_V1_t* m)
{
    CHECK_ERROR(_readGrandpaEquivocationProof_V1(c, &m->equivocation_proof))
    CHECK_ERROR(_readKeyOwnerProof_V1(c, &m->key_owner_proof))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_grandpa_report_equivocation_unsigned_V1(
    parser_context_t* c, pd_grandpa_report_equivocation_unsigned_V1_t* m)
{
    CHECK_ERROR(_readGrandpaEquivocationProof_V1(c, &m->equivocation_proof))
    CHECK_ERROR(_readKeyOwnerProof_V1(c, &m->key_owner_proof))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_grandpa_note_stalled_V1(
    parser_context_t* c, pd_grandpa_note_stalled_V1_t* m)
{
    CHECK_ERROR(_readBlockNumber(c, &m->delay))
    CHECK_ERROR(_readBlockNumber(c, &m->best_finalized_block_number))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_imonline_heartbeat_V1(
    parser_context_t* c, pd_imonline_heartbeat_V1_t* m)
{
    CHECK_ERROR(_readHeartbeat(c, &m->heartbeat))
    CHECK_ERROR(_readSignature_V1(c, &m->_signature))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_democracy_propose_V1(
    parser_context_t* c, pd_democracy_propose_V1_t* m)
{
    CHECK_ERROR(_readHash(c, &m->proposal_hash))
    CHECK_ERROR(_readCompactBalanceOf(c, &m->value))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_democracy_second_V1(
    parser_context_t* c, pd_democracy_second_V1_t* m)
{
    CHECK_ERROR(_readCompactPropIndex_V1(c, &m->proposal))
    CHECK_ERROR(_readCompactu32(c, &m->seconds_upper_bound))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_democracy_vote_V1(
    parser_context_t* c, pd_democracy_vote_V1_t* m)
{
    CHECK_ERROR(_readCompactReferendumIndex_V1(c, &m->ref_index))
    CHECK_ERROR(_readAccountVote_V1(c, &m->vote))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_democracy_emergency_cancel_V1(
    parser_context_t* c, pd_democracy_emergency_cancel_V1_t* m)
{
    CHECK_ERROR(_readReferendumIndex_V1(c, &m->ref_index))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_democracy_external_propose_V1(
    parser_context_t* c, pd_democracy_external_propose_V1_t* m)
{
    CHECK_ERROR(_readHash(c, &m->proposal_hash))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_democracy_external_propose_majority_V1(
    parser_context_t* c, pd_democracy_external_propose_majority_V1_t* m)
{
    CHECK_ERROR(_readHash(c, &m->proposal_hash))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_democracy_external_propose_default_V1(
    parser_context_t* c, pd_democracy_external_propose_default_V1_t* m)
{
    CHECK_ERROR(_readHash(c, &m->proposal_hash))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_democracy_fast_track_V1(
    parser_context_t* c, pd_democracy_fast_track_V1_t* m)
{
    CHECK_ERROR(_readHash(c, &m->proposal_hash))
    CHECK_ERROR(_readBlockNumber(c, &m->voting_period))
    CHECK_ERROR(_readBlockNumber(c, &m->delay))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_democracy_veto_external_V1(
    parser_context_t* c, pd_democracy_veto_external_V1_t* m)
{
    CHECK_ERROR(_readHash(c, &m->proposal_hash))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_democracy_cancel_referendum_V1(
    parser_context_t* c, pd_democracy_cancel_referendum_V1_t* m)
{
    CHECK_ERROR(_readCompactReferendumIndex_V1(c, &m->ref_index))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_democracy_cancel_queued_V1(
    parser_context_t* c, pd_democracy_cancel_queued_V1_t* m)
{
    CHECK_ERROR(_readReferendumIndex_V1(c, &m->which))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_democracy_delegate_V1(
    parser_context_t* c, pd_democracy_delegate_V1_t* m)
{
    CHECK_ERROR(_readAccountId_V1(c, &m->to))
    CHECK_ERROR(_readConviction_V1(c, &m->conviction))
    CHECK_ERROR(_readBalanceOf(c, &m->balance))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_democracy_undelegate_V1(
    parser_context_t* c, pd_democracy_undelegate_V1_t* m)
{
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_democracy_clear_public_proposals_V1(
    parser_context_t* c, pd_democracy_clear_public_proposals_V1_t* m)
{
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_democracy_note_preimage_V1(
    parser_context_t* c, pd_democracy_note_preimage_V1_t* m)
{
    CHECK_ERROR(_readBytes(c, &m->encoded_proposal))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_democracy_note_preimage_operational_V1(
    parser_context_t* c, pd_democracy_note_preimage_operational_V1_t* m)
{
    CHECK_ERROR(_readBytes(c, &m->encoded_proposal))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_democracy_note_imminent_preimage_V1(
    parser_context_t* c, pd_democracy_note_imminent_preimage_V1_t* m)
{
    CHECK_ERROR(_readBytes(c, &m->encoded_proposal))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_democracy_note_imminent_preimage_operational_V1(
    parser_context_t* c, pd_democracy_note_imminent_preimage_operational_V1_t* m)
{
    CHECK_ERROR(_readBytes(c, &m->encoded_proposal))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_democracy_reap_preimage_V1(
    parser_context_t* c, pd_democracy_reap_preimage_V1_t* m)
{
    CHECK_ERROR(_readHash(c, &m->proposal_hash))
    CHECK_ERROR(_readCompactu32(c, &m->proposal_len_upper_bound))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_democracy_unlock_V1(
    parser_context_t* c, pd_democracy_unlock_V1_t* m)
{
    CHECK_ERROR(_readAccountId_V1(c, &m->target))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_democracy_remove_vote_V1(
    parser_context_t* c, pd_democracy_remove_vote_V1_t* m)
{
    CHECK_ERROR(_readReferendumIndex_V1(c, &m->index))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_democracy_remove_other_vote_V1(
    parser_context_t* c, pd_democracy_remove_other_vote_V1_t* m)
{
    CHECK_ERROR(_readAccountId_V1(c, &m->target))
    CHECK_ERROR(_readReferendumIndex_V1(c, &m->index))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_democracy_enact_proposal_V1(
    parser_context_t* c, pd_democracy_enact_proposal_V1_t* m)
{
    CHECK_ERROR(_readHash(c, &m->proposal_hash))
    CHECK_ERROR(_readReferendumIndex_V1(c, &m->index))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_democracy_blacklist_V1(
    parser_context_t* c, pd_democracy_blacklist_V1_t* m)
{
    CHECK_ERROR(_readHash(c, &m->proposal_hash))
    CHECK_ERROR(_readOptionReferendumIndex_V1(c, &m->maybe_ref_index))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_democracy_cancel_proposal_V1(
    parser_context_t* c, pd_democracy_cancel_proposal_V1_t* m)
{
    CHECK_ERROR(_readCompactPropIndex_V1(c, &m->prop_index))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_council_set_members_V1(
    parser_context_t* c, pd_council_set_members_V1_t* m)
{
    CHECK_ERROR(_readVecAccountId_V1(c, &m->new_members))
    CHECK_ERROR(_readOptionAccountId_V1(c, &m->prime))
    CHECK_ERROR(_readMemberCount_V1(c, &m->old_count))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_council_execute_V1(
    parser_context_t* c, pd_council_execute_V1_t* m)
{
    CHECK_ERROR(_readProposal(c, &m->proposal))
    CHECK_ERROR(_readCompactu32(c, &m->length_bound))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_council_propose_V1(
    parser_context_t* c, pd_council_propose_V1_t* m)
{
    CHECK_ERROR(_readCompactMemberCount_V1(c, &m->threshold))
    CHECK_ERROR(_readProposal(c, &m->proposal))
    CHECK_ERROR(_readCompactu32(c, &m->length_bound))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_council_vote_V1(
    parser_context_t* c, pd_council_vote_V1_t* m)
{
    CHECK_ERROR(_readHash(c, &m->proposal))
    CHECK_ERROR(_readCompactProposalIndex_V1(c, &m->index))
    CHECK_ERROR(_readbool(c, &m->approve))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_council_close_V1(
    parser_context_t* c, pd_council_close_V1_t* m)
{
    CHECK_ERROR(_readHash(c, &m->proposal_hash))
    CHECK_ERROR(_readCompactProposalIndex_V1(c, &m->index))
    CHECK_ERROR(_readCompactWeight_V1(c, &m->proposal_weight_bound))
    CHECK_ERROR(_readCompactu32(c, &m->length_bound))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_council_disapprove_proposal_V1(
    parser_context_t* c, pd_council_disapprove_proposal_V1_t* m)
{
    CHECK_ERROR(_readHash(c, &m->proposal_hash))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_technicalcommittee_set_members_V1(
    parser_context_t* c, pd_technicalcommittee_set_members_V1_t* m)
{
    CHECK_ERROR(_readVecAccountId_V1(c, &m->new_members))
    CHECK_ERROR(_readOptionAccountId_V1(c, &m->prime))
    CHECK_ERROR(_readMemberCount_V1(c, &m->old_count))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_technicalcommittee_execute_V1(
    parser_context_t* c, pd_technicalcommittee_execute_V1_t* m)
{
    CHECK_ERROR(_readProposal(c, &m->proposal))
    CHECK_ERROR(_readCompactu32(c, &m->length_bound))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_technicalcommittee_propose_V1(
    parser_context_t* c, pd_technicalcommittee_propose_V1_t* m)
{
    CHECK_ERROR(_readCompactMemberCount_V1(c, &m->threshold))
    CHECK_ERROR(_readProposal(c, &m->proposal))
    CHECK_ERROR(_readCompactu32(c, &m->length_bound))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_technicalcommittee_vote_V1(
    parser_context_t* c, pd_technicalcommittee_vote_V1_t* m)
{
    CHECK_ERROR(_readHash(c, &m->proposal))
    CHECK_ERROR(_readCompactProposalIndex_V1(c, &m->index))
    CHECK_ERROR(_readbool(c, &m->approve))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_technicalcommittee_close_V1(
    parser_context_t* c, pd_technicalcommittee_close_V1_t* m)
{
    CHECK_ERROR(_readHash(c, &m->proposal_hash))
    CHECK_ERROR(_readCompactProposalIndex_V1(c, &m->index))
    CHECK_ERROR(_readCompactWeight_V1(c, &m->proposal_weight_bound))
    CHECK_ERROR(_readCompactu32(c, &m->length_bound))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_technicalcommittee_disapprove_proposal_V1(
    parser_context_t* c, pd_technicalcommittee_disapprove_proposal_V1_t* m)
{
    CHECK_ERROR(_readHash(c, &m->proposal_hash))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_electionsphragmen_vote_V1(
    parser_context_t* c, pd_electionsphragmen_vote_V1_t* m)
{
    CHECK_ERROR(_readVecAccountId_V1(c, &m->votes))
    CHECK_ERROR(_readCompactBalanceOf(c, &m->value))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_electionsphragmen_remove_voter_V1(
    parser_context_t* c, pd_electionsphragmen_remove_voter_V1_t* m)
{
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_electionsphragmen_submit_candidacy_V1(
    parser_context_t* c, pd_electionsphragmen_submit_candidacy_V1_t* m)
{
    CHECK_ERROR(_readCompactu32(c, &m->candidate_count))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_electionsphragmen_renounce_candidacy_V1(
    parser_context_t* c, pd_electionsphragmen_renounce_candidacy_V1_t* m)
{
    CHECK_ERROR(_readRenouncing_V1(c, &m->renouncing))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_electionsphragmen_remove_member_V1(
    parser_context_t* c, pd_electionsphragmen_remove_member_V1_t* m)
{
    CHECK_ERROR(_readLookupSource_V1(c, &m->who))
    CHECK_ERROR(_readbool(c, &m->has_replacement))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_electionsphragmen_clean_defunct_voters_V1(
    parser_context_t* c, pd_electionsphragmen_clean_defunct_voters_V1_t* m)
{
    CHECK_ERROR(_readu32(c, &m->_num_voters))
    CHECK_ERROR(_readu32(c, &m->_num_defunct))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_technicalmembership_add_member_V1(
    parser_context_t* c, pd_technicalmembership_add_member_V1_t* m)
{
    CHECK_ERROR(_readAccountId_V1(c, &m->who))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_technicalmembership_remove_member_V1(
    parser_context_t* c, pd_technicalmembership_remove_member_V1_t* m)
{
    CHECK_ERROR(_readAccountId_V1(c, &m->who))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_technicalmembership_swap_member_V1(
    parser_context_t* c, pd_technicalmembership_swap_member_V1_t* m)
{
    CHECK_ERROR(_readAccountId_V1(c, &m->remove))
    CHECK_ERROR(_readAccountId_V1(c, &m->add))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_technicalmembership_reset_members_V1(
    parser_context_t* c, pd_technicalmembership_reset_members_V1_t* m)
{
    CHECK_ERROR(_readVecAccountId_V1(c, &m->members))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_technicalmembership_change_key_V1(
    parser_context_t* c, pd_technicalmembership_change_key_V1_t* m)
{
    CHECK_ERROR(_readAccountId_V1(c, &m->new_))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_technicalmembership_set_prime_V1(
    parser_context_t* c, pd_technicalmembership_set_prime_V1_t* m)
{
    CHECK_ERROR(_readAccountId_V1(c, &m->who))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_technicalmembership_clear_prime_V1(
    parser_context_t* c, pd_technicalmembership_clear_prime_V1_t* m)
{
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_treasury_propose_spend_V1(
    parser_context_t* c, pd_treasury_propose_spend_V1_t* m)
{
    CHECK_ERROR(_readCompactBalanceOf(c, &m->value))
    CHECK_ERROR(_readLookupSource_V1(c, &m->beneficiary))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_treasury_reject_proposal_V1(
    parser_context_t* c, pd_treasury_reject_proposal_V1_t* m)
{
    CHECK_ERROR(_readCompactProposalIndex_V1(c, &m->proposal_id))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_treasury_approve_proposal_V1(
    parser_context_t* c, pd_treasury_approve_proposal_V1_t* m)
{
    CHECK_ERROR(_readCompactProposalIndex_V1(c, &m->proposal_id))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_utility_as_derivative_V1(
    parser_context_t* c, pd_utility_as_derivative_V1_t* m)
{
    CHECK_ERROR(_readu16(c, &m->index))
    CHECK_ERROR(_readCall(c, &m->call))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_identity_add_registrar_V1(
    parser_context_t* c, pd_identity_add_registrar_V1_t* m)
{
    CHECK_ERROR(_readAccountId_V1(c, &m->account))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_identity_set_identity_V1(
    parser_context_t* c, pd_identity_set_identity_V1_t* m)
{
    CHECK_ERROR(_readIdentityInfo_V1(c, &m->info))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_identity_set_subs_V1(
    parser_context_t* c, pd_identity_set_subs_V1_t* m)
{
    CHECK_ERROR(_readVecTupleAccountIdData_V1(c, &m->subs))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_identity_clear_identity_V1(
    parser_context_t* c, pd_identity_clear_identity_V1_t* m)
{
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_identity_request_judgement_V1(
    parser_context_t* c, pd_identity_request_judgement_V1_t* m)
{
    CHECK_ERROR(_readCompactRegistrarIndex_V1(c, &m->reg_index))
    CHECK_ERROR(_readCompactBalanceOf(c, &m->max_fee))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_identity_cancel_request_V1(
    parser_context_t* c, pd_identity_cancel_request_V1_t* m)
{
    CHECK_ERROR(_readRegistrarIndex_V1(c, &m->reg_index))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_identity_set_fee_V1(
    parser_context_t* c, pd_identity_set_fee_V1_t* m)
{
    CHECK_ERROR(_readCompactRegistrarIndex_V1(c, &m->index))
    CHECK_ERROR(_readCompactBalanceOf(c, &m->fee))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_identity_set_account_id_V1(
    parser_context_t* c, pd_identity_set_account_id_V1_t* m)
{
    CHECK_ERROR(_readCompactRegistrarIndex_V1(c, &m->index))
    CHECK_ERROR(_readAccountId_V1(c, &m->new_))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_identity_set_fields_V1(
    parser_context_t* c, pd_identity_set_fields_V1_t* m)
{
    CHECK_ERROR(_readCompactRegistrarIndex_V1(c, &m->index))
    CHECK_ERROR(_readIdentityFields_V1(c, &m->fields))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_identity_provide_judgement_V1(
    parser_context_t* c, pd_identity_provide_judgement_V1_t* m)
{
    CHECK_ERROR(_readCompactRegistrarIndex_V1(c, &m->reg_index))
    CHECK_ERROR(_readLookupSource_V1(c, &m->target))
    CHECK_ERROR(_readIdentityJudgement_V1(c, &m->judgement))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_identity_kill_identity_V1(
    parser_context_t* c, pd_identity_kill_identity_V1_t* m)
{
    CHECK_ERROR(_readLookupSource_V1(c, &m->target))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_identity_add_sub_V1(
    parser_context_t* c, pd_identity_add_sub_V1_t* m)
{
    CHECK_ERROR(_readLookupSource_V1(c, &m->sub))
    CHECK_ERROR(_readData(c, &m->data))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_identity_rename_sub_V1(
    parser_context_t* c, pd_identity_rename_sub_V1_t* m)
{
    CHECK_ERROR(_readLookupSource_V1(c, &m->sub))
    CHECK_ERROR(_readData(c, &m->data))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_identity_remove_sub_V1(
    parser_context_t* c, pd_identity_remove_sub_V1_t* m)
{
    CHECK_ERROR(_readLookupSource_V1(c, &m->sub))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_identity_quit_sub_V1(
    parser_context_t* c, pd_identity_quit_sub_V1_t* m)
{
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_bounties_propose_bounty_V1(
    parser_context_t* c, pd_bounties_propose_bounty_V1_t* m)
{
    CHECK_ERROR(_readCompactBalanceOf(c, &m->value))
    CHECK_ERROR(_readBytes(c, &m->description))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_bounties_approve_bounty_V1(
    parser_context_t* c, pd_bounties_approve_bounty_V1_t* m)
{
    CHECK_ERROR(_readCompactBountyIndex_V1(c, &m->bounty_id))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_bounties_propose_curator_V1(
    parser_context_t* c, pd_bounties_propose_curator_V1_t* m)
{
    CHECK_ERROR(_readCompactBountyIndex_V1(c, &m->bounty_id))
    CHECK_ERROR(_readLookupSource_V1(c, &m->curator))
    CHECK_ERROR(_readCompactBalanceOf(c, &m->fee))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_bounties_unassign_curator_V1(
    parser_context_t* c, pd_bounties_unassign_curator_V1_t* m)
{
    CHECK_ERROR(_readCompactBountyIndex_V1(c, &m->bounty_id))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_bounties_accept_curator_V1(
    parser_context_t* c, pd_bounties_accept_curator_V1_t* m)
{
    CHECK_ERROR(_readCompactBountyIndex_V1(c, &m->bounty_id))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_bounties_award_bounty_V1(
    parser_context_t* c, pd_bounties_award_bounty_V1_t* m)
{
    CHECK_ERROR(_readCompactBountyIndex_V1(c, &m->bounty_id))
    CHECK_ERROR(_readLookupSource_V1(c, &m->beneficiary))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_bounties_claim_bounty_V1(
    parser_context_t* c, pd_bounties_claim_bounty_V1_t* m)
{
    CHECK_ERROR(_readCompactBountyIndex_V1(c, &m->bounty_id))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_bounties_close_bounty_V1(
    parser_context_t* c, pd_bounties_close_bounty_V1_t* m)
{
    CHECK_ERROR(_readCompactBountyIndex_V1(c, &m->bounty_id))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_bounties_extend_bounty_expiry_V1(
    parser_context_t* c, pd_bounties_extend_bounty_expiry_V1_t* m)
{
    CHECK_ERROR(_readCompactBountyIndex_V1(c, &m->bounty_id))
    CHECK_ERROR(_readBytes(c, &m->_remark))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_tips_report_awesome_V1(
    parser_context_t* c, pd_tips_report_awesome_V1_t* m)
{
    CHECK_ERROR(_readBytes(c, &m->reason))
    CHECK_ERROR(_readAccountId_V1(c, &m->who))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_tips_retract_tip_V1(
    parser_context_t* c, pd_tips_retract_tip_V1_t* m)
{
    CHECK_ERROR(_readHash(c, &m->hash))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_tips_tip_new_V1(
    parser_context_t* c, pd_tips_tip_new_V1_t* m)
{
    CHECK_ERROR(_readBytes(c, &m->reason))
    CHECK_ERROR(_readAccountId_V1(c, &m->who))
    CHECK_ERROR(_readCompactBalanceOf(c, &m->tip_value))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_tips_tip_V1(
    parser_context_t* c, pd_tips_tip_V1_t* m)
{
    CHECK_ERROR(_readHash(c, &m->hash))
    CHECK_ERROR(_readCompactBalanceOf(c, &m->tip_value))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_tips_close_tip_V1(
    parser_context_t* c, pd_tips_close_tip_V1_t* m)
{
    CHECK_ERROR(_readHash(c, &m->hash))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_tips_slash_tip_V1(
    parser_context_t* c, pd_tips_slash_tip_V1_t* m)
{
    CHECK_ERROR(_readHash(c, &m->hash))
    return parser_ok;
}

__Z_INLINE parser_error_t _readMethod_electionprovidermultiphase_submit_unsigned_V1(
    parser_context_t* c, pd_electionprovidermultiphase_submit_unsigned_V1_t* m)
{
    CHECK_ERROR(_readRawSolution_V1(c, &m->solution))
    CHECK_ERROR(_readSolutionOrSnapshotSize_V1(c, &m->witness))
    return parser_ok;
}

#endif

// Return extrinsic based of the module index (in `construct_runtime`) and extrinsic index (order of declaration inside `decl_module`). 
parser_error_t _readMethod_V1(
    parser_context_t* c,
    uint8_t moduleIdx,
    uint8_t callIdx,
    pd_Method_V1_t* method)
{
    uint16_t callPrivIdx = ((uint16_t)moduleIdx << 8u) + callIdx;

    switch (callPrivIdx) {

    case 512: /* module 2 call 0 */
    CHECK_ERROR(_readMethod_balances_transfer_V1(c, &method->nested.balances_transfer_V1))
        break;
    case 515: /* module 2 call 3 */
    CHECK_ERROR(_readMethod_balances_transfer_keep_alive_V1(c, &method->nested.balances_transfer_keep_alive_V1))
        break;
    case 7680: /* module 30 call 0 */
        CHECK_ERROR(_readMethod_staking_bond_V1(c, &method->nested.staking_bond_V1))
        break;
    case 7681: /* module 30 call 1 */
        CHECK_ERROR(_readMethod_staking_bond_extra_V1(c, &method->nested.staking_bond_extra_V1))
        break;
    case 7682: /* module 30 call 2 */
        CHECK_ERROR(_readMethod_staking_unbond_V1(c, &method->nested.staking_unbond_V1))
        break;
    case 7683: /* module 30 call 3 */
        CHECK_ERROR(_readMethod_staking_withdraw_unbonded_V1(c, &method->nested.staking_withdraw_unbonded_V1))
        break;
    case 7684: /* module 30 call 4 */
        CHECK_ERROR(_readMethod_staking_validate_V1(c, &method->nested.staking_validate_V1))
        break;
    case 7685: /* module 30 call 5 */
        CHECK_ERROR(_readMethod_staking_nominate_V1(c, &method->nested.staking_nominate_V1))
        break;
    case 7686: /* module 30 call 6 */
        CHECK_ERROR(_readMethod_staking_chill_V1(c, &method->nested.staking_chill_V1))
        break;
    case 7687: /* module 30 call 7 */
        CHECK_ERROR(_readMethod_staking_set_payee_V1(c, &method->nested.staking_set_payee_V1))
        break;
    case 7698: /* module 30 call 18 */
        CHECK_ERROR(_readMethod_staking_payout_stakers_V1(c, &method->nested.staking_payout_stakers_V1))
        break;
    case 7699: /* module 30 call 19 */
        CHECK_ERROR(_readMethod_staking_rebond_V1(c, &method->nested.staking_rebond_V1))
        break;
    case 768: /* module 3 call 0 */
        CHECK_ERROR(_readMethod_session_set_keys_V1(c, &method->basic.session_set_keys_V1))
        break;
    case 769: /* module 3 call 1 */
        CHECK_ERROR(_readMethod_session_purge_keys_V1(c, &method->basic.session_purge_keys_V1))
        break;
    case 2048: /* module 8 call 0 */
        CHECK_ERROR(_readMethod_utility_batch_V1(c, &method->basic.utility_batch_V1))
        break;
    case 2050: /* module 8 call 2 */
        CHECK_ERROR(_readMethod_utility_batch_all_V1(c, &method->basic.utility_batch_all_V1))
        break;

#ifdef SUBSTRATE_PARSER_FULL
    case 0: /* module 0 call 0 */
        CHECK_ERROR(_readMethod_system_fill_block_V1(c, &method->nested.system_fill_block_V1))
        break;
    case 1: /* module 0 call 1 */
        CHECK_ERROR(_readMethod_system_remark_V1(c, &method->nested.system_remark_V1))
        break;
    case 2: /* module 0 call 2 */
        CHECK_ERROR(_readMethod_system_set_heap_pages_V1(c, &method->nested.system_set_heap_pages_V1))
        break;
    case 3: /* module 0 call 3 */
        CHECK_ERROR(_readMethod_system_set_code_V1(c, &method->nested.system_set_code_V1))
        break;
    case 4: /* module 0 call 4 */
        CHECK_ERROR(_readMethod_system_set_code_without_checks_V1(c, &method->nested.system_set_code_without_checks_V1))
        break;
    case 5: /* module 0 call 5 */
        CHECK_ERROR(_readMethod_system_set_changes_trie_config_V1(c, &method->nested.system_set_changes_trie_config_V1))
        break;
    case 6: /* module 0 call 6 */
        CHECK_ERROR(_readMethod_system_set_storage_V1(c, &method->nested.system_set_storage_V1))
        break;
    case 7: /* module 0 call 7 */
        CHECK_ERROR(_readMethod_system_kill_storage_V1(c, &method->nested.system_kill_storage_V1))
        break;
    case 8: /* module 0 call 8 */
        CHECK_ERROR(_readMethod_system_kill_prefix_V1(c, &method->nested.system_kill_prefix_V1))
        break;
    case 9: /* module 0 call 9 */
        CHECK_ERROR(_readMethod_system_remark_with_event_V1(c, &method->basic.system_remark_with_event_V1))
        break;
    case 5376: /* module 21 call 0 */
        CHECK_ERROR(_readMethod_scheduler_schedule_V1(c, &method->basic.scheduler_schedule_V1))
        break;
    case 5377: /* module 21 call 1 */
        CHECK_ERROR(_readMethod_scheduler_cancel_V1(c, &method->basic.scheduler_cancel_V1))
        break;
    case 5378: /* module 21 call 2 */
        CHECK_ERROR(_readMethod_scheduler_schedule_named_V1(c, &method->basic.scheduler_schedule_named_V1))
        break;
    case 5379: /* module 21 call 3 */
        CHECK_ERROR(_readMethod_scheduler_cancel_named_V1(c, &method->basic.scheduler_cancel_named_V1))
        break;
    case 5380: /* module 21 call 4 */
        CHECK_ERROR(_readMethod_scheduler_schedule_after_V1(c, &method->basic.scheduler_schedule_after_V1))
        break;
    case 5381: /* module 21 call 5 */
        CHECK_ERROR(_readMethod_scheduler_schedule_named_after_V1(c, &method->basic.scheduler_schedule_named_after_V1))
        break;
    case 7424: /* module 29 call 0 */
        CHECK_ERROR(_readMethod_babe_report_equivocation_V1(c, &method->basic.babe_report_equivocation_V1))
        break;
    case 7425: /* module 29 call 1 */
        CHECK_ERROR(_readMethod_babe_report_equivocation_unsigned_V1(c, &method->basic.babe_report_equivocation_unsigned_V1))
        break;
    case 256: /* module 1 call 0 */
        CHECK_ERROR(_readMethod_timestamp_set_V1(c, &method->basic.timestamp_set_V1))
        break;
    case 513: /* module 2 call 1 */
        CHECK_ERROR(_readMethod_balances_set_balance_V1(c, &method->nested.balances_set_balance_V1))
        break;
    case 514: /* module 2 call 2 */
        CHECK_ERROR(_readMethod_balances_force_transfer_V1(c, &method->nested.balances_force_transfer_V1))
        break;
    case 1536: /* module 6 call 0 */
        CHECK_ERROR(_readMethod_authorship_set_uncles_V1(c, &method->basic.authorship_set_uncles_V1))
        break;
    case 7688: /* module 30 call 8 */
        CHECK_ERROR(_readMethod_staking_set_controller_V1(c, &method->basic.staking_set_controller_V1))
        break;
    case 7689: /* module 30 call 9 */
        CHECK_ERROR(_readMethod_staking_set_validator_count_V1(c, &method->basic.staking_set_validator_count_V1))
        break;
    case 7690: /* module 30 call 10 */
        CHECK_ERROR(_readMethod_staking_increase_validator_count_V1(c, &method->basic.staking_increase_validator_count_V1))
        break;
    case 7691: /* module 30 call 11 */
        CHECK_ERROR(_readMethod_staking_scale_validator_count_V1(c, &method->basic.staking_scale_validator_count_V1))
        break;
    case 7692: /* module 30 call 12 */
        CHECK_ERROR(_readMethod_staking_force_no_eras_V1(c, &method->basic.staking_force_no_eras_V1))
        break;
    case 7693: /* module 30 call 13 */
        CHECK_ERROR(_readMethod_staking_force_new_era_V1(c, &method->basic.staking_force_new_era_V1))
        break;
    case 7694: /* module 30 call 14 */
        CHECK_ERROR(_readMethod_staking_set_invulnerables_V1(c, &method->basic.staking_set_invulnerables_V1))
        break;
    case 7695: /* module 30 call 15 */
        CHECK_ERROR(_readMethod_staking_force_unstake_V1(c, &method->basic.staking_force_unstake_V1))
        break;
    case 7696: /* module 30 call 16 */
        CHECK_ERROR(_readMethod_staking_force_new_era_always_V1(c, &method->basic.staking_force_new_era_always_V1))
        break;
    case 7697: /* module 30 call 17 */
        CHECK_ERROR(_readMethod_staking_cancel_deferred_slash_V1(c, &method->basic.staking_cancel_deferred_slash_V1))
        break;
    case 7700: /* module 30 call 20 */
        CHECK_ERROR(_readMethod_staking_set_history_depth_V1(c, &method->basic.staking_set_history_depth_V1))
        break;
    case 7701: /* module 30 call 21 */
        CHECK_ERROR(_readMethod_staking_reap_stash_V1(c, &method->basic.staking_reap_stash_V1))
        break;
    case 7702: /* module 30 call 22 */
        CHECK_ERROR(_readMethod_staking_submit_election_solution_V1(c, &method->basic.staking_submit_election_solution_V1))
        break;
    case 7703: /* module 30 call 23 */
        CHECK_ERROR(_readMethod_staking_submit_election_solution_unsigned_V1(c, &method->basic.staking_submit_election_solution_unsigned_V1))
        break;
    case 7704: /* module 30 call 24 */
        CHECK_ERROR(_readMethod_staking_kick_V1(c, &method->basic.staking_kick_V1))
        break;
    case 1280: /* module 5 call 0 */
        CHECK_ERROR(_readMethod_grandpa_report_equivocation_V1(c, &method->basic.grandpa_report_equivocation_V1))
        break;
    case 1281: /* module 5 call 1 */
        CHECK_ERROR(_readMethod_grandpa_report_equivocation_unsigned_V1(c, &method->basic.grandpa_report_equivocation_unsigned_V1))
        break;
    case 1282: /* module 5 call 2 */
        CHECK_ERROR(_readMethod_grandpa_note_stalled_V1(c, &method->basic.grandpa_note_stalled_V1))
        break;
    case 7168: /* module 28 call 0 */
        CHECK_ERROR(_readMethod_imonline_heartbeat_V1(c, &method->basic.imonline_heartbeat_V1))
        break;
    case 4352: /* module 17 call 0 */
        CHECK_ERROR(_readMethod_democracy_propose_V1(c, &method->basic.democracy_propose_V1))
        break;
    case 4353: /* module 17 call 1 */
        CHECK_ERROR(_readMethod_democracy_second_V1(c, &method->basic.democracy_second_V1))
        break;
    case 4354: /* module 17 call 2 */
        CHECK_ERROR(_readMethod_democracy_vote_V1(c, &method->basic.democracy_vote_V1))
        break;
    case 4355: /* module 17 call 3 */
        CHECK_ERROR(_readMethod_democracy_emergency_cancel_V1(c, &method->basic.democracy_emergency_cancel_V1))
        break;
    case 4356: /* module 17 call 4 */
        CHECK_ERROR(_readMethod_democracy_external_propose_V1(c, &method->basic.democracy_external_propose_V1))
        break;
    case 4357: /* module 17 call 5 */
        CHECK_ERROR(_readMethod_democracy_external_propose_majority_V1(c, &method->basic.democracy_external_propose_majority_V1))
        break;
    case 4358: /* module 17 call 6 */
        CHECK_ERROR(_readMethod_democracy_external_propose_default_V1(c, &method->basic.democracy_external_propose_default_V1))
        break;
    case 4359: /* module 17 call 7 */
        CHECK_ERROR(_readMethod_democracy_fast_track_V1(c, &method->basic.democracy_fast_track_V1))
        break;
    case 4360: /* module 17 call 8 */
        CHECK_ERROR(_readMethod_democracy_veto_external_V1(c, &method->basic.democracy_veto_external_V1))
        break;
    case 4361: /* module 17 call 9 */
        CHECK_ERROR(_readMethod_democracy_cancel_referendum_V1(c, &method->basic.democracy_cancel_referendum_V1))
        break;
    case 4362: /* module 17 call 10 */
        CHECK_ERROR(_readMethod_democracy_cancel_queued_V1(c, &method->basic.democracy_cancel_queued_V1))
        break;
    case 4363: /* module 17 call 11 */
        CHECK_ERROR(_readMethod_democracy_delegate_V1(c, &method->basic.democracy_delegate_V1))
        break;
    case 4364: /* module 17 call 12 */
        CHECK_ERROR(_readMethod_democracy_undelegate_V1(c, &method->basic.democracy_undelegate_V1))
        break;
    case 4365: /* module 17 call 13 */
        CHECK_ERROR(_readMethod_democracy_clear_public_proposals_V1(c, &method->basic.democracy_clear_public_proposals_V1))
        break;
    case 4366: /* module 17 call 14 */
        CHECK_ERROR(_readMethod_democracy_note_preimage_V1(c, &method->basic.democracy_note_preimage_V1))
        break;
    case 4367: /* module 17 call 15 */
        CHECK_ERROR(_readMethod_democracy_note_preimage_operational_V1(c, &method->basic.democracy_note_preimage_operational_V1))
        break;
    case 4368: /* module 17 call 16 */
        CHECK_ERROR(_readMethod_democracy_note_imminent_preimage_V1(c, &method->basic.democracy_note_imminent_preimage_V1))
        break;
    case 4369: /* module 17 call 17 */
        CHECK_ERROR(_readMethod_democracy_note_imminent_preimage_operational_V1(c, &method->basic.democracy_note_imminent_preimage_operational_V1))
        break;
    case 4370: /* module 17 call 18 */
        CHECK_ERROR(_readMethod_democracy_reap_preimage_V1(c, &method->basic.democracy_reap_preimage_V1))
        break;
    case 4371: /* module 17 call 19 */
        CHECK_ERROR(_readMethod_democracy_unlock_V1(c, &method->basic.democracy_unlock_V1))
        break;
    case 4372: /* module 17 call 20 */
        CHECK_ERROR(_readMethod_democracy_remove_vote_V1(c, &method->basic.democracy_remove_vote_V1))
        break;
    case 4373: /* module 17 call 21 */
        CHECK_ERROR(_readMethod_democracy_remove_other_vote_V1(c, &method->basic.democracy_remove_other_vote_V1))
        break;
    case 4374: /* module 17 call 22 */
        CHECK_ERROR(_readMethod_democracy_enact_proposal_V1(c, &method->basic.democracy_enact_proposal_V1))
        break;
    case 4375: /* module 17 call 23 */
        CHECK_ERROR(_readMethod_democracy_blacklist_V1(c, &method->basic.democracy_blacklist_V1))
        break;
    case 4376: /* module 17 call 24 */
        CHECK_ERROR(_readMethod_democracy_cancel_proposal_V1(c, &method->basic.democracy_cancel_proposal_V1))
        break;
    case 4608: /* module 18 call 0 */
        CHECK_ERROR(_readMethod_council_set_members_V1(c, &method->basic.council_set_members_V1))
        break;
    case 4609: /* module 18 call 1 */
        CHECK_ERROR(_readMethod_council_execute_V1(c, &method->basic.council_execute_V1))
        break;
    case 4610: /* module 18 call 2 */
        CHECK_ERROR(_readMethod_council_propose_V1(c, &method->basic.council_propose_V1))
        break;
    case 4611: /* module 18 call 3 */
        CHECK_ERROR(_readMethod_council_vote_V1(c, &method->basic.council_vote_V1))
        break;
    case 4612: /* module 18 call 4 */
        CHECK_ERROR(_readMethod_council_close_V1(c, &method->basic.council_close_V1))
        break;
    case 4613: /* module 18 call 5 */
        CHECK_ERROR(_readMethod_council_disapprove_proposal_V1(c, &method->basic.council_disapprove_proposal_V1))
        break;
    case 4864: /* module 19 call 0 */
        CHECK_ERROR(_readMethod_technicalcommittee_set_members_V1(c, &method->basic.technicalcommittee_set_members_V1))
        break;
    case 4865: /* module 19 call 1 */
        CHECK_ERROR(_readMethod_technicalcommittee_execute_V1(c, &method->basic.technicalcommittee_execute_V1))
        break;
    case 4866: /* module 19 call 2 */
        CHECK_ERROR(_readMethod_technicalcommittee_propose_V1(c, &method->basic.technicalcommittee_propose_V1))
        break;
    case 4867: /* module 19 call 3 */
        CHECK_ERROR(_readMethod_technicalcommittee_vote_V1(c, &method->basic.technicalcommittee_vote_V1))
        break;
    case 4868: /* module 19 call 4 */
        CHECK_ERROR(_readMethod_technicalcommittee_close_V1(c, &method->basic.technicalcommittee_close_V1))
        break;
    case 4869: /* module 19 call 5 */
        CHECK_ERROR(_readMethod_technicalcommittee_disapprove_proposal_V1(c, &method->basic.technicalcommittee_disapprove_proposal_V1))
        break;
    case 9216: /* module 36 call 0 */
        CHECK_ERROR(_readMethod_electionsphragmen_vote_V1(c, &method->basic.electionsphragmen_vote_V1))
        break;
    case 9217: /* module 36 call 1 */
        CHECK_ERROR(_readMethod_electionsphragmen_remove_voter_V1(c, &method->basic.electionsphragmen_remove_voter_V1))
        break;
    case 9218: /* module 36 call 2 */
        CHECK_ERROR(_readMethod_electionsphragmen_submit_candidacy_V1(c, &method->basic.electionsphragmen_submit_candidacy_V1))
        break;
    case 9219: /* module 36 call 3 */
        CHECK_ERROR(_readMethod_electionsphragmen_renounce_candidacy_V1(c, &method->basic.electionsphragmen_renounce_candidacy_V1))
        break;
    case 9220: /* module 36 call 4 */
        CHECK_ERROR(_readMethod_electionsphragmen_remove_member_V1(c, &method->basic.electionsphragmen_remove_member_V1))
        break;
    case 9221: /* module 36 call 5 */
        CHECK_ERROR(_readMethod_electionsphragmen_clean_defunct_voters_V1(c, &method->basic.electionsphragmen_clean_defunct_voters_V1))
        break;
    case 5120: /* module 20 call 0 */
        CHECK_ERROR(_readMethod_technicalmembership_add_member_V1(c, &method->basic.technicalmembership_add_member_V1))
        break;
    case 5121: /* module 20 call 1 */
        CHECK_ERROR(_readMethod_technicalmembership_remove_member_V1(c, &method->basic.technicalmembership_remove_member_V1))
        break;
    case 5122: /* module 20 call 2 */
        CHECK_ERROR(_readMethod_technicalmembership_swap_member_V1(c, &method->basic.technicalmembership_swap_member_V1))
        break;
    case 5123: /* module 20 call 3 */
        CHECK_ERROR(_readMethod_technicalmembership_reset_members_V1(c, &method->basic.technicalmembership_reset_members_V1))
        break;
    case 5124: /* module 20 call 4 */
        CHECK_ERROR(_readMethod_technicalmembership_change_key_V1(c, &method->basic.technicalmembership_change_key_V1))
        break;
    case 5125: /* module 20 call 5 */
        CHECK_ERROR(_readMethod_technicalmembership_set_prime_V1(c, &method->basic.technicalmembership_set_prime_V1))
        break;
    case 5126: /* module 20 call 6 */
        CHECK_ERROR(_readMethod_technicalmembership_clear_prime_V1(c, &method->basic.technicalmembership_clear_prime_V1))
        break;
    case 8448: /* module 33 call 0 */
        CHECK_ERROR(_readMethod_treasury_propose_spend_V1(c, &method->basic.treasury_propose_spend_V1))
        break;
    case 8449: /* module 33 call 1 */
        CHECK_ERROR(_readMethod_treasury_reject_proposal_V1(c, &method->basic.treasury_reject_proposal_V1))
        break;
    case 8450: /* module 33 call 2 */
        CHECK_ERROR(_readMethod_treasury_approve_proposal_V1(c, &method->basic.treasury_approve_proposal_V1))
        break;
    case 2049: /* module 8 call 1 */
        CHECK_ERROR(_readMethod_utility_as_derivative_V1(c, &method->basic.utility_as_derivative_V1))
        break;
    case 9728: /* module 38 call 0 */
        CHECK_ERROR(_readMethod_identity_add_registrar_V1(c, &method->basic.identity_add_registrar_V1))
        break;
    case 9729: /* module 38 call 1 */
        CHECK_ERROR(_readMethod_identity_set_identity_V1(c, &method->basic.identity_set_identity_V1))
        break;
    case 9730: /* module 38 call 2 */
        CHECK_ERROR(_readMethod_identity_set_subs_V1(c, &method->basic.identity_set_subs_V1))
        break;
    case 9731: /* module 38 call 3 */
        CHECK_ERROR(_readMethod_identity_clear_identity_V1(c, &method->basic.identity_clear_identity_V1))
        break;
    case 9732: /* module 38 call 4 */
        CHECK_ERROR(_readMethod_identity_request_judgement_V1(c, &method->basic.identity_request_judgement_V1))
        break;
    case 9733: /* module 38 call 5 */
        CHECK_ERROR(_readMethod_identity_cancel_request_V1(c, &method->basic.identity_cancel_request_V1))
        break;
    case 9734: /* module 38 call 6 */
        CHECK_ERROR(_readMethod_identity_set_fee_V1(c, &method->basic.identity_set_fee_V1))
        break;
    case 9735: /* module 38 call 7 */
        CHECK_ERROR(_readMethod_identity_set_account_id_V1(c, &method->basic.identity_set_account_id_V1))
        break;
    case 9736: /* module 38 call 8 */
        CHECK_ERROR(_readMethod_identity_set_fields_V1(c, &method->basic.identity_set_fields_V1))
        break;
    case 9737: /* module 38 call 9 */
        CHECK_ERROR(_readMethod_identity_provide_judgement_V1(c, &method->basic.identity_provide_judgement_V1))
        break;
    case 9738: /* module 38 call 10 */
        CHECK_ERROR(_readMethod_identity_kill_identity_V1(c, &method->basic.identity_kill_identity_V1))
        break;
    case 9739: /* module 38 call 11 */
        CHECK_ERROR(_readMethod_identity_add_sub_V1(c, &method->basic.identity_add_sub_V1))
        break;
    case 9740: /* module 38 call 12 */
        CHECK_ERROR(_readMethod_identity_rename_sub_V1(c, &method->basic.identity_rename_sub_V1))
        break;
    case 9741: /* module 38 call 13 */
        CHECK_ERROR(_readMethod_identity_remove_sub_V1(c, &method->basic.identity_remove_sub_V1))
        break;
    case 9742: /* module 38 call 14 */
        CHECK_ERROR(_readMethod_identity_quit_sub_V1(c, &method->basic.identity_quit_sub_V1))
        break;
    case 8704: /* module 34 call 0 */
        CHECK_ERROR(_readMethod_bounties_propose_bounty_V1(c, &method->basic.bounties_propose_bounty_V1))
        break;
    case 8705: /* module 34 call 1 */
        CHECK_ERROR(_readMethod_bounties_approve_bounty_V1(c, &method->basic.bounties_approve_bounty_V1))
        break;
    case 8706: /* module 34 call 2 */
        CHECK_ERROR(_readMethod_bounties_propose_curator_V1(c, &method->basic.bounties_propose_curator_V1))
        break;
    case 8707: /* module 34 call 3 */
        CHECK_ERROR(_readMethod_bounties_unassign_curator_V1(c, &method->basic.bounties_unassign_curator_V1))
        break;
    case 8708: /* module 34 call 4 */
        CHECK_ERROR(_readMethod_bounties_accept_curator_V1(c, &method->basic.bounties_accept_curator_V1))
        break;
    case 8709: /* module 34 call 5 */
        CHECK_ERROR(_readMethod_bounties_award_bounty_V1(c, &method->basic.bounties_award_bounty_V1))
        break;
    case 8710: /* module 34 call 6 */
        CHECK_ERROR(_readMethod_bounties_claim_bounty_V1(c, &method->basic.bounties_claim_bounty_V1))
        break;
    case 8711: /* module 34 call 7 */
        CHECK_ERROR(_readMethod_bounties_close_bounty_V1(c, &method->basic.bounties_close_bounty_V1))
        break;
    case 8712: /* module 34 call 8 */
        CHECK_ERROR(_readMethod_bounties_extend_bounty_expiry_V1(c, &method->basic.bounties_extend_bounty_expiry_V1))
        break;
    case 9472: /* module 37 call 0 */
        CHECK_ERROR(_readMethod_tips_report_awesome_V1(c, &method->basic.tips_report_awesome_V1))
        break;
    case 9473: /* module 37 call 1 */
        CHECK_ERROR(_readMethod_tips_retract_tip_V1(c, &method->basic.tips_retract_tip_V1))
        break;
    case 9474: /* module 37 call 2 */
        CHECK_ERROR(_readMethod_tips_tip_new_V1(c, &method->basic.tips_tip_new_V1))
        break;
    case 9475: /* module 37 call 3 */
        CHECK_ERROR(_readMethod_tips_tip_V1(c, &method->basic.tips_tip_V1))
        break;
    case 9476: /* module 37 call 4 */
        CHECK_ERROR(_readMethod_tips_close_tip_V1(c, &method->basic.tips_close_tip_V1))
        break;
    case 9477: /* module 37 call 5 */
        CHECK_ERROR(_readMethod_tips_slash_tip_V1(c, &method->basic.tips_slash_tip_V1))
        break;
    case 7936: /* module 31 call 0 */
        CHECK_ERROR(_readMethod_electionprovidermultiphase_submit_unsigned_V1(c, &method->basic.electionprovidermultiphase_submit_unsigned_V1))
        break;
#endif
    default:
        return parser_unexpected_callIndex;
    }

    return parser_ok;
}

/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////

const char* _getMethod_ModuleName_V1(uint8_t moduleIdx)
{
    switch (moduleIdx) {
    case 2:
        return STR_MO_BALANCES;
    case 30:
        return STR_MO_STAKING;
    case 3:
        return STR_MO_SESSION;
    case 8:
        return STR_MO_UTILITY;
#ifdef SUBSTRATE_PARSER_FULL
    case 0:
        return STR_MO_SYSTEM;
    case 21:
        return STR_MO_SCHEDULER;
    case 29:
        return STR_MO_BABE;
    case 1:
        return STR_MO_TIMESTAMP;
    case 6:
        return STR_MO_AUTHORSHIP;
    case 32:
        return STR_MO_OFFENCES;
    case 5:
        return STR_MO_GRANDPA;
    case 28:
        return STR_MO_IMONLINE;
    case 26:
        return STR_MO_AUTHORITYDISCOVERY;
    case 17:
        return STR_MO_DEMOCRACY;
    case 18:
        return STR_MO_COUNCIL;
    case 19:
        return STR_MO_TECHNICALCOMMITTEE;
    case 36:
        return STR_MO_ELECTIONSPHRAGMEN;
    case 20:
        return STR_MO_TECHNICALMEMBERSHIP;
    case 33:
        return STR_MO_TREASURY;
    case 38:
        return STR_MO_IDENTITY;
    case 34:
        return STR_MO_BOUNTIES;
    case 37:
        return STR_MO_TIPS;
    case 31:
        return STR_MO_ELECTIONPROVIDERMULTIPHASE;
#endif
    default:
        return NULL;
    }

    return NULL;
}

const char* _getMethod_Name_V1(uint8_t moduleIdx, uint8_t callIdx)
{
    uint16_t callPrivIdx = ((uint16_t)moduleIdx << 8u) + callIdx;

    switch (callPrivIdx) {
    case 512: /* module 2 call 0 */
        return STR_ME_TRANSFER;
    case 515: /* module 2 call 3 */
        return STR_ME_TRANSFER_KEEP_ALIVE;
    case 7680: /* module 30 call 0 */
        return STR_ME_BOND;
    case 7681: /* module 30 call 1 */
        return STR_ME_BOND_EXTRA;
    case 7682: /* module 30 call 2 */
        return STR_ME_UNBOND;
    case 7683: /* module 30 call 3 */
        return STR_ME_WITHDRAW_UNBONDED;
    case 7684: /* module 30 call 4 */
        return STR_ME_VALIDATE;
    case 7685: /* module 30 call 5 */
        return STR_ME_NOMINATE;
    case 7686: /* module 30 call 6 */
        return STR_ME_CHILL;
    case 7687: /* module 30 call 7 */
        return STR_ME_SET_PAYEE;
    case 7698: /* module 30 call 18 */
        return STR_ME_PAYOUT_STAKERS;
    case 7699: /* module 30 call 19 */
        return STR_ME_REBOND;
    case 768: /* module 3 call 0 */
        return STR_ME_SET_KEYS;
    case 769: /* module 3 call 1 */
        return STR_ME_PURGE_KEYS;
    case 2048: /* module 8 call 0 */
        return STR_ME_BATCH;
    case 2050: /* module 8 call 2 */
        return STR_ME_BATCH_ALL;
#ifdef SUBSTRATE_PARSER_FULL
    case 0: /* module 0 call 0 */
        return STR_ME_FILL_BLOCK;
    case 1: /* module 0 call 1 */
        return STR_ME_REMARK;
    case 2: /* module 0 call 2 */
        return STR_ME_SET_HEAP_PAGES;
    case 3: /* module 0 call 3 */
        return STR_ME_SET_CODE;
    case 4: /* module 0 call 4 */
        return STR_ME_SET_CODE_WITHOUT_CHECKS;
    case 5: /* module 0 call 5 */
        return STR_ME_SET_CHANGES_TRIE_CONFIG;
    case 6: /* module 0 call 6 */
        return STR_ME_SET_STORAGE;
    case 7: /* module 0 call 7 */
        return STR_ME_KILL_STORAGE;
    case 8: /* module 0 call 8 */
        return STR_ME_KILL_PREFIX;
    case 9: /* module 0 call 9 */
        return STR_ME_REMARK_WITH_EVENT;
    case 5376: /* module 21 call 0 */
        return STR_ME_SCHEDULE;
    case 5377: /* module 21 call 1 */
        return STR_ME_CANCEL;
    case 5378: /* module 21 call 2 */
        return STR_ME_SCHEDULE_NAMED;
    case 5379: /* module 21 call 3 */
        return STR_ME_CANCEL_NAMED;
    case 5380: /* module 21 call 4 */
        return STR_ME_SCHEDULE_AFTER;
    case 5381: /* module 21 call 5 */
        return STR_ME_SCHEDULE_NAMED_AFTER;
    case 7424: /* module 29 call 0 */
        return STR_ME_REPORT_EQUIVOCATION;
    case 7425: /* module 29 call 1 */
        return STR_ME_REPORT_EQUIVOCATION_UNSIGNED;
    case 256: /* module 1 call 0 */
        return STR_ME_SET;
    case 513: /* module 2 call 1 */
        return STR_ME_SET_BALANCE;
    case 514: /* module 2 call 2 */
        return STR_ME_FORCE_TRANSFER;
    case 1536: /* module 6 call 0 */
        return STR_ME_SET_UNCLES;
    case 7688: /* module 30 call 8 */
        return STR_ME_SET_CONTROLLER;
    case 7689: /* module 30 call 9 */
        return STR_ME_SET_VALIDATOR_COUNT;
    case 7690: /* module 30 call 10 */
        return STR_ME_INCREASE_VALIDATOR_COUNT;
    case 7691: /* module 30 call 11 */
        return STR_ME_SCALE_VALIDATOR_COUNT;
    case 7692: /* module 30 call 12 */
        return STR_ME_FORCE_NO_ERAS;
    case 7693: /* module 30 call 13 */
        return STR_ME_FORCE_NEW_ERA;
    case 7694: /* module 30 call 14 */
        return STR_ME_SET_INVULNERABLES;
    case 7695: /* module 30 call 15 */
        return STR_ME_FORCE_UNSTAKE;
    case 7696: /* module 30 call 16 */
        return STR_ME_FORCE_NEW_ERA_ALWAYS;
    case 7697: /* module 30 call 17 */
        return STR_ME_CANCEL_DEFERRED_SLASH;
    case 7700: /* module 30 call 20 */
        return STR_ME_SET_HISTORY_DEPTH;
    case 7701: /* module 30 call 21 */
        return STR_ME_REAP_STASH;
    case 7702: /* module 30 call 22 */
        return STR_ME_SUBMIT_ELECTION_SOLUTION;
    case 7703: /* module 30 call 23 */
        return STR_ME_SUBMIT_ELECTION_SOLUTION_UNSIGNED;
    case 7704: /* module 30 call 24 */
        return STR_ME_KICK;
    case 1280: /* module 5 call 0 */
        return STR_ME_REPORT_EQUIVOCATION;
    case 1281: /* module 5 call 1 */
        return STR_ME_REPORT_EQUIVOCATION_UNSIGNED;
    case 1282: /* module 5 call 2 */
        return STR_ME_NOTE_STALLED;
    case 7168: /* module 28 call 0 */
        return STR_ME_HEARTBEAT;
    case 4352: /* module 17 call 0 */
        return STR_ME_PROPOSE;
    case 4353: /* module 17 call 1 */
        return STR_ME_SECOND;
    case 4354: /* module 17 call 2 */
        return STR_ME_VOTE;
    case 4355: /* module 17 call 3 */
        return STR_ME_EMERGENCY_CANCEL;
    case 4356: /* module 17 call 4 */
        return STR_ME_EXTERNAL_PROPOSE;
    case 4357: /* module 17 call 5 */
        return STR_ME_EXTERNAL_PROPOSE_MAJORITY;
    case 4358: /* module 17 call 6 */
        return STR_ME_EXTERNAL_PROPOSE_DEFAULT;
    case 4359: /* module 17 call 7 */
        return STR_ME_FAST_TRACK;
    case 4360: /* module 17 call 8 */
        return STR_ME_VETO_EXTERNAL;
    case 4361: /* module 17 call 9 */
        return STR_ME_CANCEL_REFERENDUM;
    case 4362: /* module 17 call 10 */
        return STR_ME_CANCEL_QUEUED;
    case 4363: /* module 17 call 11 */
        return STR_ME_DELEGATE;
    case 4364: /* module 17 call 12 */
        return STR_ME_UNDELEGATE;
    case 4365: /* module 17 call 13 */
        return STR_ME_CLEAR_PUBLIC_PROPOSALS;
    case 4366: /* module 17 call 14 */
        return STR_ME_NOTE_PREIMAGE;
    case 4367: /* module 17 call 15 */
        return STR_ME_NOTE_PREIMAGE_OPERATIONAL;
    case 4368: /* module 17 call 16 */
        return STR_ME_NOTE_IMMINENT_PREIMAGE;
    case 4369: /* module 17 call 17 */
        return STR_ME_NOTE_IMMINENT_PREIMAGE_OPERATIONAL;
    case 4370: /* module 17 call 18 */
        return STR_ME_REAP_PREIMAGE;
    case 4371: /* module 17 call 19 */
        return STR_ME_UNLOCK;
    case 4372: /* module 17 call 20 */
        return STR_ME_REMOVE_VOTE;
    case 4373: /* module 17 call 21 */
        return STR_ME_REMOVE_OTHER_VOTE;
    case 4374: /* module 17 call 22 */
        return STR_ME_ENACT_PROPOSAL;
    case 4375: /* module 17 call 23 */
        return STR_ME_BLACKLIST;
    case 4376: /* module 17 call 24 */
        return STR_ME_CANCEL_PROPOSAL;
    case 4608: /* module 18 call 0 */
        return STR_ME_SET_MEMBERS;
    case 4609: /* module 18 call 1 */
        return STR_ME_EXECUTE;
    case 4610: /* module 18 call 2 */
        return STR_ME_PROPOSE;
    case 4611: /* module 18 call 3 */
        return STR_ME_VOTE;
    case 4612: /* module 18 call 4 */
        return STR_ME_CLOSE;
    case 4613: /* module 18 call 5 */
        return STR_ME_DISAPPROVE_PROPOSAL;
    case 4864: /* module 19 call 0 */
        return STR_ME_SET_MEMBERS;
    case 4865: /* module 19 call 1 */
        return STR_ME_EXECUTE;
    case 4866: /* module 19 call 2 */
        return STR_ME_PROPOSE;
    case 4867: /* module 19 call 3 */
        return STR_ME_VOTE;
    case 4868: /* module 19 call 4 */
        return STR_ME_CLOSE;
    case 4869: /* module 19 call 5 */
        return STR_ME_DISAPPROVE_PROPOSAL;
    case 9216: /* module 36 call 0 */
        return STR_ME_VOTE;
    case 9217: /* module 36 call 1 */
        return STR_ME_REMOVE_VOTER;
    case 9218: /* module 36 call 2 */
        return STR_ME_SUBMIT_CANDIDACY;
    case 9219: /* module 36 call 3 */
        return STR_ME_RENOUNCE_CANDIDACY;
    case 9220: /* module 36 call 4 */
        return STR_ME_REMOVE_MEMBER;
    case 9221: /* module 36 call 5 */
        return STR_ME_CLEAN_DEFUNCT_VOTERS;
    case 5120: /* module 20 call 0 */
        return STR_ME_ADD_MEMBER;
    case 5121: /* module 20 call 1 */
        return STR_ME_REMOVE_MEMBER;
    case 5122: /* module 20 call 2 */
        return STR_ME_SWAP_MEMBER;
    case 5123: /* module 20 call 3 */
        return STR_ME_RESET_MEMBERS;
    case 5124: /* module 20 call 4 */
        return STR_ME_CHANGE_KEY;
    case 5125: /* module 20 call 5 */
        return STR_ME_SET_PRIME;
    case 5126: /* module 20 call 6 */
        return STR_ME_CLEAR_PRIME;
    case 8448: /* module 33 call 0 */
        return STR_ME_PROPOSE_SPEND;
    case 8449: /* module 33 call 1 */
        return STR_ME_REJECT_PROPOSAL;
    case 8450: /* module 33 call 2 */
        return STR_ME_APPROVE_PROPOSAL;
    case 2049: /* module 8 call 1 */
        return STR_ME_AS_DERIVATIVE;
    case 9728: /* module 38 call 0 */
        return STR_ME_ADD_REGISTRAR;
    case 9729: /* module 38 call 1 */
        return STR_ME_SET_IDENTITY;
    case 9730: /* module 38 call 2 */
        return STR_ME_SET_SUBS;
    case 9731: /* module 38 call 3 */
        return STR_ME_CLEAR_IDENTITY;
    case 9732: /* module 38 call 4 */
        return STR_ME_REQUEST_JUDGEMENT;
    case 9733: /* module 38 call 5 */
        return STR_ME_CANCEL_REQUEST;
    case 9734: /* module 38 call 6 */
        return STR_ME_SET_FEE;
    case 9735: /* module 38 call 7 */
        return STR_ME_SET_ACCOUNT_ID;
    case 9736: /* module 38 call 8 */
        return STR_ME_SET_FIELDS;
    case 9737: /* module 38 call 9 */
        return STR_ME_PROVIDE_JUDGEMENT;
    case 9738: /* module 38 call 10 */
        return STR_ME_KILL_IDENTITY;
    case 9739: /* module 38 call 11 */
        return STR_ME_ADD_SUB;
    case 9740: /* module 38 call 12 */
        return STR_ME_RENAME_SUB;
    case 9741: /* module 38 call 13 */
        return STR_ME_REMOVE_SUB;
    case 9742: /* module 38 call 14 */
        return STR_ME_QUIT_SUB;
    case 8704: /* module 34 call 0 */
        return STR_ME_PROPOSE_BOUNTY;
    case 8705: /* module 34 call 1 */
        return STR_ME_APPROVE_BOUNTY;
    case 8706: /* module 34 call 2 */
        return STR_ME_PROPOSE_CURATOR;
    case 8707: /* module 34 call 3 */
        return STR_ME_UNASSIGN_CURATOR;
    case 8708: /* module 34 call 4 */
        return STR_ME_ACCEPT_CURATOR;
    case 8709: /* module 34 call 5 */
        return STR_ME_AWARD_BOUNTY;
    case 8710: /* module 34 call 6 */
        return STR_ME_CLAIM_BOUNTY;
    case 8711: /* module 34 call 7 */
        return STR_ME_CLOSE_BOUNTY;
    case 8712: /* module 34 call 8 */
        return STR_ME_EXTEND_BOUNTY_EXPIRY;
    case 9472: /* module 37 call 0 */
        return STR_ME_REPORT_AWESOME;
    case 9473: /* module 37 call 1 */
        return STR_ME_RETRACT_TIP;
    case 9474: /* module 37 call 2 */
        return STR_ME_TIP_NEW;
    case 9475: /* module 37 call 3 */
        return STR_ME_TIP;
    case 9476: /* module 37 call 4 */
        return STR_ME_CLOSE_TIP;
    case 9477: /* module 37 call 5 */
        return STR_ME_SLASH_TIP;
    case 7936: /* module 31 call 0 */
        return STR_ME_SUBMIT_UNSIGNED;
#endif
    default:
        return NULL;
    }

    return NULL;
}

// For number of arguments of extrinsic (exclude `origin`).
parser_error_t _getMethod_NumItems_V1(uint8_t moduleIdx, uint8_t callIdx, uint8_t* numItems)
{
    uint16_t callPrivIdx = ((uint16_t)moduleIdx << 8u) + callIdx;

    switch (callPrivIdx) {
    case 512: /* module 2 call 0 */
        SET_AND_BREAK(numItems, 2);
    case 515: /* module 2 call 3 */
        SET_AND_BREAK(numItems, 2);
    case 7680: /* module 30 call 0 */
        SET_AND_BREAK(numItems, 3);
    case 7681: /* module 30 call 1 */
        SET_AND_BREAK(numItems, 1);
    case 7682: /* module 30 call 2 */
        SET_AND_BREAK(numItems, 1);
    case 7683: /* module 30 call 3 */
        SET_AND_BREAK(numItems, 1);
    case 7684: /* module 30 call 4 */
        SET_AND_BREAK(numItems, 1);
    case 7685: /* module 30 call 5 */
        SET_AND_BREAK(numItems, 1);
    case 7686: /* module 30 call 6 */
        SET_AND_BREAK(numItems, 0);
    case 7687: /* module 30 call 7 */
        SET_AND_BREAK(numItems, 1);
    case 7698: /* module 30 call 18 */
        SET_AND_BREAK(numItems, 2);
    case 7699: /* module 30 call 19 */
        SET_AND_BREAK(numItems, 1);
    case 768: /* module 3 call 0 */
        SET_AND_BREAK(numItems, 2);
    case 769: /* module 3 call 1 */
        SET_AND_BREAK(numItems, 0);
    case 2048: /* module 8 call 0 */
        SET_AND_BREAK(numItems, 1);
    case 2050: /* module 8 call 2 */
        SET_AND_BREAK(numItems, 1);
#ifdef SUBSTRATE_PARSER_FULL
    case 0: /* module 0 call 0 */
        SET_AND_BREAK(numItems, 1);
    case 1: /* module 0 call 1 */
        SET_AND_BREAK(numItems, 1);
    case 2: /* module 0 call 2 */
        SET_AND_BREAK(numItems, 1);
    case 3: /* module 0 call 3 */
        SET_AND_BREAK(numItems, 1);
    case 4: /* module 0 call 4 */
        SET_AND_BREAK(numItems, 1);
    case 5: /* module 0 call 5 */
        SET_AND_BREAK(numItems, 1);
    case 6: /* module 0 call 6 */
        SET_AND_BREAK(numItems, 1);
    case 7: /* module 0 call 7 */
        SET_AND_BREAK(numItems, 1);
    case 8: /* module 0 call 8 */
        SET_AND_BREAK(numItems, 2);
    case 5376: /* module 21 call 0 */
        SET_AND_BREAK(numItems, 4);
    case 5377: /* module 21 call 1 */
        SET_AND_BREAK(numItems, 2);
    case 5378: /* module 21 call 2 */
        SET_AND_BREAK(numItems, 5);
    case 5379: /* module 21 call 3 */
        SET_AND_BREAK(numItems, 1);
    case 5380: /* module 21 call 4 */
        SET_AND_BREAK(numItems, 4);
    case 5381: /* module 21 call 5 */
        SET_AND_BREAK(numItems, 5);
    case 7424: /* module 29 call 0 */
        SET_AND_BREAK(numItems, 2);
    case 7425: /* module 29 call 1 */
        SET_AND_BREAK(numItems, 2);
    case 256: /* module 1 call 0 */
        SET_AND_BREAK(numItems, 1);
    case 513: /* module 2 call 1 */
        SET_AND_BREAK(numItems, 3);
    case 514: /* module 2 call 2 */
        SET_AND_BREAK(numItems, 3);
    case 1536: /* module 6 call 0 */
        SET_AND_BREAK(numItems, 1);
    case 7688: /* module 30 call 8 */
        SET_AND_BREAK(numItems, 1);
    case 7689: /* module 30 call 9 */
        SET_AND_BREAK(numItems, 1);
    case 7690: /* module 30 call 10 */
        SET_AND_BREAK(numItems, 1);
    case 7691: /* module 30 call 11 */
        SET_AND_BREAK(numItems, 1);
    case 7692: /* module 30 call 12 */
        SET_AND_BREAK(numItems, 0);
    case 7693: /* module 30 call 13 */
        SET_AND_BREAK(numItems, 0);
    case 7694: /* module 30 call 14 */
        SET_AND_BREAK(numItems, 1);
    case 7695: /* module 30 call 15 */
        SET_AND_BREAK(numItems, 2);
    case 7696: /* module 30 call 16 */
        SET_AND_BREAK(numItems, 0);
    case 7697: /* module 30 call 17 */
        SET_AND_BREAK(numItems, 2);
    case 7700: /* module 30 call 20 */
        SET_AND_BREAK(numItems, 2);
    case 7701: /* module 30 call 21 */
        SET_AND_BREAK(numItems, 2);
    case 7702: /* module 30 call 22 */
        SET_AND_BREAK(numItems, 5);
    case 7703: /* module 30 call 23 */
        SET_AND_BREAK(numItems, 5);
    case 7704: /* module 30 call 24 */
        SET_AND_BREAK(numItems, 1);
    case 1280: /* module 5 call 0 */
        SET_AND_BREAK(numItems, 2);
    case 1281: /* module 5 call 1 */
        SET_AND_BREAK(numItems, 2);
    case 1282: /* module 5 call 2 */
        SET_AND_BREAK(numItems, 2);
    case 7168: /* module 28 call 0 */
        SET_AND_BREAK(numItems, 2);
    case 4352: /* module 17 call 0 */
        SET_AND_BREAK(numItems, 2);
    case 4353: /* module 17 call 1 */
        SET_AND_BREAK(numItems, 2);
    case 4354: /* module 17 call 2 */
        SET_AND_BREAK(numItems, 2);
    case 4355: /* module 17 call 3 */
        SET_AND_BREAK(numItems, 1);
    case 4356: /* module 17 call 4 */
        SET_AND_BREAK(numItems, 1);
    case 4357: /* module 17 call 5 */
        SET_AND_BREAK(numItems, 1);
    case 4358: /* module 17 call 6 */
        SET_AND_BREAK(numItems, 1);
    case 4359: /* module 17 call 7 */
        SET_AND_BREAK(numItems, 3);
    case 4360: /* module 17 call 8 */
        SET_AND_BREAK(numItems, 1);
    case 4361: /* module 17 call 9 */
        SET_AND_BREAK(numItems, 1);
    case 4362: /* module 17 call 10 */
        SET_AND_BREAK(numItems, 1);
    case 4363: /* module 17 call 11 */
        SET_AND_BREAK(numItems, 3);
    case 4364: /* module 17 call 12 */
        SET_AND_BREAK(numItems, 0);
    case 4365: /* module 17 call 13 */
        SET_AND_BREAK(numItems, 0);
    case 4366: /* module 17 call 14 */
        SET_AND_BREAK(numItems, 1);
    case 4367: /* module 17 call 15 */
        SET_AND_BREAK(numItems, 1);
    case 4368: /* module 17 call 16 */
        SET_AND_BREAK(numItems, 1);
    case 4369: /* module 17 call 17 */
        SET_AND_BREAK(numItems, 1);
    case 4370: /* module 17 call 18 */
        SET_AND_BREAK(numItems, 2);
    case 4371: /* module 17 call 19 */
        SET_AND_BREAK(numItems, 1);
    case 4372: /* module 17 call 20 */
        SET_AND_BREAK(numItems, 1);
    case 4373: /* module 17 call 21 */
        SET_AND_BREAK(numItems, 2);
    case 4374: /* module 17 call 22 */
        SET_AND_BREAK(numItems, 2);
    case 4375: /* module 17 call 23 */
        SET_AND_BREAK(numItems, 2);
    case 4376: /* module 17 call 24 */
        SET_AND_BREAK(numItems, 1);
    case 4608: /* module 18 call 0 */
        SET_AND_BREAK(numItems, 3);
    case 4609: /* module 18 call 1 */
        SET_AND_BREAK(numItems, 2);
    case 4610: /* module 18 call 2 */
        SET_AND_BREAK(numItems, 3);
    case 4611: /* module 18 call 3 */
        SET_AND_BREAK(numItems, 3);
    case 4612: /* module 18 call 4 */
        SET_AND_BREAK(numItems, 4);
    case 4613: /* module 18 call 5 */
        SET_AND_BREAK(numItems, 1);
    case 4864: /* module 19 call 0 */
        SET_AND_BREAK(numItems, 3);
    case 4865: /* module 19 call 1 */
        SET_AND_BREAK(numItems, 2);
    case 4866: /* module 19 call 2 */
        SET_AND_BREAK(numItems, 3);
    case 4867: /* module 19 call 3 */
        SET_AND_BREAK(numItems, 3);
    case 4868: /* module 19 call 4 */
        SET_AND_BREAK(numItems, 4);
    case 4869: /* module 19 call 5 */
        SET_AND_BREAK(numItems, 1);
    case 9216: /* module 36 call 0 */
        SET_AND_BREAK(numItems, 2);
    case 9217: /* module 36 call 1 */
        SET_AND_BREAK(numItems, 0);
    case 9218: /* module 36 call 2 */
        SET_AND_BREAK(numItems, 1);
    case 9219: /* module 36 call 3 */
        SET_AND_BREAK(numItems, 1);
    case 9220: /* module 36 call 4 */
        SET_AND_BREAK(numItems, 2);
    case 9221: /* module 36 call 5 */
        SET_AND_BREAK(numItems, 2);
    case 5120: /* module 20 call 0 */
        SET_AND_BREAK(numItems, 1);
    case 5121: /* module 20 call 1 */
        SET_AND_BREAK(numItems, 1);
    case 5122: /* module 20 call 2 */
        SET_AND_BREAK(numItems, 2);
    case 5123: /* module 20 call 3 */
        SET_AND_BREAK(numItems, 1);
    case 5124: /* module 20 call 4 */
        SET_AND_BREAK(numItems, 1);
    case 5125: /* module 20 call 5 */
        SET_AND_BREAK(numItems, 1);
    case 5126: /* module 20 call 6 */
        SET_AND_BREAK(numItems, 0);
    case 8448: /* module 33 call 0 */
        SET_AND_BREAK(numItems, 2);
    case 8449: /* module 33 call 1 */
        SET_AND_BREAK(numItems, 1);
    case 8450: /* module 33 call 2 */
        SET_AND_BREAK(numItems, 1);
    case 2049: /* module 8 call 1 */
        SET_AND_BREAK(numItems, 2);
    case 9728: /* module 38 call 0 */
        SET_AND_BREAK(numItems, 1);
    case 9729: /* module 38 call 1 */
        SET_AND_BREAK(numItems, 1);
    case 9730: /* module 38 call 2 */
        SET_AND_BREAK(numItems, 1);
    case 9731: /* module 38 call 3 */
        SET_AND_BREAK(numItems, 0);
    case 9732: /* module 38 call 4 */
        SET_AND_BREAK(numItems, 2);
    case 9733: /* module 38 call 5 */
        SET_AND_BREAK(numItems, 1);
    case 9734: /* module 38 call 6 */
        SET_AND_BREAK(numItems, 2);
    case 9735: /* module 38 call 7 */
        SET_AND_BREAK(numItems, 2);
    case 9736: /* module 38 call 8 */
        SET_AND_BREAK(numItems, 2);
    case 9737: /* module 38 call 9 */
        SET_AND_BREAK(numItems, 3);
    case 9738: /* module 38 call 10 */
        SET_AND_BREAK(numItems, 1);
    case 9739: /* module 38 call 11 */
        SET_AND_BREAK(numItems, 2);
    case 9740: /* module 38 call 12 */
        SET_AND_BREAK(numItems, 2);
    case 9741: /* module 38 call 13 */
        SET_AND_BREAK(numItems, 1);
    case 9742: /* module 38 call 14 */
        SET_AND_BREAK(numItems, 0);
    case 8704: /* module 34 call 0 */
        SET_AND_BREAK(numItems, 2);
    case 8705: /* module 34 call 1 */
        SET_AND_BREAK(numItems, 1);
    case 8706: /* module 34 call 2 */
        SET_AND_BREAK(numItems, 3);
    case 8707: /* module 34 call 3 */
        SET_AND_BREAK(numItems, 1);
    case 8708: /* module 34 call 4 */
        SET_AND_BREAK(numItems, 1);
    case 8709: /* module 34 call 5 */
        SET_AND_BREAK(numItems, 2);
    case 8710: /* module 34 call 6 */
        SET_AND_BREAK(numItems, 1);
    case 8711: /* module 34 call 7 */
        SET_AND_BREAK(numItems, 1);
    case 8712: /* module 34 call 8 */
        SET_AND_BREAK(numItems, 2);
    case 9472: /* module 37 call 0 */
        SET_AND_BREAK(numItems, 2);
    case 9473: /* module 37 call 1 */
        SET_AND_BREAK(numItems, 1);
    case 9474: /* module 37 call 2 */
        SET_AND_BREAK(numItems, 3);
    case 9475: /* module 37 call 3 */
        SET_AND_BREAK(numItems, 2);
    case 9476: /* module 37 call 4 */
        SET_AND_BREAK(numItems, 1);
    case 9477: /* module 37 call 5 */
        SET_AND_BREAK(numItems, 1);
    case 7936: /* module 31 call 0 */
        SET_AND_BREAK(numItems, 2);
#endif
    default:
        return parser_unexpected_callIndex;
    }

    return parser_ok;
}

// Return argument names of extrinsics given module index, extrinsic index and argument index
const char* _getMethod_ItemName_V1(uint8_t moduleIdx, uint8_t callIdx, uint8_t itemIdx)
{
    uint16_t callPrivIdx = ((uint16_t)moduleIdx << 8u) + callIdx;

    switch (callPrivIdx) {
    case 512: /* module 2 call 0 */
        switch (itemIdx) {
        case 0:
            return STR_IT_dest;
        case 1:
            return STR_IT_value;
        default:
            return NULL;
        }
    case 515: /* module 2 call 3 */
        switch (itemIdx) {
        case 0:
            return STR_IT_dest;
        case 1:
            return STR_IT_value;
        default:
            return NULL;
        }
    case 7680: /* module 30 call 0 */
        switch (itemIdx) {
        case 0:
            return STR_IT_controller;
        case 1:
            return STR_IT_value;
        case 2:
            return STR_IT_payee;
        default:
            return NULL;
        }
    case 7681: /* module 30 call 1 */
        switch (itemIdx) {
        case 0:
            return STR_IT_max_additional;
        default:
            return NULL;
        }
    case 7682: /* module 30 call 2 */
        switch (itemIdx) {
        case 0:
            return STR_IT_value;
        default:
            return NULL;
        }
    case 7683: /* module 30 call 3 */
        switch (itemIdx) {
        case 0:
            return STR_IT_num_slashing_spans;
        default:
            return NULL;
        }
    case 7684: /* module 30 call 4 */
        switch (itemIdx) {
        case 0:
            return STR_IT_prefs;
        default:
            return NULL;
        }
    case 7685: /* module 30 call 5 */
        switch (itemIdx) {
        case 0:
            return STR_IT_targets;
        default:
            return NULL;
        }
    case 7686: /* module 30 call 6 */
        switch (itemIdx) {
        default:
            return NULL;
        }
    case 7687: /* module 30 call 7 */
        switch (itemIdx) {
        case 0:
            return STR_IT_payee;
        default:
            return NULL;
        }
    case 7698: /* module 30 call 18 */
        switch (itemIdx) {
        case 0:
            return STR_IT_validator_stash;
        case 1:
            return STR_IT_era;
        default:
            return NULL;
        }
    case 7699: /* module 30 call 19 */
        switch (itemIdx) {
        case 0:
            return STR_IT_value;
        default:
            return NULL;
        }
    case 768: /* module 3 call 0 */
        switch (itemIdx) {
        case 0:
            return STR_IT_keys;
        case 1:
            return STR_IT_proof;
        default:
            return NULL;
        }
    case 769: /* module 3 call 1 */
        switch (itemIdx) {
        default:
            return NULL;
        }
    case 2048: /* module 8 call 0 */
        switch (itemIdx) {
        case 0:
            return STR_IT_calls;
        default:
            return NULL;
        }
    case 2050: /* module 8 call 2 */
        switch (itemIdx) {
        case 0:
            return STR_IT_calls;
        default:
            return NULL;
        }
#ifdef SUBSTRATE_PARSER_FULL
    case 0: /* module 0 call 0 */
        switch (itemIdx) {
        case 0:
            return STR_IT__ratio;
        default:
            return NULL;
        }
    case 1: /* module 0 call 1 */
        switch (itemIdx) {
        case 0:
            return STR_IT__remark;
        default:
            return NULL;
        }
    case 2: /* module 0 call 2 */
        switch (itemIdx) {
        case 0:
            return STR_IT_pages;
        default:
            return NULL;
        }
    case 3: /* module 0 call 3 */
        switch (itemIdx) {
        case 0:
            return STR_IT_code;
        default:
            return NULL;
        }
    case 4: /* module 0 call 4 */
        switch (itemIdx) {
        case 0:
            return STR_IT_code;
        default:
            return NULL;
        }
    case 5: /* module 0 call 5 */
        switch (itemIdx) {
        case 0:
            return STR_IT_changes_trie_config;
        default:
            return NULL;
        }
    case 6: /* module 0 call 6 */
        switch (itemIdx) {
        case 0:
            return STR_IT_items;
        default:
            return NULL;
        }
    case 7: /* module 0 call 7 */
        switch (itemIdx) {
        case 0:
            return STR_IT_keys;
        default:
            return NULL;
        }
    case 8: /* module 0 call 8 */
        switch (itemIdx) {
        case 0:
            return STR_IT_prefix;
        case 1:
            return STR_IT__subkeys;
        default:
            return NULL;
        }
    case 5376: /* module 21 call 0 */
        switch (itemIdx) {
        case 0:
            return STR_IT_when;
        case 1:
            return STR_IT_maybe_periodic;
        case 2:
            return STR_IT_priority;
        case 3:
            return STR_IT_call;
        default:
            return NULL;
        }
    case 5377: /* module 21 call 1 */
        switch (itemIdx) {
        case 0:
            return STR_IT_when;
        case 1:
            return STR_IT_index;
        default:
            return NULL;
        }
    case 5378: /* module 21 call 2 */
        switch (itemIdx) {
        case 0:
            return STR_IT_id;
        case 1:
            return STR_IT_when;
        case 2:
            return STR_IT_maybe_periodic;
        case 3:
            return STR_IT_priority;
        case 4:
            return STR_IT_call;
        default:
            return NULL;
        }
    case 5379: /* module 21 call 3 */
        switch (itemIdx) {
        case 0:
            return STR_IT_id;
        default:
            return NULL;
        }
    case 5380: /* module 21 call 4 */
        switch (itemIdx) {
        case 0:
            return STR_IT_after;
        case 1:
            return STR_IT_maybe_periodic;
        case 2:
            return STR_IT_priority;
        case 3:
            return STR_IT_call;
        default:
            return NULL;
        }
    case 5381: /* module 21 call 5 */
        switch (itemIdx) {
        case 0:
            return STR_IT_id;
        case 1:
            return STR_IT_after;
        case 2:
            return STR_IT_maybe_periodic;
        case 3:
            return STR_IT_priority;
        case 4:
            return STR_IT_call;
        default:
            return NULL;
        }
    case 7424: /* module 29 call 0 */
        switch (itemIdx) {
        case 0:
            return STR_IT_equivocation_proof;
        case 1:
            return STR_IT_key_owner_proof;
        default:
            return NULL;
        }
    case 7425: /* module 29 call 1 */
        switch (itemIdx) {
        case 0:
            return STR_IT_equivocation_proof;
        case 1:
            return STR_IT_key_owner_proof;
        default:
            return NULL;
        }
    case 7426: /* module 29 call 0 */
        switch (itemIdx) {
        case 0:
            return STR_IT_now;
        default:
            return NULL;
        }
    /*case 1024: *//* module 4 call 0 *//*
        switch (itemIdx) {
        case 0:
            return STR_IT_index;
        default:
            return NULL;
        }
    case 1025: *//* module 4 call 1 *//*
        switch (itemIdx) {
        case 0:
            return STR_IT_new_;
        case 1:
            return STR_IT_index;
        default:
            return NULL;
        }
    case 1026: *//* module 4 call 2 *//*
        switch (itemIdx) {
        case 0:
            return STR_IT_index;
        default:
            return NULL;
        }
    case 1027: *//* module 4 call 3 *//*
        switch (itemIdx) {
        case 0:
            return STR_IT_new_;
        case 1:
            return STR_IT_index;
        case 2:
            return STR_IT_freeze;
        default:
            return NULL;
        }
    case 1028: *//* module 4 call 4 *//*
        switch (itemIdx) {
        case 0:
            return STR_IT_index;
        default:
            return NULL;
        }*/
    case 513: /* module 2 call 1 */
        switch (itemIdx) {
        case 0:
            return STR_IT_who;
        case 1:
            return STR_IT_new_free;
        case 2:
            return STR_IT_new_reserved;
        default:
            return NULL;
        }
    case 514: /* module 2 call 2 */
        switch (itemIdx) {
        case 0:
            return STR_IT_source;
        case 1:
            return STR_IT_dest;
        case 2:
            return STR_IT_value;
        default:
            return NULL;
        }
    case 1536: /* module 6 call 0 */
        switch (itemIdx) {
        case 0:
            return STR_IT_new_uncles;
        default:
            return NULL;
        }
    case 7688: /* module 30 call 8 */
        switch (itemIdx) {
        case 0:
            return STR_IT_controller;
        default:
            return NULL;
        }
    case 7689: /* module 30 call 9 */
        switch (itemIdx) {
        case 0:
            return STR_IT_new_;
        default:
            return NULL;
        }
    case 7690: /* module 30 call 10 */
        switch (itemIdx) {
        case 0:
            return STR_IT_additional;
        default:
            return NULL;
        }
    case 7691: /* module 30 call 11 */
        switch (itemIdx) {
        case 0:
            return STR_IT_factor;
        default:
            return NULL;
        }
    case 7692: /* module 30 call 12 */
        switch (itemIdx) {
        default:
            return NULL;
        }
    case 7693: /* module 30 call 13 */
        switch (itemIdx) {
        default:
            return NULL;
        }
    case 7694: /* module 30 call 14 */
        switch (itemIdx) {
        case 0:
            return STR_IT_invulnerables;
        default:
            return NULL;
        }
    case 7695: /* module 30 call 15 */
        switch (itemIdx) {
        case 0:
            return STR_IT_stash;
        case 1:
            return STR_IT_num_slashing_spans;
        default:
            return NULL;
        }
    case 7696: /* module 30 call 16 */
        switch (itemIdx) {
        default:
            return NULL;
        }
    case 7697: /* module 30 call 17 */
        switch (itemIdx) {
        case 0:
            return STR_IT_era;
        case 1:
            return STR_IT_slash_indices;
        default:
            return NULL;
        }
    case 7700: /* module 30 call 20 */
        switch (itemIdx) {
        case 0:
            return STR_IT_new_history_depth;
        case 1:
            return STR_IT__era_items_deleted;
        default:
            return NULL;
        }
    case 7701: /* module 30 call 21 */
        switch (itemIdx) {
        case 0:
            return STR_IT_stash;
        case 1:
            return STR_IT_num_slashing_spans;
        default:
            return NULL;
        }
    case 7702: /* module 30 call 22 */
        switch (itemIdx) {
        case 0:
            return STR_IT_winners;
        case 1:
            return STR_IT_compact;
        case 2:
            return STR_IT_score;
        case 3:
            return STR_IT_era;
        case 4:
            return STR_IT_size;
        default:
            return NULL;
        }
    case 7703: /* module 30 call 23 */
        switch (itemIdx) {
        case 0:
            return STR_IT_winners;
        case 1:
            return STR_IT_compact;
        case 2:
            return STR_IT_score;
        case 3:
            return STR_IT_era;
        case 4:
            return STR_IT_size;
        default:
            return NULL;
        }
    case 7704: /* module 30 call 24 */
        switch (itemIdx) {
        case 0:
            return STR_IT_who;
        default:
            return NULL;
        }
    case 1280: /* module 5 call 0 */
        switch (itemIdx) {
        case 0:
            return STR_IT_equivocation_proof;
        case 1:
            return STR_IT_key_owner_proof;
        default:
            return NULL;
        }
    case 1281: /* module 5 call 1 */
        switch (itemIdx) {
        case 0:
            return STR_IT_equivocation_proof;
        case 1:
            return STR_IT_key_owner_proof;
        default:
            return NULL;
        }
    case 1282: /* module 5 call 2 */
        switch (itemIdx) {
        case 0:
            return STR_IT_delay;
        case 1:
            return STR_IT_best_finalized_block_number;
        default:
            return NULL;
        }
    case 7168: /* module 28 call 0 */
        switch (itemIdx) {
        case 0:
            return STR_IT_heartbeat;
        case 1:
            return STR_IT__signature;
        default:
            return NULL;
        }
    case 4352: /* module 17 call 0 */
        switch (itemIdx) {
        case 0:
            return STR_IT_proposal_hash;
        case 1:
            return STR_IT_value;
        default:
            return NULL;
        }
    case 4353: /* module 17 call 1 */
        switch (itemIdx) {
        case 0:
            return STR_IT_proposal;
        case 1:
            return STR_IT_seconds_upper_bound;
        default:
            return NULL;
        }
    case 4354: /* module 17 call 2 */
        switch (itemIdx) {
        case 0:
            return STR_IT_ref_index;
        case 1:
            return STR_IT_vote;
        default:
            return NULL;
        }
    case 4355: /* module 17 call 3 */
        switch (itemIdx) {
        case 0:
            return STR_IT_ref_index;
        default:
            return NULL;
        }
    case 4356: /* module 17 call 4 */
        switch (itemIdx) {
        case 0:
            return STR_IT_proposal_hash;
        default:
            return NULL;
        }
    case 4357: /* module 17 call 5 */
        switch (itemIdx) {
        case 0:
            return STR_IT_proposal_hash;
        default:
            return NULL;
        }
    case 4358: /* module 17 call 6 */
        switch (itemIdx) {
        case 0:
            return STR_IT_proposal_hash;
        default:
            return NULL;
        }
    case 4359: /* module 17 call 7 */
        switch (itemIdx) {
        case 0:
            return STR_IT_proposal_hash;
        case 1:
            return STR_IT_voting_period;
        case 2:
            return STR_IT_delay;
        default:
            return NULL;
        }
    case 4360: /* module 17 call 8 */
        switch (itemIdx) {
        case 0:
            return STR_IT_proposal_hash;
        default:
            return NULL;
        }
    case 4361: /* module 17 call 9 */
        switch (itemIdx) {
        case 0:
            return STR_IT_ref_index;
        default:
            return NULL;
        }
    case 4362: /* module 17 call 10 */
        switch (itemIdx) {
        case 0:
            return STR_IT_which;
        default:
            return NULL;
        }
    case 4363: /* module 17 call 11 */
        switch (itemIdx) {
        case 0:
            return STR_IT_to;
        case 1:
            return STR_IT_conviction;
        case 2:
            return STR_IT_balance;
        default:
            return NULL;
        }
    case 4364: /* module 17 call 12 */
        switch (itemIdx) {
        default:
            return NULL;
        }
    case 4365: /* module 17 call 13 */
        switch (itemIdx) {
        default:
            return NULL;
        }
    case 4366: /* module 17 call 14 */
        switch (itemIdx) {
        case 0:
            return STR_IT_encoded_proposal;
        default:
            return NULL;
        }
    case 4367: /* module 17 call 15 */
        switch (itemIdx) {
        case 0:
            return STR_IT_encoded_proposal;
        default:
            return NULL;
        }
    case 4368: /* module 17 call 16 */
        switch (itemIdx) {
        case 0:
            return STR_IT_encoded_proposal;
        default:
            return NULL;
        }
    case 4369: /* module 17 call 17 */
        switch (itemIdx) {
        case 0:
            return STR_IT_encoded_proposal;
        default:
            return NULL;
        }
    case 4370: /* module 17 call 18 */
        switch (itemIdx) {
        case 0:
            return STR_IT_proposal_hash;
        case 1:
            return STR_IT_proposal_len_upper_bound;
        default:
            return NULL;
        }
    case 4371: /* module 17 call 19 */
        switch (itemIdx) {
        case 0:
            return STR_IT_target;
        default:
            return NULL;
        }
    case 4372: /* module 17 call 20 */
        switch (itemIdx) {
        case 0:
            return STR_IT_index;
        default:
            return NULL;
        }
    case 4373: /* module 17 call 21 */
        switch (itemIdx) {
        case 0:
            return STR_IT_target;
        case 1:
            return STR_IT_index;
        default:
            return NULL;
        }
    case 4374: /* module 17 call 22 */
        switch (itemIdx) {
        case 0:
            return STR_IT_proposal_hash;
        case 1:
            return STR_IT_index;
        default:
            return NULL;
        }
    case 4375: /* module 17 call 23 */
        switch (itemIdx) {
        case 0:
            return STR_IT_proposal_hash;
        case 1:
            return STR_IT_maybe_ref_index;
        default:
            return NULL;
        }
    case 4376: /* module 17 call 24 */
        switch (itemIdx) {
        case 0:
            return STR_IT_prop_index;
        default:
            return NULL;
        }
    case 4608: /* module 18 call 0 */
        switch (itemIdx) {
        case 0:
            return STR_IT_new_members;
        case 1:
            return STR_IT_prime;
        case 2:
            return STR_IT_old_count;
        default:
            return NULL;
        }
    case 4609: /* module 18 call 1 */
        switch (itemIdx) {
        case 0:
            return STR_IT_proposal;
        case 1:
            return STR_IT_length_bound;
        default:
            return NULL;
        }
    case 4610: /* module 18 call 2 */
        switch (itemIdx) {
        case 0:
            return STR_IT_threshold;
        case 1:
            return STR_IT_proposal;
        case 2:
            return STR_IT_length_bound;
        default:
            return NULL;
        }
    case 4611: /* module 18 call 3 */
        switch (itemIdx) {
        case 0:
            return STR_IT_proposal;
        case 1:
            return STR_IT_index;
        case 2:
            return STR_IT_approve;
        default:
            return NULL;
        }
    case 4612: /* module 18 call 4 */
        switch (itemIdx) {
        case 0:
            return STR_IT_proposal_hash;
        case 1:
            return STR_IT_index;
        case 2:
            return STR_IT_proposal_weight_bound;
        case 3:
            return STR_IT_length_bound;
        default:
            return NULL;
        }
    case 4613: /* module 18 call 5 */
        switch (itemIdx) {
        case 0:
            return STR_IT_proposal_hash;
        default:
            return NULL;
        }
    case 4864: /* module 19 call 0 */
        switch (itemIdx) {
        case 0:
            return STR_IT_new_members;
        case 1:
            return STR_IT_prime;
        case 2:
            return STR_IT_old_count;
        default:
            return NULL;
        }
    case 4865: /* module 19 call 1 */
        switch (itemIdx) {
        case 0:
            return STR_IT_proposal;
        case 1:
            return STR_IT_length_bound;
        default:
            return NULL;
        }
    case 4866: /* module 19 call 2 */
        switch (itemIdx) {
        case 0:
            return STR_IT_threshold;
        case 1:
            return STR_IT_proposal;
        case 2:
            return STR_IT_length_bound;
        default:
            return NULL;
        }
    case 4867: /* module 19 call 3 */
        switch (itemIdx) {
        case 0:
            return STR_IT_proposal;
        case 1:
            return STR_IT_index;
        case 2:
            return STR_IT_approve;
        default:
            return NULL;
        }
    case 4868: /* module 19 call 4 */
        switch (itemIdx) {
        case 0:
            return STR_IT_proposal_hash;
        case 1:
            return STR_IT_index;
        case 2:
            return STR_IT_proposal_weight_bound;
        case 3:
            return STR_IT_length_bound;
        default:
            return NULL;
        }
    case 4869: /* module 19 call 5 */
        switch (itemIdx) {
        case 0:
            return STR_IT_proposal_hash;
        default:
            return NULL;
        }
    case 9216: /* module 36 call 0 */
        switch (itemIdx) {
        case 0:
            return STR_IT_votes;
        case 1:
            return STR_IT_value;
        default:
            return NULL;
        }
    case 9217: /* module 36 call 1 */
        switch (itemIdx) {
        default:
            return NULL;
        }
    case 9218: /* module 36 call 2 */
        switch (itemIdx) {
        case 0:
            return STR_IT_candidate_count;
        default:
            return NULL;
        }
    case 9219: /* module 36 call 3 */
        switch (itemIdx) {
        case 0:
            return STR_IT_renouncing;
        default:
            return NULL;
        }
    case 9220: /* module 36 call 4 */
        switch (itemIdx) {
        case 0:
            return STR_IT_who;
        case 1:
            return STR_IT_has_replacement;
        default:
            return NULL;
        }
    case 9221: /* module 36 call 5 */
        switch (itemIdx) {
        case 0:
            return STR_IT__num_voters;
        case 1:
            return STR_IT__num_defunct;
        default:
            return NULL;
        }
    case 5120: /* module 20 call 0 */
        switch (itemIdx) {
        case 0:
            return STR_IT_who;
        default:
            return NULL;
        }
    case 5121: /* module 20 call 1 */
        switch (itemIdx) {
        case 0:
            return STR_IT_who;
        default:
            return NULL;
        }
    case 5122: /* module 20 call 2 */
        switch (itemIdx) {
        case 0:
            return STR_IT_remove;
        case 1:
            return STR_IT_add;
        default:
            return NULL;
        }
    case 5123: /* module 20 call 3 */
        switch (itemIdx) {
        case 0:
            return STR_IT_members;
        default:
            return NULL;
        }
    case 5124: /* module 20 call 4 */
        switch (itemIdx) {
        case 0:
            return STR_IT_new_;
        default:
            return NULL;
        }
    case 5125: /* module 20 call 5 */
        switch (itemIdx) {
        case 0:
            return STR_IT_who;
        default:
            return NULL;
        }
    case 5126: /* module 20 call 6 */
        switch (itemIdx) {
        default:
            return NULL;
        }
    case 8448: /* module 33 call 0 */
        switch (itemIdx) {
        case 0:
            return STR_IT_value;
        case 1:
            return STR_IT_beneficiary;
        default:
            return NULL;
        }
    case 8449: /* module 33 call 1 */
        switch (itemIdx) {
        case 0:
            return STR_IT_proposal_id;
        default:
            return NULL;
        }
    case 8450: /* module 33 call 2 */
        switch (itemIdx) {
        case 0:
            return STR_IT_proposal_id;
        default:
            return NULL;
        }
    /*case 6144: *//* module 24 call 0 *//*
        switch (itemIdx) {
        case 0:
            return STR_IT_dest;
        case 1:
            return STR_IT_ethereum_signature;
        default:
            return NULL;
        }
    case 6145: *//* module 24 call 1 *//*
        switch (itemIdx) {
        case 0:
            return STR_IT_who;
        case 1:
            return STR_IT_value;
        case 2:
            return STR_IT_vesting_schedule;
        case 3:
            return STR_IT_statement;
        default:
            return NULL;
        }
    case 6146: *//* module 24 call 2 *//*
        switch (itemIdx) {
        case 0:
            return STR_IT_dest;
        case 1:
            return STR_IT_ethereum_signature;
        case 2:
            return STR_IT_statement;
        default:
            return NULL;
        }
    case 6147: *//* module 24 call 3 *//*
        switch (itemIdx) {
        case 0:
            return STR_IT_statement;
        default:
            return NULL;
        }
    case 6148: *//* module 24 call 4 *//*
        switch (itemIdx) {
        case 0:
            return STR_IT_old;
        case 1:
            return STR_IT_new_;
        case 2:
            return STR_IT_maybe_preclaim;
        default:
            return NULL;
        }
    case 6400: *//* module 25 call 0 *//*
        switch (itemIdx) {
        default:
            return NULL;
        }
    case 6401: *//* module 25 call 1 *//*
        switch (itemIdx) {
        case 0:
            return STR_IT_target;
        default:
            return NULL;
        }
    case 6402: *//* module 25 call 2 *//*
        switch (itemIdx) {
        case 0:
            return STR_IT_target;
        case 1:
            return STR_IT_schedule;
        default:
            return NULL;
        }
    case 6403: *//* module 25 call 3 *//*
        switch (itemIdx) {
        case 0:
            return STR_IT_source;
        case 1:
            return STR_IT_target;
        case 2:
            return STR_IT_schedule;
        default:
            return NULL;
        }*/
    case 2049: /* module 8 call 1 */
        switch (itemIdx) {
        case 0:
            return STR_IT_index;
        case 1:
            return STR_IT_call;
        default:
            return NULL;
        }
    case 9728: /* module 38 call 0 */
        switch (itemIdx) {
        case 0:
            return STR_IT_account;
        default:
            return NULL;
        }
    case 9729: /* module 38 call 1 */
        switch (itemIdx) {
        case 0:
            return STR_IT_info;
        default:
            return NULL;
        }
    case 9730: /* module 38 call 2 */
        switch (itemIdx) {
        case 0:
            return STR_IT_subs;
        default:
            return NULL;
        }
    case 9731: /* module 38 call 3 */
        switch (itemIdx) {
        default:
            return NULL;
        }
    case 9732: /* module 38 call 4 */
        switch (itemIdx) {
        case 0:
            return STR_IT_reg_index;
        case 1:
            return STR_IT_max_fee;
        default:
            return NULL;
        }
    case 9733: /* module 38 call 5 */
        switch (itemIdx) {
        case 0:
            return STR_IT_reg_index;
        default:
            return NULL;
        }
    case 9734: /* module 38 call 6 */
        switch (itemIdx) {
        case 0:
            return STR_IT_index;
        case 1:
            return STR_IT_fee;
        default:
            return NULL;
        }
    case 9735: /* module 38 call 7 */
        switch (itemIdx) {
        case 0:
            return STR_IT_index;
        case 1:
            return STR_IT_new_;
        default:
            return NULL;
        }
    case 9736: /* module 38 call 8 */
        switch (itemIdx) {
        case 0:
            return STR_IT_index;
        case 1:
            return STR_IT_fields;
        default:
            return NULL;
        }
    case 9737: /* module 38 call 9 */
        switch (itemIdx) {
        case 0:
            return STR_IT_reg_index;
        case 1:
            return STR_IT_target;
        case 2:
            return STR_IT_judgement;
        default:
            return NULL;
        }
    case 9738: /* module 38 call 10 */
        switch (itemIdx) {
        case 0:
            return STR_IT_target;
        default:
            return NULL;
        }
    case 9739: /* module 38 call 11 */
        switch (itemIdx) {
        case 0:
            return STR_IT_sub;
        case 1:
            return STR_IT_data;
        default:
            return NULL;
        }
    case 9740: /* module 38 call 12 */
        switch (itemIdx) {
        case 0:
            return STR_IT_sub;
        case 1:
            return STR_IT_data;
        default:
            return NULL;
        }
    case 9741: /* module 38 call 13 */
        switch (itemIdx) {
        case 0:
            return STR_IT_sub;
        default:
            return NULL;
        }
    case 9742: /* module 38 call 14 */
        switch (itemIdx) {
        default:
            return NULL;
        }
    /*case 7424: *//* module 29 call 0 *//*
        switch (itemIdx) {
        case 0:
            return STR_IT_real;
        case 1:
            return STR_IT_force_proxy_type;
        case 2:
            return STR_IT_call;
        default:
            return NULL;
        }
    case 7425: *//* module 29 call 1 *//*
        switch (itemIdx) {
        case 0:
            return STR_IT_delegate;
        case 1:
            return STR_IT_proxy_type;
        case 2:
            return STR_IT_delay;
        default:
            return NULL;
        }
    case 7426: *//* module 29 call 2 *//*
        switch (itemIdx) {
        case 0:
            return STR_IT_delegate;
        case 1:
            return STR_IT_proxy_type;
        case 2:
            return STR_IT_delay;
        default:
            return NULL;
        }
    case 7427: *//* module 29 call 3 *//*
        switch (itemIdx) {
        default:
            return NULL;
        }
    case 7428: *//* module 29 call 4 *//*
        switch (itemIdx) {
        case 0:
            return STR_IT_proxy_type;
        case 1:
            return STR_IT_delay;
        case 2:
            return STR_IT_index;
        default:
            return NULL;
        }
    case 7429: *//* module 29 call 5 *//*
        switch (itemIdx) {
        case 0:
            return STR_IT_spawner;
        case 1:
            return STR_IT_proxy_type;
        case 2:
            return STR_IT_index;
        case 3:
            return STR_IT_height;
        case 4:
            return STR_IT_ext_index;
        default:
            return NULL;
        }
    case 7430: *//* module 29 call 6 *//*
        switch (itemIdx) {
        case 0:
            return STR_IT_real;
        case 1:
            return STR_IT_call_hash;
        default:
            return NULL;
        }
    case 7431: *//* module 29 call 7 *//*
        switch (itemIdx) {
        case 0:
            return STR_IT_real;
        case 1:
            return STR_IT_call_hash;
        default:
            return NULL;
        }
    case 7432: *//* module 29 call 8 *//*
        switch (itemIdx) {
        case 0:
            return STR_IT_delegate;
        case 1:
            return STR_IT_call_hash;
        default:
            return NULL;
        }
    case 7433: *//* module 29 call 9 *//*
        switch (itemIdx) {
        case 0:
            return STR_IT_delegate;
        case 1:
            return STR_IT_real;
        case 2:
            return STR_IT_force_proxy_type;
        case 3:
            return STR_IT_call;
        default:
            return NULL;
        }
    case 7680: *//* module 30 call 0 *//*
        switch (itemIdx) {
        case 0:
            return STR_IT_other_signatories;
        case 1:
            return STR_IT_call;
        default:
            return NULL;
        }
    case 7681: *//* module 30 call 1 *//*
        switch (itemIdx) {
        case 0:
            return STR_IT_threshold;
        case 1:
            return STR_IT_other_signatories;
        case 2:
            return STR_IT_maybe_timepoint;
        case 3:
            return STR_IT_call;
        case 4:
            return STR_IT_store_call;
        case 5:
            return STR_IT_max_weight;
        default:
            return NULL;
        }
    case 7682: *//* module 30 call 2 *//*
        switch (itemIdx) {
        case 0:
            return STR_IT_threshold;
        case 1:
            return STR_IT_other_signatories;
        case 2:
            return STR_IT_maybe_timepoint;
        case 3:
            return STR_IT_call_hash;
        case 4:
            return STR_IT_max_weight;
        default:
            return NULL;
        }
    case 7683: *//* module 30 call 3 *//*
        switch (itemIdx) {
        case 0:
            return STR_IT_threshold;
        case 1:
            return STR_IT_other_signatories;
        case 2:
            return STR_IT_timepoint;
        case 3:
            return STR_IT_call_hash;
        default:
            return NULL;
        }*/
    case 8704: /* module 34 call 0 */
        switch (itemIdx) {
        case 0:
            return STR_IT_value;
        case 1:
            return STR_IT_description;
        default:
            return NULL;
        }
    case 8705: /* module 34 call 1 */
        switch (itemIdx) {
        case 0:
            return STR_IT_bounty_id;
        default:
            return NULL;
        }
    case 8706: /* module 34 call 2 */
        switch (itemIdx) {
        case 0:
            return STR_IT_bounty_id;
        case 1:
            return STR_IT_curator;
        case 2:
            return STR_IT_fee;
        default:
            return NULL;
        }
    case 8707: /* module 34 call 3 */
        switch (itemIdx) {
        case 0:
            return STR_IT_bounty_id;
        default:
            return NULL;
        }
    case 8708: /* module 34 call 4 */
        switch (itemIdx) {
        case 0:
            return STR_IT_bounty_id;
        default:
            return NULL;
        }
    case 8709: /* module 34 call 5 */
        switch (itemIdx) {
        case 0:
            return STR_IT_bounty_id;
        case 1:
            return STR_IT_beneficiary;
        default:
            return NULL;
        }
    case 8710: /* module 34 call 6 */
        switch (itemIdx) {
        case 0:
            return STR_IT_bounty_id;
        default:
            return NULL;
        }
    case 8711: /* module 34 call 7 */
        switch (itemIdx) {
        case 0:
            return STR_IT_bounty_id;
        default:
            return NULL;
        }
    case 8712: /* module 34 call 8 */
        switch (itemIdx) {
        case 0:
            return STR_IT_bounty_id;
        case 1:
            return STR_IT__remark;
        default:
            return NULL;
        }
    case 9472: /* module 37 call 0 */
        switch (itemIdx) {
        case 0:
            return STR_IT_reason;
        case 1:
            return STR_IT_who;
        default:
            return NULL;
        }
    case 9473: /* module 37 call 1 */
        switch (itemIdx) {
        case 0:
            return STR_IT_hash;
        default:
            return NULL;
        }
    case 9474: /* module 37 call 2 */
        switch (itemIdx) {
        case 0:
            return STR_IT_reason;
        case 1:
            return STR_IT_who;
        case 2:
            return STR_IT_tip_value;
        default:
            return NULL;
        }
    case 9475: /* module 37 call 3 */
        switch (itemIdx) {
        case 0:
            return STR_IT_hash;
        case 1:
            return STR_IT_tip_value;
        default:
            return NULL;
        }
    case 9476: /* module 37 call 4 */
        switch (itemIdx) {
        case 0:
            return STR_IT_hash;
        default:
            return NULL;
        }
    case 9477: /* module 37 call 5 */
        switch (itemIdx) {
        case 0:
            return STR_IT_hash;
        default:
            return NULL;
        }
    case 7936: /* module 31 call 0 */
        switch (itemIdx) {
        case 0:
            return STR_IT_solution;
        case 1:
            return STR_IT_witness;
        default:
            return NULL;
        }
#endif
    default:
        return NULL;
    }

    return NULL;
}

parser_error_t _getMethod_ItemValue_V1(
    pd_Method_V1_t* m,
    uint8_t moduleIdx, uint8_t callIdx, uint8_t itemIdx,
    char* outValue, uint16_t outValueLen,
    uint8_t pageIdx, uint8_t* pageCount)
{
    uint16_t callPrivIdx = ((uint16_t)moduleIdx << 8u) + callIdx;

    switch (callPrivIdx) {
    case 512: /* module 2 call 0 */
        switch (itemIdx) {
        case 0: /* balances_transfer_V1 - dest */;
            return _toStringLookupSource_V1(
                &m->nested.balances_transfer_V1.dest,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* balances_transfer_V1 - value */;
            return _toStringCompactBalance(
                &m->nested.balances_transfer_V1.value,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 515: /* module 2 call 3 */
        switch (itemIdx) {
        case 0: /* balances_transfer_keep_alive_V1 - dest */;
            return _toStringLookupSource_V1(
                &m->nested.balances_transfer_keep_alive_V1.dest,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* balances_transfer_keep_alive_V1 - value */;
            return _toStringCompactBalance(
                &m->nested.balances_transfer_keep_alive_V1.value,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 7680: /* module 30 call 0 */
        switch (itemIdx) {
        case 0: /* staking_bond_V1 - controller */;
            return _toStringLookupSource_V1(
                &m->nested.staking_bond_V1.controller,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* staking_bond_V1 - value */;
            return _toStringCompactBalanceOf(
                &m->nested.staking_bond_V1.value,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 2: /* staking_bond_V1 - payee */;
            return _toStringRewardDestination_V1(
                &m->nested.staking_bond_V1.payee,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 7681: /* module 30 call 1 */
        switch (itemIdx) {
        case 0: /* staking_bond_extra_V1 - max_additional */;
            return _toStringCompactBalanceOf(
                &m->nested.staking_bond_extra_V1.max_additional,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 7682: /* module 30 call 2 */
        switch (itemIdx) {
        case 0: /* staking_unbond_V1 - value */;
            return _toStringCompactBalanceOf(
                &m->nested.staking_unbond_V1.value,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 7683: /* module 30 call 3 */
        switch (itemIdx) {
        case 0: /* staking_withdraw_unbonded_V1 - num_slashing_spans */;
            return _toStringu32(
                &m->nested.staking_withdraw_unbonded_V1.num_slashing_spans,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 7684: /* module 30 call 4 */
        switch (itemIdx) {
        case 0: /* staking_validate_V1 - prefs */;
            return _toStringValidatorPrefs_V1(
                &m->nested.staking_validate_V1.prefs,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 7685: /* module 30 call 5 */
        switch (itemIdx) {
        case 0: /* staking_nominate_V1 - targets */;
            return _toStringVecLookupSource_V1(
                &m->nested.staking_nominate_V1.targets,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 7686: /* module 30 call 6 */
        switch (itemIdx) {
        default:
            return parser_no_data;
        }
    case 7687: /* module 30 call 7 */
        switch (itemIdx) {
        case 0: /* staking_set_payee_V1 - payee */;
            return _toStringRewardDestination_V1(
                &m->nested.staking_set_payee_V1.payee,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 7698: /* module 30 call 18 */
        switch (itemIdx) {
        case 0: /* staking_payout_stakers_V1 - validator_stash */;
            return _toStringAccountId_V1(
                &m->nested.staking_payout_stakers_V1.validator_stash,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* staking_payout_stakers_V1 - era */;
            return _toStringEraIndex_V1(
                &m->nested.staking_payout_stakers_V1.era,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 7699: /* module 30 call 19 */
        switch (itemIdx) {
        case 0: /* staking_rebond_V1 - value */;
            return _toStringCompactBalanceOf(
                &m->nested.staking_rebond_V1.value,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 768: /* module 3 call 0 */
        switch (itemIdx) {
        case 0: /* session_set_keys_V1 - keys */;
            return _toStringKeys_V1(
                &m->basic.session_set_keys_V1.keys,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* session_set_keys_V1 - proof */;
            return _toStringBytes(
                &m->basic.session_set_keys_V1.proof,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 769: /* module 3 call 1 */
        switch (itemIdx) {
        default:
            return parser_no_data;
        }
    case 2048: /* module 8 call 0 */
        switch (itemIdx) {
        case 0: /* utility_batch_V1 - calls */;
            return _toStringVecCall(
                &m->basic.utility_batch_V1.calls,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 2050: /* module 8 call 2 */
        switch (itemIdx) {
        case 0: /* utility_batch_all_V1 - calls */;
            return _toStringVecCall(
                &m->basic.utility_batch_all_V1.calls,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
#ifdef SUBSTRATE_PARSER_FULL
    case 0: /* module 0 call 0 */
        switch (itemIdx) {
        case 0: /* system_fill_block_V1 - _ratio */;
            return _toStringPerbill_V1(
                &m->nested.system_fill_block_V1._ratio,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 1: /* module 0 call 1 */
        switch (itemIdx) {
        case 0: /* system_remark_V1 - _remark */;
            return _toStringBytes(
                &m->nested.system_remark_V1._remark,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 2: /* module 0 call 2 */
        switch (itemIdx) {
        case 0: /* system_set_heap_pages_V1 - pages */;
            return _toStringu64(
                &m->nested.system_set_heap_pages_V1.pages,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 3: /* module 0 call 3 */
        switch (itemIdx) {
        case 0: /* system_set_code_V1 - code */;
            return _toStringBytes(
                &m->nested.system_set_code_V1.code,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 4: /* module 0 call 4 */
        switch (itemIdx) {
        case 0: /* system_set_code_without_checks_V1 - code */;
            return _toStringBytes(
                &m->nested.system_set_code_without_checks_V1.code,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 5: /* module 0 call 5 */
        switch (itemIdx) {
        case 0: /* system_set_changes_trie_config_V1 - changes_trie_config */;
            return _toStringOptionChangesTrieConfiguration_V1(
                &m->nested.system_set_changes_trie_config_V1.changes_trie_config,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 6: /* module 0 call 6 */
        switch (itemIdx) {
        case 0: /* system_set_storage_V1 - items */;
            return _toStringVecKeyValue_V1(
                &m->nested.system_set_storage_V1.items,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 7: /* module 0 call 7 */
        switch (itemIdx) {
        case 0: /* system_kill_storage_V1 - keys */;
            return _toStringVecKey_V1(
                &m->nested.system_kill_storage_V1.keys,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 8: /* module 0 call 8 */
        switch (itemIdx) {
        case 0: /* system_kill_prefix_V1 - prefix */;
            return _toStringKey_V1(
                &m->nested.system_kill_prefix_V1.prefix,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* system_kill_prefix_V1 - _subkeys */;
            return _toStringu32(
                &m->nested.system_kill_prefix_V1._subkeys,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 9: /* module 0 call 9 */
        switch (itemIdx) {
            case 0: /* system_remark_with_event_V1 - remark */;
            return _toStringBytes(
                    &m->basic.system_remark_with_event_V1.remark,
                    outValue, outValueLen,
                    pageIdx, pageCount);
            default:
                return parser_no_data;
        }
    case 5376: /* module 21 call 0 */
        switch (itemIdx) {
        case 0: /* scheduler_schedule_V1 - when */;
            return _toStringBlockNumber(
                &m->basic.scheduler_schedule_V1.when,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* scheduler_schedule_V1 - maybe_periodic */;
            return _toStringOptionPeriod_V1(
                &m->basic.scheduler_schedule_V1.maybe_periodic,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 2: /* scheduler_schedule_V1 - priority */;
            return _toStringPriority_V1(
                &m->basic.scheduler_schedule_V1.priority,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 3: /* scheduler_schedule_V1 - call */;
            return _toStringCall(
                &m->basic.scheduler_schedule_V1.call,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 5377: /* module 21 call 1 */
        switch (itemIdx) {
        case 0: /* scheduler_cancel_V1 - when */;
            return _toStringBlockNumber(
                &m->basic.scheduler_cancel_V1.when,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* scheduler_cancel_V1 - index */;
            return _toStringu32(
                &m->basic.scheduler_cancel_V1.index,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 5378: /* module 21 call 2 */
        switch (itemIdx) {
        case 0: /* scheduler_schedule_named_V1 - id */;
            return _toStringBytes(
                &m->basic.scheduler_schedule_named_V1.id,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* scheduler_schedule_named_V1 - when */;
            return _toStringBlockNumber(
                &m->basic.scheduler_schedule_named_V1.when,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 2: /* scheduler_schedule_named_V1 - maybe_periodic */;
            return _toStringOptionPeriod_V1(
                &m->basic.scheduler_schedule_named_V1.maybe_periodic,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 3: /* scheduler_schedule_named_V1 - priority */;
            return _toStringPriority_V1(
                &m->basic.scheduler_schedule_named_V1.priority,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 4: /* scheduler_schedule_named_V1 - call */;
            return _toStringCall(
                &m->basic.scheduler_schedule_named_V1.call,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 5379: /* module 21 call 3 */
        switch (itemIdx) {
        case 0: /* scheduler_cancel_named_V1 - id */;
            return _toStringBytes(
                &m->basic.scheduler_cancel_named_V1.id,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 5380: /* module 21 call 4 */
        switch (itemIdx) {
        case 0: /* scheduler_schedule_after_V1 - after */;
            return _toStringBlockNumber(
                &m->basic.scheduler_schedule_after_V1.after,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* scheduler_schedule_after_V1 - maybe_periodic */;
            return _toStringOptionPeriod_V1(
                &m->basic.scheduler_schedule_after_V1.maybe_periodic,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 2: /* scheduler_schedule_after_V1 - priority */;
            return _toStringPriority_V1(
                &m->basic.scheduler_schedule_after_V1.priority,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 3: /* scheduler_schedule_after_V1 - call */;
            return _toStringCall(
                &m->basic.scheduler_schedule_after_V1.call,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 5381: /* module 21 call 5 */
        switch (itemIdx) {
        case 0: /* scheduler_schedule_named_after_V1 - id */;
            return _toStringBytes(
                &m->basic.scheduler_schedule_named_after_V1.id,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* scheduler_schedule_named_after_V1 - after */;
            return _toStringBlockNumber(
                &m->basic.scheduler_schedule_named_after_V1.after,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 2: /* scheduler_schedule_named_after_V1 - maybe_periodic */;
            return _toStringOptionPeriod_V1(
                &m->basic.scheduler_schedule_named_after_V1.maybe_periodic,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 3: /* scheduler_schedule_named_after_V1 - priority */;
            return _toStringPriority_V1(
                &m->basic.scheduler_schedule_named_after_V1.priority,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 4: /* scheduler_schedule_named_after_V1 - call */;
            return _toStringCall(
                &m->basic.scheduler_schedule_named_after_V1.call,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 7424: /* module 29 call 0 */
        switch (itemIdx) {
        case 0: /* babe_report_equivocation_V1 - equivocation_proof */;
            return _toStringBabeEquivocationProof_V1(
                &m->basic.babe_report_equivocation_V1.equivocation_proof,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* babe_report_equivocation_V1 - key_owner_proof */;
            return _toStringKeyOwnerProof_V1(
                &m->basic.babe_report_equivocation_V1.key_owner_proof,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 7425: /* module 29 call 1 */
        switch (itemIdx) {
        case 0: /* babe_report_equivocation_unsigned_V1 - equivocation_proof */;
            return _toStringBabeEquivocationProof_V1(
                &m->basic.babe_report_equivocation_unsigned_V1.equivocation_proof,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* babe_report_equivocation_unsigned_V1 - key_owner_proof */;
            return _toStringKeyOwnerProof_V1(
                &m->basic.babe_report_equivocation_unsigned_V1.key_owner_proof,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 256: /* module 1 call 0 */
        switch (itemIdx) {
        case 0: /* timestamp_set_V1 - now */;
            return _toStringCompactMoment_V1(
                &m->basic.timestamp_set_V1.now,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 513: /* module 2 call 1 */
        switch (itemIdx) {
        case 0: /* balances_set_balance_V1 - who */;
            return _toStringLookupSource_V1(
                &m->nested.balances_set_balance_V1.who,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* balances_set_balance_V1 - new_free */;
            return _toStringCompactBalance(
                &m->nested.balances_set_balance_V1.new_free,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 2: /* balances_set_balance_V1 - new_reserved */;
            return _toStringCompactBalance(
                &m->nested.balances_set_balance_V1.new_reserved,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 514: /* module 2 call 2 */
        switch (itemIdx) {
        case 0: /* balances_force_transfer_V1 - source */;
            return _toStringLookupSource_V1(
                &m->nested.balances_force_transfer_V1.source,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* balances_force_transfer_V1 - dest */;
            return _toStringLookupSource_V1(
                &m->nested.balances_force_transfer_V1.dest,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 2: /* balances_force_transfer_V1 - value */;
            return _toStringCompactBalance(
                &m->nested.balances_force_transfer_V1.value,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 1536: /* module 6 call 0 */
        switch (itemIdx) {
        case 0: /* authorship_set_uncles_V1 - new_uncles */;
            return _toStringVecHeader(
                &m->basic.authorship_set_uncles_V1.new_uncles,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 7688: /* module 30 call 8 */
        switch (itemIdx) {
        case 0: /* staking_set_controller_V1 - controller */;
            return _toStringLookupSource_V1(
                &m->basic.staking_set_controller_V1.controller,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 7689: /* module 30 call 9 */
        switch (itemIdx) {
        case 0: /* staking_set_validator_count_V1 - new_ */;
            return _toStringCompactu32(
                &m->basic.staking_set_validator_count_V1.new_,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 7690: /* module 30 call 10 */
        switch (itemIdx) {
        case 0: /* staking_increase_validator_count_V1 - additional */;
            return _toStringCompactu32(
                &m->basic.staking_increase_validator_count_V1.additional,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 7691: /* module 30 call 11 */
        switch (itemIdx) {
        case 0: /* staking_scale_validator_count_V1 - factor */;
            return _toStringPercent_V1(
                &m->basic.staking_scale_validator_count_V1.factor,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 7692: /* module 30 call 12 */
        switch (itemIdx) {
        default:
            return parser_no_data;
        }
    case 7693: /* module 30 call 13 */
        switch (itemIdx) {
        default:
            return parser_no_data;
        }
    case 7694: /* module 30 call 14 */
        switch (itemIdx) {
        case 0: /* staking_set_invulnerables_V1 - invulnerables */;
            return _toStringVecAccountId_V1(
                &m->basic.staking_set_invulnerables_V1.invulnerables,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 7695: /* module 30 call 15 */
        switch (itemIdx) {
        case 0: /* staking_force_unstake_V1 - stash */;
            return _toStringAccountId_V1(
                &m->basic.staking_force_unstake_V1.stash,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* staking_force_unstake_V1 - num_slashing_spans */;
            return _toStringu32(
                &m->basic.staking_force_unstake_V1.num_slashing_spans,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 7696: /* module 30 call 16 */
        switch (itemIdx) {
        default:
            return parser_no_data;
        }
    case 7697: /* module 30 call 17 */
        switch (itemIdx) {
        case 0: /* staking_cancel_deferred_slash_V1 - era */;
            return _toStringEraIndex_V1(
                &m->basic.staking_cancel_deferred_slash_V1.era,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* staking_cancel_deferred_slash_V1 - slash_indices */;
            return _toStringVecu32(
                &m->basic.staking_cancel_deferred_slash_V1.slash_indices,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 7700: /* module 30 call 20 */
        switch (itemIdx) {
        case 0: /* staking_set_history_depth_V1 - new_history_depth */;
            return _toStringCompactEraIndex_V1(
                &m->basic.staking_set_history_depth_V1.new_history_depth,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* staking_set_history_depth_V1 - _era_items_deleted */;
            return _toStringCompactu32(
                &m->basic.staking_set_history_depth_V1._era_items_deleted,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 7701: /* module 30 call 21 */
        switch (itemIdx) {
        case 0: /* staking_reap_stash_V1 - stash */;
            return _toStringAccountId_V1(
                &m->basic.staking_reap_stash_V1.stash,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* staking_reap_stash_V1 - num_slashing_spans */;
            return _toStringu32(
                &m->basic.staking_reap_stash_V1.num_slashing_spans,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 7702: /* module 30 call 22 */
        switch (itemIdx) {
        case 0: /* staking_submit_election_solution_V1 - winners */;
            return _toStringVecValidatorIndex_V1(
                &m->basic.staking_submit_election_solution_V1.winners,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* staking_submit_election_solution_V1 - compact */;
            return _toStringCompactAssignments_V1(
                &m->basic.staking_submit_election_solution_V1.compact,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 2: /* staking_submit_election_solution_V1 - score */;
            return _toStringElectionScore_V1(
                &m->basic.staking_submit_election_solution_V1.score,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 3: /* staking_submit_election_solution_V1 - era */;
            return _toStringEraIndex_V1(
                &m->basic.staking_submit_election_solution_V1.era,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 4: /* staking_submit_election_solution_V1 - size */;
            return _toStringElectionSize_V1(
                &m->basic.staking_submit_election_solution_V1.size,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 7703: /* module 30 call 23 */
        switch (itemIdx) {
        case 0: /* staking_submit_election_solution_unsigned_V1 - winners */;
            return _toStringVecValidatorIndex_V1(
                &m->basic.staking_submit_election_solution_unsigned_V1.winners,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* staking_submit_election_solution_unsigned_V1 - compact */;
            return _toStringCompactAssignments_V1(
                &m->basic.staking_submit_election_solution_unsigned_V1.compact,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 2: /* staking_submit_election_solution_unsigned_V1 - score */;
            return _toStringElectionScore_V1(
                &m->basic.staking_submit_election_solution_unsigned_V1.score,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 3: /* staking_submit_election_solution_unsigned_V1 - era */;
            return _toStringEraIndex_V1(
                &m->basic.staking_submit_election_solution_unsigned_V1.era,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 4: /* staking_submit_election_solution_unsigned_V1 - size */;
            return _toStringElectionSize_V1(
                &m->basic.staking_submit_election_solution_unsigned_V1.size,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 7704: /* module 30 call 24 */
        switch (itemIdx) {
        case 0: /* staking_kick_V1 - who */;
            return _toStringVecLookupSource_V1(
                &m->basic.staking_kick_V1.who,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 1280: /* module 5 call 0 */
        switch (itemIdx) {
        case 0: /* grandpa_report_equivocation_V1 - equivocation_proof */;
            return _toStringGrandpaEquivocationProof_V1(
                &m->basic.grandpa_report_equivocation_V1.equivocation_proof,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* grandpa_report_equivocation_V1 - key_owner_proof */;
            return _toStringKeyOwnerProof_V1(
                &m->basic.grandpa_report_equivocation_V1.key_owner_proof,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 1281: /* module 5 call 1 */
        switch (itemIdx) {
        case 0: /* grandpa_report_equivocation_unsigned_V1 - equivocation_proof */;
            return _toStringGrandpaEquivocationProof_V1(
                &m->basic.grandpa_report_equivocation_unsigned_V1.equivocation_proof,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* grandpa_report_equivocation_unsigned_V1 - key_owner_proof */;
            return _toStringKeyOwnerProof_V1(
                &m->basic.grandpa_report_equivocation_unsigned_V1.key_owner_proof,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 1282: /* module 5 call 2 */
        switch (itemIdx) {
        case 0: /* grandpa_note_stalled_V1 - delay */;
            return _toStringBlockNumber(
                &m->basic.grandpa_note_stalled_V1.delay,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* grandpa_note_stalled_V1 - best_finalized_block_number */;
            return _toStringBlockNumber(
                &m->basic.grandpa_note_stalled_V1.best_finalized_block_number,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 7168: /* module 28 call 0 */
        switch (itemIdx) {
        case 0: /* imonline_heartbeat_V1 - heartbeat */;
            return _toStringHeartbeat(
                &m->basic.imonline_heartbeat_V1.heartbeat,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* imonline_heartbeat_V1 - _signature */;
            return _toStringSignature_V1(
                &m->basic.imonline_heartbeat_V1._signature,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 4352: /* module 17 call 0 */
        switch (itemIdx) {
        case 0: /* democracy_propose_V1 - proposal_hash */;
            return _toStringHash(
                &m->basic.democracy_propose_V1.proposal_hash,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* democracy_propose_V1 - value */;
            return _toStringCompactBalanceOf(
                &m->basic.democracy_propose_V1.value,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 4353: /* module 17 call 1 */
        switch (itemIdx) {
        case 0: /* democracy_second_V1 - proposal */;
            return _toStringCompactPropIndex_V1(
                &m->basic.democracy_second_V1.proposal,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* democracy_second_V1 - seconds_upper_bound */;
            return _toStringCompactu32(
                &m->basic.democracy_second_V1.seconds_upper_bound,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 4354: /* module 17 call 2 */
        switch (itemIdx) {
        case 0: /* democracy_vote_V1 - ref_index */;
            return _toStringCompactReferendumIndex_V1(
                &m->basic.democracy_vote_V1.ref_index,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* democracy_vote_V1 - vote */;
            return _toStringAccountVote_V1(
                &m->basic.democracy_vote_V1.vote,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 4355: /* module 17 call 3 */
        switch (itemIdx) {
        case 0: /* democracy_emergency_cancel_V1 - ref_index */;
            return _toStringReferendumIndex_V1(
                &m->basic.democracy_emergency_cancel_V1.ref_index,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 4356: /* module 17 call 4 */
        switch (itemIdx) {
        case 0: /* democracy_external_propose_V1 - proposal_hash */;
            return _toStringHash(
                &m->basic.democracy_external_propose_V1.proposal_hash,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 4357: /* module 17 call 5 */
        switch (itemIdx) {
        case 0: /* democracy_external_propose_majority_V1 - proposal_hash */;
            return _toStringHash(
                &m->basic.democracy_external_propose_majority_V1.proposal_hash,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 4358: /* module 17 call 6 */
        switch (itemIdx) {
        case 0: /* democracy_external_propose_default_V1 - proposal_hash */;
            return _toStringHash(
                &m->basic.democracy_external_propose_default_V1.proposal_hash,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 4359: /* module 17 call 7 */
        switch (itemIdx) {
        case 0: /* democracy_fast_track_V1 - proposal_hash */;
            return _toStringHash(
                &m->basic.democracy_fast_track_V1.proposal_hash,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* democracy_fast_track_V1 - voting_period */;
            return _toStringBlockNumber(
                &m->basic.democracy_fast_track_V1.voting_period,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 2: /* democracy_fast_track_V1 - delay */;
            return _toStringBlockNumber(
                &m->basic.democracy_fast_track_V1.delay,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 4360: /* module 17 call 8 */
        switch (itemIdx) {
        case 0: /* democracy_veto_external_V1 - proposal_hash */;
            return _toStringHash(
                &m->basic.democracy_veto_external_V1.proposal_hash,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 4361: /* module 17 call 9 */
        switch (itemIdx) {
        case 0: /* democracy_cancel_referendum_V1 - ref_index */;
            return _toStringCompactReferendumIndex_V1(
                &m->basic.democracy_cancel_referendum_V1.ref_index,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 4362: /* module 17 call 10 */
        switch (itemIdx) {
        case 0: /* democracy_cancel_queued_V1 - which */;
            return _toStringReferendumIndex_V1(
                &m->basic.democracy_cancel_queued_V1.which,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 4363: /* module 17 call 11 */
        switch (itemIdx) {
        case 0: /* democracy_delegate_V1 - to */;
            return _toStringAccountId_V1(
                &m->basic.democracy_delegate_V1.to,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* democracy_delegate_V1 - conviction */;
            return _toStringConviction_V1(
                &m->basic.democracy_delegate_V1.conviction,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 2: /* democracy_delegate_V1 - balance */;
            return _toStringBalanceOf(
                &m->basic.democracy_delegate_V1.balance,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 4364: /* module 17 call 12 */
        switch (itemIdx) {
        default:
            return parser_no_data;
        }
    case 4365: /* module 17 call 13 */
        switch (itemIdx) {
        default:
            return parser_no_data;
        }
    case 4366: /* module 17 call 14 */
        switch (itemIdx) {
        case 0: /* democracy_note_preimage_V1 - encoded_proposal */;
            return _toStringBytes(
                &m->basic.democracy_note_preimage_V1.encoded_proposal,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 4367: /* module 17 call 15 */
        switch (itemIdx) {
        case 0: /* democracy_note_preimage_operational_V1 - encoded_proposal */;
            return _toStringBytes(
                &m->basic.democracy_note_preimage_operational_V1.encoded_proposal,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 4368: /* module 17 call 16 */
        switch (itemIdx) {
        case 0: /* democracy_note_imminent_preimage_V1 - encoded_proposal */;
            return _toStringBytes(
                &m->basic.democracy_note_imminent_preimage_V1.encoded_proposal,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 4369: /* module 17 call 17 */
        switch (itemIdx) {
        case 0: /* democracy_note_imminent_preimage_operational_V1 - encoded_proposal */;
            return _toStringBytes(
                &m->basic.democracy_note_imminent_preimage_operational_V1.encoded_proposal,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 4370: /* module 17 call 18 */
        switch (itemIdx) {
        case 0: /* democracy_reap_preimage_V1 - proposal_hash */;
            return _toStringHash(
                &m->basic.democracy_reap_preimage_V1.proposal_hash,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* democracy_reap_preimage_V1 - proposal_len_upper_bound */;
            return _toStringCompactu32(
                &m->basic.democracy_reap_preimage_V1.proposal_len_upper_bound,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 4371: /* module 17 call 19 */
        switch (itemIdx) {
        case 0: /* democracy_unlock_V1 - target */;
            return _toStringAccountId_V1(
                &m->basic.democracy_unlock_V1.target,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 4372: /* module 17 call 20 */
        switch (itemIdx) {
        case 0: /* democracy_remove_vote_V1 - index */;
            return _toStringReferendumIndex_V1(
                &m->basic.democracy_remove_vote_V1.index,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 4373: /* module 17 call 21 */
        switch (itemIdx) {
        case 0: /* democracy_remove_other_vote_V1 - target */;
            return _toStringAccountId_V1(
                &m->basic.democracy_remove_other_vote_V1.target,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* democracy_remove_other_vote_V1 - index */;
            return _toStringReferendumIndex_V1(
                &m->basic.democracy_remove_other_vote_V1.index,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 4374: /* module 17 call 22 */
        switch (itemIdx) {
        case 0: /* democracy_enact_proposal_V1 - proposal_hash */;
            return _toStringHash(
                &m->basic.democracy_enact_proposal_V1.proposal_hash,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* democracy_enact_proposal_V1 - index */;
            return _toStringReferendumIndex_V1(
                &m->basic.democracy_enact_proposal_V1.index,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 4375: /* module 17 call 23 */
        switch (itemIdx) {
        case 0: /* democracy_blacklist_V1 - proposal_hash */;
            return _toStringHash(
                &m->basic.democracy_blacklist_V1.proposal_hash,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* democracy_blacklist_V1 - maybe_ref_index */;
            return _toStringOptionReferendumIndex_V1(
                &m->basic.democracy_blacklist_V1.maybe_ref_index,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 4376: /* module 17 call 24 */
        switch (itemIdx) {
        case 0: /* democracy_cancel_proposal_V1 - prop_index */;
            return _toStringCompactPropIndex_V1(
                &m->basic.democracy_cancel_proposal_V1.prop_index,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 4608: /* module 18 call 0 */
        switch (itemIdx) {
        case 0: /* council_set_members_V1 - new_members */;
            return _toStringVecAccountId_V1(
                &m->basic.council_set_members_V1.new_members,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* council_set_members_V1 - prime */;
            return _toStringOptionAccountId_V1(
                &m->basic.council_set_members_V1.prime,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 2: /* council_set_members_V1 - old_count */;
            return _toStringMemberCount_V1(
                &m->basic.council_set_members_V1.old_count,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 4609: /* module 18 call 1 */
        switch (itemIdx) {
        case 0: /* council_execute_V1 - proposal */;
            return _toStringProposal(
                &m->basic.council_execute_V1.proposal,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* council_execute_V1 - length_bound */;
            return _toStringCompactu32(
                &m->basic.council_execute_V1.length_bound,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 4610: /* module 18 call 2 */
        switch (itemIdx) {
        case 0: /* council_propose_V1 - threshold */;
            return _toStringCompactMemberCount_V1(
                &m->basic.council_propose_V1.threshold,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* council_propose_V1 - proposal */;
            return _toStringProposal(
                &m->basic.council_propose_V1.proposal,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 2: /* council_propose_V1 - length_bound */;
            return _toStringCompactu32(
                &m->basic.council_propose_V1.length_bound,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 4611: /* module 18 call 3 */
        switch (itemIdx) {
        case 0: /* council_vote_V1 - proposal */;
            return _toStringHash(
                &m->basic.council_vote_V1.proposal,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* council_vote_V1 - index */;
            return _toStringCompactProposalIndex_V1(
                &m->basic.council_vote_V1.index,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 2: /* council_vote_V1 - approve */;
            return _toStringbool(
                &m->basic.council_vote_V1.approve,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 4612: /* module 18 call 4 */
        switch (itemIdx) {
        case 0: /* council_close_V1 - proposal_hash */;
            return _toStringHash(
                &m->basic.council_close_V1.proposal_hash,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* council_close_V1 - index */;
            return _toStringCompactProposalIndex_V1(
                &m->basic.council_close_V1.index,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 2: /* council_close_V1 - proposal_weight_bound */;
            return _toStringCompactWeight_V1(
                &m->basic.council_close_V1.proposal_weight_bound,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 3: /* council_close_V1 - length_bound */;
            return _toStringCompactu32(
                &m->basic.council_close_V1.length_bound,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 4613: /* module 18 call 5 */
        switch (itemIdx) {
        case 0: /* council_disapprove_proposal_V1 - proposal_hash */;
            return _toStringHash(
                &m->basic.council_disapprove_proposal_V1.proposal_hash,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 4864: /* module 19 call 0 */
        switch (itemIdx) {
        case 0: /* technicalcommittee_set_members_V1 - new_members */;
            return _toStringVecAccountId_V1(
                &m->basic.technicalcommittee_set_members_V1.new_members,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* technicalcommittee_set_members_V1 - prime */;
            return _toStringOptionAccountId_V1(
                &m->basic.technicalcommittee_set_members_V1.prime,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 2: /* technicalcommittee_set_members_V1 - old_count */;
            return _toStringMemberCount_V1(
                &m->basic.technicalcommittee_set_members_V1.old_count,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 4865: /* module 19 call 1 */
        switch (itemIdx) {
        case 0: /* technicalcommittee_execute_V1 - proposal */;
            return _toStringProposal(
                &m->basic.technicalcommittee_execute_V1.proposal,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* technicalcommittee_execute_V1 - length_bound */;
            return _toStringCompactu32(
                &m->basic.technicalcommittee_execute_V1.length_bound,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 4866: /* module 19 call 2 */
        switch (itemIdx) {
        case 0: /* technicalcommittee_propose_V1 - threshold */;
            return _toStringCompactMemberCount_V1(
                &m->basic.technicalcommittee_propose_V1.threshold,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* technicalcommittee_propose_V1 - proposal */;
            return _toStringProposal(
                &m->basic.technicalcommittee_propose_V1.proposal,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 2: /* technicalcommittee_propose_V1 - length_bound */;
            return _toStringCompactu32(
                &m->basic.technicalcommittee_propose_V1.length_bound,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 4867: /* module 19 call 3 */
        switch (itemIdx) {
        case 0: /* technicalcommittee_vote_V1 - proposal */;
            return _toStringHash(
                &m->basic.technicalcommittee_vote_V1.proposal,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* technicalcommittee_vote_V1 - index */;
            return _toStringCompactProposalIndex_V1(
                &m->basic.technicalcommittee_vote_V1.index,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 2: /* technicalcommittee_vote_V1 - approve */;
            return _toStringbool(
                &m->basic.technicalcommittee_vote_V1.approve,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 4868: /* module 19 call 4 */
        switch (itemIdx) {
        case 0: /* technicalcommittee_close_V1 - proposal_hash */;
            return _toStringHash(
                &m->basic.technicalcommittee_close_V1.proposal_hash,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* technicalcommittee_close_V1 - index */;
            return _toStringCompactProposalIndex_V1(
                &m->basic.technicalcommittee_close_V1.index,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 2: /* technicalcommittee_close_V1 - proposal_weight_bound */;
            return _toStringCompactWeight_V1(
                &m->basic.technicalcommittee_close_V1.proposal_weight_bound,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 3: /* technicalcommittee_close_V1 - length_bound */;
            return _toStringCompactu32(
                &m->basic.technicalcommittee_close_V1.length_bound,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 4869: /* module 19 call 5 */
        switch (itemIdx) {
        case 0: /* technicalcommittee_disapprove_proposal_V1 - proposal_hash */;
            return _toStringHash(
                &m->basic.technicalcommittee_disapprove_proposal_V1.proposal_hash,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 9216: /* module 36 call 0 */
        switch (itemIdx) {
        case 0: /* electionsphragmen_vote_V1 - votes */;
            return _toStringVecAccountId_V1(
                &m->basic.electionsphragmen_vote_V1.votes,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* electionsphragmen_vote_V1 - value */;
            return _toStringCompactBalanceOf(
                &m->basic.electionsphragmen_vote_V1.value,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 9217: /* module 36 call 1 */
        switch (itemIdx) {
        default:
            return parser_no_data;
        }
    case 9218: /* module 36 call 2 */
        switch (itemIdx) {
        case 0: /* electionsphragmen_submit_candidacy_V1 - candidate_count */;
            return _toStringCompactu32(
                &m->basic.electionsphragmen_submit_candidacy_V1.candidate_count,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 9219: /* module 36 call 3 */
        switch (itemIdx) {
        case 0: /* electionsphragmen_renounce_candidacy_V1 - renouncing */;
            return _toStringRenouncing_V1(
                &m->basic.electionsphragmen_renounce_candidacy_V1.renouncing,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 9220: /* module 36 call 4 */
        switch (itemIdx) {
        case 0: /* electionsphragmen_remove_member_V1 - who */;
            return _toStringLookupSource_V1(
                &m->basic.electionsphragmen_remove_member_V1.who,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* electionsphragmen_remove_member_V1 - has_replacement */;
            return _toStringbool(
                &m->basic.electionsphragmen_remove_member_V1.has_replacement,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 9221: /* module 36 call 5 */
        switch (itemIdx) {
        case 0: /* electionsphragmen_clean_defunct_voters_V1 - _num_voters */;
            return _toStringu32(
                &m->basic.electionsphragmen_clean_defunct_voters_V1._num_voters,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* electionsphragmen_clean_defunct_voters_V1 - _num_defunct */;
            return _toStringu32(
                &m->basic.electionsphragmen_clean_defunct_voters_V1._num_defunct,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 5120: /* module 20 call 0 */
        switch (itemIdx) {
        case 0: /* technicalmembership_add_member_V1 - who */;
            return _toStringAccountId_V1(
                &m->basic.technicalmembership_add_member_V1.who,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 5121: /* module 20 call 1 */
        switch (itemIdx) {
        case 0: /* technicalmembership_remove_member_V1 - who */;
            return _toStringAccountId_V1(
                &m->basic.technicalmembership_remove_member_V1.who,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 5122: /* module 20 call 2 */
        switch (itemIdx) {
        case 0: /* technicalmembership_swap_member_V1 - remove */;
            return _toStringAccountId_V1(
                &m->basic.technicalmembership_swap_member_V1.remove,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* technicalmembership_swap_member_V1 - add */;
            return _toStringAccountId_V1(
                &m->basic.technicalmembership_swap_member_V1.add,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 5123: /* module 20 call 3 */
        switch (itemIdx) {
        case 0: /* technicalmembership_reset_members_V1 - members */;
            return _toStringVecAccountId_V1(
                &m->basic.technicalmembership_reset_members_V1.members,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 5124: /* module 20 call 4 */
        switch (itemIdx) {
        case 0: /* technicalmembership_change_key_V1 - new_ */;
            return _toStringAccountId_V1(
                &m->basic.technicalmembership_change_key_V1.new_,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 5125: /* module 20 call 5 */
        switch (itemIdx) {
        case 0: /* technicalmembership_set_prime_V1 - who */;
            return _toStringAccountId_V1(
                &m->basic.technicalmembership_set_prime_V1.who,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 5126: /* module 20 call 6 */
        switch (itemIdx) {
        default:
            return parser_no_data;
        }
    case 8448: /* module 33 call 0 */
        switch (itemIdx) {
        case 0: /* treasury_propose_spend_V1 - value */;
            return _toStringCompactBalanceOf(
                &m->basic.treasury_propose_spend_V1.value,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* treasury_propose_spend_V1 - beneficiary */;
            return _toStringLookupSource_V1(
                &m->basic.treasury_propose_spend_V1.beneficiary,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 8449: /* module 33 call 1 */
        switch (itemIdx) {
        case 0: /* treasury_reject_proposal_V1 - proposal_id */;
            return _toStringCompactProposalIndex_V1(
                &m->basic.treasury_reject_proposal_V1.proposal_id,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 8450: /* module 33 call 2 */
        switch (itemIdx) {
        case 0: /* treasury_approve_proposal_V1 - proposal_id */;
            return _toStringCompactProposalIndex_V1(
                &m->basic.treasury_approve_proposal_V1.proposal_id,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 2049: /* module 8 call 1 */
        switch (itemIdx) {
        case 0: /* utility_as_derivative_V1 - index */;
            return _toStringu16(
                &m->basic.utility_as_derivative_V1.index,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* utility_as_derivative_V1 - call */;
            return _toStringCall(
                &m->basic.utility_as_derivative_V1.call,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 9728: /* module 38 call 0 */
        switch (itemIdx) {
        case 0: /* identity_add_registrar_V1 - account */;
            return _toStringAccountId_V1(
                &m->basic.identity_add_registrar_V1.account,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 9729: /* module 38 call 1 */
        switch (itemIdx) {
        case 0: /* identity_set_identity_V1 - info */;
            return _toStringIdentityInfo_V1(
                &m->basic.identity_set_identity_V1.info,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 9730: /* module 38 call 2 */
        switch (itemIdx) {
        case 0: /* identity_set_subs_V1 - subs */;
            return _toStringVecTupleAccountIdData_V1(
                &m->basic.identity_set_subs_V1.subs,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 9731: /* module 38 call 3 */
        switch (itemIdx) {
        default:
            return parser_no_data;
        }
    case 9732: /* module 38 call 4 */
        switch (itemIdx) {
        case 0: /* identity_request_judgement_V1 - reg_index */;
            return _toStringCompactRegistrarIndex_V1(
                &m->basic.identity_request_judgement_V1.reg_index,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* identity_request_judgement_V1 - max_fee */;
            return _toStringCompactBalanceOf(
                &m->basic.identity_request_judgement_V1.max_fee,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 9733: /* module 38 call 5 */
        switch (itemIdx) {
        case 0: /* identity_cancel_request_V1 - reg_index */;
            return _toStringRegistrarIndex_V1(
                &m->basic.identity_cancel_request_V1.reg_index,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 9734: /* module 38 call 6 */
        switch (itemIdx) {
        case 0: /* identity_set_fee_V1 - index */;
            return _toStringCompactRegistrarIndex_V1(
                &m->basic.identity_set_fee_V1.index,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* identity_set_fee_V1 - fee */;
            return _toStringCompactBalanceOf(
                &m->basic.identity_set_fee_V1.fee,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 9735: /* module 38 call 7 */
        switch (itemIdx) {
        case 0: /* identity_set_account_id_V1 - index */;
            return _toStringCompactRegistrarIndex_V1(
                &m->basic.identity_set_account_id_V1.index,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* identity_set_account_id_V1 - new_ */;
            return _toStringAccountId_V1(
                &m->basic.identity_set_account_id_V1.new_,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 9736: /* module 38 call 8 */
        switch (itemIdx) {
        case 0: /* identity_set_fields_V1 - index */;
            return _toStringCompactRegistrarIndex_V1(
                &m->basic.identity_set_fields_V1.index,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* identity_set_fields_V1 - fields */;
            return _toStringIdentityFields_V1(
                &m->basic.identity_set_fields_V1.fields,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 9737: /* module 38 call 9 */
        switch (itemIdx) {
        case 0: /* identity_provide_judgement_V1 - reg_index */;
            return _toStringCompactRegistrarIndex_V1(
                &m->basic.identity_provide_judgement_V1.reg_index,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* identity_provide_judgement_V1 - target */;
            return _toStringLookupSource_V1(
                &m->basic.identity_provide_judgement_V1.target,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 2: /* identity_provide_judgement_V1 - judgement */;
            return _toStringIdentityJudgement_V1(
                &m->basic.identity_provide_judgement_V1.judgement,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 9738: /* module 38 call 10 */
        switch (itemIdx) {
        case 0: /* identity_kill_identity_V1 - target */;
            return _toStringLookupSource_V1(
                &m->basic.identity_kill_identity_V1.target,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 9739: /* module 38 call 11 */
        switch (itemIdx) {
        case 0: /* identity_add_sub_V1 - sub */;
            return _toStringLookupSource_V1(
                &m->basic.identity_add_sub_V1.sub,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* identity_add_sub_V1 - data */;
            return _toStringData(
                &m->basic.identity_add_sub_V1.data,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 9740: /* module 38 call 12 */
        switch (itemIdx) {
        case 0: /* identity_rename_sub_V1 - sub */;
            return _toStringLookupSource_V1(
                &m->basic.identity_rename_sub_V1.sub,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* identity_rename_sub_V1 - data */;
            return _toStringData(
                &m->basic.identity_rename_sub_V1.data,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 9741: /* module 38 call 13 */
        switch (itemIdx) {
        case 0: /* identity_remove_sub_V1 - sub */;
            return _toStringLookupSource_V1(
                &m->basic.identity_remove_sub_V1.sub,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 9742: /* module 38 call 14 */
        switch (itemIdx) {
        default:
            return parser_no_data;
        }
    case 8704: /* module 34 call 0 */
        switch (itemIdx) {
        case 0: /* bounties_propose_bounty_V1 - value */;
            return _toStringCompactBalanceOf(
                &m->basic.bounties_propose_bounty_V1.value,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* bounties_propose_bounty_V1 - description */;
            return _toStringBytes(
                &m->basic.bounties_propose_bounty_V1.description,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 8705: /* module 34 call 1 */
        switch (itemIdx) {
        case 0: /* bounties_approve_bounty_V1 - bounty_id */;
            return _toStringCompactBountyIndex_V1(
                &m->basic.bounties_approve_bounty_V1.bounty_id,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 8706: /* module 34 call 2 */
        switch (itemIdx) {
        case 0: /* bounties_propose_curator_V1 - bounty_id */;
            return _toStringCompactBountyIndex_V1(
                &m->basic.bounties_propose_curator_V1.bounty_id,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* bounties_propose_curator_V1 - curator */;
            return _toStringLookupSource_V1(
                &m->basic.bounties_propose_curator_V1.curator,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 2: /* bounties_propose_curator_V1 - fee */;
            return _toStringCompactBalanceOf(
                &m->basic.bounties_propose_curator_V1.fee,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 8707: /* module 34 call 3 */
        switch (itemIdx) {
        case 0: /* bounties_unassign_curator_V1 - bounty_id */;
            return _toStringCompactBountyIndex_V1(
                &m->basic.bounties_unassign_curator_V1.bounty_id,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 8708: /* module 34 call 4 */
        switch (itemIdx) {
        case 0: /* bounties_accept_curator_V1 - bounty_id */;
            return _toStringCompactBountyIndex_V1(
                &m->basic.bounties_accept_curator_V1.bounty_id,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 8709: /* module 34 call 5 */
        switch (itemIdx) {
        case 0: /* bounties_award_bounty_V1 - bounty_id */;
            return _toStringCompactBountyIndex_V1(
                &m->basic.bounties_award_bounty_V1.bounty_id,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* bounties_award_bounty_V1 - beneficiary */;
            return _toStringLookupSource_V1(
                &m->basic.bounties_award_bounty_V1.beneficiary,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 8710: /* module 34 call 6 */
        switch (itemIdx) {
        case 0: /* bounties_claim_bounty_V1 - bounty_id */;
            return _toStringCompactBountyIndex_V1(
                &m->basic.bounties_claim_bounty_V1.bounty_id,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 8711: /* module 34 call 7 */
        switch (itemIdx) {
        case 0: /* bounties_close_bounty_V1 - bounty_id */;
            return _toStringCompactBountyIndex_V1(
                &m->basic.bounties_close_bounty_V1.bounty_id,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 8712: /* module 34 call 8 */
        switch (itemIdx) {
        case 0: /* bounties_extend_bounty_expiry_V1 - bounty_id */;
            return _toStringCompactBountyIndex_V1(
                &m->basic.bounties_extend_bounty_expiry_V1.bounty_id,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* bounties_extend_bounty_expiry_V1 - _remark */;
            return _toStringBytes(
                &m->basic.bounties_extend_bounty_expiry_V1._remark,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 9472: /* module 37 call 0 */
        switch (itemIdx) {
        case 0: /* tips_report_awesome_V1 - reason */;
            return _toStringBytes(
                &m->basic.tips_report_awesome_V1.reason,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* tips_report_awesome_V1 - who */;
            return _toStringAccountId_V1(
                &m->basic.tips_report_awesome_V1.who,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 9473: /* module 37 call 1 */
        switch (itemIdx) {
        case 0: /* tips_retract_tip_V1 - hash */;
            return _toStringHash(
                &m->basic.tips_retract_tip_V1.hash,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 9474: /* module 37 call 2 */
        switch (itemIdx) {
        case 0: /* tips_tip_new_V1 - reason */;
            return _toStringBytes(
                &m->basic.tips_tip_new_V1.reason,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* tips_tip_new_V1 - who */;
            return _toStringAccountId_V1(
                &m->basic.tips_tip_new_V1.who,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 2: /* tips_tip_new_V1 - tip_value */;
            return _toStringCompactBalanceOf(
                &m->basic.tips_tip_new_V1.tip_value,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 9475: /* module 37 call 3 */
        switch (itemIdx) {
        case 0: /* tips_tip_V1 - hash */;
            return _toStringHash(
                &m->basic.tips_tip_V1.hash,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* tips_tip_V1 - tip_value */;
            return _toStringCompactBalanceOf(
                &m->basic.tips_tip_V1.tip_value,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 9476: /* module 37 call 4 */
        switch (itemIdx) {
        case 0: /* tips_close_tip_V1 - hash */;
            return _toStringHash(
                &m->basic.tips_close_tip_V1.hash,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 9477: /* module 37 call 5 */
        switch (itemIdx) {
        case 0: /* tips_slash_tip_V1 - hash */;
            return _toStringHash(
                &m->basic.tips_slash_tip_V1.hash,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 7936: /* module 31 call 0 */
        switch (itemIdx) {
        case 0: /* electionprovidermultiphase_submit_unsigned_V1 - solution */;
            return _toStringRawSolution_V1(
                &m->basic.electionprovidermultiphase_submit_unsigned_V1.solution,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* electionprovidermultiphase_submit_unsigned_V1 - witness */;
            return _toStringSolutionOrSnapshotSize_V1(
                &m->basic.electionprovidermultiphase_submit_unsigned_V1.witness,
                outValue, outValueLen,
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
#endif
    default:
        return parser_ok;
    }

    return parser_ok;
}

bool _getMethod_ItemIsExpert_V1(uint8_t moduleIdx, uint8_t callIdx, uint8_t itemIdx)
{
    uint16_t callPrivIdx = ((uint16_t)moduleIdx << 8u) + callIdx;

    switch (callPrivIdx) {
    case 7683: // Staking:Withdraw Unbonded
        switch (itemIdx) {
        case 0: // Num slashing spans
            return true;
        default:
            return false;
        }
    case 7695: // Staking:Force unstake
        switch (itemIdx) {
        case 1: // Num slashing spans
            return true;
        default:
            return false;
        }
    case 7701: // Staking:Reap stash
        switch (itemIdx) {
        case 1: // Num slashing spans
            return true;
        default:
            return false;
        }

    default:
        return false;
    }
}

// Remove any methods that can be passed in to a dispatchable like utility.batch, utility.batchAll or in proposals or in sudo
bool _getMethod_IsNestingSupported_V1(uint8_t moduleIdx, uint8_t callIdx)
{
    uint16_t callPrivIdx = ((uint16_t)moduleIdx << 8u) + callIdx;

    switch (callPrivIdx) {
    case 9: // System:Remark with event
    case 5376: // Scheduler:Schedule
    case 5377: // Scheduler:Cancel
    case 5378: // Scheduler:Schedule named
    case 5379: // Scheduler:Cancel named
    case 5380: // Scheduler:Schedule after
    case 5381: // Scheduler:Schedule named after
    case 7424: // Babe:Report equivocation
    case 7425: // Babe:Report equivocation unsigned
    case 256: // Timestamp:Set
    case 1536: // Authorship:Set uncles
    case 7688: // Staking:Set controller
    case 7689: // Staking:Set validator count
    case 7690: // Staking:Increase validator count
    case 7691: // Staking:Scale validator count
    case 7692: // Staking:Force no eras
    case 7693: // Staking:Force new era
    case 7694: // Staking:Set invulnerables
    case 7695: // Staking:Force unstake
    case 7696: // Staking:Force new era always
    case 7697: // Staking:Cancel deferred slash
    case 7700: // Staking:Set history depth
    case 7701: // Staking:Reap stash
    case 7702: // Staking:Submit election solution
    case 7703: // Staking:Submit election solution unsigned
    case 7704: // Staking:Kick
    case 768: // Session:Set keys
    case 769: // Session:Purge keys
    case 1280: // Grandpa:Report equivocation
    case 1281: // Grandpa:Report equivocation unsigned
    case 1282: // Grandpa:Note stalled
    case 7168: // ImOnline:Heartbeat
    case 4352: // Democracy:Propose
    case 4353: // Democracy:Second
    case 4354: // Democracy:Vote
    case 4355: // Democracy:Emergency cancel
    case 4356: // Democracy:External propose
    case 4357: // Democracy:External propose majority
    case 4358: // Democracy:External propose default
    case 4359: // Democracy:Fast track
    case 4360: // Democracy:Veto external
    case 4361: // Democracy:Cancel referendum
    case 4362: // Democracy:Cancel queued
    case 4363: // Democracy:Delegate
    case 4364: // Democracy:Undelegate
    case 4365: // Democracy:Clear public proposals
    case 4366: // Democracy:Note preimage
    case 4367: // Democracy:Note preimage operational
    case 4368: // Democracy:Note imminent preimage
    case 4369: // Democracy:Note imminent preimage operational
    case 4370: // Democracy:Reap preimage
    case 4371: // Democracy:Unlock
    case 4372: // Democracy:Remove vote
    case 4373: // Democracy:Remove other vote
    case 4374: // Democracy:Enact proposal
    case 4375: // Democracy:Blacklist
    case 4376: // Democracy:Cancel proposal
    case 4608: // Council:Set members
    case 4609: // Council:Execute
    case 4610: // Council:Propose
    case 4611: // Council:Vote
    case 4612: // Council:Close
    case 4613: // Council:Disapprove proposal
    case 4864: // TechnicalCommittee:Set members
    case 4865: // TechnicalCommittee:Execute
    case 4866: // TechnicalCommittee:Propose
    case 4867: // TechnicalCommittee:Vote
    case 4868: // TechnicalCommittee:Close
    case 4869: // TechnicalCommittee:Disapprove proposal
    case 9216: // ElectionsPhragmen:Vote
    case 9217: // ElectionsPhragmen:Remove voter
    case 9218: // ElectionsPhragmen:Submit candidacy
    case 9219: // ElectionsPhragmen:Renounce candidacy
    case 9220: // ElectionsPhragmen:Remove member
    case 9221: // ElectionsPhragmen:Clean defunct voters
    case 5120: // TechnicalMembership:Add member
    case 5121: // TechnicalMembership:Remove member
    case 5122: // TechnicalMembership:Swap member
    case 5123: // TechnicalMembership:Reset members
    case 5124: // TechnicalMembership:Change key
    case 5125: // TechnicalMembership:Set prime
    case 5126: // TechnicalMembership:Clear prime
    case 8448: // Treasury:Propose spend
    case 8449: // Treasury:Reject proposal
    case 8450: // Treasury:Approve proposal
    case 2048: // Utility:Batch
    case 2049: // Utility:As derivative
    case 2050: // Utility:Batch all
    case 9728: // Identity:Add registrar
    case 9729: // Identity:Set identity
    case 9730: // Identity:Set subs
    case 9731: // Identity:Clear identity
    case 9732: // Identity:Request judgement
    case 9733: // Identity:Cancel request
    case 9734: // Identity:Set fee
    case 9735: // Identity:Set account id
    case 9736: // Identity:Set fields
    case 9737: // Identity:Provide judgement
    case 9738: // Identity:Kill identity
    case 9739: // Identity:Add sub
    case 9740: // Identity:Rename sub
    case 9741: // Identity:Remove sub
    case 9742: // Identity:Quit sub
    case 8704: // Bounties:Propose bounty
    case 8705: // Bounties:Approve bounty
    case 8706: // Bounties:Propose curator
    case 8707: // Bounties:Unassign curator
    case 8708: // Bounties:Accept curator
    case 8709: // Bounties:Award bounty
    case 8710: // Bounties:Claim bounty
    case 8711: // Bounties:Close bounty
    case 8712: // Bounties:Extend bounty expiry
    case 9472: // Tips:Report awesome
    case 9473: // Tips:Retract tip
    case 9474: // Tips:Tip new
    case 9475: // Tips:Tip
    case 9476: // Tips:Close tip
    case 9477: // Tips:Slash tip
    case 7936: // ElectionProviderMultiPhase:Submit unsigned
        return false;
    default:
        return true;
    }
}
