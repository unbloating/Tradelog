-- Remove redundant permissive policies and require the validated RPC to create chats.
DROP POLICY IF EXISTS "users delete own trades" ON public.trades;
DROP POLICY IF EXISTS "users write own trades" ON public.trades;
DROP POLICY IF EXISTS "users read own trades" ON public.trades;
DROP POLICY IF EXISTS "users update own trades" ON public.trades;
DROP POLICY IF EXISTS "users manage own social connections" ON public.social_connections;
DROP POLICY IF EXISTS "users read likes" ON public.template_likes;
DROP POLICY IF EXISTS "create conversations" ON public.conversations;
