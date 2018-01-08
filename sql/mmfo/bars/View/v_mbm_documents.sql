

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_MBM_DOCUMENTS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_MBM_DOCUMENTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_MBM_DOCUMENTS ("ID", "TRANSACTION_TYPE", "DOC_NUMBER", "IS_DEBIT", "CURRENCY_ID", "CURRENCY_CODE", "DOCUMENT_DATE", "CREATED_DATE", "PAYED_DATE", "AMOUNT", "AMOUNT_STRING", "AMOUNT_EQUIVALENT", "PURPOSE", "STATE", "SENDER_NAME", "SENDER_ACC_NUMBER", "SENDER_BANK_ID", "SENDER_BANK_NAME", "SENDER_CODE", "SENDER_CURRENCY_ID", "SENDER_CURRENCY_CODE", "RECIPIENT_NAME", "RECIPIENT_ACC_NUMBER", "RECIPIENT_BANK_ID", "RECIPIENT_BANK_NAME", "RECIPIENT_CODE", "RECIPIENT_CURRENCY_ID", "RECIPIENT_CURRENCY_CODE", "DEAL_TAG", "VOB", "SK", "PDAT", "D_REC", "ID_O", "SIGN", "VP", "CHK", "S2", "KVQ", "REFL", "PRTY", "SQ2", "CURRVISAGRP", "NEXTVISAGRP", "REF_A", "TOBO", "OTM", "SIGNED", "BRANCH", "USERID", "RESPID", "KF", "BIS", "S_", "S2_") AS 
  SELECT op.REF AS ID,
          op.TT AS Transaction_Type,
          op.ND AS Doc_Number,
          op.DK AS IS_DEBIT,
          op.KV AS CURRENCY_ID,
          op.LCV AS CURRENCY_CODE,
          op.DATD AS DOCUMENT_DATE,                --Дата документу(фінансова)
          OP.PDAT AS CREATED_DATE,            --Дата та час введення документу
          (SELECT NVL (MAX (DAT), op.pdat)
             FROM OPER_VISA
            WHERE (OP.REF = REF))
             AS PAYED_DATE,             -- Дата фактичної оплати(остання віза)
          op.S AS AMOUNT,
          (SELECT F_SUMPR (op.S,
                           op.KV,
                           gender,
                           dig)
             FROM tabval
            WHERE kv = op.kv)
             AS AMOUNT_STRING,
          op.SQ AS AMOUNT_EQUIVALENT,
          op.NAZN AS PURPOSE,
          op.SOS AS State,
          CASE op.dk WHEN 1 THEN op.NAM_A ELSE op.NAM_B END AS Sender_Name,
          CASE op.dk WHEN 1 THEN op.NLSA ELSE op.NLSB END
             AS Sender_Acc_Number,
          CASE op.dk WHEN 1 THEN op.MFOA ELSE op.MFOB END AS Sender_Bank_Id,
          CASE op.dk WHEN 1 THEN ba.NB ELSE bb.nb END AS Sender_Bank_NAME,
          CASE op.dk WHEN 1 THEN op.ID_A ELSE op.id_b END AS Sender_Code,
          CASE op.dk WHEN 1 THEN op.KV ELSE op.kv2 END AS SENDER_CURRENCY_ID,
          CASE op.dk WHEN 1 THEN op.lcv ELSE op.lcv2 END
             AS SENDER_CURRENCY_CODE,
          CASE op.dk WHEN 0 THEN op.NAM_A ELSE op.NAM_B END AS Recipient_Name,
          CASE op.dk WHEN 0 THEN op.NLSA ELSE op.NLSB END
             AS Recipient_Acc_Number,
          CASE op.dk WHEN 0 THEN op.MFOA ELSE op.MFOB END
             AS Recipient_Bank_Id,
          CASE op.dk WHEN 0 THEN ba.NB ELSE bb.nb END AS Recipient_Bank_NAME,
          CASE op.dk WHEN 0 THEN op.ID_A ELSE op.id_b END AS Recipient_Code,
          CASE op.dk WHEN 0 THEN op.KV ELSE op.kv2 END
             AS RECIPIENT_CURRENCY_ID,
          CASE op.dk WHEN 0 THEN op.lcv ELSE op.lcv2 END
             AS RECIPIENT_CURRENCY_CODE,
          op.DEAL_TAG,
          op.VOB,
          op.SK,
          op.PDAT,
          op.D_REC,
          op.ID_O,
          op.SIGN,
          op.VP,
          op.CHK,
          op.S2,
          op.KVQ,
          op.REFL,
          op.PRTY,
          op.SQ2,
          op.CURRVISAGRP,
          op.NEXTVISAGRP,
          op.REF_A,
          op.TOBO,
          op.OTM,
          op.SIGNED,
          op.BRANCH,
          op.USERID,
          op.RESPID,
          op.KF,
          op.BIS,
          op.s_,
          op.s2_
     FROM V_DOCS_TOBO_OUT op, banks ba, banks bb
    WHERE ba.MFO = op.MFOA AND bb.MFO = op.MFOB;

PROMPT *** Create  grants  V_MBM_DOCUMENTS ***
grant SELECT                                                                 on V_MBM_DOCUMENTS to BARSREADER_ROLE;
grant SELECT                                                                 on V_MBM_DOCUMENTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_MBM_DOCUMENTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_MBM_DOCUMENTS.sql =========*** End **
PROMPT ===================================================================================== 
