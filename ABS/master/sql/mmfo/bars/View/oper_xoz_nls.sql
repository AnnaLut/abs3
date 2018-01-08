CREATE OR REPLACE FORCE VIEW BARS.OPER_XOZ_NLS AS
   SELECT * FROM bars.accounts  WHERE  tip IN ('XOZ', 'W4X')  AND dazs IS NULL    AND kv = 980  AND branch LIKE SYS_CONTEXT ('bars_context', 'user_branch') || '%';

/