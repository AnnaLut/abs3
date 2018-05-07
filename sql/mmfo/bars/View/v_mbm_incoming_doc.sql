

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_MBM_INCOMING_DOC.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_MBM_INCOMING_DOC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_MBM_INCOMING_DOC ("ID", "TRANSACTION_TYPE", "DOC_NUMBER", "IS_DEBIT", "CURRENCY_ID", "CURRENCY_CODE", "DOCUMENT_DATE", "CREATED_DATE", "PAYED_DATE", "AMOUNT", "AMOUNT_STRING", "AMOUNT_EQUIVALENT", "PURPOSE", "STATE", "SENDER_NAME", "SENDER_ACC_NUMBER", "SENDER_BANK_ID", "SENDER_BANK_NAME", "SENDER_CODE", "SENDER_CURRENCY_ID", "SENDER_CURRENCY_CODE", "RECIPIENT_NAME", "RECIPIENT_ACC_NUMBER", "RECIPIENT_BANK_ID", "RECIPIENT_BANK_NAME", "RECIPIENT_CODE", "RECIPIENT_CURRENCY_ID", "RECIPIENT_CURRENCY_CODE", "DEAL_TAG", "VOB", "SK", "PDAT", "D_REC", "ID_O", "SIGN", "VP", "CHK", "S2", "KVQ", "REFL", "PRTY", "SQ2", "CURRVISAGRP", "NEXTVISAGRP", "REF_A", "TOBO", "OTM", "SIGNED", "BRANCH", "USERID", "RESPID", "KF", "BIS", "S_", "S2_", "RECIPIENTCUSTOMERID") AS 
  select  /*+ index (accb XIE_ACCOUNTS_RNK) leading(accb ob)*/
	d."ID",d."TRANSACTION_TYPE",d."DOC_NUMBER",d."IS_DEBIT",d."CURRENCY_ID",d."CURRENCY_CODE",d."DOCUMENT_DATE",d."CREATED_DATE",d."PAYED_DATE",d."AMOUNT",d."AMOUNT_STRING",d."AMOUNT_EQUIVALENT",d."PURPOSE",d."STATE",d."SENDER_NAME",d."SENDER_ACC_NUMBER",d."SENDER_BANK_ID",d."SENDER_BANK_NAME",d."SENDER_CODE",d."SENDER_CURRENCY_ID",d."SENDER_CURRENCY_CODE",d."RECIPIENT_NAME",d."RECIPIENT_ACC_NUMBER",d."RECIPIENT_BANK_ID",d."RECIPIENT_BANK_NAME",d."RECIPIENT_CODE",d."RECIPIENT_CURRENCY_ID",d."RECIPIENT_CURRENCY_CODE",d."DEAL_TAG",d."VOB",d."SK",d."PDAT",d."D_REC",d."ID_O",d."SIGN",d."VP",d."CHK",d."S2",d."KVQ",d."REFL",d."PRTY",d."SQ2",d."CURRVISAGRP",d."NEXTVISAGRP",d."REF_A",d."TOBO",d."OTM",d."SIGNED",d."BRANCH",d."USERID",d."RESPID",d."KF",d."BIS",d."S_",d."S2_",
    accb.rnk as recipientcustomerid
from   accounts accb
join   opldok ob on ob.acc = accb.acc
/*join   opldok oa on oa.ref = ob.ref and oa.stmt = ob.stmt and oa.dk <> ob.dk 
join   accounts acca on acca.acc = oa.acc */
join   v_mbm_documents d on d.id = ob.ref
where  accb.nbs in (select nbs from mbm_nbs_acc_types) and ob.dk = 1 and
       d.state = 5;

PROMPT *** Create  grants  V_MBM_INCOMING_DOC ***
grant SELECT                                                                 on V_MBM_INCOMING_DOC to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_MBM_INCOMING_DOC.sql =========*** End
PROMPT ===================================================================================== 
