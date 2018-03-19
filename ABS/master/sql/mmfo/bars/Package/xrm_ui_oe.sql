
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/xrm_ui_oe.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
CREATE OR REPLACE PACKAGE XRM_UI_OE
IS
   title              CONSTANT VARCHAR2 (19) := 'xrm_ui_oe:';

   TYPE t_cursor IS REF CURSOR;

   g_header_version   CONSTANT VARCHAR2 (64) := 'version 1.07 18.05.2017';

   FUNCTION header_version
      RETURN VARCHAR2;

   FUNCTION body_version
      RETURN VARCHAR2;

   procedure xrm_audit(p_TransactionId XRMSW_AUDIT.TransactionId%type,
                       p_TranType      XRMSW_AUDIT.TranType%type,
                       p_Description   XRMSW_AUDIT.Description%type,
                       p_user_login    XRMSW_AUDIT.user_login%type);

  procedure CheckTrasaction(p_TransactionId IN XRMSW_AUDIT.TransactionId%type, p_TransactionResult OUT number, p_resp out blob);
  procedure save_req(p_TransactionId IN XRMSW_AUDIT.TransactionId%type, p_req in blob, p_resp in blob);
   procedure xrm_customer_trans(p_TransactionId XRMSW_AUDIT.TransactionId%type,
                                p_rnk           customer.rnk%type,
                                p_STATUSCODE    number,
                                p_ERRORMESSAGE  varchar2);
   procedure xrm_card_trans(p_TransactionId XRMSW_AUDIT.TransactionId%type,
                            p_ND            XRMSW_card_trans.ND%type,
                            p_ACC           XRMSW_card_trans.ACC%type,
                            p_NLS           XRMSW_card_trans.NLS%type,
                            p_DAOS          XRMSW_card_trans.DAOS%type,
                            p_DATE_BEGIN    XRMSW_card_trans.DATE_BEGIN%type,
                            p_STATUS        XRMSW_card_trans.STATUS%type,
                            p_BLKD          XRMSW_card_trans.BLKD%type,
                            p_BLKK          XRMSW_card_trans.BLKK%type,
                            p_DKBO_NUM      XRMSW_card_trans.DKBO_NUM%type,
                            p_DKBO_IN       XRMSW_card_trans.DKBO_IN%type,
                            p_DKBO_OUT      XRMSW_card_trans.DKBO_OUT%type,
                            p_STATUSCODE    XRMSW_card_trans.STATUSCODE%type,
                            p_ERRORMESSAGE  XRMSW_card_trans.ERRORMESSAGE%type);

   procedure xrm_deposit_trans(p_TransactionId XRMSW_AUDIT.TransactionId%type,
                               p_DPTID           XRMSW_DEPOSIT_TRANS.DPTID%type,
                               p_NLS             XRMSW_DEPOSIT_TRANS.NLS%type,
                               p_RATE            XRMSW_DEPOSIT_TRANS.RATE%type,
                               p_NLSINT          XRMSW_DEPOSIT_TRANS.NLSINT%type,
                               p_DAOS            XRMSW_DEPOSIT_TRANS.DAOS%type,
                               p_DAT_BEGIN       XRMSW_DEPOSIT_TRANS.DAT_BEGIN%type,
                               p_DAT_END         XRMSW_DEPOSIT_TRANS.DAT_END%type,
                               p_BLKD            XRMSW_DEPOSIT_TRANS.BLKD%type,
                               p_BLKK            XRMSW_DEPOSIT_TRANS.BLKK%type,
                               p_DKBO_NUM        XRMSW_DEPOSIT_TRANS.DKBO_NUM%type,
                               p_DKBO_IN         XRMSW_DEPOSIT_TRANS.DKBO_IN%type,
                               p_DKBO_OUT        XRMSW_DEPOSIT_TRANS.DKBO_OUT%type,
                               p_STATUSCODE      XRMSW_DEPOSIT_TRANS.STATUSCODE%type,
                               p_ERRORMESSAGE    XRMSW_DEPOSIT_TRANS.ERRORMESSAGE%type);

  procedure xrm_docsign_trans(p_TransactionId   XRMSW_AUDIT.TransactionId%type,
                            p_archdoc_id        XRMSW_DEPOSITSIGN_TRANS.Archdoc_id%type,
                            p_ERRORMESSAGE      XRMSW_DEPOSITSIGN_TRANS.ErrorMessage%type);

  procedure xrm_depositagreemnt_trans(p_TransactionId XRMSW_AUDIT.TransactionId%type,
                                 P_DPTID        number,
                                 P_AGRMNTTYPE   number,
                                 P_INITCUSTID   number,
                                 P_TRUSTCUSTID  number,
                                 P_DENOMCOUNT   varchar2,
                                 P_AGRMNTID     number,
                                 p_STATUSCODE   number,
                                 p_ERRORMESSAGE varchar2);

  procedure xrm_InstantcardOrder_trans(p_TransactionId XRMSW_AUDIT.TransactionId%type,
                                 P_CARDCODE 	varchar2,
                                 P_BRANCH		varchar2,
                                 P_CARDCOUNT	number,
                                 p_STATUSCODE   number,
                                 p_ERRORMESSAGE varchar2);
  procedure xrm_SetGetCardParams_trans(p_TransactionId  XRMSW_AUDIT.TransactionId%type,
	                                   P_ND				varchar2,
                                       P_XMLTAGS		CLOB,
                                       p_STATUSCODE		number,
                                       p_ERRORMESSAGE	varchar2);
  procedure xrm_regular_trans(p_TransactionId XRMSW_AUDIT.TransactionId%type,
                              Rnk             number,
                              StartDate       date,
                              FinishDate      date,
                              Frequency       number,
                              KV              number,
                              NLSA            varchar2,
                              OKPOB           varchar2,
                              NAMEB           varchar2,
                              MFOB            varchar2,
                              NLSB            varchar2,
                              Holyday         number,
                              fSum            number,
                              Purpose         varchar2,
                              DPT_ID          number,
                              AGR_ID          number,
                              StatusCode      number,
                              ErrorMessage    varchar2);

        PROCEDURE xrm_Sbon_trans (
           p_TransactionId     IN XRMSW_AUDIT.TransactionId%TYPE,
           SBONTYPE            IN varchar2, -- Contr, NoContr
           payer_account_id    IN INTEGER,
           start_date          IN DATE,
           stop_date           IN DATE,
           payment_frequency   IN INTEGER,
           holiday_shift       IN INTEGER,
           provider_id         IN INTEGER,
           personal_account    IN VARCHAR2,
           regular_amount      IN NUMBER,
           ceiling_amount      IN NUMBER,
           extra_attributes    IN CLOB,
           sendsms             IN VARCHAR2,
           orderid             IN NUMBER,
           StatusCode          IN NUMBER,
           ErrorMessage        IN VARCHAR2);

        PROCEDURE xrm_FreeSbon_trans (
           p_TransactionId     IN XRMSW_AUDIT.TransactionId%TYPE,
           payer_account_id    IN INTEGER,
           start_date          IN DATE,
           stop_date           IN DATE,
           payment_frequency   IN INTEGER,
           holiday_shift       IN INTEGER,
           provider_id         IN INTEGER,
           regular_amount      IN NUMBER,
           receiver_mfo        IN VARCHAR2,
           receiver_account    IN VARCHAR2,
           receiver_name       IN VARCHAR2,
           receiver_edrpou     IN VARCHAR2,
           purpose             IN VARCHAR2,
           extra_attributes    IN CLOB,
           sendsms             IN VARCHAR2,
           orderid             IN NUMBER,
           StatusCode          IN NUMBER,
           ErrorMessage        IN VARCHAR2);

  PROCEDURE xrm_dkbo_trans (  TransactionId     IN VARCHAR2,
                              ext_id            IN VARCHAR2,
                              Rnk               IN NUMBER,
                              DealNumber        IN deal.deal_number%TYPE,
                              acc_list          IN VARCHAR2,
                              dkbo_date_from    IN DATE,
                              dkbo_date_to      IN DATE,
                              dkbo_date_state   IN NUMBER,
                              deal_id           IN Number,
                              start_date        IN date,
                              StatusCode        IN NUMBER,
                              ErrorMessage      IN VARCHAR2);

