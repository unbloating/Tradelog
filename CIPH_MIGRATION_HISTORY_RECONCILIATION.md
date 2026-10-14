# CIPH Migration-History Reconciliation — Focused Checklist

**Status:** Blocked pending migration provenance recovery. Do not run `supabase db push`, apply migrations, reset production, or change production schema while this checklist is open.

## Verified inventory (2026-10-11)

- [x] Read-only Supabase migration inventory completed for project `tbjduoaywvmggcjejsth`.
- [x] Production reports 11 applied migration versions:
  - `20260927165415` tradelog_initial_schema
  - `20260927165446` lock_down_profile_trigger_function
  - `20260927165454` restrict_profile_trigger_function_execute
  - `20260928003438` secure_tradelog_rls
  - `20260928231905` add_friends_messaging_template_shares
  - `20260928231919` friends_messaging_rls
  - `20261002024149` fix_chat_function_permissions
  - `20261006152657` prevent_direct_chat_membership_join
  - `20261006152710` harden_direct_conversation_rpc
  - `20261006152810` remove_duplicate_permissive_policies
  - `20261006153319` remove_redundant_policies_and_lock_conversation_creation
- [x] Release branch contains only two SQL migration files: `001_tradelog.sql` and `20261006153300_remove_redundant_policies_and_lock_conversation_creation.sql`.
- [x] Confirmed cleanup migration filename/version differs from production history: local `20261006153300`, production `20261006153319`.
- [x] Confirmed initial SQL username check allows 3–24 characters, while live `public.profiles.username` check allows 1–24 characters.
- [x] Read-only schema inventory reports 13 public tables with RLS enabled. No database migrations or data changes were made during this review.

## Required before any migration deployment

- [ ] Recover the exact original SQL for the nine missing migration versions from trusted repository history, backups, or the original author. Do not reconstruct historical migrations from names alone.
- [ ] Recover/confirm the exact SQL and checksum/provenance for the initial and cleanup migrations; resolve filename/version drift without pretending already-applied migrations are new.
- [ ] Export and review a schema-only snapshot of production, including policies, triggers, functions, grants, constraints, and storage policies. Do not export user data into the repository.
- [ ] Compare the recovered migration sequence to the live schema and identify every drift item, including username constraint, profile social URL columns, template tables, and chat functions/policies.
- [ ] Prepare a non-destructive reconciliation plan that does not drop tables, rewrite user rows, reset production, or relax RLS.
- [ ] Test the plan against a disposable Supabase development branch or isolated database with representative schema; confirm migrations are idempotent where appropriate and preserve data.
- [ ] Have a project maintainer review the SQL and rollback/forward-recovery plan.
- [ ] Only after all prior items pass, decide whether to restore exact historical migration files or adopt a documented baseline strategy; do not mark history reconciled until Supabase migration status and repository history agree.

## Known blockers

- The connected tools expose live migration versions and schema metadata, but do not provide the missing historical SQL source.
- Production has real user records; no destructive test, reset, or speculative migration is safe.
- Username constraint difference is documented only; no constraint change was made because it could affect existing usernames or product requirements.

**Exit criteria:** exact migration provenance recovered, schema drift documented, a non-destructive plan reviewed and tested off-production, and migration status reconciled without changing existing user data.
