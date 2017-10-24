create or replace view v_sw_journal
as
SELECT SW_JOURNAL.SWREF,   SW_JOURNAL.MT,      SW_JOURNAL.TRN ,
        SW_JOURNAL.IO_IND,  SW_JOURNAL.CURRENCY,SW_JOURNAL.SENDER,SW_JOURNAL.RECEIVER,
        SW_JOURNAL.PAYER,   SW_JOURNAL.PAYEE,   SW_JOURNAL.AMOUNT/100 AMOUNT,SW_JOURNAL.ACCD,SW_JOURNAL.ACCK,
        to_char(SW_JOURNAL.DATE_IN, 'dd.mm.yyyy HH24:MI:SS') DATE_IN, to_char(SW_JOURNAL.DATE_OUT, 'dd.mm.yyyy HH24:MI:SS') DATE_OUT,d.nls NLS_D,      k.nls NLS_K,  
        SW_JOURNAL.DATE_PAY,SW_JOURNAL.DATE_REC,SW_JOURNAL.VDATE, SW_JOURNAL.ID, 
        SW_JOURNAL.PAGE,    SW_JOURNAL.TRANSIT, SW_JOURNAL.SOS , (SELECT ref FROM sw_oper WHERE swref=SW_JOURNAL.SWREF) sw_oper_ref,
        (SELECT swref FROM sw_950 WHERE swref=SW_JOURNAL.SWREF and done=1) sw_950_ref
   FROM SW_JOURNAL, accounts d, accounts k
  WHERE SW_JOURNAL.accd=d.acc (+) and SW_JOURNAL.acck=k.acc (+) AND SW_JOURNAL.VDATE>=trunc(sysdate)-30
  ORDER BY SW_JOURNAL.swref desc;
  
grant select, insert, update, delete on v_sw_journal to bars_access_defrole
/  