END;
/
CREATE OR REPLACE PACKAGE BODY XRM_UI_OE
IS
  g_body_version   CONSTANT VARCHAR2 (64) := 'version 1.08 18.05.2017';

   FUNCTION body_version
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN 'Package body xrm_ui_oe ' || g_body_version;
   END body_version;


   FUNCTION header_version
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN 'Package body xrm_ui_oe ' || g_body_version;
   END header_version;

  procedure xrm_audit( p_TransactionId XRMSW_AUDIT.TransactionId%type,
                       p_TranType      XRMSW_AUDIT.TranType%type,
                       p_Description   XRMSW_AUDIT.Description%type,
                       p_user_login    XRMSW_AUDIT.user_login%type)
  is
  pragma autonomous_transaction;
  l_errmessage varchar2(500);
  begin
   bars_audit.info(title || 'xrm_audit starts with params: p_TransactionId = ' || to_char(p_TransactionId));
   begin
       insert into XRMSW_AUDIT (TransactionId, TranType, Description, user_login)
       values (p_TransactionId, p_TranType, p_Description, p_user_login);
   exception when dup_val_on_index
   then
    l_errmessage := title || 'p_TransactionId = ' || to_char(p_TransactionId) || 'Вже було прийнято в АБС. Повторний прийом заборонено.';
    bars_audit.info(l_errmessage);
   end;
   commit;
  end;

  procedure CheckTrasaction(p_TransactionId IN XRMSW_AUDIT.TransactionId%type, p_TransactionResult OUT number, p_resp out blob)
  is
  l_exists int :=0;
  begin
   bars_audit.info(title || 'CheckTrasaction starts with TransactionId=' || to_char(p_TransactionId));
   p_TransactionResult := -1;
   begin
     select 1
       into l_exists
       from XRMSW_AUDIT
      where TransactionId = p_TransactionId;
   exception when no_data_found then l_exists := 0;
   end;

   if (l_exists != 0)
   then p_TransactionResult := -1;
     begin
       select t.resp
         into p_resp
         from XRMSW_QUERY_LOG t
        where t.transactionid = p_TransactionId;
     exception
       when no_Data_found then
         p_resp := null;
     end;
   else p_TransactionResult := 0;
   end if;

   bars_audit.info(title || 'CheckTrasaction finished with TransactionResult=' || to_char(p_TransactionResult));
  end;

  procedure save_req(p_TransactionId IN XRMSW_AUDIT.TransactionId%type, p_req in blob, p_resp in blob)
    
  is
  begin
   bars_audit.info(title || 'save_req starts with TransactionId=' || to_char(p_TransactionId));    
    insert into XRMSW_QUERY_LOG(TRANSACTIONID, REQ, RESP)
    values(p_TransactionId, p_req, p_resp);
   bars_audit.info(title || 'save_req finished with TransactionId=' || to_char(p_TransactionId));    
  exception
    when dup_val_on_index then
       bars_audit.info(title || 'save_req already exists with TransactionId=' || to_char(p_TransactionId));
  end;


  procedure xrm_customer_trans(p_TransactionId XRMSW_AUDIT.TransactionId%type,
                               p_rnk           customer.rnk%type,
                               p_STATUSCODE    number,
                               p_ERRORMESSAGE  varchar2)
  is
  pragma autonomous_transaction;
  begin
   bars_audit.info(title|| 'xrm_customer_trans starts');
   begin
    insert into XRMSW_CUSTOMER_TRANS(TRANSACTIONID, RNK, STATUSCODE, ERRORMESSAGE)
    values (p_TransactionId, p_rnk, p_STATUSCODE, p_ERRORMESSAGE);
   exception when dup_val_on_index then bars_audit.error(title||'xrm_deposit_trans:p_TransactionId='||to_char(p_TransactionId)|| ' already exists!');
   end;
   commit;
  end;

  procedure xrm_card_trans(p_TransactionId XRMSW_AUDIT.TransactionId%type,
                           p_ND            XRMSW_card_trans.ND%type,
                           p_ACC           XRMSW_card_trans.ACC%type,
                           p_NLS           XRMSW_card_trans.NLS%type,
                           p_DAOS          XRMSW_card_trans.DAOS%type,
                           p_DATE_BEGIN    XRMSW_card_trans.DATE_BEGIN%type,
                           p_STATUS        XRMSW_card_trans.STATUS%type,
                           p_BLKD          XRMSW_card_trans.BLKD%type,
                           p_BLKK          XRMSW_card_trans.BLKK%type,
                           p_DKBO_NUM      XRMSW_card_trans.DKBO_NUM%type,
                           p_DKBO_IN       XRMSW_card_trans.DKBO_IN%type,
                           p_DKBO_OUT      XRMSW_card_trans.DKBO_OUT%type,
                           p_STATUSCODE    XRMSW_card_trans.STATUSCODE%type,
                           p_ERRORMESSAGE  XRMSW_card_trans.ERRORMESSAGE%type)
  is
  pragma autonomous_transaction;
  begin
   bars_audit.info(title|| 'xrm_card_trans starts '||p_DAOS);
   begin
    insert into XRMSW_card_trans (TRANSACTIONID, ND, ACC, NLS, DAOS, DATE_BEGIN, STATUS, BLKD, BLKK, DKBO_NUM, DKBO_IN, DKBO_OUT, STATUSCODE, ERRORMESSAGE)
    values (p_TRANSACTIONID, p_ND, p_ACC, p_NLS, p_DAOS, p_DATE_BEGIN, p_STATUS, p_BLKD, p_BLKK, p_DKBO_NUM, p_DKBO_IN, p_DKBO_OUT, p_STATUSCODE, p_ERRORMESSAGE);
   exception when dup_val_on_index then bars_audit.error(title||'xrm_deposit_trans:p_TransactionId='||to_char(p_TransactionId)|| ' already exists!');
   end;
   commit;
  end;

  procedure xrm_deposit_trans(p_TransactionId   XRMSW_AUDIT.TransactionId%type,
                              p_DPTID           XRMSW_DEPOSIT_TRANS.DPTID%type,
                              p_NLS             XRMSW_DEPOSIT_TRANS.NLS%type,
                              p_RATE            XRMSW_DEPOSIT_TRANS.RATE%type,
                              p_NLSINT          XRMSW_DEPOSIT_TRANS.NLSINT%type,
                              p_DAOS            XRMSW_DEPOSIT_TRANS.DAOS%type,
                              p_DAT_BEGIN       XRMSW_DEPOSIT_TRANS.DAT_BEGIN%type,
                              p_DAT_END         XRMSW_DEPOSIT_TRANS.DAT_END%type,
                              p_BLKD            XRMSW_DEPOSIT_TRANS.BLKD%type,
                              p_BLKK            XRMSW_DEPOSIT_TRANS.BLKK%type,
                              p_DKBO_NUM        XRMSW_DEPOSIT_TRANS.DKBO_NUM%type,
                              p_DKBO_IN         XRMSW_DEPOSIT_TRANS.DKBO_IN%type,
                              p_DKBO_OUT        XRMSW_DEPOSIT_TRANS.DKBO_OUT%type,
                              p_STATUSCODE      XRMSW_DEPOSIT_TRANS.STATUSCODE%type,
                              p_ERRORMESSAGE    XRMSW_DEPOSIT_TRANS.ERRORMESSAGE%type)
  is
  pragma autonomous_transaction;
  begin
   bars_audit.info(title|| 'xrm_deposit_trans starts');
   begin
     insert into XRMSW_DEPOSIT_TRANS(TRANSACTIONID, DPTID, NLS, RATE, NLSINT, DAOS, DAT_BEGIN, DAT_END, BLKD, BLKK, DKBO_NUM, DKBO_IN, DKBO_OUT, STATUSCODE, ERRORMESSAGE)
     values (p_TransactionId,p_DPTID,p_NLS,p_RATE,p_NLSINT,p_DAOS,p_DAT_BEGIN,p_DAT_END,p_BLKD,p_BLKK,p_DKBO_NUM,p_DKBO_IN,p_DKBO_OUT,p_STATUSCODE,p_ERRORMESSAGE);
   exception when dup_val_on_index then bars_audit.error(title||'xrm_deposit_trans:p_TransactionId='||to_char(p_TransactionId)|| ' already exists!');
   end;
   commit;
  end;

  procedure xrm_docsign_trans(p_TransactionId     XRMSW_AUDIT.TransactionId%type,
                              p_archdoc_id        XRMSW_DEPOSITSIGN_TRANS.Archdoc_id%type,
                              p_ERRORMESSAGE      XRMSW_DEPOSITSIGN_TRANS.ErrorMessage%type)
  is
  pragma autonomous_transaction;
  begin
   bars_audit.info(title|| 'xrm_docsign_trans starts');
   begin
     insert into XRMSW_DEPOSITSIGN_TRANS(TRANSACTIONID, ARCHDOC_ID, ERRORMESSAGE)
     values (p_TransactionId, p_archdoc_id, p_ERRORMESSAGE);
   exception when dup_val_on_index then bars_audit.error(title||'xrm_docsign_trans:p_TransactionId='||to_char(p_TransactionId)|| ' already exists!');
   end;
   commit;
   bars_audit.info(title|| 'xrm_docsign_trans finished');
  end;

    procedure xrm_depositagreemnt_trans(p_TransactionId XRMSW_AUDIT.TransactionId%type,
                                 P_DPTID        number,
                                 P_AGRMNTTYPE   number,
                                 P_INITCUSTID   number,
                                 P_TRUSTCUSTID  number,
                                 P_DENOMCOUNT   varchar2,
                                 P_AGRMNTID     number,
                                 p_STATUSCODE   number,
                                 p_ERRORMESSAGE varchar2)
  is
  pragma autonomous_transaction;
  begin
   bars_audit.info(title|| 'xrm_depositagreemnt_trans starts');
   begin
     insert into XRMSW_DEPOSITAGREEMENT_TRANS(TRANSACTIONID, DPTID, ERRORMESSAGE)
     values (p_TransactionId, P_DPTID, p_ERRORMESSAGE);
   exception when dup_val_on_index then bars_audit.error(title||'xrm_depositagreemnt_trans:p_TransactionId='||to_char(p_TransactionId)|| ' already exists!');
   end;
   commit;
   bars_audit.info(title|| 'xrm_depositagreemnt_trans finished');
  end;
  procedure xrm_InstantcardOrder_trans(p_TransactionId XRMSW_AUDIT.TransactionId%type,
                                 P_CARDCODE 	varchar2,
                                 P_BRANCH		varchar2,
                                 P_CARDCOUNT	number,
                                 p_STATUSCODE   number,
                                 p_ERRORMESSAGE varchar2)
  is
   pragma autonomous_transaction;
  begin
   bars_audit.info(title|| 'xrm_InstantcardOrder_trans starts: p_TransactionId =' || p_TransactionId
                                 || ',P_CARDCODE =' ||P_CARDCODE
                                 || ',P_BRANCH	 =' ||	P_BRANCH
                                 || ',P_CARDCOUNT =' ||	  to_char(P_CARDCOUNT)
                                 || ',p_STATUSCODE =' ||  to_char(p_STATUSCODE)
                                 || ',p_ERRORMESSAGE' || p_ERRORMESSAGE);
   begin
     insert into XRMSW_INSTANTCARDORDER_TRANS(TRANSACTIONID, CARDCODE, BRANCH, CARDCOUNT, STATUSCODE, ERRORMESSAGE)
     values (p_TransactionId, P_CARDCODE, P_BRANCH, p_CARDCOUNT, p_STATUSCODE, p_ERRORMESSAGE);
    null;
   exception when dup_val_on_index then bars_audit.error(title||'xrm_InstantcardOrder_trans:p_TransactionId='||to_char(p_TransactionId)|| ' already exists!');
   end;
   commit;
   bars_audit.info(title|| 'xrm_InstantcardOrder_trans finished');
  end;

  procedure xrm_SetGetCardParams_trans(p_TransactionId  XRMSW_AUDIT.TransactionId%type,
	                                   P_ND				varchar2,
                                       P_XMLTAGS		CLOB,
                                       p_STATUSCODE		number,
                                       p_ERRORMESSAGE	varchar2)
  is
   pragma autonomous_transaction;
  begin
   begin
     insert into XRMSW_GETSETCARDPARAM_TRANS(TRANSACTIONID, ND, XMLTAGS, STATUSCODE, ERRORMESSAGE)
     values (p_TransactionId, P_ND, P_XMLTAGS, p_STATUSCODE, p_ERRORMESSAGE);
    null;
   exception when dup_val_on_index then bars_audit.error(title||'xrm_SetGetCardParams_trans:p_TransactionId='||to_char(p_TransactionId)|| ' already exists!');
   end;
   commit;
   bars_audit.info(title|| 'xrm_SetGetCardParams_trans finished');
  end;

  procedure xrm_regular_trans(p_TransactionId XRMSW_AUDIT.TransactionId%type,
                              Rnk             number,
                              StartDate       date,
                              FinishDate      date,
                              Frequency       number,
                              KV              number,
                              NLSA            varchar2,
                              OKPOB           varchar2,
                              NAMEB           varchar2,
                              MFOB            varchar2,
                              NLSB            varchar2,
                              Holyday         number,
                              fSum            number,
                              Purpose         varchar2,
                              DPT_ID          number,
                              AGR_ID          number,
                              StatusCode      number,
                              ErrorMessage    varchar2)
  is
   pragma autonomous_transaction;
  begin
   begin
     insert into XRMSW_REGULAR_TRANS(TRANSACTIONID, RNK, STARTDATE, FINISHDATE, FREQUENCY, KV, NLSA, OKPOB, NAMEB, MFOB, NLSB, HOLYDAY, SUM, PURPOSE, DPT_ID, AGR_ID, STATUSCODE, ERRORMESSAGE)
     values (p_TransactionId, RNK, STARTDATE, FINISHDATE, FREQUENCY, KV, NLSA, OKPOB, NAMEB, MFOB, NLSB, HOLYDAY, fSUM, PURPOSE, DPT_ID, AGR_ID, STATUSCODE, ERRORMESSAGE);
   exception when dup_val_on_index then bars_audit.error(title||'XRMSW_REGULAR_TRANS:p_TransactionId='||to_char(p_TransactionId)|| ' already exists!');
   end;
   commit;
   bars_audit.info(title|| 'XRMSW_REGULAR_TRANS finished');
  end;

    PROCEDURE xrm_FreeSbon_trans (p_TransactionId      XRMSW_AUDIT.TransactionId%TYPE,
                                  payer_account_id     INTEGER,
                                  start_date           DATE,
                                  stop_date            DATE,
                                  payment_frequency    INTEGER,
                                  holiday_shift        INTEGER,
                                  provider_id          INTEGER,
                                  regular_amount       NUMBER,
                                  receiver_mfo         VARCHAR2,
                                  receiver_account     VARCHAR2,
                                  receiver_name        VARCHAR2,
                                  receiver_edrpou      VARCHAR2,
                                  purpose              VARCHAR2,
                                  extra_attributes     CLOB,
                                  sendsms              VARCHAR2,
                                  orderid              NUMBER,
                                  StatusCode           NUMBER,
                                  ErrorMessage         VARCHAR2)
  is
   pragma autonomous_transaction;
  begin
   begin
     insert into XRMSW_FREESBON_TRANS(TRANSACTIONID, PAYER_ACCOUNT_ID, START_DATE, STOP_DATE, PAYMENT_FREQUENCY, HOLIDAY_SHIFT, PROVIDER_ID, REGULAR_AMOUNT, RECEIVER_MFO, RECEIVER_ACCOUNT, RECEIVER_NAME, RECEIVER_EDRPOU, PURPOSE, EXTRA_ATTRIBUTES, SENDSMS, ORDERID, STATUSCODE, ERRORMESSAGE)
     values (p_TransactionId, PAYER_ACCOUNT_ID, START_DATE, STOP_DATE, PAYMENT_FREQUENCY, HOLIDAY_SHIFT, PROVIDER_ID, REGULAR_AMOUNT, RECEIVER_MFO, RECEIVER_ACCOUNT, RECEIVER_NAME, RECEIVER_EDRPOU, PURPOSE, EXTRA_ATTRIBUTES, SENDSMS, ORDERID, STATUSCODE, ERRORMESSAGE);
   exception when dup_val_on_index then bars_audit.error(title||'XRMSW_FREESBON_TRANS:p_TransactionId='||to_char(p_TransactionId)|| ' already exists!');
   end;
   commit;
   bars_audit.info(title|| 'XRMSW_FREESBON_TRANS finished');
  end;

     PROCEDURE xrm_Sbon_trans (
               p_TransactionId     IN XRMSW_AUDIT.TransactionId%TYPE,
               SBONTYPE            IN varchar2, -- Contr, NoContr
               payer_account_id    IN INTEGER,
               start_date          IN DATE,
               stop_date           IN DATE,
               payment_frequency   IN INTEGER,
               holiday_shift       IN INTEGER,
               provider_id         IN INTEGER,
               personal_account    IN VARCHAR2,
               regular_amount      IN NUMBER,
               ceiling_amount      IN NUMBER,
               extra_attributes    IN CLOB,
               sendsms             IN VARCHAR2,
               orderid             IN NUMBER,
               StatusCode          IN NUMBER,
               ErrorMessage        IN VARCHAR2)
  is
    pragma autonomous_transaction;
  begin
   begin
     insert into XRMSW_SBON_TRANS(TRANSACTIONID, SBONTYPE, PAYER_ACCOUNT_ID, START_DATE, STOP_DATE, PAYMENT_FREQUENCY, HOLIDAY_SHIFT, PROVIDER_ID, PERSONAL_ACCOUNT, REGULAR_AMOUNT, CEILING_AMOUNT, EXTRA_ATTRIBUTES, SENDSMS, ORDER_ID, STATUSCODE, ERRORMESSAGE)
     values (p_TransactionId, SBONTYPE, PAYER_ACCOUNT_ID, START_DATE, STOP_DATE, PAYMENT_FREQUENCY, HOLIDAY_SHIFT, PROVIDER_ID, PERSONAL_ACCOUNT, REGULAR_AMOUNT, CEILING_AMOUNT, EXTRA_ATTRIBUTES, SENDSMS, ORDERID, STATUSCODE, ERRORMESSAGE);
   exception when dup_val_on_index then bars_audit.error(title||'XRMSW_SBON_TRANS:p_TransactionId='||to_char(p_TransactionId)|| ' already exists!');
   end;
   commit;
   bars_audit.info(title|| 'XRMSW_SBON_TRANS finished');
  end;

  PROCEDURE xrm_dkbo_trans (  TransactionId     IN VARCHAR2,
                              ext_id            IN VARCHAR2,
                              Rnk               IN NUMBER,
                              DealNumber        IN deal.deal_number%TYPE,
                              acc_list          IN VARCHAR2,
                              dkbo_date_from    IN DATE,
                              dkbo_date_to      IN DATE,
                              dkbo_date_state   IN NUMBER,
                              deal_id           IN Number,
                              start_date        IN date,
                              StatusCode        IN NUMBER,
                              ErrorMessage      IN VARCHAR2)
 is
    pragma autonomous_transaction;
  begin
   begin
    INSERT INTO XRMSW_DKBO_TRANS (TRANSACTIONID,                                  
                                  RNK,
                                  DEALNUMBER,
                                  ACC_LIST,
                                  DKBO_DATE_FROM,
                                  DKBO_DATE_TO,
                                  DKBO_DATE_STATE,
                                  DEAL_ID,
                                  STARTDATE,
                                  STATUSCODE,
                                  ERRORMESSAGE,
                                  EXTERNAL_ID)
         VALUES (TransactionId,
                 Rnk,
                 DealNumber,
                 acc_list,
                 DKBO_DATE_FROM,
                 DKBO_DATE_TO,
                 DKBO_DATE_STATE,
                 DEAL_ID,
                 start_date,
                 STATUSCODE,
                 ERRORMESSAGE,
                 ext_id);
   exception when dup_val_on_index then bars_audit.error(title||'XRMSW_DKBO_TRANS:TransactionId='||to_char(TransactionId)|| ' already exists!');
   end;
   commit;
   bars_audit.info(title|| 'XRMSW_DKBO_TRANS finished');
  end;

END;
/
 show err;
 
PROMPT *** Create  grants  XRM_UI_OE ***
grant DEBUG,EXECUTE                                                          on XRM_UI_OE       to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/xrm_ui_oe.sql =========*** End *** =
 PROMPT ===================================================================================== 
 