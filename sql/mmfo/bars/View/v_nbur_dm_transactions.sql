PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_DM_TRANSACTIONS.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view V_NBUR_DM_TRANSACTIONS ***

create or replace view V_NBUR_DM_TRANSACTIONS
as
   select /*+ PARALLEL( 16 ) */
          txn.REPORT_DATE, txn.KF, txn.REF, txn.TT, txn.KV, txn.BAL, txn.BAL_UAH, doc.VDAT
          , CUST_ID_DB, ACC_ID_DB, ACC_NUM_DB, ACC_TYPE_DB, R020_DB, OB22_DB, NBUC_DB
          , CUST_ID_CR, ACC_ID_CR, ACC_NUM_CR, ACC_TYPE_CR, R020_CR, OB22_CR, NBUC_CR
   from  NBUR_DM_TRANSACTIONS_ARCH txn
         join OPER doc on ( doc.KF = txn.KF AND doc.REF = txn.REF )
   where ( txn.REPORT_DATE, txn.KF, txn.VERSION_ID ) in ( 
                                                          select report_date, kf, max(version_id)
                                                          from   NBUR_LST_OBJECTS
                                                          where  OBJECT_ID in (
                                                                                 select id
                                                                                 from   nbur_ref_objects 
                                                                                 where  object_name = 'NBUR_DM_TRANSACTIONS'
								               )
                                                                 and VLD = 0
                                                          group by report_date, kf 
                                                        )
           and doc.SOS = 5;

comment on table  V_NBUR_DM_TRANSACTIONS is 'Financial transactions (opldok)';
comment on column V_NBUR_DM_TRANSACTIONS.report_date is 'Calculation date';
comment on column V_NBUR_DM_TRANSACTIONS.kf is 'Bank code';
comment on column V_NBUR_DM_TRANSACTIONS.ref is 'Document identifier';
comment on column V_NBUR_DM_TRANSACTIONS.tt is 'Transaction type code';
comment on column V_NBUR_DM_TRANSACTIONS.kv is 'Currency identifier';
comment on column V_NBUR_DM_TRANSACTIONS.bal is 'Transaction amount';
comment on column V_NBUR_DM_TRANSACTIONS.bal_uah is 'Transaction amount in UAH';
comment on column V_NBUR_DM_TRANSACTIONS.cust_id_db is 'Customer identifier Debit side transaction (sender)';
comment on column V_NBUR_DM_TRANSACTIONS.acc_id_db is 'Account identifier Debit side transaction';
comment on column V_NBUR_DM_TRANSACTIONS.acc_num_db is 'Account number Debit side transaction';
comment on column V_NBUR_DM_TRANSACTIONS.acc_type_db is 'Account type code  Debit side transaction';
comment on column V_NBUR_DM_TRANSACTIONS.r020_db is 'Account code Debit side transaction';
comment on column V_NBUR_DM_TRANSACTIONS.ob22_db is 'Account code Debit side transaction';
comment on column V_NBUR_DM_TRANSACTIONS.cust_id_cr is 'Customer identifier Credit side transaction (receiver)';
comment on column V_NBUR_DM_TRANSACTIONS.acc_id_cr is 'Account identifier Credit side transaction';
comment on column V_NBUR_DM_TRANSACTIONS.acc_num_cr is 'Account number Credit side transaction';
comment on column V_NBUR_DM_TRANSACTIONS.acc_type_cr is 'Account type code Credit side transaction';
comment on column V_NBUR_DM_TRANSACTIONS.r020_cr is 'Account code Credit side transaction';
comment on column V_NBUR_DM_TRANSACTIONS.ob22_cr is 'Account code Credit side transaction';