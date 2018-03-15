PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_SECAUDIT.sql =========*** Run ***
PROMPT ===================================================================================== 

PROMPT *** Create  sequence S_SECAUDIT ***

CREATE SEQUENCE S_SECAUDIT MINVALUE 1 INCREMENT BY 1 START WITH 1 CACHE 100 ORDER NOCYCLE;


alter sequence S_SECAUDIT ORDER;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_SECAUDIT.sql =========*** End ***
PROMPT ===================================================================================== 
