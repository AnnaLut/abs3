
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_bpk.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_BPK is

g_head_version constant varchar2(64)  := 'Version 1.6 11/11/2011';
g_head_defs    constant varchar2(512) := '';

/** header_version - возвращает версию заголовка пакета */
function header_version return varchar2;

/** body_version - возвращает версию тела пакета */
function body_version return varchar2;

-------------------------------------------------------------------------------
-- set_bpk_acc
-- Процедура привязки счетов
--
procedure set_bpk_acc (
  p_acc_pk    accounts.acc%type,
  p_nls_ovr   accounts.nls%type,
  p_nls_9129  accounts.nls%type,
  p_nls_tovr  accounts.nls%type,
  p_nls_3570  accounts.nls%type,
  p_nls_2208  accounts.nls%type,
  p_nls_2207  accounts.nls%type,
  p_nls_3579  accounts.nls%type,
  p_nls_2209  accounts.nls%type );

-------------------------------------------------------------------------------
-- product_add
-- Процедура добавления продукта БПК
--
procedure product_add (
  p_id        bpk_product.id%type,
  p_name      bpk_product.name%type,
  p_type      bpk_product.type%type,
  p_kv        bpk_product.kv%type,
  p_kk        bpk_product.kk%type,
  p_condset   bpk_product.cond_set%type,
  p_limit     bpk_product.limit%type,
  p_nbs       bpk_product.nbs%type,
  p_ob22      bpk_product.ob22%type,
  p_doc       bpk_product.id_doc%type,
  p_doccred   bpk_product.id_doc_cred%type );

-------------------------------------------------------------------------------
-- product_delete
-- Процедура удаления продукта БПК
--
procedure product_delete (p_id bpk_product.id%type);

-------------------------------------------------------------------------------
-- product_change
-- Процедура изменения продукта БПК
--
procedure product_change (
  p_id        bpk_product.id%type,
  p_name      bpk_product.name%type,
  p_type      bpk_product.type%type,
  p_kv        bpk_product.kv%type,
  p_kk        bpk_product.kk%type,
  p_condset   bpk_product.cond_set%type,
  p_limit     bpk_product.limit%type,
  p_nbs       bpk_product.nbs%type,
  p_ob22      bpk_product.ob22%type,
  p_doc       bpk_product.id_doc%type,
  p_doccred   bpk_product.id_doc_cred%type );

-------------------------------------------------------------------------------
-- open_card
-- Процедура регистрации БПК
--
procedure open_card (
  p_rnk         customer.rnk%type,
  p_product_id  bpk_product.id%type,
  p_filial      demand_filiales.code%type,
  p_limit       number,
  p_kl          number,
  p_branch      accounts.tobo%type,
  p_dm_name     varchar2,
  p_dm_mname    varchar2,
  p_work        varchar2,
  p_office      varchar2,
  p_wphone      varchar2,
  p_wcntry      varchar2,
  p_wpcode      varchar2,
  p_wcity       varchar2,
  p_wstreet     varchar2,
  p_nd      out number       /* номер договора */
);

-------------------------------------------------------------------------------
-- open_kl
-- Процедура открытия кредитной линии
--
procedure open_kl (
  p_nd   in number,
  p_acc out number );

-------------------------------------------------------------------------------
-- imp_proect
-- Процедура импорта файла для регистрации клиентов и карт
--
procedure imp_proect (
  p_filename  in varchar2,
  p_id       out number );

-------------------------------------------------------------------------------
-- crete_deal
-- Процедура регистрации БПК по файлу
--
procedure create_deal (
  p_file_id     number,
  p_product_id  number,
  p_filial      varchar2,
  p_branch      varchar2,
  p_isp         number );

-------------------------------------------------------------------------------
-- can_close_deal
-- Процедура проверки: можно закрыть БПК?
--
procedure can_close_deal (
  p_nd   in number,
  p_msg out varchar2 );

-------------------------------------------------------------------------------
-- close_deal
-- Процедура закрытия счетов БПК
--
procedure close_deal (
  p_nd   in number,
  p_msg out varchar2 );

end;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_BPK wrapped
0
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
3
b
9200000
1
4
0
1da
2 :e:
1PACKAGE:
1BODY:
1BARS_BPK:
1G_BODY_VERSION:
1CONSTANT:
1VARCHAR2:
164:
1Version 2.2 11/11/2011:
1G_BODY_DEFS:
1512:
1:
1G_MODCODE:
13:
1BPK:
1SUBTYPE:
1T_PROECT:
1BPK_IMP_PROECT_DATA:
1ROWTYPE:
1FUNCTION:
1HEADER_VERSION:
1RETURN:
1Package header bars_bpk :
1||:
1G_HEAD_VERSION:
1CHR:
110:
1AWK definition:: :
1G_HEAD_DEFS:
1BODY_VERSION:
1Package body bars_bpk :
1SEARCH_ACC:
1P_MODE:
1P_RNK:
1ACCOUNTS:
1RNK:
1TYPE:
1P_NLS:
1NLS:
1P_KV:
1KV:
1NUMBER:
1L_ACC:
1ACC:
1L_NBS:
1NBS:
1L_RNK:
1IS NOT NULL:
1SELECT acc, nbs, rnk into l_acc, l_nbs, l_rnk:n          from accounts:n     +
1    where nls = p_nls and kv = p_kv:
1NO_DATA_FOUND:
1BARS_ERROR:
1RAISE_NERROR:
1ACC_NOT_FOUND:
1=:
1OVR:
1NOT_LIKE:
12%:
1INCORRECT_NBS_OVR:
1ELSIF:
19129:
1!=:
1INCORRECT_NBS_9129:
13570:
13579:
1INCORRECT_NBS_3570:
12208:
12__8:
12__9:
1INCORRECT_NBS_2208:
12207:
12__7:
1INCORRECT_NBS_DEBT:
12209:
1ACC_REG_RNK:
1SET_BPK_ACC:
1P_ACC_PK:
1P_NLS_OVR:
1P_NLS_9129:
1P_NLS_TOVR:
1P_NLS_3570:
1P_NLS_2208:
1P_NLS_2207:
1P_NLS_3579:
1P_NLS_2209:
1L_KV:
1L_ACC_OVR:
1L_ACC_9129:
1L_ACC_3570:
1L_ACC_2208:
1L_ACC_2207:
1L_ACC_3579:
1L_ACC_2209:
1SELECT kv, rnk into l_kv, l_rnk:n          from accounts:n         where acc +
1= p_acc_pk:
1BPK_ACC:
1ACC_OVR:
1ACC_9129:
1ACC_3570:
1ACC_2208:
1ACC_2207:
1ACC_3579:
1ACC_2209:
1ACC_PK:
1UPDATE bpk_acc:n           set acc_ovr  = l_acc_ovr,:n               acc_9129+
1 = l_acc_9129,:n               acc_3570 = l_acc_3570,:n               acc_220+
18 = l_acc_2208,:n               acc_2207 = l_acc_2207,:n               acc_35+
179 = l_acc_3579,:n               acc_2209 = l_acc_2209:n         where acc_pk+
1 = p_acc_pk:
1CHECK_PARAMS:
1P_NAME:
1BPK_PRODUCT:
1NAME:
1P_TYPE:
1P_KK:
1KK:
1P_CONDSET:
1COND_SET:
1P_NBS:
1P_OB22:
1OB22:
1L_MERR:
1100:
1IS NULL:
1NAME_NOT_SET:
1TYPE_NOT_SET:
1KV_NOT_SET:
1KK_NOT_SET:
1CONDSET_NOT_SET:
1NBS_NOT_SET:
1OB22_NOT_SET:
1GET_CARD_TYPE:
1L_CARDTYPE:
1CARD_TYPE:
1DEMAND_ACC_TYPE:
1SELECT card_type into l_cardtype from demand_acc_type where type = p_type:
1CARDTYPE_NOT_FOUND:
1CHECK_COND_SET:
1P_CARDTYPE:
1L_NAME:
1L_PAR1:
1L_PAR2:
1L_PAR3:
1C:
1DECODE:
1CURRENCY:
1SUBSTR:
1A:
1DEMAND_COND_SET:
1SELECT c.card_type, decode(c.currency,'UAH',980,840), substr(a.name,1,100):n +
1      into l_cardtype, l_kv, l_name:n       from demand_cond_set c, demand_ac+
1c_type a:n      where a.type = p_type:n        and a.card_type = c.card_type+
1:n        and c.cond_set  = p_condset:
1CONDSET_CARDTYPE_INCORRECT:
1TO_CHAR:
1CONDSET_KV_INCORRECT:
1CONDSET_NOT_FOUND:
1PRODUCT_ADD:
1P_ID:
1ID:
1P_LIMIT:
1LIMIT:
1P_DOC:
1ID_DOC:
1P_DOCCRED:
1ID_DOC_CRED:
1L_ID:
1D_CLOSE:
1DELETE from bpk_product:n   where type      = p_type:n     and card_type = l_+
1cardtype:n     and kv        = p_kv:n     and kk        = p_kk:n     and cond+
1_set  = p_condset:n     and nbs       = p_nbs:n     and ob22      = p_ob22:n +
1    and d_close is not null:
10:
1NVL:
1MIN:
1B:
1ROWNUM:
1SELECT nvl(min(id),0) + 1 into l_id:n       from bpk_product b:n      where n+
1ot exists ( select id from bpk_product where id = b.id + 1):n        and rown+
1um = 1:
1INSERT into bpk_product (id, name, type, card_type, kv, :n            kk, con+
1d_set, limit, nbs, ob22, id_doc, id_doc_cred):n     values (l_id, p_name, p_t+
1ype, l_cardtype, p_kv, :n            p_kk, p_condset, p_limit, p_nbs, p_ob22,+
1 p_doc, p_doccred):
1DUP_VAL_ON_INDEX:
1DUBL_PRODUCT:
1PRODUCT_DELETE:
1TRUNC:
1SYSDATE:
1UPDATE bpk_product:n     set d_close = trunc(sysdate):n   where id = p_id:n  +
1   and d_close is null:
1PRODUCT_CHANGE:
1DELETE from bpk_product:n      where type      = p_type:n        and card_typ+
1e = l_cardtype:n        and kv        = p_kv:n        and kk        = p_kk:n +
1       and cond_set  = p_condset:n        and nbs       = p_nbs:n        and +
1ob22      = p_ob22:n        and d_close is not null:
1UPDATE bpk_product:n        set name        = p_name,:n            type      +
1  = p_type,:n            card_type   = l_cardtype,:n            kv          =+
1 p_kv,:n            kk          = p_kk,:n            cond_set    = p_condset,+
1:n            limit       = p_limit,:n            nbs         = p_nbs,:n     +
1       ob22        = p_ob22,:n            id_doc      = p_doc,:n            i+
1d_doc_cred = p_doccred:n      where id = p_id:
1GET_DEAL_ID:
1L_DEAL_ID:
1S_OBPCDEAL:
1NEXTVAL:
1DUAL:
1SELECT s_obpcdeal.nextval into l_deal_id from dual:
1ADD_DEAL:
1P_ACC:
1P_ND:
1OUT:
1P_PRODUCT_ID:
1L_ND:
1ND:
1SELECT nd into l_nd from bpk_acc where acc_pk = p_acc:
1PRODUCT_ID:
1UPDATE bpk_acc set product_id = p_product_id where nd = l_nd:
1SELECT s_obpcdeal.nextval into l_nd from dual:
1INSERT into bpk_acc (nd, acc_pk, product_id):n     values (l_nd, p_acc, p_pro+
1duct_id):
1OPEN_CARD:
1CUSTOMER:
1P_FILIAL:
1DEMAND_FILIALES:
1CODE:
1P_KL:
1P_BRANCH:
1TOBO:
1P_DM_NAME:
1P_DM_MNAME:
1P_WORK:
1P_OFFICE:
1P_WPHONE:
1P_WCNTRY:
1P_WPCODE:
1P_WCITY:
1P_WSTREET:
1L_KK:
1DEMAND_KK:
1L_CONDSET:
1L_NBS_PK:
1L_OB22:
1SPECPARAM_INT:
1L_TIP:
1TIP:
1L_CUSTTYPE:
1BPK_NBS:
1CUSTTYPE:
1L_TERM:
1C_VALIDITY:
1L_CTYPE:
1L_NLS_PK:
1L_NMS_PK:
1NMS:
1L_ACC_PK:
1L_GRP:
1L_VID:
1L_TMP:
1L_MFO:
16:
1I:
1GL:
1AMFO:
1N:
1D:
1SELECT b.kv, b.kk, b.cond_set, b.nbs, b.ob22, n.tip, n.custtype, d.c_validity+
1:n    into l_kv, l_kk, l_condset, l_nbs_pk, l_ob22, l_tip, l_custtype, l_term+
1:n    from bpk_product b, bpk_nbs n, demand_cond_set d:n   where b.id   = p_p+
1roduct_id:n     and b.nbs  = n.nbs:n     and b.ob22 = n.ob22:n     and b.card+
1_type = d.card_type:n     and b.cond_set  = d.cond_set:
1TRIM:
1SED:
1SELECT decode(custtype, 3, decode(nvl(trim(sed),'00'),'91',2,1), 2) into l_ct+
1ype:n    from customer:n   where rnk = p_rnk:
1CTYPE_ERROR:
1F_NEWNLS2:
1F_NEWNMS:
1SELECT f_newnls2(null, l_tip, l_nbs_pk, p_rnk, null, l_kv),:n         f_newnm+
1s (null, l_tip, l_nbs_pk, p_rnk, null):n    into l_nls_pk, l_nms_pk:n    from+
1 dual:
1SELECT 1 into l_tmp from accounts where nls = l_nls_pk and kv = l_kv:
1LOOP:
1VKRZN:
11:
15:
1LPAD:
12:
17:
1EXIT:
1+:
1OP_REG_LOCK:
199:
1USER_ID:
1OBPC:
1SET_SPARAM:
12625:
1ACCREG:
1SETACCOUNTSPARAM:
1DEMAND_BRN:
1SETACCOUNTWPARAM:
1PK_NAME:
1PK_WORK:
1PK_OFFIC:
1PK_PHONE:
1PK_CNTRW:
1PK_PCODW:
1PK_CITYW:
1PK_STRTW:
1KL:
1SETCUSTOMERELEMENT:
1PC_MF:
1OPEN_ACC:
12202:
1OPEN_KL:
1O:
1SELECT o.acc_ovr into l_acc:n       from bpk_acc o:n      where o.nd = p_nd:
1DEAL_NOT_FOUND:
1CHECK_PROECT:
1P_PROECT:
1OKPO:
1ADR_STREET:
1PASSP_SER:
1PASSP_NUMDOC:
1PASSP_ORGAN:
1PASSP_DATE:
1BDAY:
1BPLACE:
1MNAME:
1STR_ERR:
1Не заповнено обов'язкові реквізити:
1IMP_PROECT:
1P_FILENAME:
1REFCUR:
1SYS_REFCURSOR:
1L_PROECT:
1L_FILEID:
1MAX:
1BPK_IMP_PROECT_FILES:
1SELECT nvl(max(id),0) + 1 into l_fileid from bpk_imp_proect_files:
1FILE_NAME:
1FILE_DATE:
1INSERT into bpk_imp_proect_files (id, file_name, file_date):n  values (l_file+
1id, p_filename, sysdate):
1OPEN:
1select name, okpo, adr_pcode, adr_domain, adr_region, adr_city, adr_street, +
1:n            passp_ser, passp_num, passp_org, passp_date, bday, bplace, mnam+
1e, :n            w_place, w_office, w_phone, w_pcode, w_city, w_street:n     +
1  from test_bpk_impproect:
1ADR_PCODE:
1ADR_DOMAIN:
1ADR_REGION:
1ADR_CITY:
1WORK_PLACE:
1WORK_OFFICE:
1WORK_PHONE:
1WORK_PCODE:
1WORK_CITY:
1WORK_STREET:
1NOTFOUND:
1IDN:
1INSERT into bpk_imp_proect_data (id, idn, name, okpo, :n        adr_pcode, ad+
1r_domain, adr_region, adr_city, adr_street,:n        passp_ser, passp_numdoc,+
1 passp_organ, passp_date,:n        bday, bplace, mname, work_place, work_offi+
1ce,:n        work_phone, work_pcode, work_city, work_street, str_err):n     v+
1alues (l_fileid, i, l_proect.name, l_proect.okpo,:n        l_proect.adr_pcode+
1, l_proect.adr_domain, l_proect.adr_region,:n        l_proect.adr_city, l_pro+
1ect.adr_street, :n        l_proect.passp_ser, l_proect.passp_numdoc, l_proect+
1.passp_organ, l_proect.passp_date,:n        l_proect.bday, l_proect.bplace, l+
1_proect.mname, :n        l_proect.work_place, l_proect.work_office, l_proect.+
1work_phone, l_proect.work_pcode,:n        l_proect.work_city, l_proect.work_s+
1treet, l_proect.str_err):
1CLOSE:
1ADD_CUSTOMER:
1L_ADR:
170:
1BARS_AUDIT:
1TRACE:
1bpk_imp:: p_proect.str_err=>:
1bpk_imp:: p_proect.str_err is null:
1NVL2:
1SELECT substr(trim(p_proect.adr_domain) || :n              nvl2(trim(p_proect+
1.adr_region), ' ' || trim(p_proect.adr_region), '') ||:n              nvl2(tr+
1im(p_proect.adr_city  ), ' ' || trim(p_proect.adr_city  ), '') ||:n          +
1    nvl2(trim(p_proect.adr_street), ' ' || trim(p_proect.adr_street), ''), 1,+
1 70):n       into l_adr from dual:
1SETCUSTOMERATTR:
1RNK_:
1CUSTTYPE_:
1ND_:
1NMK_:
1NMKV_:
1F_TRANSLATE_KMU:
1NMKK_:
138:
1ADR_:
1CODCAGENT_:
1COUNTRY_:
1804:
1PRINSIDER_:
1TGR_:
1OKPO_:
1STMT_:
1SAB_:
1DATEON_:
1BANKDATE:
1TAXF_:
1CREG_:
1-:
1CDST_:
1ADM_:
1RGTAX_:
1RGADM_:
1DATET_:
1DATEA_:
1ISE_:
1FS_:
1OE_:
1VED_:
1SED_:
1NOTES_:
1NOTESEC_:
1CRISK_:
1PINCODE_:
1RNKP_:
1LIM_:
1NOMPDV_:
1MB_:
19:
1BC_:
1TOBO_:
1ISP_:
1SETCUSTOMEREN:
1P_K070:
1GETGLOBALOPTION:
1CUSTK070:
100000:
1P_K080:
1CUSTK080:
100:
1P_K110:
1P_K090:
1P_K050:
1000:
1P_K051:
1TAG_:
1FGIDX:
1VAL_:
1OTD_:
1FGOBL:
1FGDST:
1FGTWN:
1FGADR:
1SETCUSTOMERADDRESSBYTERRITORY:
1TYPEID_:
1ZIP_:
1DOMAIN_:
1REGION_:
1LOCALITY_:
1ADDRESS_:
1TERRITORYID_:
1SETPERSONATTR:
1SEX_:
1PASSP_:
1SER_:
1NUMDOC_:
1PDATE_:
1ORGAN_:
1BDAY_:
1BPLACE_:
1TELD_:
1TELW_:
1ADD_BPK:
1P_ISP:
1L_DM_NAME:
124:
1REPLACE:
1NMKV:
1INSTR:
1SELECT substr(:n         substr(trim(replace(nmkv, '  ', ' ')), 1, :n        +
1        decode(instr(trim(replace(nmkv, '  ', ' ')), ' ',1,2),0,24,:n        +
1               instr(trim(replace(nmkv, '  ', ' ')), ' ',1,2)-1)), 1, 24):n  +
1  into l_dm_name:n    from customer where rnk = p_proect.rnk:
1Україна:
1ISP:
1UPDATE accounts set isp = p_isp:n   where acc = ( select acc_pk from bpk_acc +
1where nd = p_proect.nd ):
1CREATE_DEAL:
1P_FILE_ID:
1Z:
1select idn from bpk_imp_proect_data where id = p_file_id and rnk is null :
1SELECT * into l_proect from bpk_imp_proect_data where id = p_file_id and idn +
1= z.idn:
1UPDATE bpk_imp_proect_data:n           set rnk = l_proect.rnk,:n             +
1  nd = l_proect.nd:n         where id = p_file_id and idn = z.idn:
1FILIAL:
1BRANCH:
1UPDATE bpk_imp_proect_files:n     set product_id = p_product_id,:n         fi+
1lial = p_filial,:n         branch = p_branch,:n         isp = p_isp:n   where+
1 id = p_file_id:
1CAN_CLOSE_DEAL:
1P_MSG:
1L_NLS:
114:
1L_DAPP:
1DATE:
1L_OSTC:
1L_OSTB:
1APPEND_MSG:
1P_TXT:
1V_BPK_ND_ACC:
1select acc from v_bpk_nd_acc where nd = p_nd and name <> 'ACC_9129' :
1DAPP:
1OSTC:
1OSTB:
1DAZS:
1SELECT nls, kv, dapp, ostc/100, ostb/100:n          into l_nls, l_kv, l_dapp,+
1 l_ostc, l_ostb:n          from accounts:n         where acc = z.acc:n       +
1    and dazs is null:
1>=:
1Рахунок :
1/:
1:: дата останнього руху >= банк.дати, закриття рахунку неможливе.:
1:: фактичний залишок=:
1, плановий залишок=:
1, закриття рахунку неможливе.:
1Продовжити закриття угоди?:
1Будуть закриті всі рахунки з нульовим залишком.:
1CLOSE_DEAL:
1V:
1select v.acc, a.nls, a.kv:n               from v_bpk_nd_acc v, accounts a:n  +
1            where v.nd  = p_nd:n                and v.name <> 'ACC_9129':n   +
1             and v.acc = a.acc:n                and a.dazs is null :
1OSTF:
1DAOS:
1SELECT 1 into i:n          from accounts:n         where acc = z.acc:n       +
1    and ostc = 0:n           and ostb = 0:n           and ostf = 0:n         +
1  and (dapp is null or dapp < bankdate):n           and daos <= bankdate:n   +
1     for update nowait:
1UPDATE accounts set dazs = bankdate where acc = z.acc:
1 - закрито.:
1 - не закривається.:
0

0
0
fde
2
0 :2 a0 97 87 :2 a0 51 a5 1c
6e 1b b0 87 :2 a0 51 a5 1c
6e 1b b0 87 :2 a0 51 a5 1c
6e 1b b0 a0 9b :2 a0 f 1c
70 a0 8d a0 b4 a0 2c 6a
a0 6e 7e a0 b4 2e 7e a0
51 a5 b b4 2e 7e 6e b4
2e 7e a0 51 a5 b b4 2e
7e a0 b4 2e 65 b7 a4 a0
b1 11 68 4f a0 8d a0 b4
a0 2c 6a a0 6e 7e a0 b4
2e 7e a0 51 a5 b b4 2e
7e 6e b4 2e 7e a0 51 a5
b b4 2e 7e a0 b4 2e 65
b7 a4 a0 b1 11 68 4f a0
8d 8f a0 b0 3d 8f :2 a0 6b
:2 a0 f b0 3d 8f :2 a0 6b :2 a0
f b0 3d 8f :2 a0 6b :2 a0 f
b0 3d b4 :2 a0 2c 6a a3 :2 a0
6b :2 a0 f 1c 81 b0 a3 :2 a0
6b :2 a0 f 1c 81 b0 a3 :2 a0
6b :2 a0 f 1c 81 b0 a0 7e
b4 2e a0 7e b4 2e a 10
a0 7e b4 2e a 10 :b a0 12a
b7 :3 a0 6b a0 6e :2 a0 a5 57
b7 a6 9 a4 b1 11 4f a0
7e 6e b4 2e a0 7e 6e b4
2e a 10 :2 a0 6b a0 6e a0
a5 57 a0 b7 a0 7e 6e b4
2e a0 7e 6e b4 2e a 10
:2 a0 6b a0 6e a0 a5 57 a0
b7 19 a0 7e 6e b4 2e a0
7e 6e b4 2e a 10 a0 7e
6e b4 2e a 10 :2 a0 6b a0
6e a0 a5 57 a0 b7 19 a0
7e 6e b4 2e a0 7e 6e b4
2e a 10 a0 7e 6e b4 2e
a 10 :2 a0 6b a0 6e a0 a5
57 a0 b7 19 a0 7e 6e b4
2e a0 7e 6e b4 2e a 10
:2 a0 6b a0 6e a0 a5 57 a0
b7 19 a0 7e 6e b4 2e a0
7e 6e b4 2e a 10 :2 a0 6b
a0 6e a0 a5 57 a0 b7 19
a0 7e 6e b4 2e a0 7e 6e
b4 2e a 10 :2 a0 6b a0 6e
a0 a5 57 b7 :2 19 3c :2 a0 7e
b4 2e :2 a0 6b a0 6e :3 a0 a5
57 b7 19 3c b7 a0 4d d
b7 :2 19 3c :2 a0 65 b7 a4 a0
b1 11 68 4f 9a 8f :2 a0 6b
:2 a0 f b0 3d 8f :2 a0 6b :2 a0
f b0 3d 8f :2 a0 6b :2 a0 f
b0 3d 8f :2 a0 6b :2 a0 f b0
3d 8f :2 a0 6b :2 a0 f b0 3d
8f :2 a0 6b :2 a0 f b0 3d 8f
:2 a0 6b :2 a0 f b0 3d 8f :2 a0
6b :2 a0 f b0 3d 8f :2 a0 6b
:2 a0 f b0 3d b4 55 6a a3
:2 a0 6b :2 a0 f 1c 81 b0 a3
:2 a0 6b :2 a0 f 1c 81 b0 a3
:2 a0 6b :2 a0 f 1c 81 b0 a3
:2 a0 6b :2 a0 f 1c 81 b0 a3
:2 a0 6b :2 a0 f 1c 81 b0 a3
:2 a0 6b :2 a0 f 1c 81 b0 a3
:2 a0 6b :2 a0 f 1c 81 b0 a3
:2 a0 6b :2 a0 f 1c 81 b0 a3
:2 a0 6b :2 a0 f 1c 81 b0 a0
7e b4 2e :7 a0 12a :2 a0 6e :3 a0
a5 b d :2 a0 6e :3 a0 a5 b
d :2 a0 6e :3 a0 a5 b d :2 a0
6e :3 a0 a5 b d :2 a0 6e :3 a0
a5 b d :2 a0 6e :3 a0 a5 b
d :2 a0 6e :3 a0 a5 b d :11 a0
12a b7 a0 4f b7 a6 9 a4
b1 11 4f b7 19 3c b7 a4
a0 b1 11 68 4f 9a 8f :2 a0
6b :2 a0 f b0 3d 8f :2 a0 6b
:2 a0 f b0 3d 8f :2 a0 6b :2 a0
f b0 3d 8f :2 a0 6b :2 a0 f
b0 3d 8f :2 a0 6b :2 a0 f b0
3d 8f :2 a0 6b :2 a0 f b0 3d
8f :2 a0 6b :2 a0 f b0 3d b4
55 6a a3 a0 51 a5 1c 81
b0 a0 4d d a0 7e b4 2e
a0 6e d a0 b7 a0 7e b4
2e a0 6e d a0 b7 19 a0
7e b4 2e a0 6e d a0 b7
19 a0 7e b4 2e a0 6e d
a0 b7 19 a0 7e b4 2e a0
6e d a0 b7 19 a0 7e b4
2e a0 6e d a0 b7 19 a0
7e b4 2e a0 6e d b7 :2 19
3c a0 7e b4 2e :2 a0 6b :2 a0
a5 57 b7 19 3c b7 a4 a0
b1 11 68 4f a0 8d 8f :2 a0
6b :2 a0 f b0 3d b4 :2 a0 2c
6a a3 a0 1c 81 b0 a3 a0
51 a5 1c 81 b0 :5 a0 12a b7
:2 a0 6e d b7 a6 9 a4 b1
11 4f a0 7e b4 2e :2 a0 6b
:2 a0 a5 57 b7 19 3c :2 a0 65
b7 a4 a0 b1 11 68 4f 9a
8f :2 a0 6b :2 a0 f b0 3d 8f
:2 a0 6b :2 a0 f b0 3d 8f :2 a0
6b :2 a0 f b0 3d 8f :2 a0 6b
:2 a0 f b0 3d b4 55 6a a3
a0 1c 81 b0 a3 a0 1c 81
b0 a3 a0 51 a5 1c 81 b0
a3 a0 51 a5 1c 81 b0 a3
a0 51 a5 1c 81 b0 a3 a0
51 a5 1c 81 b0 a3 a0 51
a5 1c 81 b0 :19 a0 12a :2 a0 7e
b4 2e a0 6e d :2 a0 d :3 a0
a5 b d a0 4d d b7 19
3c :2 a0 7e b4 2e a0 6e d
:2 a0 d :3 a0 a5 b d :3 a0 a5
b d b7 19 3c b7 :2 a0 6e
d :2 a0 d :3 a0 a5 b d a0
4d d b7 a6 9 a4 b1 11
4f a0 7e b4 2e :2 a0 6b :5 a0
a5 57 b7 19 3c b7 a4 a0
b1 11 68 4f 9a 8f :2 a0 6b
:2 a0 f b0 3d 8f :2 a0 6b :2 a0
f b0 3d 8f :2 a0 6b :2 a0 f
b0 3d 8f :2 a0 6b :2 a0 f b0
3d 8f :2 a0 6b :2 a0 f b0 3d
8f :2 a0 6b :2 a0 f b0 3d 8f
:2 a0 6b :2 a0 f b0 3d 8f :2 a0
6b :2 a0 f b0 3d 8f :2 a0 6b
:2 a0 f b0 3d 8f :2 a0 6b :2 a0
f b0 3d 8f :2 a0 6b :2 a0 f
b0 3d b4 55 6a a3 a0 1c
81 b0 a3 a0 1c 81 b0 :8 a0
a5 57 :3 a0 a5 b d :5 a0 a5
57 :10 a0 12a a0 7e b4 2e a0
7e 51 b4 2e 52 10 :c a0 12a
b7 :2 a0 d b7 :2 19 3c :19 a0 12a
b7 :3 a0 6b a0 6e a5 57 b7
a6 9 a4 b1 11 4f b7 a4
a0 b1 11 68 4f 9a 8f :2 a0
6b :2 a0 f b0 3d b4 55 6a
:7 a0 12a b7 a4 a0 b1 11 68
4f 9a 8f :2 a0 6b :2 a0 f b0
3d 8f :2 a0 6b :2 a0 f b0 3d
8f :2 a0 6b :2 a0 f b0 3d 8f
:2 a0 6b :2 a0 f b0 3d 8f :2 a0
6b :2 a0 f b0 3d 8f :2 a0 6b
:2 a0 f b0 3d 8f :2 a0 6b :2 a0
f b0 3d 8f :2 a0 6b :2 a0 f
b0 3d 8f :2 a0 6b :2 a0 f b0
3d 8f :2 a0 6b :2 a0 f b0 3d
8f :2 a0 6b :2 a0 f b0 3d b4
55 6a a3 a0 1c 81 b0 :8 a0
a5 57 :3 a0 a5 b d :5 a0 a5
57 :10 a0 12a :19 a0 12a b7 :3 a0 6b
a0 6e a5 57 b7 a6 9 a4
b1 11 4f b7 a4 a0 b1 11
68 4f a0 8d a0 b4 a0 2c
6a a3 a0 1c 81 b0 :4 a0 12a
:2 a0 65 b7 a4 a0 b1 11 68
4f 9a 8f a0 b0 3d 96 :2 a0
b0 54 8f a0 b0 3d b4 55
6a a3 a0 1c 81 b0 :5 a0 12a
:5 a0 12a b7 :5 a0 12a :7 a0 12a b7
a6 9 a4 b1 11 4f :2 a0 d
b7 a4 a0 b1 11 68 4f 9a
8f :2 a0 6b :2 a0 f b0 3d 8f
:2 a0 6b :2 a0 f b0 3d 8f :2 a0
6b :2 a0 f b0 3d 8f a0 b0
3d 8f a0 b0 3d 8f :2 a0 6b
:2 a0 f b0 3d 8f a0 b0 3d
8f a0 b0 3d 8f a0 b0 3d
8f a0 b0 3d 8f a0 b0 3d
8f a0 b0 3d 8f a0 b0 3d
8f a0 b0 3d 8f a0 b0 3d
96 :2 a0 b0 54 b4 55 6a a3
:2 a0 6b :2 a0 f 1c 81 b0 a3
:2 a0 6b :2 a0 f 1c 81 b0 a3
:2 a0 6b :2 a0 f 1c 81 b0 a3
:2 a0 6b :2 a0 f 1c 81 b0 a3
:2 a0 6b :2 a0 f 1c 81 b0 a3
:2 a0 6b :2 a0 f 1c 81 b0 a3
:2 a0 6b :2 a0 f 1c 81 b0 a3
:2 a0 6b :2 a0 f 1c 81 b0 a3
a0 1c 81 b0 a3 a0 1c 81
b0 a3 :2 a0 6b :2 a0 f 1c 81
b0 a3 :2 a0 6b :2 a0 f 1c 81
b0 a3 :2 a0 6b :2 a0 f 1c 81
b0 a3 :2 a0 6b :2 a0 f 1c 81
b0 a3 a0 1c 81 b0 a3 a0
1c 81 b0 a3 a0 1c 81 b0
a3 a0 51 a5 1c 81 b0 a3
a0 1c 81 b0 :3 a0 6b d :31 a0
12a :a a0 12a :2 a0 7e b4 2e :2 a0
6b a0 6e a5 57 b7 19 3c
:c a0 12a :6 a0 12a a0 51 d :5 a0
:2 51 a5 b a0 7e 6e b4 2e
7e :3 a0 a5 b 51 6e a5 b
b4 2e 7e :3 a0 a5 b 51 6e
a5 b b4 2e a5 b d :6 a0
12a b7 :2 a0 2b b7 a6 9 a4
b1 11 4f :2 a0 7e 51 b4 2e
d a0 7e 51 b4 2e a0 2b
b7 19 3c b7 a0 47 b7 a0
4f b7 a6 9 a4 b1 11 4f
a0 4d d a0 7e 51 b4 2e
a0 51 d b7 a0 51 d b7
:2 19 3c a0 :3 51 :9 a0 6e 51 a0
:6 4d a0 :2 4d a0 a5 57 :4 a0 a5
57 :2 a0 6b 6e a0 a5 57 a0
7e b4 2e :2 a0 6b a0 6e a0
a5 57 b7 19 3c a0 7e b4
2e :2 a0 6b a0 6e a0 a5 57
b7 19 3c a0 7e b4 2e :2 a0
6b a0 6e a0 a5 57 b7 19
3c a0 7e b4 2e :2 a0 6b a0
6e a0 a5 57 b7 19 3c a0
7e b4 2e :2 a0 6b a0 6e a0
a5 57 b7 19 3c a0 7e b4
2e :2 a0 6b a0 6e a0 a5 57
b7 19 3c a0 7e b4 2e :2 a0
6b a0 6e a0 a5 57 b7 19
3c a0 7e b4 2e :2 a0 6b a0
6e a0 a5 57 b7 19 3c a0
7e b4 2e :2 a0 6b a0 6e a0
a5 57 b7 19 3c a0 7e b4
2e :2 a0 6b a0 6e a0 a5 57
b7 19 3c a0 7e b4 2e :2 a0
6b a0 6e a0 a5 57 b7 19
3c a0 7e b4 2e :2 a0 6b a0
6e a0 a5 57 b7 19 3c :2 a0
6b a0 6e a0 51 a5 57 a0
7e 51 b4 2e :2 a0 6b a0 6e
a0 a5 57 b7 19 3c :2 a0 d
b7 a4 a0 b1 11 68 4f 9a
8f a0 b0 3d 96 :2 a0 b0 54
b4 55 6a a3 a0 1c 81 b0
:8 a0 12a b7 :3 a0 6b a0 6e :2 a0
a5 b a5 57 b7 a6 9 a4
b1 11 4f a0 7e b4 2e :2 a0
6b a0 6e a0 a5 57 b7 19
3c :2 a0 d b7 a4 a0 b1 11
68 4f 9a 90 :2 a0 b0 3f b4
55 6a :2 a0 6b 7e b4 2e :2 a0
6b 7e b4 2e 52 10 :2 a0 6b
7e b4 2e 52 10 :2 a0 6b 7e
b4 2e 52 10 :2 a0 6b 7e b4
2e 52 10 :2 a0 6b 7e b4 2e
52 10 :2 a0 6b 7e b4 2e 52
10 :2 a0 6b 7e b4 2e 52 10
:2 a0 6b 7e b4 2e 52 10 :2 a0
6b 7e b4 2e 52 10 :2 a0 6b
6e d b7 :2 a0 6b 4d d b7
:2 19 3c b7 a4 a0 b1 11 68
4f 9a 8f a0 b0 3d 96 :2 a0
b0 54 b4 55 6a a3 a0 1c
81 b0 a3 a0 1c 81 b0 a3
a0 1c 81 b0 a3 a0 1c 81
b0 :5 a0 12a :7 a0 12a a0 51 d
:2 a0 6e 11c 11d :4 a0 6b :2 a0 6b
:2 a0 6b :2 a0 6b :2 a0 6b :2 a0 6b
:2 a0 6b :2 a0 6b :2 a0 6b :2 a0 6b
:2 a0 6b :2 a0 6b :2 a0 6b :2 a0 6b
:2 a0 6b :2 a0 6b :2 a0 6b :2 a0 6b
:2 a0 6b :2 a0 6b e9 d3 5 :3 a0
f 2b :2 a0 a5 57 :2 a0 7e 51
b4 2e d :44 a0 12a b7 a0 47
:2 a0 e9 c1 :2 a0 d b7 a4 a0
b1 11 68 4f 9a 90 :2 a0 b0
3f 8f a0 b0 3d b4 55 6a
a3 a0 1c 4d 81 b0 a3 a0
51 a5 1c 81 b0 :2 a0 a5 57
:2 a0 6b 6e 7e :2 a0 6b b4 2e
a5 57 :2 a0 6b 7e b4 2e :2 a0
6b 6e a5 57 :1b a0 12a :2 a0 6b
:2 a0 e a0 51 e a0 4d e
:5 a0 6b a5 b :2 51 a5 b e
:6 a0 6b a5 b a5 b :2 51 a5
b e :5 a0 6b a5 b :2 51 a5
b e :2 a0 e a0 51 e a0
51 e a0 51 e a0 51 e
:4 a0 6b a5 b e a0 51 e
a0 4d e :2 a0 e a0 4d e
a0 7e 51 b4 2e e a0 7e
51 b4 2e e a0 4d e a0
4d e a0 4d e a0 4d e
a0 4d e a0 4d e a0 4d
e a0 4d e a0 4d e a0
4d e a0 4d e a0 4d e
a0 4d e a0 4d e a0 4d
e a0 4d e a0 4d e a0
51 e a0 51 e :2 a0 e a0
4d e a5 57 :2 a0 6b :2 a0 e
:3 a0 6e a5 b 6e a5 b e
:3 a0 6e a5 b 6e a5 b e
a0 6e e a0 6e e a0 6e
e a0 6e e a5 57 :2 a0 6b
:2 a0 e a0 6e e :4 a0 6b a5
b e a0 51 e a5 57 :2 a0
6b :2 a0 e a0 6e e :4 a0 6b
a5 b e a0 51 e a5 57
:2 a0 6b :2 a0 e a0 6e e :4 a0
6b a5 b e a0 51 e a5
57 :2 a0 6b :2 a0 e a0 6e e
:4 a0 6b a5 b e a0 51 e
a5 57 :2 a0 6b :2 a0 e a0 6e
e :4 a0 6b a5 b e a0 51
e a5 57 :2 a0 6b :2 a0 e a0
51 e a0 51 e :4 a0 6b a5
b e :4 a0 6b a5 b e :4 a0
6b a5 b e :4 a0 6b a5 b
e :4 a0 6b a5 b e a0 4d
e a5 57 :2 a0 6b :2 a0 e a0
51 e a0 51 e :4 a0 6b a5
b e :4 a0 6b a5 b e :4 a0
6b a5 b e :4 a0 6b a5 b
e :3 a0 6b e :3 a0 6b e a0
4d e a0 4d e a5 57 :2 a0
6b a0 d b7 19 3c b7 a4
a0 b1 11 68 4f 9a 90 :2 a0
b0 3f 8f a0 b0 3d 8f a0
b0 3d 8f a0 b0 3d 8f a0
b0 3d b4 55 6a a3 a0 51
a5 1c 81 b0 :13 a0 12a :2 a0 6b
:3 a0 6b e :2 a0 e :2 a0 e a0
51 e a0 51 e :2 a0 e :2 a0
e :4 a0 6b a5 b e :3 a0 6b
e :3 a0 6b e :3 a0 6b e a0
6e e :3 a0 6b e :3 a0 6b e
:3 a0 6b e :3 a0 6b e a5 57
:9 a0 12a b7 a0 4f b7 a6 9
a4 a0 b1 11 68 4f 9a 8f
a0 b0 3d 8f a0 b0 3d 8f
a0 b0 3d 8f a0 b0 3d 8f
a0 b0 3d b4 55 6a a3 a0
1c 81 b0 91 :6 a0 12a 37 :7 a0
12a :3 a0 a5 57 :2 a0 6b 7e b4
2e :6 a0 a5 57 b7 19 3c :2 a0
6b 7e b4 2e :c a0 12a b7 19
3c b7 a0 47 :b a0 12a b7 a4
a0 b1 11 68 4f 9a 8f a0
b0 3d 96 :2 a0 b0 54 b4 55
6a a3 a0 51 a5 1c 81 b0
a3 a0 1c 81 b0 a3 a0 1c
81 b0 a3 a0 1c 81 b0 a3
a0 1c 81 b0 9a 8f a0 b0
3d b4 55 6a a0 7e b4 2e
:2 a0 7e a0 51 a5 b b4 2e
7e a0 b4 2e d b7 :2 a0 d
b7 :2 19 3c b7 a4 b1 11 68
4f 91 :6 a0 12a 37 :f a0 12a :2 a0
7e b4 2e a0 6e 7e a0 b4
2e 7e 6e b4 2e 7e :2 a0 a5
b b4 2e 7e 6e b4 2e a5
57 b7 19 3c a0 7e 51 b4
2e a0 7e 51 b4 2e 52 10
a0 6e 7e a0 b4 2e 7e 6e
b4 2e 7e :2 a0 a5 b b4 2e
7e 6e b4 2e 7e :2 a0 a5 b
b4 2e 7e 6e b4 2e 7e :2 a0
a5 b b4 2e 7e 6e b4 2e
a5 57 b7 19 3c b7 a0 4f
b7 a6 9 a4 b1 11 4f b7
a0 47 a0 7e b4 2e a0 6e
a5 57 a0 6e a5 57 b7 19
3c b7 a4 a0 b1 11 68 4f
9a 8f a0 b0 3d 96 :2 a0 b0
54 b4 55 6a a3 a0 1c 81
b0 9a 8f a0 b0 3d b4 55
6a a0 7e b4 2e :2 a0 7e a0
51 a5 b b4 2e 7e a0 b4
2e d b7 :2 a0 d b7 :2 19 3c
b7 a4 b1 11 68 4f 91 :16 a0
12a 37 :d a0 12a :6 a0 12a a0 6e
7e :2 a0 6b b4 2e 7e 6e b4
2e 7e :3 a0 6b a5 b b4 2e
7e 6e b4 2e a5 57 b7 :2 a0
6e 7e :2 a0 6b b4 2e 7e 6e
b4 2e 7e :3 a0 6b a5 b b4
2e 7e 6e b4 2e a5 57 b7
a6 9 a4 b1 11 4f b7 a0
47 b7 a4 a0 b1 11 68 4f
b1 b7 a4 11 b1 56 4f 1d
17 b5
fde
2
0 3 7 b 36 19 1d 21
24 25 2d 32 18 5b 41 45
15 49 4a 52 57 40 80 66
6a 3d 6e 6f 77 7c 65 87
8b 8f 93 97 9c 62 a4 a8
bc c0 c1 c5 c9 cd d1 d6
d9 dd de e3 e6 ea ed ee
f0 f1 f6 f9 fe ff 104 107
10b 10e 10f 111 112 117 11a 11e
11f 124 128 12a 12e 132 134 140
144 146 14a 15e 162 163 167 16b
16f 173 178 17b 17f 180 185 188
18c 18f 190 192 193 198 19b 1a0
1a1 1a6 1a9 1ad 1b0 1b1 1b3 1b4
1b9 1bc 1c0 1c1 1c6 1ca 1cc 1d0
1d4 1d6 1e2 1e6 1e8 1ec 208 204
203 210 22e 219 21d 200 221 225
229 218 236 254 23f 243 215 247
24b 24f 23e 25c 27a 265 269 23b
26d 271 275 264 282 261 287 28b
28f 293 2c0 29b 29f 2a3 2a6 2aa
2ae 2b3 2bb 29a 2ed 2cb 2cf 297
2d3 2d7 2db 2e0 2e8 2ca 31a 2f8
2fc 2c7 300 304 308 30d 315 2f7
321 2f4 325 326 32b 32f 332 333
1 338 33d 341 344 345 1 34a
34f 353 357 35b 35f 363 367 36b
36f 373 377 37b 387 389 38d 391
395 398 39c 3a1 3a5 3a9 3aa 3af
3b1 3b2 3b7 3bb 3bd 3c9 3cb 3cf
3d2 3d7 3d8 3dd 3e1 3e4 3e9 3ea
1 3ef 3f4 3f8 3fc 3ff 403 408
40c 40d 412 416 418 41c 41f 424
425 42a 42e 431 436 437 1 43c
441 445 449 44c 450 455 459 45a
45f 463 465 469 46d 470 475 476
47b 47f 482 487 488 1 48d 492
496 499 49e 49f 1 4a4 4a9 4ad
4b1 4b4 4b8 4bd 4c1 4c2 4c7 4cb
4cd 4d1 4d5 4d8 4dd 4de 4e3 4e7
4ea 4ef 4f0 1 4f5 4fa 4fe 501
506 507 1 50c 511 515 519 51c
520 525 529 52a 52f 533 535 539
53d 540 545 546 54b 54f 552 557
558 1 55d 562 566 56a 56d 571
576 57a 57b 580 584 586 58a 58e
591 596 597 59c 5a0 5a3 5a8 5a9
1 5ae 5b3 5b7 5bb 5be 5c2 5c7
5cb 5cc 5d1 5d5 5d7 5db 5df 5e2
5e7 5e8 5ed 5f1 5f4 5f9 5fa 1
5ff 604 608 60c 60f 613 618 61c
61d 622 624 628 62c 62f 633 637
63a 63b 640 644 648 64b 64f 654
658 65c 660 661 666 668 66c 66f
671 675 676 67a 67c 680 684 687
68b 68f 693 695 699 69d 69f 6ab
6af 6b1 6e1 6c9 6cd 6d1 6d4 6d8
6dc 6c8 6e9 707 6f2 6f6 6c5 6fa
6fe 702 6f1 70f 72d 718 71c 6ee
720 724 728 717 735 753 73e 742
714 746 74a 74e 73d 75b 779 764
768 73a 76c 770 774 763 781 79f
78a 78e 760 792 796 79a 789 7a7
7c5 7b0 7b4 786 7b8 7bc 7c0 7af
7cd 7eb 7d6 7da 7ac 7de 7e2 7e6
7d5 7f3 811 7fc 800 7d2 804 808
80c 7fb 819 7f8 81e 822 84f 82a
82e 832 835 839 83d 842 84a 829
87c 85a 85e 826 862 866 86a 86f
877 859 8a9 887 88b 856 88f 893
897 89c 8a4 886 8d6 8b4 8b8 883
8bc 8c0 8c4 8c9 8d1 8b3 903 8e1
8e5 8b0 8e9 8ed 8f1 8f6 8fe 8e0
930 90e 912 8dd 916 91a 91e 923
92b 90d 95d 93b 93f 90a 943 947
94b 950 958 93a 98a 968 96c 937
970 974 978 97d 985 967 9b7 995
999 964 99d 9a1 9a5 9aa 9b2 994
9be 991 9c2 9c3 9c8 9cc 9d0 9d4
9d8 9dc 9e0 9e4 9f0 9f4 9f8 9fd
a01 a05 a09 a0a a0c a10 a14 a18
a1d a21 a25 a29 a2a a2c a30 a34
a38 a3d a41 a45 a49 a4a a4c a50
a54 a58 a5d a61 a65 a69 a6a a6c
a70 a74 a78 a7d a81 a85 a89 a8a
a8c a90 a94 a98 a9d aa1 aa5 aa9
aaa aac ab0 ab4 ab8 abd ac1 ac5
ac9 aca acc ad0 ad4 ad8 adc ae0
ae4 ae8 aec af0 af4 af8 afc b00
b04 b08 b0c b10 b14 b20 b22 b26
b28 b2a b2b b30 b34 b36 b42 b44
b46 b4a b4d b4f b53 b57 b59 b65
b69 b6b b9b b83 b87 b8b b8e b92
b96 b82 ba3 bc1 bac bb0 b7f bb4
bb8 bbc bab bc9 be7 bd2 bd6 ba8
bda bde be2 bd1 bef c0d bf8 bfc
bce c00 c04 c08 bf7 c15 c33 c1e
c22 bf4 c26 c2a c2e c1d c3b c59
c44 c48 c1a c4c c50 c54 c43 c61
c7f c6a c6e c40 c72 c76 c7a c69
c87 c66 c8c c90 cad c98 c9c c9f
ca0 ca8 c97 cb4 c94 cb8 cbc cc0
cc3 cc4 cc9 ccd cd2 cd6 cda cdc
ce0 ce3 ce4 ce9 ced cf2 cf6 cfa
cfc d00 d04 d07 d08 d0d d11 d16
d1a d1e d20 d24 d28 d2b d2c d31
d35 d3a d3e d42 d44 d48 d4c d4f
d50 d55 d59 d5e d62 d66 d68 d6c
d70 d73 d74 d79 d7d d82 d86 d8a
d8c d90 d94 d97 d98 d9d da1 da6
daa dac db0 db4 db7 dbb dbe dbf
dc4 dc8 dcc dcf dd3 dd7 dd8 ddd
ddf de3 de6 de8 dec df0 df2 dfe
e02 e04 e08 e38 e20 e24 e28 e2b
e2f e33 e1f e40 e1c e45 e49 e4d
e51 e6a e59 e5d e65 e58 e87 e75
e55 e79 e7a e82 e74 e8e e92 e96
e9a e9e ea2 e71 eae eb2 eb6 ebb
ebf ec1 ec2 ec7 ecb ecd ed9 edb
edf ee2 ee3 ee8 eec ef0 ef3 ef7
efb efc f01 f03 f07 f0a f0e f12
f16 f18 f1c f20 f22 f2e f32 f34
f64 f4c f50 f54 f57 f5b f5f f4b
f6c f8a f75 f79 f48 f7d f81 f85
f74 f92 fb0 f9b f9f f71 fa3 fa7
fab f9a fb8 fd6 fc1 fc5 f97 fc9
fcd fd1 fc0 fde fbd fe3 fe7 1000
fef ff3 ffb fee 101c 100b 100f 1017
feb 1038 1023 1027 102a 102b 1033 100a
1055 1043 1007 1047 1048 1050 1042 1072
1060 103f 1064 1065 106d 105f 108f 107d
105c 1081 1082 108a 107c 10ac 109a 1079
109e 109f 10a7 1099 10b3 10b7 10bb 10bf
10c3 10c7 10cb 10cf 10d3 10d7 10db 10df
10e3 10e7 10eb 10ef 10f3 10f7 10fb 10ff
1103 1107 110b 110f 1113 1117 1123 1127
1096 112b 112c 1131 1135 113a 113e 1142
1146 114a 114e 1152 1156 1157 1159 115d
1161 1162 1166 1168 116c 116f 1173 1177
117a 117b 1180 1184 1189 118d 1191 1195
1199 119d 11a1 11a5 11a6 11a8 11ac 11b0
11b4 11b8 11b9 11bb 11bf 11c1 11c5 11c8
11ca 11ce 11d2 11d7 11db 11df 11e3 11e7
11eb 11ef 11f3 11f4 11f6 11fa 11fe 11ff
1203 1205 1206 120b 120f 1211 121d 121f
1223 1226 1227 122c 1230 1234 1237 123b
123f 1243 1247 124b 124c 1251 1253 1257
125a 125c 1260 1264 1266 1272 1276 1278
12a8 1290 1294 1298 129b 129f 12a3 128f
12b0 12ce 12b9 12bd 128c 12c1 12c5 12c9
12b8 12d6 12f4 12df 12e3 12b5 12e7 12eb
12ef 12de 12fc 131a 1305 1309 12db 130d
1311 1315 1304 1322 1340 132b 132f 1301
1333 1337 133b 132a 1348 1366 1351 1355
1327 1359 135d 1361 1350 136e 138c 1377
137b 134d 137f 1383 1387 1376 1394 13b2
139d 13a1 1373 13a5 13a9 13ad 139c 13ba
13d8 13c3 13c7 1399 13cb 13cf 13d3 13c2
13e0 13fe 13e9 13ed 13bf 13f1 13f5 13f9
13e8 1406 1424 140f 1413 13e5 1417 141b
141f 140e 142c 140b 1431 1435 144e 143d
1441 1449 143c 146a 1459 145d 1465 1439
1455 1471 1475 1479 147d 1481 1485 1489
148d 148e 1493 1497 149b 149f 14a0 14a2
14a6 14aa 14ae 14b2 14b6 14ba 14bb 14c0
14c4 14c8 14cc 14d0 14d4 14d8 14dc 14e0
14e4 14e8 14ec 14f0 14f4 14f8 14fc 1500
150c 1510 1513 1514 1519 151d 1520 1523
1524 1 1529 152e 1532 1536 153a 153e
1542 1546 154a 154e 1552 1556 155a 155e
156a 156c 1570 1574 1578 157a 157e 1582
1585 1589 158d 1591 1595 1599 159d 15a1
15a5 15a9 15ad 15b1 15b5 15b9 15bd 15c1
15c5 15c9 15cd 15d1 15d5 15d9 15dd 15e1
15e5 15e9 15f5 15f7 15fb 15ff 1603 1606
160a 160f 1610 1615 1617 1618 161d 1621
1623 162f 1631 1633 1637 163b 163d 1649
164d 164f 167f 1667 166b 166f 1672 1676
167a 1666 1687 1663 168c 1690 1694 1698
169c 16a0 16a4 16a8 16ac 16b0 16bc 16be
16c2 16c6 16c8 16d4 16d8 16da 170a 16f2
16f6 16fa 16fd 1701 1705 16f1 1712 1730
171b 171f 16ee 1723 1727 172b 171a 1738
1756 1741 1745 1717 1749 174d 1751 1740
175e 177c 1767 176b 173d 176f 1773 1777
1766 1784 17a2 178d 1791 1763 1795 1799
179d 178c 17aa 17c8 17b3 17b7 1789 17bb
17bf 17c3 17b2 17d0 17ee 17d9 17dd 17af
17e1 17e5 17e9 17d8 17f6 1814 17ff 1803
17d5 1807 180b 180f 17fe 181c 183a 1825
1829 17fb 182d 1831 1835 1824 1842 1860
184b 184f 1821 1853 1857 185b 184a 1868
1886 1871 1875 1847 1879 187d 1881 1870
188e 186d 1893 1897 18b0 189f 18a3 18ab
189e 18b7 18bb 18bf 18c3 18c7 18cb 18cf
18d3 189b 18d7 18dc 18e0 18e4 18e8 18e9
18eb 18ef 18f3 18f7 18fb 18ff 1903 1904
1909 190d 1911 1915 1919 191d 1921 1925
1929 192d 1931 1935 1939 193d 1941 1945
1949 1955 1959 195d 1961 1965 1969 196d
1971 1975 1979 197d 1981 1985 1989 198d
1991 1995 1999 199d 19a1 19a5 19a9 19ad
19b1 19b5 19b9 19c5 19c7 19cb 19cf 19d3
19d6 19da 19df 19e0 19e5 19e7 19e8 19ed
19f1 19f3 19ff 1a01 1a03 1a07 1a0b 1a0d
1a19 1a1d 1a1f 1a23 1a37 1a3b 1a3c 1a40
1a44 1a5d 1a4c 1a50 1a58 1a4b 1a64 1a68
1a6c 1a70 1a74 1a80 1a84 1a88 1a48 1a8c
1a90 1a94 1a96 1aa2 1aa6 1aa8 1ac4 1ac0
1abf 1acc 1add 1ad5 1ad9 1abc 1ae4 1aed
1ae9 1ad4 1af5 1ad1 1afa 1afe 1b17 1b06
1b0a 1b12 1b05 1b1e 1b22 1b26 1b2a 1b2e
1b32 1b3e 1b42 1b46 1b4a 1b4e 1b52 1b02
1b5e 1b62 1b66 1b6a 1b6e 1b72 1b7e 1b82
1b86 1b8a 1b8e 1b92 1b96 1b9a 1ba6 1ba8
1ba9 1bae 1bb2 1bb4 1bc0 1bc2 1bc6 1bca
1bce 1bd0 1bd4 1bd8 1bda 1be6 1bea 1bec
1c1c 1c04 1c08 1c0c 1c0f 1c13 1c17 1c03
1c24 1c42 1c2d 1c31 1c00 1c35 1c39 1c3d
1c2c 1c4a 1c68 1c53 1c57 1c29 1c5b 1c5f
1c63 1c52 1c70 1c7d 1c79 1c4f 1c85 1c8e
1c8a 1c78 1c96 1cb4 1c9f 1ca3 1c75 1ca7
1cab 1caf 1c9e 1cbc 1cc9 1cc5 1c9b 1cd1
1cda 1cd6 1cc4 1ce2 1cef 1ceb 1cc1 1cf7
1d00 1cfc 1cea 1d08 1d15 1d11 1ce7 1d1d
1d26 1d22 1d10 1d2e 1d3b 1d37 1d0d 1d43
1d4c 1d48 1d36 1d54 1d61 1d5d 1d33 1d69
1d76 1d6e 1d72 1d5c 1d7d 1d59 1d82 1d86
1db3 1d8e 1d92 1d96 1d99 1d9d 1da1 1da6
1dae 1d8d 1de0 1dbe 1dc2 1d8a 1dc6 1dca
1dce 1dd3 1ddb 1dbd 1e0d 1deb 1def 1dba
1df3 1df7 1dfb 1e00 1e08 1dea 1e3a 1e18
1e1c 1de7 1e20 1e24 1e28 1e2d 1e35 1e17
1e67 1e45 1e49 1e14 1e4d 1e51 1e55 1e5a
1e62 1e44 1e94 1e72 1e76 1e41 1e7a 1e7e
1e82 1e87 1e8f 1e71 1ec1 1e9f 1ea3 1e6e
1ea7 1eab 1eaf 1eb4 1ebc 1e9e 1eee 1ecc
1ed0 1e9b 1ed4 1ed8 1edc 1ee1 1ee9 1ecb
1f0a 1ef9 1efd 1f05 1ec8 1f22 1f11 1f15
1f1d 1ef8 1f4f 1f2d 1f31 1ef5 1f35 1f39
1f3d 1f42 1f4a 1f2c 1f7c 1f5a 1f5e 1f29
1f62 1f66 1f6a 1f6f 1f77 1f59 1fa9 1f87
1f8b 1f56 1f8f 1f93 1f97 1f9c 1fa4 1f86
1fd6 1fb4 1fb8 1f83 1fbc 1fc0 1fc4 1fc9
1fd1 1fb3 1ff2 1fe1 1fe5 1fed 1fb0 200a
1ff9 1ffd 2005 1fe0 2026 2015 2019 2021
1fdd 2042 202d 2031 2034 2035 203d 2014
205e 204d 2051 2059 2011 2049 2065 2069
206d 2070 2074 2078 207c 2080 2084 2088
208c 2090 2094 2098 209c 20a0 20a4 20a8
20ac 20b0 20b4 20b8 20bc 20c0 20c4 20c8
20cc 20d0 20d4 20d8 20dc 20e0 20e4 20e8
20ec 20f0 20f4 20f8 20fc 2100 2104 2108
210c 2110 2114 2118 211c 2120 2124 2128
212c 2130 2134 2138 2144 2148 214c 2150
2154 2158 215c 2160 2164 2168 216c 2178
217c 2180 2183 2184 2189 218d 2191 2194
2198 219d 219e 21a3 21a5 21a9 21ac 21b0
21b4 21b8 21bc 21c0 21c4 21c8 21cc 21d0
21d4 21d8 21dc 21e8 21ec 21f0 21f4 21f8
21fc 2200 220c 2210 2213 2217 221b 221f
2223 2227 222b 222e 2231 2232 2234 2238
223b 2240 2241 2246 2249 224d 2251 2255
2256 2258 225b 2260 2261 2263 2264 2269
226c 2270 2274 2278 2279 227b 227e 2283
2284 2286 2287 228c 228d 228f 2293 2297
229b 229f 22a3 22a7 22ab 22b7 22b9 22bd
22c1 22c7 22c9 22ca 22cf 22d3 22d5 22e1
22e3 22e7 22eb 22ee 22f1 22f2 22f7 22fb
22ff 2302 2305 2306 230b 230f 2315 2317
231b 231e 2320 2324 232b 232d 2331 2333
2335 2336 233b 233f 2341 234d 234f 2353
2354 2358 235c 235f 2362 2363 2368 236c
236f 2373 2375 2379 237c 2380 2382 2386
238a 238d 2391 2394 2397 239a 239e 23a2
23a6 23aa 23ae 23b2 23b6 23ba 23be 23c3
23c6 23ca 23cb 23cc 23cd 23ce 23cf 23d0
23d4 23d5 23d6 23da 23db 23e0 23e4 23e8
23ec 23f0 23f1 23f6 23fa 23fe 2401 2406
240a 240b 2410 2414 2417 2418 241d 2421
2425 2428 242c 2431 2435 2436 243b 243d
2441 2444 2448 244b 244c 2451 2455 2459
245c 2460 2465 2469 246a 246f 2471 2475
2478 247c 247f 2480 2485 2489 248d 2490
2494 2499 249d 249e 24a3 24a5 24a9 24ac
24b0 24b3 24b4 24b9 24bd 24c1 24c4 24c8
24cd 24d1 24d2 24d7 24d9 24dd 24e0 24e4
24e7 24e8 24ed 24f1 24f5 24f8 24fc 2501
2505 2506 250b 250d 2511 2514 2518 251b
251c 2521 2525 2529 252c 2530 2535 2539
253a 253f 2541 2545 2548 254c 254f 2550
2555 2559 255d 2560 2564 2569 256d 256e
2573 2575 2579 257c 2580 2583 2584 2589
258d 2591 2594 2598 259d 25a1 25a2 25a7
25a9 25ad 25b0 25b4 25b7 25b8 25bd 25c1
25c5 25c8 25cc 25d1 25d5 25d6 25db 25dd
25e1 25e4 25e8 25eb 25ec 25f1 25f5 25f9
25fc 2600 2605 2609 260a 260f 2611 2615
2618 261c 261f 2620 2625 2629 262d 2630
2634 2639 263d 263e 2643 2645 2649 264c
2650 2653 2654 2659 265d 2661 2664 2668
266d 2671 2672 2677 2679 267d 2680 2684
2688 268b 268f 2694 2698 269b 269c 26a1
26a5 26a8 26ab 26ac 26b1 26b5 26b9 26bc
26c0 26c5 26c9 26ca 26cf 26d1 26d5 26d8
26dc 26e0 26e4 26e6 26ea 26ee 26f0 26fc
2700 2702 271e 271a 2719 2726 2737 272f
2733 2716 273e 272e 2743 2747 2760 274f
2753 275b 272b 274b 2767 276b 276f 2773
2777 277b 277f 2783 278f 2791 2795 2799
279d 27a0 27a4 27a9 27ad 27b1 27b2 27b4
27b5 27ba 27bc 27bd 27c2 27c6 27c8 27d4
27d6 27da 27dd 27de 27e3 27e7 27eb 27ee
27f2 27f7 27fb 27fc 2801 2803 2807 280a
280e 2812 2816 2818 281c 2820 2822 282e
2832 2834 2854 284c 2850 284b 285b 2848
2860 2864 2868 286c 2870 2873 2876 2877
287c 2880 2884 2887 288a 288b 1 2890
2895 2899 289d 28a0 28a3 28a4 1 28a9
28ae 28b2 28b6 28b9 28bc 28bd 1 28c2
28c7 28cb 28cf 28d2 28d5 28d6 1 28db
28e0 28e4 28e8 28eb 28ee 28ef 1 28f4
28f9 28fd 2901 2904 2907 2908 1 290d
2912 2916 291a 291d 2920 2921 1 2926
292b 292f 2933 2936 2939 293a 1 293f
2944 2948 294c 294f 2952 2953 1 2958
295d 2961 2965 2968 296d 2971 2973 2977
297b 297e 297f 2983 2985 2989 298d 2990
2992 2996 299a 299c 29a8 29ac 29ae 29ca
29c6 29c5 29d2 29e3 29db 29df 29c2 29ea
29da 29ef 29f3 2a0c 29fb 29ff 2a07 29d7
2a24 2a13 2a17 2a1f 29fa 2a40 2a2f 2a33
2a3b 29f7 2a58 2a47 2a4b 2a53 2a2e 2a5f
2a63 2a67 2a6b 2a6f 2a73 2a7f 2a83 2a87
2a8b 2a8f 2a93 2a97 2a9b 2aa7 2a2b 2aab
2aaf 2ab3 2ab7 2abc 2abf 2ac3 2ac7 2acb
2acf 2ad3 2ad6 2ada 2ade 2ae1 2ae5 2ae9
2aec 2af0 2af4 2af7 2afb 2aff 2b02 2b06
2b0a 2b0d 2b11 2b15 2b18 2b1c 2b20 2b23
2b27 2b2b 2b2e 2b32 2b36 2b39 2b3d 2b41
2b44 2b48 2b4c 2b4f 2b53 2b57 2b5a 2b5e
2b62 2b65 2b69 2b6d 2b70 2b74 2b78 2b7b
2b7f 2b83 2b86 2b8a 2b8e 2b91 2b95 2b99
2b9c 2ba0 2ba4 2ba7 2bac 2bb1 2bb5 2bb9
2bbd 2bc1 2bc6 2bcc 2bd0 2bd4 2bd5 2bda
2bde 2be2 2be5 2be8 2be9 2bee 2bf2 2bf6
2bfa 2bfe 2c02 2c06 2c0a 2c0e 2c12 2c16
2c1a 2c1e 2c22 2c26 2c2a 2c2e 2c32 2c36
2c3a 2c3e 2c42 2c46 2c4a 2c4e 2c52 2c56
2c5a 2c5e 2c62 2c66 2c6a 2c6e 2c72 2c76
2c7a 2c7e 2c82 2c86 2c8a 2c8e 2c92 2c96
2c9a 2c9e 2ca2 2ca6 2caa 2cae 2cb2 2cb6
2cba 2cbe 2cc2 2cc6 2cca 2cce 2cd2 2cd6
2cda 2cde 2ce2 2ce6 2cea 2cee 2cf2 2cf6
2cfa 2cfe 2d02 2d0e 2d10 2d14 2d1b 2d1f
2d23 2d28 2d2a 2d2e 2d32 2d36 2d38 2d3c
2d40 2d42 2d4e 2d52 2d54 2d74 2d6c 2d70
2d6b 2d7b 2d88 2d84 2d68 2d90 2d83 2d95
2d99 2db2 2da1 2da5 2d80 2dad 2da0 2dcf
2dbd 2d9d 2dc1 2dc2 2dca 2dbc 2dd6 2dda
2db9 2dde 2de3 2de7 2deb 2dee 2df3 2df6
2dfa 2dfe 2e01 2e02 2e07 2e08 2e0d 2e11
2e15 2e18 2e1b 2e1c 2e21 2e25 2e29 2e2c
2e31 2e32 2e37 2e3b 2e3f 2e43 2e47 2e4b
2e4f 2e53 2e57 2e5b 2e5f 2e63 2e67 2e6b
2e6f 2e73 2e77 2e7b 2e7f 2e83 2e87 2e8b
2e8f 2e93 2e97 2e9b 2e9f 2ea3 2eaf 2eb3
2eb7 2eba 2ebe 2ec2 2ec4 2ec8 2ecb 2ecd
2ed1 2ed2 2ed4 2ed8 2edc 2ee0 2ee4 2ee8
2eeb 2eec 2eee 2ef1 2ef4 2ef5 2ef7 2ef9
2efd 2f01 2f05 2f09 2f0d 2f11 2f14 2f15
2f17 2f18 2f1a 2f1d 2f20 2f21 2f23 2f25
2f29 2f2d 2f31 2f35 2f39 2f3c 2f3d 2f3f
2f42 2f45 2f46 2f48 2f4a 2f4e 2f52 2f54
2f58 2f5b 2f5d 2f61 2f64 2f66 2f6a 2f6d
2f6f 2f73 2f76 2f78 2f7c 2f80 2f84 2f88
2f8b 2f8c 2f8e 2f90 2f94 2f97 2f99 2f9d
2f9e 2fa0 2fa4 2fa8 2faa 2fae 2faf 2fb1
2fb5 2fb8 2fbb 2fbc 2fc1 2fc3 2fc7 2fca
2fcd 2fce 2fd3 2fd5 2fd9 2fda 2fdc 2fe0
2fe1 2fe3 2fe7 2fe8 2fea 2fee 2fef 2ff1
2ff5 2ff6 2ff8 2ffc 2ffd 2fff 3003 3004
3006 300a 300b 300d 3011 3012 3014 3018
3019 301b 301f 3020 3022 3026 3027 3029
302d 302e 3030 3034 3035 3037 303b 303c
303e 3042 3043 3045 3049 304a 304c 3050
3053 3055 3059 305c 305e 3062 3066 3068
306c 306d 306f 3070 3075 3079 307d 3080
3084 3088 308a 308e 3092 3096 309b 309c
309e 30a3 30a4 30a6 30a8 30ac 30b0 30b4
30b9 30ba 30bc 30c1 30c2 30c4 30c6 30ca
30cf 30d1 30d5 30da 30dc 30e0 30e5 30e7
30eb 30f0 30f2 30f3 30f8 30fc 3100 3103
3107 310b 310d 3111 3116 3118 311c 3120
3124 3128 312b 312c 312e 3130 3134 3137
3139 313a 313f 3143 3147 314a 314e 3152
3154 3158 315d 315f 3163 3167 316b 316f
3172 3173 3175 3177 317b 317e 3180 3181
3186 318a 318e 3191 3195 3199 319b 319f
31a4 31a6 31aa 31ae 31b2 31b6 31b9 31ba
31bc 31be 31c2 31c5 31c7 31c8 31cd 31d1
31d5 31d8 31dc 31e0 31e2 31e6 31eb 31ed
31f1 31f5 31f9 31fd 3200 3201 3203 3205
3209 320c 320e 320f 3214 3218 321c 321f
3223 3227 3229 322d 3232 3234 3238 323c
3240 3244 3247 3248 324a 324c 3250 3253
3255 3256 325b 325f 3263 3266 326a 326e
3270 3274 3277 3279 327d 3280 3282 3286
328a 328e 3292 3295 3296 3298 329a 329e
32a2 32a6 32aa 32ad 32ae 32b0 32b2 32b6
32ba 32be 32c2 32c5 32c6 32c8 32ca 32ce
32d2 32d6 32da 32dd 32de 32e0 32e2 32e6
32ea 32ee 32f2 32f5 32f6 32f8 32fa 32fe
32ff 3301 3302 3307 330b 330f 3312 3316
331a 331c 3320 3323 3325 3329 332c 332e
3332 3336 333a 333e 3341 3342 3344 3346
334a 334e 3352 3356 3359 335a 335c 335e
3362 3366 336a 336e 3371 3372 3374 3376
337a 337e 3382 3386 3389 338a 338c 338e
3392 3396 339a 339d 339f 33a3 33a7 33ab
33ae 33b0 33b4 33b5 33b7 33bb 33bc 33be
33bf 33c4 33c8 33cc 33cf 33d3 33d7 33d9
33dd 33e0 33e2 33e6 33ea 33ec 33f8 33fc
33fe 341e 3416 341a 3415 3425 3432 342e
3412 343a 3443 343f 342d 344b 3458 3454
342a 3460 3469 3465 3453 3471 3450 3476
347a 3497 3482 3486 3489 348a 3492 3481
349e 34a2 34a6 34aa 34ae 34b2 34b6 34ba
34be 34c2 34c6 34ca 34ce 34d2 34d6 34da
34de 34e2 34e6 34ea 34f6 34fa 347e 34fe
3502 3506 350a 350d 350f 3513 3517 3519
351d 3521 3523 3527 352a 352c 3530 3533
3535 3539 353d 353f 3543 3547 3549 354d
3551 3555 3559 355c 355d 355f 3561 3565
3569 356d 3570 3572 3576 357a 357e 3581
3583 3587 358b 358f 3592 3594 3598 359d
359f 35a3 35a7 35ab 35ae 35b0 35b4 35b8
35bc 35bf 35c1 35c5 35c9 35cd 35d0 35d2
35d6 35da 35de 35e1 35e3 35e4 35e9 35ed
35f1 35f5 35f9 35fd 3601 3605 3609 360d
3619 361b 361f 3621 3623 3624 3629 362d
3631 3633 363f 3643 3645 3661 365d 365c
3669 3676 3672 3659 367e 3687 3683 3671
368f 369c 3698 366e 36a4 36ad 36a9 3697
36b5 3694 36ba 36be 36d7 36c6 36ca 36d2
36c5 36de 36e2 36e6 36ea 36ee 36f2 36f6
36fa 36c2 3706 370a 370e 3712 3716 371a
371e 3722 372e 3732 3736 373a 373b 3740
3744 3748 374b 374e 374f 3754 3758 375c
3760 3764 3768 376c 376d 3772 3774 3778
377b 377f 3783 3786 3789 378a 378f 3793
3797 379b 379f 37a3 37a7 37ab 37af 37b3
37b7 37bb 37bf 37cb 37cd 37d1 37d4 37d6
37da 37e1 37e5 37e9 37ed 37f1 37f5 37f9
37fd 3801 3805 3809 380d 3819 381b 381f
3823 3825 3831 3835 3837 3853 384f 384e
385b 386c 3864 3868 384b 3873 3863 3878
387c 3896 3884 3860 3888 3889 3891 3883
38b2 38a1 38a5 38ad 3880 38ca 38b9 38bd
38c5 38a0 38e6 38d5 38d9 38e1 389d 38fe
38ed 38f1 38f9 38d4 3905 3921 391d 38d1
3929 391c 392e 3932 3936 3919 393a 393b
3940 3944 3948 394b 394f 3952 3953 3955
3956 395b 395e 3962 3963 3968 396c 396e
3972 3976 397a 397c 3980 3984 3987 3989
398d 398f 399b 399f 39a1 39a5 39a9 39ad
39b1 39b5 39b9 39bd 39c9 39cb 39cf 39d3
39d7 39db 39df 39e3 39e7 39eb 39ef 39f3
39f7 39fb 39ff 3a03 3a07 3a13 3a17 3a1b
3a1e 3a1f 3a24 3a28 3a2d 3a30 3a34 3a35
3a3a 3a3d 3a42 3a43 3a48 3a4b 3a4f 3a53
3a54 3a56 3a57 3a5c 3a5f 3a64 3a65 3a6a
3a6b 3a70 3a72 3a76 3a79 3a7d 3a80 3a83
3a84 3a89 3a8d 3a90 3a93 3a94 1 3a99
3a9e 3aa2 3aa7 3aaa 3aae 3aaf 3ab4 3ab7
3abc 3abd 3ac2 3ac5 3ac9 3acd 3ace 3ad0
3ad1 3ad6 3ad9 3ade 3adf 3ae4 3ae7 3aeb
3aef 3af0 3af2 3af3 3af8 3afb 3b00 3b01
3b06 3b09 3b0d 3b11 3b12 3b14 3b15 3b1a
3b1d 3b22 3b23 3b28 3b29 3b2e 3b30 3b34
3b37 3b39 3b3d 3b3f 3b41 3b42 3b47 3b4b
3b4d 3b59 3b5b 3b5d 3b61 3b68 3b6c 3b6f
3b70 3b75 3b79 3b7e 3b7f 3b84 3b88 3b8d
3b8e 3b93 3b95 3b99 3b9c 3b9e 3ba2 3ba6
3ba8 3bb4 3bb8 3bba 3bd6 3bd2 3bd1 3bde
3bef 3be7 3beb 3bce 3bf6 3be6 3bfb 3bff
3c18 3c07 3c0b 3c13 3be3 3c1f 3c37 3c33
3c06 3c3f 3c03 3c44 3c48 3c4c 3c50 3c53
3c54 3c59 3c5d 3c61 3c64 3c68 3c6b 3c6c
3c6e 3c6f 3c74 3c77 3c7b 3c7c 3c81 3c85
3c87 3c8b 3c8f 3c93 3c95 3c99 3c9d 3ca0
3ca2 3ca6 3ca8 3cb4 3cb8 3cba 3cbe 3cc2
3cc6 3cca 3cce 3cd2 3cd6 3cda 3cde 3ce2
3ce6 3cea 3cee 3cf2 3cf6 3cfa 3cfe 3d02
3d06 3d0a 3d0e 3d12 3d16 3d22 3d24 3d28
3d2c 3d30 3d34 3d38 3d3c 3d40 3d44 3d48
3d4c 3d50 3d54 3d58 3d64 3d68 3d6c 3d70
3d74 3d78 3d7c 3d88 3d8c 3d91 3d94 3d98
3d9c 3d9f 3da0 3da5 3da8 3dad 3dae 3db3
3db6 3dba 3dbe 3dc2 3dc5 3dc6 3dc8 3dc9
3dce 3dd1 3dd6 3dd7 3ddc 3ddd 3de2 3de4
3de8 3dec 3df1 3df4 3df8 3dfc 3dff 3e00
3e05 3e08 3e0d 3e0e 3e13 3e16 3e1a 3e1e
3e22 3e25 3e26 3e28 3e29 3e2e 3e31 3e36
3e37 3e3c 3e3d 3e42 3e44 3e45 3e4a 3e4e
3e50 3e5c 3e5e 3e60 3e64 3e6b 3e6d 3e71
3e75 3e77 3e83 3e87 3e89 3e8b 3e8d 3e91
3e9d 3e9f 3ea2 3ea4 3ea5 3eae
fde
2
0 1 9 e 1 10 19 22
21 19 2a 10 :2 1 10 19 22
21 19 2a 10 :2 1 10 19 22
21 19 2a 10 :2 1 9 15 29
:2 15 :2 1 a 19 0 20 :2 1 3
a 25 28 :2 a 37 3a 3e :2 3a
:2 a 42 :3 a 1d 20 24 :2 20 :2 a
28 2b :2 a 3 :2 1 5 :5 1 a
17 0 1e :2 1 3 a 23 26
:2 a 35 39 3d :2 39 :2 a 41 :3 a
1d 20 24 :2 20 :2 a 28 2b :2 a
3 :2 1 5 :5 1 a 3 a :3 3
a 13 a :2 17 a :3 3 a 13
a :2 17 a :3 3 a 13 a :2 16
a :2 3 15 1d 24 :2 1 3 a
13 a :2 17 :3 a :2 3 a 13 a
:2 17 :3 a :2 3 a 13 a :2 17 :3 a
3 :4 6 :4 1c :2 6 :4 32 :2 6 10 15
1a 23 2a 31 :2 10 16 20 25
9 6 15 9 :2 14 21 2c 3d
44 :2 9 23 :2 10 6 :3 43 9 10
12 :2 10 1c 22 2b :2 1c :3 9 :2 14
21 2c 41 :2 9 6 30 c 13
15 :2 13 20 26 29 :2 26 :2 c 9
:2 14 21 2c 42 :2 9 6 :2 30 c
13 15 :2 13 20 26 29 :2 26 :2 c
34 3a 3d :2 3a :2 c 9 :2 14 21
2c 42 :2 9 6 44 30 c 13
15 :2 13 20 26 2f :2 20 :2 c 3a
40 49 :2 3a :2 c 9 :2 14 21 2c
42 :2 9 6 50 30 c 13 15
:2 13 20 26 2f :2 20 :2 c 9 :2 14
21 2c 42 :2 9 6 36 30 c
13 15 :2 13 20 26 29 :2 26 :2 c
9 :2 14 21 2c 42 :2 9 6 :2 30
c 13 15 :2 13 20 26 2f :2 20
:2 c 9 :2 14 21 2c 42 :2 9 36
30 :2 6 9 12 :3 f 9 :2 14 21
2c 3b 42 48 :2 9 18 :2 6 43
6 f 6 :5 3 a 3 :2 1 5
:4 1 b 3 f 18 f :2 1c f
:3 3 f 18 f :2 1c f :3 3 f
18 f :2 1c f :3 3 f 18 f
:2 1c f :3 3 f 18 f :2 1c f
:3 3 f 18 f :2 1c f :3 3 f
18 f :2 1c f :3 3 f 18 f
:2 1c f :3 3 f 18 f :2 1c f
:2 3 17 :2 1 3 f 18 f :2 1b
:3 f :2 3 f 18 f :2 1c :3 f :2 3
f 18 f :2 1c :3 f :2 3 f 18
f :2 1c :3 f :2 3 f 18 f :2 1c
:3 f :2 3 f 18 f :2 1c :3 f :2 3
f 18 f :2 1c :3 f :2 3 f 18
f :2 1c :3 f :2 3 f 18 f :2 1c
:3 f 3 :4 6 10 14 1d 23 :2 10
16 :2 9 17 22 2a 31 3d :2 17
:2 9 17 22 2a 31 3d :2 17 :2 9
17 22 2a 31 3d :2 17 :2 9 17
22 2a 31 3d :2 17 :2 9 17 22
2a 31 3d :2 17 :2 9 17 22 2a
31 3d :2 17 :2 9 17 22 2a 31
3d :2 17 9 :2 10 1b 10 1b 10
1b 10 1b 10 1b 10 1b 10
1b 10 19 9 6 15 28 23
:2 10 6 :4 1b :2 3 :2 1 5 :4 1 b
3 f 1b f :2 20 f :3 3 f
1b f :2 20 f :3 3 f 1b f
:2 1e f :3 3 f 1b f :2 1e f
:3 3 f 1b f :2 24 f :3 3 f
1b f :2 1f f :3 3 f 1b f
:2 20 f :2 3 18 :2 1 3 f 18
17 :2 f :2 3 d 3 :5 6 10 6
3 15 :4 9 6 10 6 3 18
15 :4 9 6 10 6 3 16 15
:4 9 6 10 6 3 16 15 :4 9
6 10 6 3 1b 15 :4 9 6
10 6 3 17 15 :4 9 6 10
6 18 15 :2 3 :5 6 :2 11 1e 29
:2 6 19 :2 3 :2 1 5 :5 1 a 19
20 2c 20 :2 31 20 :2 19 18 37
3e :2 1 3 :3 f :2 3 f 18 17
:2 f 3 d 1c 2c 42 49 6
3 12 6 10 6 20 :2 d 3
:3 1 :5 6 :2 11 1e 29 :2 6 19 :3 3
a 3 :2 1 5 :4 1 b 3 f
1b f :2 20 f :3 3 f 1b f
:2 25 f :3 3 f 1b f :2 1e f
:3 3 f 1b f :2 24 f :2 3 1a
:2 1 3 :3 f :2 3 :3 f :2 3 f 18
17 :2 f :2 3 f 18 17 :2 f :2 3
f 18 17 :2 f :2 3 f 18 17
:2 f :2 3 f 18 17 :2 f 3 d
f 1a 21 23 3c 43 45 d
19 1f d 1d 20 30 d f
16 d f 1b 1d d f 1b
6 9 17 :3 14 9 13 :2 9 13
:2 9 13 1b :2 13 :2 9 13 9 22
:2 6 9 11 :3 e 9 13 :2 9 13
:2 9 13 1b :2 13 :2 9 13 1b :2 13
9 16 :2 6 3 12 6 10 6
9 13 :2 9 13 1b :2 13 :2 9 13
9 20 :2 d 3 :3 1 :5 6 :2 11 1e
29 31 39 41 :2 6 19 :2 3 :2 1
5 :4 1 b 3 f 1b f :2 1e
f :3 3 f 1b f :2 20 f :3 3
f 1b f :2 20 f :3 3 f 1b
f :2 1e f :3 3 f 1b f :2 1e
f :3 3 f 1b f :2 24 f :3 3
f 1b f :2 21 f :3 3 f 1b
f :2 1f f :3 3 f 1b f :2 20
f :3 3 f 1b f :2 22 f :3 3
f 1b f :2 27 f :2 3 17 :2 1
3 :3 f :2 3 :3 f :2 3 10 18 20
26 2c 37 3e :3 3 11 1f :2 11
:2 3 12 1a 26 2c :2 3 f a
16 a 16 a 16 a 16 a
16 a 16 a 16 a 3 :4 6
16 1b 1d :2 1b :2 6 d 11 15
25 d 19 21 29 3b 40 42
d 6 1f 6 e 6 :4 3 12
1f 23 29 2f 3a d 11 1b
22 27 2d 35 e 14 1c 24
30 d 13 1e 27 2e 36 3d
6 3 12 6 :2 11 1e 29 :2 6
23 :2 d 3 :5 1 5 :4 1 b 1b
20 2c 20 :2 2f 20 :2 1b 1a :2 1
:2 a 14 1a a f a 3 :2 1
5 :4 1 b 3 f 1b f :2 1e
f :3 3 f 1b f :2 20 f :3 3
f 1b f :2 20 f :3 3 f 1b
f :2 1e f :3 3 f 1b f :2 1e
f :3 3 f 1b f :2 24 f :3 3
f 1b f :2 21 f :3 3 f 1b
f :2 1f f :3 3 f 1b f :2 20
f :3 3 f 1b f :2 22 f :3 3
f 1b f :2 27 f :2 3 1a :2 1
3 :3 f :2 3 10 18 20 26 2c
37 3e :3 3 11 1f :2 11 :2 3 12
1a 26 2c :2 3 12 d 19 d
19 d 19 d 19 d 19 d
19 d 19 d 6 :2 d 1b d
1b d 1b d 1b d 1b d
1b d 1b d 1b d 1b d
1b d 1b d 12 6 3 12
6 :2 11 1e 29 :2 6 23 :2 d 3
:5 1 5 :5 1 a 16 0 1d :2 1
3 :3 d 3 a 15 22 31 :2 3
a 3 :2 1 5 :4 1 b 15 1e
:2 15 26 2b 2f :2 26 37 44 :2 37
14 :2 1 3 :3 8 3 d 15 1f
2d 36 6 d 19 26 39 3e
6 3 12 d 18 25 2f 6
12 1b 1f 27 e 14 1b 6
20 :2 d 3 :3 1 3 b 3 :2 1
5 :4 1 b 3 11 1a 11 :2 1e
11 :3 3 11 1d 11 :2 20 11 :3 3
11 21 11 :2 26 11 :3 3 11 :3 3
11 :3 3 11 1a 11 :2 1f 11 :3 3
11 :3 3 11 :3 3 11 :3 3 11 :3 3
11 :3 3 11 :3 3 11 :3 3 11 :3 3
11 :3 3 d 11 :2 3 15 :2 1 3
11 1a 11 :2 1d :3 11 :2 3 11 1b
11 :2 1e :3 11 :2 3 11 21 11 :2 2a
:3 11 :2 3 11 1a 11 :2 1e :3 11 :2 3
11 1f 11 :2 24 :3 11 :2 3 11 1a
11 :2 1e :3 11 :2 3 11 19 11 :2 22
:3 11 :2 3 11 21 11 :2 2c :3 11 :2 3
:3 11 :2 3 :3 11 :2 3 11 1a 11 :2 1e
:3 11 :2 3 11 1a 11 :2 1e :3 11 :2 3
11 1a 11 :2 1e :3 11 :2 3 11 1a
11 :2 1e :3 11 :2 3 :3 11 :2 3 :3 11 :2 3
:3 11 :2 3 11 1a 19 :2 11 :2 3 :3 11
:2 3 c :2 f 3 a c 10 12
16 18 22 24 29 2b 31 33
38 3a 44 46 a 10 16 21
2b 33 3a 46 a 16 19 21
24 34 a c 13 a c 13
15 a c 13 15 a c 18
1a a c 18 1a 3 a 11
1e 25 29 2e 4c :2 a 10 3
6 14 :3 11 6 :2 11 1e 29 :2 6
1c :2 3 a 1a 21 2b 38 a
1a 21 2b a 14 a 3 14
1f 2e 34 41 46 :2 6 b :2 6
9 15 1b 22 28 2a :2 1b b
14 17 :2 b 1b 1e 23 2b :2 23
2f 32 :2 1e :2 b 37 3a 3f 47
:2 3f 4f 52 :2 3a :2 b :2 15 9 1a
25 34 3a 47 4c c 9 18
:2 c 26 :2 13 9 :3 6 9 e 10
12 :2 e 9 c e 10 :2 e :2 c
14 :2 9 6 a :2 3 12 25 20
:2 d 3 :3 1 3 c 3 6 11
13 :2 11 6 f 6 15 6 f
6 :5 3 f 13 16 19 20 27
2e 38 3e 6 d 16 20 25
6 d 13 19 1f 25 2b 31
3a 40 46 :3 3 c 16 1c :3 3
:2 8 13 1b :2 3 :5 6 :2 d 1e 28
30 :2 6 19 :2 3 :5 6 :2 d 1e 28
35 :2 6 17 :2 3 :5 6 :2 d 1e 28
3b :2 6 1c :2 3 :5 6 :2 d 1e 28
36 :2 6 1b :2 3 :5 6 :2 d 1e 28
34 :2 6 1c :2 3 :5 6 :2 d 1e 28
33 :2 6 19 :2 3 :5 6 :2 d 1e 28
34 :2 6 1b :2 3 :5 6 :2 d 1e 28
34 :2 6 1b :2 3 :5 6 :2 d 1e 28
34 :2 6 1b :2 3 :5 6 :2 d 1e 28
34 :2 6 1b :2 3 :5 6 :2 d 1e 28
34 :2 6 1a :2 3 :5 6 :2 d 1e 28
34 :2 6 1c :3 3 :2 6 19 20 29
35 :2 3 6 b d :2 b 6 :2 b
14 1a 22 :2 6 f :3 3 b 3
:2 1 5 :4 1 b 3 d :3 3 9
d :2 3 13 :2 1 3 :3 9 3 d
f 1c d 15 d f 14 6
3 12 6 :2 11 1e 29 3b 43
:2 3b :2 6 20 :2 d 3 :3 1 :5 6 :2 b
14 1a 22 :2 6 14 :3 3 c 3
:2 1 5 :4 1 b 19 25 29 :2 19
18 :2 1 6 :2 f :4 6 :2 f :6 6 :2 f
:6 6 :2 f :6 6 :2 f :6 6 :2 f :6 6 :2 f
:6 6 :2 f :6 6 :2 f :6 6 :2 f :6 6 :2 f
1a 6 24 6 :2 f 1a 6 :4 3
:2 1 5 :4 1 b 3 12 :3 3 e
12 :2 3 16 :2 1 3 :3 a :2 3 :3 c
:2 3 :3 c :2 3 :3 5 3 a e 12
22 30 3 f 25 29 34 b
15 21 :2 3 8 :2 3 8 :2 5 :2 3
c 18 :2 21 27 :2 30 36 :2 3f 4a
:2 53 5f :2 68 74 :2 7d 87 :2 90 c
:2 15 20 :2 29 37 :2 40 4d :2 56 62
:2 6b 71 :2 7a 82 :2 8b c :2 15 21
:2 2a 37 :2 40 4c :2 55 61 :2 6a 75
:2 7e :4 6 10 17 10 :2 6 13 :3 6
b d f :2 b 6 12 27 2b
30 36 9 14 20 2c 36 9
14 22 2f 9 f 17 1e 2a
9 15 21 2c 39 e 18 1b
24 2a 33 9 12 1d 26 32
3b 9 12 1c 25 9 12 1d
26 34 3d 4a 53 9 12 18
21 29 32 9 12 1e 27 34
3d 49 52 9 12 1d 26 33
3c 6 3 7 1 3 9 :3 3
b 3 :2 1 5 :4 1 b 3 f
13 :3 3 13 :2 3 18 :2 1 3 :2 9
13 9 :2 3 9 12 11 :2 9 :2 3
10 :3 3 :2 e 14 32 35 :2 3e :2 14
:2 3 6 :2 f :3 6 3 :2 e 14 :2 3
d 14 19 22 f 14 19 22
36 3b 44 f 14 19 22 36
3b 44 f 14 19 22 36 3b
44 d 18 :2 6 :3 9 19 :2 9 19
:2 9 19 :2 9 19 20 25 :2 2e :2 20
34 36 :2 19 :2 9 19 20 30 35
:2 3e :2 30 :2 20 45 47 :2 19 :2 9 19
20 25 :2 2e :2 20 34 36 :2 19 :2 9
19 :2 9 19 :2 9 19 :2 9 19 :2 9
19 :2 9 19 1e :2 27 :2 19 :2 9 19
:2 9 19 :2 9 19 :2 9 19 :2 9 19
1a :2 19 :2 9 19 1a :2 19 :2 9 19
:2 9 19 :2 9 19 :2 9 19 :2 9 19
:2 9 19 :2 9 19 :2 9 19 :2 9 19
:2 9 19 :2 9 19 :2 9 19 :2 9 19
:2 9 19 :2 9 19 :2 9 19 :2 9 19
:2 9 19 :2 9 19 :2 9 19 :2 9 19
9 :3 6 :3 9 15 :2 9 15 19 29
:2 19 36 :2 15 :2 9 15 19 29 :2 19
36 :2 15 :2 9 15 :2 9 15 :2 9 15
:2 9 15 9 :3 6 :3 9 13 :2 9 13
:2 9 13 18 :2 21 :2 13 :2 9 13 9
:3 6 :3 9 13 :2 9 13 :2 9 13 18
:2 21 :2 13 :2 9 13 9 :3 6 :3 9 13
:2 9 13 :2 9 13 18 :2 21 :2 13 :2 9
13 9 :3 6 :3 9 13 :2 9 13 :2 9
13 18 :2 21 :2 13 :2 9 13 9 :3 6
:3 9 13 :2 9 13 :2 9 13 18 :2 21
:2 13 :2 9 13 9 :3 6 :3 9 1b :2 9
1b :2 9 1b :2 9 1b 20 :2 29 :2 1b
:2 9 1b 20 :2 29 :2 1b :2 9 1b 20
:2 29 :2 1b :2 9 1b 20 :2 29 :2 1b :2 9
1b 20 :2 29 :2 1b :2 9 1b 9 :3 6
:3 9 16 :2 9 16 :2 9 16 :2 9 16
1b :2 24 :2 16 :2 9 16 1b :2 24 :2 16
:2 9 16 1b :2 24 :2 16 :2 9 16 1b
:2 24 :2 16 :2 9 16 :2 1f :2 9 16 :2 1f
:2 9 16 :2 9 16 9 :3 6 :2 f 16
6 1f :2 3 :2 1 5 :4 1 b 3
13 17 :3 3 10 :3 3 10 :3 3 10
:3 3 10 :2 3 :3 1 3 d 16 15
:2 d 3 :2 a 11 16 1e 11 18
1e 23 2b 18 1e 23 2b :2 a
19 1f 28 :2 3 :2 c 6 18 :2 21
:2 6 18 :2 6 18 :2 6 18 :2 6 18
:2 6 18 :2 6 18 :2 6 18 1d :2 26
:2 18 :2 6 18 :2 21 :2 6 18 :2 21 :2 6
18 :2 21 :2 6 18 :2 6 18 :2 21 :2 6
18 :2 21 :2 6 18 :2 21 :2 6 18 :2 21
6 :2 3 a 17 1d a 19 25
33 38 41 3 1 10 23 1e
:2 b 1 5 :4 1 b 3 11 :3 3
11 :3 3 11 :3 3 11 :3 3 11 :2 3
17 :2 1 3 :3 c 3 7 15 1e
38 3d 4b 3 c 3 14 22
3c 41 4f 55 57 :2 6 13 1d
:2 6 9 :2 12 :4 9 11 1b 29 33
3d :2 9 22 :2 6 9 :2 12 :3 9 :2 10
16 1f 10 15 1e 10 15 23
29 2b 9 21 :2 6 3 7 3
:2 a 17 a 13 a 13 a 10
a f 3 :2 1 5 :4 1 b 3
d :3 3 9 d :2 3 1a :2 1 3
a 13 12 :2 a :2 3 :3 a :2 3 :3 a
:2 3 :3 a :2 3 :3 a 3 d 1a 20
:2 1a 18 :2 3 :5 9 12 18 1b 1f
:2 1b :2 12 23 26 :2 12 9 1b 9
12 9 :4 6 :6 3 7 15 1e 31
36 3f 3 c 3 10 15 19
1f 29 10 17 1d 25 2d :2 10
16 18 10 9 c 16 :3 13 c
17 22 25 :2 17 2b 2e :2 17 32
35 3d :2 35 :2 17 43 46 :2 17 :2 c
1f :2 9 c 13 16 :2 13 1b 22
25 :2 22 :3 c 17 22 25 :2 17 2b
2e :2 17 32 35 3d :2 35 :2 17 43
46 :2 17 5d 60 68 :2 60 :2 17 70
72 :2 17 88 8b 93 :2 8b :2 17 9b
9e :2 17 :2 c 27 :2 9 6 15 28
23 :2 10 6 :4 3 7 3 :5 6 11
:3 6 11 :2 6 18 :2 3 :2 1 5 :4 1
b 3 d :3 3 9 d :2 3 16
:2 1 3 :3 5 3 d 1a 20 :2 1a
18 :2 3 :5 9 12 18 1b 1f :2 1b
:2 12 23 26 :2 12 9 1b 9 12
9 :4 6 :6 3 7 15 17 1c 1e
23 25 15 22 25 2e 15 17
1d 15 17 15 17 1d 1f 15
17 3 c 3 17 :2 10 16 18
:3 10 11 21 28 10 18 9 10
1d 24 33 39 3b :2 9 14 1f
22 :2 24 :2 14 28 2b :2 14 2f 32
3a :2 3c :2 32 :2 14 40 43 :2 14 :2 9
6 15 9 14 1f 22 :2 24 :2 14
28 2b :2 14 2f 32 3a :2 3c :2 32
:2 14 40 43 :2 14 :2 9 23 :2 10 6
:4 3 7 3 :2 1 5 :e 1
fde
4
0 :3 1 :9 3 :9 4
:9 6 :7 8 :3 b 0
:3 b :e d e :2 d
:5 e :2 d :2 e :3 d
:2 c f :4 b :3 12
0 :3 12 :e 14 15
:2 14 :5 15 :2 14 :2 15
:3 14 :2 13 16 :4 12
:2 1c :4 1d :9 1e :9 1f
:9 20 1c :2 20 :2 1c
:a 22 :a 23 :a 24 :10 27
:6 2b 2c :4 2d 2b
2a 2e :9 30 :4 2e
:3 27 :c 34 :8 36 37
34 :c 37 :8 39 3a
37 34 :13 3a :8 3c
3d 3a 34 :13 3d
:8 3f 40 3d 34
:c 40 :8 42 43 40
34 :c 43 :8 45 46
43 34 :c 46 :8 48
46 :3 34 :5 4c :a 4e
:3 4c 27 :3 53 51
:3 27 :3 57 :2 25 59
:4 1c 5f :9 60 :9 61
:9 62 :9 63 :9 64 :9 65
:9 66 :9 67 :9 68 :3 5f
:a 6a :a 6b :a 6c :a 6d
:a 6e :a 6f :a 70 :a 71
:a 72 :4 75 :4 79 7a
:2 7b 79 :9 7d :9 7e
:9 7f :9 80 :9 81 :9 82
:9 83 85 :2 86 :2 87
:2 88 :2 89 :2 8a :2 8b
:2 8c :2 8d 85 77
:6 8f :6 75 :2 73 94
:4 5f 97 :9 98 :9 99
:9 9a :9 9b :9 9c :9 9d
:9 9e :3 97 :7 a0 :3 a3
:4 a5 :3 a6 a7 a5
:4 a7 :3 a8 a9 a7
a5 :4 a9 :3 aa ab
a9 a5 :4 ab :3 ac
ad ab a5 :4 ad
:3 ae af ad a5
:4 af :3 b0 b1 af
a5 :4 b1 :3 b2 b1
:3 a5 :4 b5 :7 b6 :3 b5
:2 a1 b9 :4 97 :10 bc
:5 be :7 bf :6 c3 c2
c4 :3 c5 :4 c4 :3 c0
:4 c8 :7 c9 :3 c8 :3 cc
:2 c0 ce :4 bc d1
:9 d2 :9 d3 :9 d4 :9 d5
:3 d1 :5 d7 :5 d8 :7 d9
:7 da :7 db :7 dc :7 dd
:8 e1 :3 e2 :4 e3 :3 e4
:4 e5 :3 e6 e1 :5 e8
:3 e9 :3 ea :6 eb :3 ec
:3 e8 :5 ef :3 f0 :3 f1
:6 f2 :6 f3 :3 ef e0
f5 :3 f6 :3 f7 :6 f8
:3 f9 :4 f5 :3 de :4 fc
:a fd :3 fc :2 de 100
:4 d1 106 :9 107 :9 108
:9 109 :9 10a :9 10b :9 10c
:9 10d :9 10e :9 10f :9 110
:9 111 :3 106 :5 113 :5 114
:a 117 :6 119 :7 11b 11e
:2 11f :2 120 :2 121 :2 122
:2 123 :2 124 :2 125 126
11e :b 128 :4 129 :2 12a
:5 12b 12c 129 128
:3 12e 12d :3 128 :6 132
:7 133 :5 134 :7 135 132
131 136 :7 137 :4 136
:5 115 13a :4 106 :d 140
144 :3 145 :2 146 147
144 :2 142 149 :4 140
14f :9 150 :9 151 :9 152
:9 153 :9 154 :9 155 :9 156
:9 157 :9 158 :9 159 :9 15a
:3 14f :5 15c :a 15f :6 161
:7 163 168 :2 169 :2 16a
:2 16b :2 16c :2 16d :2 16e
:2 16f 170 168 172
:2 173 :2 174 :2 175 :2 176
:2 177 :2 178 :2 179 :2 17a
:2 17b :2 17c :2 17d :2 17e
172 165 180 :7 182
:4 180 :5 15d 186 :4 14f
:3 18c 0 :3 18c :5 18e
:5 190 :3 191 :2 18f 192
:4 18c :11 198 :5 19a :6 19e
:6 19f 19d 1a0 :5 1a1
:4 1a2 :3 1a3 1a2 :4 1a0
:3 19b :3 1a6 :2 19b 1a8
:4 198 1ae :9 1af :9 1b0
:9 1b1 :4 1b2 :4 1b3 :9 1b4
:4 1b5 :4 1b6 :4 1b7 :4 1b8
:4 1b9 :4 1ba :4 1bb :4 1bc
:4 1bd :5 1be :3 1ae :a 1c1
:a 1c2 :a 1c3 :a 1c4 :a 1c5
:a 1c6 :a 1c7 :a 1c8 :5 1c9
:5 1ca :a 1cb :a 1cc :a 1cd
:a 1ce :5 1cf :5 1d0 :5 1d1
:7 1d2 :5 1d3 :5 1d6 :10 1d9
:8 1da :6 1db :3 1dc :4 1dd
:4 1de :4 1df :4 1e0 1d9
:7 1e3 1e4 :2 1e5 1e3
:5 1e7 :7 1e8 :3 1e7 :5 1ec
:4 1ed :2 1ee 1ef 1ec
:7 1f3 :3 1f6 1f7 :8 1f9
:1d 1fa :3 1f9 :7 1fd 1fc
1fe :2 200 :4 1fe :3 1f7
:7 202 :5 203 :2 204 :3 203
1f7 206 :2 1f2 :6 207
:3 1d4 :3 20a :5 20d :3 20e
20d :3 211 210 :3 20d
:a 215 :5 216 :b 217 :2 215
:6 21a :7 21d :4 220 :8 221
:3 220 :4 224 :8 225 :3 224
:4 227 :8 228 :3 227 :4 22a
:8 22b :3 22a :4 22e :8 22f
:3 22e :4 231 :8 232 :3 231
:4 234 :8 235 :3 234 :4 237
:8 238 :3 237 :4 23a :8 23b
:3 23a :4 23d :8 23e :3 23d
:4 240 :8 241 :3 240 :4 243
:8 244 :3 243 :9 247 :5 24a
:8 24c :3 24a :3 250 :2 1d4
252 :4 1ae 258 :4 259
:5 25a :3 258 :5 25c :3 260
:2 261 :3 262 260 25f
263 :b 264 :4 263 :3 25d
:4 267 :8 268 :3 267 :3 26b
:2 25d 26d :4 258 :9 273
:6 276 :6 277 :2 276 :6 27c
:2 276 :6 27d :2 276 :6 27e
:2 276 :6 27f :2 276 :6 280
:2 276 :6 281 :2 276 :6 282
:2 276 :6 283 :2 276 :5 284
283 :5 286 285 :3 276
:2 275 289 :4 273 28f
:4 290 :5 291 :3 28f :5 293
:5 294 :5 295 :5 296 :6 299
:4 29b :3 29c 29b :3 29e
:2 2a0 :2 2a1 2a0 2a5
:16 2a6 :15 2a7 :12 2a8 :3 2a6
:5 2a9 :4 2ab :7 2ad :5 2af
:5 2b0 :4 2b1 :5 2b2 :5 2b3
:6 2b4 :6 2b5 :4 2b6 :8 2b7
:6 2b8 :8 2b9 :6 2ba 2af
2a5 2bc 297 :4 2bd
:3 2bf :2 297 2c1 :4 28f
2c7 :5 2c8 :4 2c9 :3 2c7
:6 2cb :7 2cc :4 2cf :c 2d1
:6 2d3 :6 2d5 :4 2d7 :7 2d8
:7 2d9 :7 2da :2 2db 2d7
:3 2dd :3 2de :3 2df :3 2e0
:d 2e1 :10 2e2 :d 2e3 :3 2e4
:3 2e5 :3 2e6 :3 2e7 :3 2e8
:8 2e9 :3 2ea :3 2eb :3 2ec
:3 2ed :6 2ee :6 2ef :3 2f0
:3 2f1 :3 2f2 :3 2f3 :3 2f4
:3 2f5 :3 2f6 :3 2f7 :3 2f8
:3 2f9 :3 2fa :3 2fb :3 2fc
:3 2fd :3 2fe :3 2ff :3 300
:3 301 :3 302 :3 303 :3 304
:2 2dd :3 307 :3 308 :a 309
:a 30a :3 30b :3 30c :3 30d
:3 30e :2 307 :3 311 :3 312
:3 313 :8 314 :3 315 :2 311
:3 318 :3 319 :3 31a :8 31b
:3 31c :2 318 :3 31f :3 320
:3 321 :8 322 :3 323 :2 31f
:3 326 :3 327 :3 328 :8 329
:3 32a :2 326 :3 32d :3 32e
:3 32f :8 330 :3 331 :2 32d
:3 334 :3 335 :3 336 :3 337
:8 338 :8 339 :8 33a :8 33b
:8 33c :3 33d :2 334 :3 340
:3 341 :3 342 :3 343 :8 344
:8 345 :8 346 :8 347 :5 348
:5 349 :3 34a :3 34b :2 340
:5 34e :3 2d3 :2 2cd 352
:4 2c7 358 :5 359 :4 35a
:4 35b :4 35c :4 35d 359
:2 358 :7 35f 362 :4 363
:5 364 :4 365 366 :4 367
362 :3 369 :5 36a :3 36b
:3 36c :3 36d :3 36e :3 36f
:3 370 :8 371 :5 372 :5 373
:5 374 :3 375 :5 376 :5 377
:5 378 :5 379 :2 369 :3 37c
:6 37d 37c 360 :6 37f
380 :4 358 386 :4 387
:4 388 :4 389 :4 38a :4 38b
:3 386 :5 38d :6 390 391
:2 390 :8 393 :5 396 :6 399
:8 39a :3 399 :6 39e 3a0
:3 3a1 :3 3a2 :5 3a3 3a0
:3 39e 391 3a7 390
3a9 :2 3aa :2 3ab :2 3ac
:2 3ad :2 3ae 3a9 :2 38e
3b0 :4 386 3b6 :4 3b7
:5 3b8 :3 3b6 :7 3ba :5 3bb
:5 3bc :5 3bd :5 3be :8 3c0
:4 3c3 :e 3c4 3c3 :3 3c6
3c5 :3 3c3 :2 3c2 :4 3c0
:6 3cc 3cd :2 3cc :5 3d1
:5 3d2 3d3 :3 3d4 3d5
3d1 :5 3d7 :17 3d8 :3 3d7
:c 3db :2d 3dc :3 3db 3cf
:6 3df :4 3cd 3e2 3cc
:4 3e4 :4 3e5 :4 3e6 :3 3e4
:2 3ca 3e9 :4 3b6 3ef
:4 3f0 :5 3f1 :3 3ef :5 3f3
:8 3f5 :4 3f8 :e 3f9 3f8
:3 3fb 3fa :3 3f8 :2 3f7
:4 3f5 :7 401 :4 402 :3 403
:2 404 :4 405 :2 406 407
:2 401 40b 40c :3 40d
40e 40f 410 :3 411
:2 412 40b :7 415 :1b 417
409 419 :1b 41a :4 419
:4 407 41d 401 :2 3ff
41f :4 3ef :4 b :6 1

3eb0
4
:3 0 1 :3 0 2
:3 0 3 :6 0 1
:2 0 a :2 0 :2 5
:3 0 6 :3 0 7
:2 0 3 6 8
:6 0 8 :4 0 c
9 a fd8 4
:6 0 d :2 0 9
5 :3 0 6 :3 0
7 f 11 :6 0
b :4 0 15 12
13 fd8 9 :6 0
20 24 fd8 d
5 :3 0 6 :3 0
b 18 1a :6 0
e :4 0 1e 1b
1c fd8 c :6 0
f :3 0 10 :3 0
11 :3 0 12 :3 0
21 22 :3 0 23
:7 0 13 :3 0 14
:a 0 4f 2 :7 0
15 :4 0 6 :3 0
29 2a 0 4f
27 2b :2 0 15
:3 0 16 :4 0 17
:2 0 18 :3 0 f
2f 31 :3 0 17
:2 0 19 :3 0 1a
:2 0 12 34 36
14 33 38 :3 0
17 :2 0 1b :4 0
17 3a 3c :3 0
17 :2 0 19 :3 0
1a :2 0 1a 3f
41 1c 3e 43
:3 0 17 :2 0 1c
:3 0 1f 45 47
:3 0 48 :2 0 4a
22 4e :3 0 4e
14 :4 0 4e 4d
4a 4b :6 0 4f
1 0 27 2b
4e fd8 :2 0 13
:3 0 1d :a 0 7a
3 :7 0 15 :4 0
6 :3 0 54 55
0 7a 52 56
:2 0 15 :3 0 1e
:4 0 17 :2 0 4
:3 0 24 5a 5c
:3 0 17 :2 0 19
:3 0 1a :2 0 27
5f 61 29 5e
63 :3 0 17 :2 0
1b :4 0 2c 65
67 :3 0 17 :2 0
19 :3 0 1a :2 0
2f 6a 6c 31
69 6e :3 0 17
:2 0 9 :3 0 34
70 72 :3 0 73
:2 0 75 37 79
:3 0 79 1d :4 0
79 78 75 76
:6 0 7a 1 0
52 56 79 fd8
:2 0 13 :3 0 1f
:a 0 1bf 4 :7 0
83 84 0 39
6 :3 0 20 :7 0
80 7f :3 0 8c
8d 0 3b 22
:3 0 23 :2 0 4
24 :3 0 24 :2 0
1 85 87 :3 0
21 :7 0 89 88
:3 0 95 96 0
3d 22 :3 0 26
:2 0 4 24 :3 0
24 :2 0 1 8e
90 :3 0 25 :7 0
92 91 :3 0 41
:2 0 3f 22 :3 0
28 :2 0 4 24
:3 0 24 :2 0 1
97 99 :3 0 27
:7 0 9b 9a :3 0
15 :3 0 29 :3 0
9d 9f 0 1bf
7d a0 :2 0 ad
ae 0 46 22
:3 0 2b :2 0 4
a3 a4 0 24
:3 0 24 :2 0 1
a5 a7 :3 0 a8
:7 0 ab a9 0
1bd 0 2a :6 0
b7 b8 0 48
22 :3 0 2d :2 0
4 24 :3 0 24
:2 0 1 af b1
:3 0 b2 :7 0 b5
b3 0 1bd 0
2c :6 0 2f :2 0
4a 22 :3 0 23
:2 0 4 24 :3 0
24 :2 0 1 b9
bb :3 0 bc :7 0
bf bd 0 1bd
0 2e :6 0 21
:3 0 4c c1 c2
:3 0 25 :3 0 2f
:2 0 4e c5 c6
:3 0 c3 c8 c7
:2 0 27 :3 0 2f
:2 0 50 cb cc
:3 0 c9 ce cd
:2 0 2b :3 0 2d
:3 0 23 :3 0 2a
:3 0 2c :3 0 2e
:3 0 22 :3 0 26
:3 0 25 :3 0 28
:3 0 27 :4 0 30
1 :8 0 dc 52
ec 31 :3 0 32
:3 0 33 :3 0 de
df 0 c :3 0
34 :4 0 25 :3 0
27 :3 0 54 e0
e5 :2 0 e7 59
e9 5b e8 e7
:2 0 ea 5d :2 0
ec 0 ec eb
dc ea :6 0 1af
4 :3 0 20 :3 0
35 :2 0 36 :4 0
61 ef f1 :3 0
2c :3 0 37 :2 0
38 :4 0 64 f4
f6 :3 0 f2 f8
f7 :2 0 32 :3 0
33 :3 0 fa fb
0 c :3 0 39
:4 0 25 :3 0 67
fc 100 :2 0 103
3a :3 0 6b 19b
20 :3 0 35 :2 0
3b :4 0 6f 105
107 :3 0 2c :3 0
3c :2 0 3b :4 0
74 10a 10c :3 0
108 10e 10d :2 0
32 :3 0 33 :3 0
110 111 0 c
:3 0 3d :4 0 25
:3 0 77 112 116
:2 0 119 3a :3 0
7b 11a 10f 119
0 19c 20 :3 0
35 :2 0 3e :4 0
7f 11c 11e :3 0
2c :3 0 3c :2 0
3e :4 0 84 121
123 :3 0 11f 125
124 :2 0 2c :3 0
3c :2 0 3f :4 0
89 128 12a :3 0
126 12c 12b :2 0
32 :3 0 33 :3 0
12e 12f 0 c
:3 0 40 :4 0 25
:3 0 8c 130 134
:2 0 137 3a :3 0
90 138 12d 137
0 19c 20 :3 0
35 :2 0 41 :4 0
94 13a 13c :3 0
2c :3 0 37 :2 0
42 :4 0 97 13f
141 :3 0 13d 143
142 :2 0 2c :3 0
37 :2 0 43 :4 0
9a 146 148 :3 0
144 14a 149 :2 0
32 :3 0 33 :3 0
14c 14d 0 c
:3 0 44 :4 0 25
:3 0 9d 14e 152
:2 0 155 3a :3 0
a1 156 14b 155
0 19c 20 :3 0
35 :2 0 45 :4 0
a5 158 15a :3 0
2c :3 0 37 :2 0
46 :4 0 a8 15d
15f :3 0 15b 161
160 :2 0 32 :3 0
33 :3 0 163 164
0 c :3 0 47
:4 0 25 :3 0 ab
165 169 :2 0 16c
3a :3 0 af 16d
162 16c 0 19c
20 :3 0 35 :2 0
3f :4 0 b3 16f
171 :3 0 2c :3 0
3c :2 0 3f :4 0
b8 174 176 :3 0
172 178 177 :2 0
32 :3 0 33 :3 0
17a 17b 0 c
:3 0 47 :4 0 25
:3 0 bb 17c 180
:2 0 183 3a :3 0
bf 184 179 183
0 19c 20 :3 0
35 :2 0 48 :4 0
c3 186 188 :3 0
2c :3 0 37 :2 0
43 :4 0 c6 18b
18d :3 0 189 18f
18e :2 0 32 :3 0
33 :3 0 191 192
0 c :3 0 47
:4 0 25 :3 0 c9
193 197 :2 0 199
cd 19a 190 199
0 19c f9 103
0 19c cf 0
1af 21 :3 0 2e
:3 0 3c :2 0 d9
19f 1a0 :3 0 32
:3 0 33 :3 0 1a2
1a3 0 c :3 0
49 :4 0 25 :3 0
27 :3 0 2e :3 0
dc 1a4 1aa :2 0
1ac e2 1ad 1a1
1ac 0 1ae e4
0 1af e6 1b4
2a :4 0 1b0 1b1
0 1b3 ea 1b5
cf 1af 0 1b6
0 1b3 0 1b6
ec 0 1ba 15
:3 0 2a :3 0 1b8
:2 0 1ba ef 1be
:3 0 1be 1f :3 0
f2 1be 1bd 1ba
1bb :6 0 1bf 1
0 7d a0 1be
fd8 :2 0 4a :a 0
2df 6 :7 0 1cc
1cd 0 f6 22
:3 0 2b :2 0 4
1c3 1c4 0 24
:3 0 24 :2 0 1
1c5 1c7 :3 0 4b
:7 0 1c9 1c8 :3 0
1d5 1d6 0 f8
22 :3 0 26 :2 0
4 24 :3 0 24
:2 0 1 1ce 1d0
:3 0 4c :7 0 1d2
1d1 :3 0 1de 1df
0 fa 22 :3 0
26 :2 0 4 24
:3 0 24 :2 0 1
1d7 1d9 :3 0 4d
:7 0 1db 1da :3 0
1e7 1e8 0 fc
22 :3 0 26 :2 0
4 24 :3 0 24
:2 0 1 1e0 1e2
:3 0 4e :7 0 1e4
1e3 :3 0 1f0 1f1
0 fe 22 :3 0
26 :2 0 4 24
:3 0 24 :2 0 1
1e9 1eb :3 0 4f
:7 0 1ed 1ec :3 0
1f9 1fa 0 100
22 :3 0 26 :2 0
4 24 :3 0 24
:2 0 1 1f2 1f4
:3 0 50 :7 0 1f6
1f5 :3 0 202 203
0 102 22 :3 0
26 :2 0 4 24
:3 0 24 :2 0 1
1fb 1fd :3 0 51
:7 0 1ff 1fe :3 0
20b 20c 0 104
22 :3 0 26 :2 0
4 24 :3 0 24
:2 0 1 204 206
:3 0 52 :7 0 208
207 :3 0 108 :2 0
106 22 :3 0 26
:2 0 4 24 :3 0
24 :2 0 1 20d
20f :3 0 53 :7 0
211 210 :3 0 213
:2 0 2df 1c1 214
:2 0 221 222 0
112 22 :3 0 28
:2 0 4 217 218
0 24 :3 0 24
:2 0 1 219 21b
:3 0 21c :7 0 21f
21d 0 2dd 0
54 :6 0 22b 22c
0 114 22 :3 0
23 :2 0 4 24
:3 0 24 :2 0 1
223 225 :3 0 226
:7 0 229 227 0
2dd 0 2e :6 0
235 236 0 116
22 :3 0 2b :2 0
4 24 :3 0 24
:2 0 1 22d 22f
:3 0 230 :7 0 233
231 0 2dd 0
55 :6 0 23f 240
0 118 22 :3 0
2b :2 0 4 24
:3 0 24 :2 0 1
237 239 :3 0 23a
:7 0 23d 23b 0
2dd 0 56 :6 0
249 24a 0 11a
22 :3 0 2b :2 0
4 24 :3 0 24
:2 0 1 241 243
:3 0 244 :7 0 247
245 0 2dd 0
57 :6 0 253 254
0 11c 22 :3 0
2b :2 0 4 24
:3 0 24 :2 0 1
24b 24d :3 0 24e
:7 0 251 24f 0
2dd 0 58 :6 0
25d 25e 0 11e
22 :3 0 2b :2 0
4 24 :3 0 24
:2 0 1 255 257
:3 0 258 :7 0 25b
259 0 2dd 0
59 :6 0 267 268
0 120 22 :3 0
2b :2 0 4 24
:3 0 24 :2 0 1
25f 261 :3 0 262
:7 0 265 263 0
2dd 0 5a :6 0
2f :2 0 122 22
:3 0 2b :2 0 4
24 :3 0 24 :2 0
1 269 26b :3 0
26c :7 0 26f 26d
0 2dd 0 5b
:6 0 4b :3 0 124
271 272 :3 0 28
:3 0 23 :3 0 54
:3 0 2e :3 0 22
:3 0 2b :3 0 4b
:4 0 5c 1 :8 0
2cd 55 :3 0 1f
:3 0 36 :4 0 2e
:3 0 4c :3 0 54
:3 0 126 27d 282
27c 283 0 2cd
56 :3 0 1f :3 0
3b :4 0 2e :3 0
4d :3 0 54 :3 0
12b 286 28b 285
28c 0 2cd 57
:3 0 1f :3 0 3e
:4 0 2e :3 0 4f
:3 0 54 :3 0 130
28f 294 28e 295
0 2cd 58 :3 0
1f :3 0 41 :4 0
2e :3 0 50 :3 0
54 :3 0 135 298
29d 297 29e 0
2cd 59 :3 0 1f
:3 0 45 :4 0 2e
:3 0 51 :3 0 54
:3 0 13a 2a1 2a6
2a0 2a7 0 2cd
5a :3 0 1f :3 0
3f :4 0 2e :3 0
52 :3 0 54 :3 0
13f 2aa 2af 2a9
2b0 0 2cd 5b
:3 0 1f :3 0 48
:4 0 2e :3 0 53
:3 0 54 :3 0 144
2b3 2b8 2b2 2b9
0 2cd 5d :3 0
5e :3 0 55 :3 0
5f :3 0 56 :3 0
60 :3 0 57 :3 0
61 :3 0 58 :3 0
62 :3 0 59 :3 0
63 :3 0 5a :3 0
64 :3 0 5b :3 0
65 :3 0 4b :4 0
66 1 :8 0 2cd
149 2d5 31 :4 0
2d0 153 2d2 155
2d1 2d0 :2 0 2d3
157 :2 0 2d5 0
2d5 2d4 2cd 2d3
:6 0 2d7 6 :3 0
159 2d8 273 2d7
0 2d9 15b 0
2da 15d 2de :3 0
2de 4a :3 0 15f
2de 2dd 2da 2db
:6 0 2df 1 0
1c1 214 2de fd8
:2 0 67 :a 0 387
8 :7 0 2ec 2ed
0 169 69 :3 0
6a :2 0 4 2e3
2e4 0 24 :3 0
24 :2 0 1 2e5
2e7 :3 0 68 :7 0
2e9 2e8 :3 0 2f5
2f6 0 16b 69
:3 0 24 :2 0 4
24 :3 0 24 :2 0
1 2ee 2f0 :3 0
6b :7 0 2f2 2f1
:3 0 2fe 2ff 0
16d 69 :3 0 28
:2 0 4 24 :3 0
24 :2 0 1 2f7
2f9 :3 0 27 :7 0
2fb 2fa :3 0 307
308 0 16f 69
:3 0 6d :2 0 4
24 :3 0 24 :2 0
1 300 302 :3 0
6c :7 0 304 303
:3 0 310 311 0
171 69 :3 0 6f
:2 0 4 24 :3 0
24 :2 0 1 309
30b :3 0 6e :7 0
30d 30c :3 0 319
31a 0 173 69
:3 0 2d :2 0 4
24 :3 0 24 :2 0
1 312 314 :3 0
70 :7 0 316 315
:3 0 177 :2 0 175
69 :3 0 72 :2 0
4 24 :3 0 24
:2 0 1 31b 31d
:3 0 71 :7 0 31f
31e :3 0 321 :2 0
387 2e1 322 :5 0
181 6 :3 0 74
:2 0 17f 325 327
:6 0 32a 328 0
385 0 73 :6 0
73 :3 0 32b 32c
0 382 68 :3 0
75 :2 0 183 32f
330 :3 0 73 :3 0
76 :4 0 332 333
0 336 3a :3 0
185 372 6b :3 0
75 :2 0 187 338
339 :3 0 73 :3 0
77 :4 0 33b 33c
0 33f 3a :3 0
189 340 33a 33f
0 373 27 :3 0
75 :2 0 18b 342
343 :3 0 73 :3 0
78 :4 0 345 346
0 349 3a :3 0
18d 34a 344 349
0 373 6c :3 0
75 :2 0 18f 34c
34d :3 0 73 :3 0
79 :4 0 34f 350
0 353 3a :3 0
191 354 34e 353
0 373 6e :3 0
75 :2 0 193 356
357 :3 0 73 :3 0
7a :4 0 359 35a
0 35d 3a :3 0
195 35e 358 35d
0 373 70 :3 0
75 :2 0 197 360
361 :3 0 73 :3 0
7b :4 0 363 364
0 367 3a :3 0
199 368 362 367
0 373 71 :3 0
75 :2 0 19b 36a
36b :3 0 73 :3 0
7c :4 0 36d 36e
0 370 19d 371
36c 370 0 373
331 336 0 373
19f 0 382 73
:3 0 2f :2 0 1a7
375 376 :3 0 32
:3 0 33 :3 0 378
379 0 c :3 0
73 :3 0 1a9 37a
37d :2 0 37f 1ac
380 377 37f 0
381 1ae 0 382
1b0 386 :3 0 386
67 :3 0 1b4 386
385 382 383 :6 0
387 1 0 2e1
322 386 fd8 :2 0
13 :3 0 7d :a 0
3cd 9 :7 0 1b8
:2 0 1b6 69 :3 0
24 :2 0 4 38c
38d 0 24 :3 0
24 :2 0 1 38e
390 :3 0 6b :7 0
392 391 :3 0 15
:3 0 29 :3 0 394
396 0 3cd 38a
397 :2 0 74 :2 0
1ba 29 :3 0 39a
:7 0 39d 39b 0
3cb 0 7e :6 0
1c0 3b5 0 1be
6 :3 0 1bc 39f
3a1 :6 0 3a4 3a2
0 3cb 0 73
:6 0 7f :3 0 7e
:3 0 80 :3 0 24
:3 0 6b :4 0 81
1 :8 0 3ab 31
:3 0 73 :3 0 82
:4 0 3ad 3ae 0
3b0 1c2 3b2 1c4
3b1 3b0 :2 0 3b3
1c6 :2 0 3b5 0
3b5 3b4 3ab 3b3
:6 0 3c8 9 :3 0
73 :3 0 2f :2 0
1c8 3b8 3b9 :3 0
32 :3 0 33 :3 0
3bb 3bc 0 c
:3 0 73 :3 0 1ca
3bd 3c0 :2 0 3c2
1cd 3c3 3ba 3c2
0 3c4 1cf 0
3c8 15 :3 0 7e
:3 0 3c6 :2 0 3c8
1d1 3cc :3 0 3cc
7d :3 0 1d5 3cc
3cb 3c8 3c9 :6 0
3cd 1 0 38a
397 3cc fd8 :2 0
83 :a 0 49d b
:7 0 3da 3db 0
1d8 69 :3 0 24
:2 0 4 3d1 3d2
0 24 :3 0 24
:2 0 1 3d3 3d5
:3 0 6b :7 0 3d7
3d6 :3 0 3e3 3e4
0 1da 69 :3 0
7f :2 0 4 24
:3 0 24 :2 0 1
3dc 3de :3 0 84
:7 0 3e0 3df :3 0
3ec 3ed 0 1dc
69 :3 0 28 :2 0
4 24 :3 0 24
:2 0 1 3e5 3e7
:3 0 27 :7 0 3e9
3e8 :3 0 1e0 :2 0
1de 69 :3 0 6f
:2 0 4 24 :3 0
24 :2 0 1 3ee
3f0 :3 0 6e :7 0
3f2 3f1 :3 0 3f4
:2 0 49d 3cf 3f5
:2 0 1e7 1007 0
1e5 29 :3 0 3f8
:7 0 3fb 3f9 0
49b 0 7e :6 0
74 :2 0 1eb 29
:3 0 3fd :7 0 400
3fe 0 49b 0
54 :6 0 6 :3 0
74 :2 0 1e9 402
404 :6 0 407 405
0 49b 0 85
:6 0 74 :2 0 1ef
6 :3 0 1ed 409
40b :6 0 40e 40c
0 49b 0 73
:6 0 74 :2 0 1f3
6 :3 0 1f1 410
412 :6 0 415 413
0 49b 0 86
:6 0 74 :2 0 1f7
6 :3 0 1f5 417
419 :6 0 41c 41a
0 49b 0 87
:6 0 3c :2 0 1fb
6 :3 0 1f9 41e
420 :6 0 423 421
0 49b 0 88
:6 0 89 :3 0 7f
:3 0 8a :3 0 89
:3 0 8b :3 0 8c
:3 0 8d :3 0 6a
:3 0 7e :3 0 54
:3 0 85 :3 0 8e
:3 0 89 :3 0 80
:3 0 8d :3 0 8d
:3 0 24 :3 0 6b
:3 0 8d :3 0 7f
:3 0 89 :3 0 7f
:3 0 89 :3 0 6f
:3 0 6e :4 0 8f
1 :8 0 46f 84
:3 0 7e :3 0 1ff
440 441 :3 0 73
:3 0 90 :4 0 443
444 0 452 86
:3 0 85 :3 0 446
447 0 452 87
:3 0 91 :3 0 6e
:3 0 202 44a 44c
449 44d 0 452
88 :4 0 44f 450
0 452 204 453
442 452 0 454
209 0 46f 27
:3 0 54 :3 0 3c
:2 0 20d 457 458
:3 0 73 :3 0 92
:4 0 45a 45b 0
46c 86 :3 0 85
:3 0 45d 45e 0
46c 87 :3 0 91
:3 0 6e :3 0 210
461 463 460 464
0 46c 88 :3 0
91 :3 0 27 :3 0
212 467 469 466
46a 0 46c 214
46d 459 46c 0
46e 219 0 46f
21b 485 31 :3 0
73 :3 0 93 :4 0
471 472 0 480
86 :3 0 85 :3 0
474 475 0 480
87 :3 0 91 :3 0
6e :3 0 21f 478
47a 477 47b 0
480 88 :4 0 47d
47e 0 480 221
482 226 481 480
:2 0 483 228 :2 0
485 0 485 484
46f 483 :6 0 498
b :3 0 73 :3 0
2f :2 0 22a 488
489 :3 0 32 :3 0
33 :3 0 48b 48c
0 c :3 0 73
:3 0 86 :3 0 87
:3 0 88 :3 0 22c
48d 493 :2 0 495
232 496 48a 495
0 497 234 0
498 236 49c :3 0
49c 83 :3 0 239
49c 49b 498 499
:6 0 49d 1 0
3cf 3f5 49c fd8
:2 0 94 :a 0 587
d :7 0 4aa 4ab
0 241 69 :3 0
96 :2 0 4 4a1
4a2 0 24 :3 0
24 :2 0 1 4a3
4a5 :3 0 95 :7 0
4a7 4a6 :3 0 4b3
4b4 0 243 69
:3 0 6a :2 0 4
24 :3 0 24 :2 0
1 4ac 4ae :3 0
68 :7 0 4b0 4af
:3 0 4bc 4bd 0
245 69 :3 0 24
:2 0 4 24 :3 0
24 :2 0 1 4b5
4b7 :3 0 6b :7 0
4b9 4b8 :3 0 4c5
4c6 0 247 69
:3 0 28 :2 0 4
24 :3 0 24 :2 0
1 4be 4c0 :3 0
27 :7 0 4c2 4c1
:3 0 4ce 4cf 0
249 69 :3 0 6d
:2 0 4 24 :3 0
24 :2 0 1 4c7
4c9 :3 0 6c :7 0
4cb 4ca :3 0 4d7
4d8 0 24b 69
:3 0 6f :2 0 4
24 :3 0 24 :2 0
1 4d0 4d2 :3 0
6e :7 0 4d4 4d3
:3 0 4e0 4e1 0
24d 69 :3 0 98
:2 0 4 24 :3 0
24 :2 0 1 4d9
4db :3 0 97 :7 0
4dd 4dc :3 0 4e9
4ea 0 24f 69
:3 0 2d :2 0 4
24 :3 0 24 :2 0
1 4e2 4e4 :3 0
70 :7 0 4e6 4e5
:3 0 4f2 4f3 0
251 69 :3 0 72
:2 0 4 24 :3 0
24 :2 0 1 4eb
4ed :3 0 71 :7 0
4ef 4ee :3 0 4fb
4fc 0 253 69
:3 0 9a :2 0 4
24 :3 0 24 :2 0
1 4f4 4f6 :3 0
99 :7 0 4f8 4f7
:3 0 257 :2 0 255
69 :3 0 9c :2 0
4 24 :3 0 24
:2 0 1 4fd 4ff
:3 0 9b :7 0 501
500 :3 0 503 :2 0
587 49f 504 :2 0
265 1455 0 263
29 :3 0 507 :7 0
50a 508 0 585
0 9d :6 0 67
:3 0 29 :3 0 50c
:7 0 50f 50d 0
585 0 7e :6 0
68 :3 0 6b :3 0
27 :3 0 6c :3 0
6e :3 0 70 :3 0
71 :3 0 267 510
518 :2 0 582 7e
:3 0 7d :3 0 6b
:3 0 26f 51b 51d
51a 51e 0 582
83 :3 0 6b :3 0
7e :3 0 27 :3 0
6e :3 0 271 520
525 :2 0 582 69
:3 0 24 :3 0 6b
:3 0 7f :3 0 7e
:3 0 28 :3 0 27
:3 0 6d :3 0 6c
:3 0 6f :3 0 6e
:3 0 2d :3 0 70
:3 0 72 :3 0 71
:3 0 9e :4 0 9f
1 :8 0 582 95
:3 0 75 :2 0 276
539 53a :3 0 95
:3 0 35 :2 0 a0
:2 0 27a 53d 53f
:3 0 53b 541 540
:2 0 a1 :3 0 a2
:3 0 96 :3 0 9d
:3 0 69 :3 0 a3
:3 0 96 :3 0 69
:3 0 96 :3 0 a3
:3 0 96 :3 0 a4
:4 0 a5 1 :8 0
550 27d 555 9d
:3 0 95 :3 0 551
552 0 554 27f
556 542 550 0
557 0 554 0
557 281 0 582
69 :3 0 96 :3 0
6a :3 0 24 :3 0
7f :3 0 28 :3 0
6d :3 0 6f :3 0
98 :3 0 2d :3 0
72 :3 0 9a :3 0
9c :3 0 9d :3 0
68 :3 0 6b :3 0
7e :3 0 27 :3 0
6c :3 0 6e :3 0
97 :3 0 70 :3 0
71 :3 0 99 :3 0
9b :4 0 a6 1
:8 0 572 284 580
a7 :3 0 32 :3 0
33 :3 0 574 575
0 c :3 0 a8
:4 0 286 576 579
:2 0 57b 289 57d
28b 57c 57b :2 0
57e 28d :2 0 580
0 580 57f 572
57e :6 0 582 d
:3 0 28f 586 :3 0
586 94 :3 0 296
586 585 582 583
:6 0 587 1 0
49f 504 586 fd8
:2 0 a9 :a 0 5a3
f :7 0 29b :2 0
299 69 :3 0 96
:2 0 4 58b 58c
0 24 :3 0 24
:2 0 1 58d 58f
:3 0 95 :7 0 591
590 :3 0 593 :2 0
5a3 589 594 :2 0
69 :3 0 9e :3 0
aa :3 0 ab :3 0
96 :3 0 95 :3 0
9e :4 0 ac 1
:8 0 59e 29d 5a2
:3 0 5a2 a9 :4 0
5a2 5a1 59e 59f
:6 0 5a3 1 0
589 594 5a2 fd8
:2 0 ad :a 0 668
10 :7 0 5b0 5b1
0 29f 69 :3 0
96 :2 0 4 5a7
5a8 0 24 :3 0
24 :2 0 1 5a9
5ab :3 0 95 :7 0
5ad 5ac :3 0 5b9
5ba 0 2a1 69
:3 0 6a :2 0 4
24 :3 0 24 :2 0
1 5b2 5b4 :3 0
68 :7 0 5b6 5b5
:3 0 5c2 5c3 0
2a3 69 :3 0 24
:2 0 4 24 :3 0
24 :2 0 1 5bb
5bd :3 0 6b :7 0
5bf 5be :3 0 5cb
5cc 0 2a5 69
:3 0 28 :2 0 4
24 :3 0 24 :2 0
1 5c4 5c6 :3 0
27 :7 0 5c8 5c7
:3 0 5d4 5d5 0
2a7 69 :3 0 6d
:2 0 4 24 :3 0
24 :2 0 1 5cd
5cf :3 0 6c :7 0
5d1 5d0 :3 0 5dd
5de 0 2a9 69
:3 0 6f :2 0 4
24 :3 0 24 :2 0
1 5d6 5d8 :3 0
6e :7 0 5da 5d9
:3 0 5e6 5e7 0
2ab 69 :3 0 98
:2 0 4 24 :3 0
24 :2 0 1 5df
5e1 :3 0 97 :7 0
5e3 5e2 :3 0 5ef
5f0 0 2ad 69
:3 0 2d :2 0 4
24 :3 0 24 :2 0
1 5e8 5ea :3 0
70 :7 0 5ec 5eb
:3 0 5f8 5f9 0
2af 69 :3 0 72
:2 0 4 24 :3 0
24 :2 0 1 5f1
5f3 :3 0 71 :7 0
5f5 5f4 :3 0 601
602 0 2b1 69
:3 0 9a :2 0 4
24 :3 0 24 :2 0
1 5fa 5fc :3 0
99 :7 0 5fe 5fd
:3 0 2b5 :2 0 2b3
69 :3 0 9c :2 0
4 24 :3 0 24
:2 0 1 603 605
:3 0 9b :7 0 607
606 :3 0 609 :2 0
668 5a5 60a :2 0
2c3 :2 0 2c1 29
:3 0 60d :7 0 610
60e 0 666 0
7e :6 0 67 :3 0
68 :3 0 6b :3 0
27 :3 0 6c :3 0
6e :3 0 70 :3 0
71 :3 0 611 619
:2 0 663 7e :3 0
7d :3 0 6b :3 0
2cb 61c 61e 61b
61f 0 663 83
:3 0 6b :3 0 7e
:3 0 27 :3 0 6e
:3 0 2cd 621 626
:2 0 663 69 :3 0
24 :3 0 6b :3 0
7f :3 0 7e :3 0
28 :3 0 27 :3 0
6d :3 0 6c :3 0
6f :3 0 6e :3 0
2d :3 0 70 :3 0
72 :3 0 71 :3 0
9e :4 0 ae 1
:8 0 653 69 :3 0
6a :3 0 68 :3 0
24 :3 0 6b :3 0
7f :3 0 7e :3 0
28 :3 0 27 :3 0
6d :3 0 6c :3 0
6f :3 0 6e :3 0
98 :3 0 97 :3 0
2d :3 0 70 :3 0
72 :3 0 71 :3 0
9a :3 0 99 :3 0
9c :3 0 9b :3 0
96 :3 0 95 :4 0
af 1 :8 0 653
2d2 661 a7 :3 0
32 :3 0 33 :3 0
655 656 0 c
:3 0 a8 :4 0 2d5
657 65a :2 0 65c
2d8 65e 2da 65d
65c :2 0 65f 2dc
:2 0 661 0 661
660 653 65f :6 0
663 10 :3 0 2de
667 :3 0 667 ad
:3 0 2e3 667 666
663 664 :6 0 668
1 0 5a5 60a
667 fd8 :2 0 13
:3 0 b0 :a 0 683
12 :7 0 15 :4 0
29 :3 0 66d 66e
0 683 66b 66f
:2 0 2e7 682 0
2e5 29 :3 0 672
:7 0 675 673 0
681 0 b1 :6 0
b2 :3 0 b3 :3 0
b1 :3 0 b4 :4 0
b5 1 :8 0 67e
15 :3 0 b1 :3 0
67c :2 0 67e :3 0
682 b0 :3 0 2ea
682 681 67e 67f
:6 0 683 1 0
66b 66f 682 fd8
:2 0 b6 :a 0 6c5
13 :7 0 2ee 1ad1
0 2ec 29 :3 0
b7 :7 0 688 687
:3 0 2f2 :2 0 2f0
b9 :3 0 29 :3 0
b8 :6 0 68d 68c
:3 0 29 :3 0 ba
:7 0 691 690 :3 0
693 :2 0 6c5 685
694 :2 0 2f8 6bb
0 2f6 29 :3 0
697 :7 0 69a 698
0 6c3 0 bb
:6 0 bc :3 0 bb
:3 0 5d :3 0 65
:3 0 b7 :4 0 bd
1 :8 0 6a7 5d
:3 0 be :3 0 ba
:3 0 bc :3 0 bb
:4 0 bf 1 :8 0
6a7 31 :3 0 b2
:3 0 b3 :3 0 bb
:3 0 b4 :4 0 c0
1 :8 0 6b6 5d
:3 0 bc :3 0 65
:3 0 be :3 0 bb
:3 0 b7 :3 0 ba
:4 0 c1 1 :8 0
6b6 2fb 6b8 2fe
6b7 6b6 :2 0 6b9
300 :2 0 6bb 0
6bb 6ba 6a7 6b9
:6 0 6c0 13 :3 0
b8 :3 0 bb :3 0
6bd 6be 0 6c0
302 6c4 :3 0 6c4
b6 :3 0 305 6c4
6c3 6c0 6c1 :6 0
6c5 1 0 685
694 6c4 fd8 :2 0
c2 :a 0 98f 15
:7 0 6d2 6d3 0
307 c3 :3 0 23
:2 0 4 6c9 6ca
0 24 :3 0 24
:2 0 1 6cb 6cd
:3 0 21 :7 0 6cf
6ce :3 0 6db 6dc
0 309 69 :3 0
96 :2 0 4 24
:3 0 24 :2 0 1
6d4 6d6 :3 0 ba
:7 0 6d8 6d7 :3 0
30d 1c75 0 30b
c5 :3 0 c6 :2 0
4 24 :3 0 24
:2 0 1 6dd 6df
:3 0 c4 :7 0 6e1
6e0 :3 0 6ec 6ed
0 30f 29 :3 0
97 :7 0 6e5 6e4
:3 0 29 :3 0 c7
:7 0 6e9 6e8 :3 0
313 1cc1 0 311
22 :3 0 c9 :2 0
4 24 :3 0 24
:2 0 1 6ee 6f0
:3 0 c8 :7 0 6f2
6f1 :3 0 317 1ce7
0 315 6 :3 0
ca :7 0 6f6 6f5
:3 0 6 :3 0 cb
:7 0 6fa 6f9 :3 0
31b 1d0d 0 319
6 :3 0 cc :7 0
6fe 6fd :3 0 6
:3 0 cd :7 0 702
701 :3 0 31f 1d33
0 31d 6 :3 0
ce :7 0 706 705
:3 0 6 :3 0 cf
:7 0 70a 709 :3 0
323 1d59 0 321
6 :3 0 d0 :7 0
70e 70d :3 0 6
:3 0 d1 :7 0 712
711 :3 0 327 :2 0
325 6 :3 0 d2
:7 0 716 715 :3 0
b9 :3 0 29 :3 0
b8 :6 0 71b 71a
:3 0 71d :2 0 98f
6c7 71e :2 0 72b
72c 0 338 22
:3 0 28 :2 0 4
721 722 0 24
:3 0 24 :2 0 1
723 725 :3 0 726
:7 0 729 727 0
98d 0 54 :6 0
735 736 0 33a
d4 :3 0 6d :2 0
4 24 :3 0 24
:2 0 1 72d 72f
:3 0 730 :7 0 733
731 0 98d 0
d3 :6 0 73f 740
0 33c 8e :3 0
6f :2 0 4 24
:3 0 24 :2 0 1
737 739 :3 0 73a
:7 0 73d 73b 0
98d 0 d5 :6 0
749 74a 0 33e
22 :3 0 2d :2 0
4 24 :3 0 24
:2 0 1 741 743
:3 0 744 :7 0 747
745 0 98d 0
d6 :6 0 753 754
0 340 d8 :3 0
72 :2 0 4 24
:3 0 24 :2 0 1
74b 74d :3 0 74e
:7 0 751 74f 0
98d 0 d7 :6 0
75d 75e 0 342
22 :3 0 da :2 0
4 24 :3 0 24
:2 0 1 755 757
:3 0 758 :7 0 75b
759 0 98d 0
d9 :6 0 767 768
0 344 dc :3 0
dd :2 0 4 24
:3 0 24 :2 0 1
75f 761 :3 0 762
:7 0 765 763 0
98d 0 db :6 0
348 1ef5 0 346
8e :3 0 df :2 0
4 24 :3 0 24
:2 0 1 769 76b
:3 0 76c :7 0 76f
76d 0 98d 0
de :6 0 77b 77c
0 34a 29 :3 0
771 :7 0 774 772
0 98d 0 e0
:6 0 29 :3 0 776
:7 0 779 777 0
98d 0 bb :6 0
785 786 0 34c
22 :3 0 26 :2 0
4 24 :3 0 24
:2 0 1 77d 77f
:3 0 780 :7 0 783
781 0 98d 0
e1 :6 0 78f 790
0 34e 22 :3 0
e3 :2 0 4 24
:3 0 24 :2 0 1
787 789 :3 0 78a
:7 0 78d 78b 0
98d 0 e2 :6 0
799 79a 0 350
22 :3 0 2b :2 0
4 24 :3 0 24
:2 0 1 791 793
:3 0 794 :7 0 797
795 0 98d 0
e4 :6 0 354 1fdd
0 352 22 :3 0
2b :2 0 4 24
:3 0 24 :2 0 1
79b 79d :3 0 79e
:7 0 7a1 79f 0
98d 0 55 :6 0
358 2011 0 356
29 :3 0 7a3 :7 0
7a6 7a4 0 98d
0 e5 :6 0 29
:3 0 7a8 :7 0 7ab
7a9 0 98d 0
e6 :6 0 35e 2049
0 35c 29 :3 0
7ad :7 0 7b0 7ae
0 98d 0 e7
:6 0 6 :3 0 e9
:2 0 35a 7b2 7b4
:6 0 7b7 7b5 0
98d 0 e8 :6 0
e8 :3 0 29 :3 0
7b9 :7 0 7bc 7ba
0 98d 0 ea
:6 0 eb :3 0 ec
:3 0 7be 7bf 0
7bd 7c0 0 98a
a3 :3 0 28 :3 0
a3 :3 0 6d :3 0
a3 :3 0 6f :3 0
a3 :3 0 2d :3 0
a3 :3 0 72 :3 0
ed :3 0 da :3 0
ed :3 0 dd :3 0
ee :3 0 df :3 0
54 :3 0 d3 :3 0
d5 :3 0 d6 :3 0
d7 :3 0 d9 :3 0
db :3 0 de :3 0
69 :3 0 a3 :3 0
dc :3 0 ed :3 0
8e :3 0 ee :3 0
a3 :3 0 96 :3 0
ba :3 0 a3 :3 0
2d :3 0 ed :3 0
2d :3 0 a3 :3 0
72 :3 0 ed :3 0
72 :3 0 a3 :3 0
7f :3 0 ee :3 0
7f :3 0 a3 :3 0
6f :3 0 ee :3 0
6f :4 0 ef 1
:8 0 98a 8a :3 0
dd :3 0 8a :3 0
a1 :3 0 f0 :3 0
f1 :3 0 e0 :3 0
c3 :3 0 23 :3 0
21 :4 0 f2 1
:8 0 98a db :3 0
e0 :3 0 3c :2 0
362 801 802 :3 0
32 :3 0 33 :3 0
804 805 0 c
:3 0 f3 :4 0 365
806 809 :2 0 80b
368 80c 803 80b
0 80d 36a 0
98a f4 :3 0 d9
:3 0 d6 :3 0 21
:3 0 54 :3 0 f5
:3 0 d9 :3 0 d6
:3 0 21 :3 0 e1
:3 0 e2 :3 0 b4
:4 0 f6 1 :8 0
98a e7 :3 0 22
:3 0 26 :3 0 e1
:3 0 28 :3 0 54
:4 0 f7 1 :8 0
874 ea :3 0 a0
:2 0 822 823 0
874 f8 :3 0 e1
:3 0 f9 :3 0 8c
:3 0 e8 :3 0 fa
:2 0 fb :2 0 36c
828 82c d6 :3 0
17 :2 0 a0 :4 0
370 82f 831 :3 0
17 :2 0 fc :3 0
91 :3 0 ea :3 0
373 835 837 fd
:2 0 a0 :4 0 375
834 83b 379 833
83d :3 0 17 :2 0
fc :3 0 91 :3 0
21 :3 0 37c 841
843 fe :2 0 a0
:4 0 37e 840 847
382 83f 849 :3 0
385 827 84b 826
84c 0 871 e7
:3 0 22 :3 0 26
:3 0 e1 :3 0 28
:3 0 54 :4 0 f7
1 :8 0 855 388
85e 31 :3 0 ff
:8 0 859 38a 85b
38c 85a 859 :2 0
85c 38e :2 0 85e
0 85e 85d 855
85c :6 0 871 17
:3 0 ea :3 0 ea
:3 0 100 :2 0 fa
:2 0 390 862 864
:3 0 860 865 0
871 ea :3 0 35
:2 0 74 :2 0 395
868 86a :3 0 ff
:8 0 86e 398 86f
86b 86e 0 870
39a 0 871 39c
873 f8 :4 0 871
:4 0 874 3a1 87c
31 :4 0 877 3a5
879 3a7 878 877
:2 0 87a 3a9 :2 0
87c 0 87c 87b
874 87a :6 0 98a
15 :3 0 e5 :4 0
87e 87f 0 98a
db :3 0 35 :2 0
fa :2 0 3ad 882
884 :3 0 e6 :3 0
a0 :2 0 886 887
0 889 3b0 88e
e6 :3 0 fa :2 0
88a 88b 0 88d
3b2 88f 885 889
0 890 0 88d
0 890 3b4 0
98a 101 :3 0 102
:2 0 a0 :2 0 a0
:2 0 e5 :3 0 e7
:3 0 21 :3 0 e1
:3 0 54 :3 0 e2
:3 0 d9 :3 0 103
:3 0 e4 :3 0 fa
:4 0 fd :2 0 e6
:9 0 97 :5 0 c8
:3 0 3b7 891 8ab
:2 0 98a b6 :3 0
e4 :3 0 bb :3 0
ba :3 0 3d1 8ad
8b1 :2 0 98a 104
:3 0 105 :3 0 8b3
8b4 0 106 :4 0
e4 :3 0 3d5 8b5
8b8 :2 0 98a d7
:3 0 2f :2 0 3d8
8bb 8bc :3 0 107
:3 0 108 :3 0 8be
8bf 0 e4 :3 0
72 :4 0 d7 :3 0
3da 8c0 8c4 :2 0
8c6 3de 8c7 8bd
8c6 0 8c8 3e0
0 98a d3 :3 0
2f :2 0 3e2 8ca
8cb :3 0 107 :3 0
108 :3 0 8cd 8ce
0 e4 :3 0 d4
:4 0 d3 :3 0 3e4
8cf 8d3 :2 0 8d5
3e8 8d6 8cc 8d5
0 8d7 3ea 0
98a d5 :3 0 2f
:2 0 3ec 8d9 8da
:3 0 107 :3 0 108
:3 0 8dc 8dd 0
e4 :3 0 8e :4 0
d5 :3 0 3ee 8de
8e2 :2 0 8e4 3f2
8e5 8db 8e4 0
8e6 3f4 0 98a
c4 :3 0 2f :2 0
3f6 8e8 8e9 :3 0
107 :3 0 108 :3 0
8eb 8ec 0 e4
:3 0 109 :4 0 c4
:3 0 3f8 8ed 8f1
:2 0 8f3 3fc 8f4
8ea 8f3 0 8f5
3fe 0 98a ca
:3 0 2f :2 0 400
8f7 8f8 :3 0 107
:3 0 10a :3 0 8fa
8fb 0 e4 :3 0
10b :4 0 ca :3 0
402 8fc 900 :2 0
902 406 903 8f9
902 0 904 408
0 98a cc :3 0
2f :2 0 40a 906
907 :3 0 107 :3 0
10a :3 0 909 90a
0 e4 :3 0 10c
:4 0 cc :3 0 40c
90b 90f :2 0 911
410 912 908 911
0 913 412 0
98a cd :3 0 2f
:2 0 414 915 916
:3 0 107 :3 0 10a
:3 0 918 919 0
e4 :3 0 10d :4 0
cd :3 0 416 91a
91e :2 0 920 41a
921 917 920 0
922 41c 0 98a
ce :3 0 2f :2 0
41e 924 925 :3 0
107 :3 0 10a :3 0
927 928 0 e4
:3 0 10e :4 0 ce
:3 0 420 929 92d
:2 0 92f 424 930
926 92f 0 931
426 0 98a cf
:3 0 2f :2 0 428
933 934 :3 0 107
:3 0 10a :3 0 936
937 0 e4 :3 0
10f :4 0 cf :3 0
42a 938 93c :2 0
93e 42e 93f 935
93e 0 940 430
0 98a d0 :3 0
2f :2 0 432 942
943 :3 0 107 :3 0
10a :3 0 945 946
0 e4 :3 0 110
:4 0 d0 :3 0 434
947 94b :2 0 94d
438 94e 944 94d
0 94f 43a 0
98a d1 :3 0 2f
:2 0 43c 951 952
:3 0 107 :3 0 10a
:3 0 954 955 0
e4 :3 0 111 :4 0
d1 :3 0 43e 956
95a :2 0 95c 442
95d 953 95c 0
95e 444 0 98a
d2 :3 0 2f :2 0
446 960 961 :3 0
107 :3 0 10a :3 0
963 964 0 e4
:3 0 112 :4 0 d2
:3 0 448 965 969
:2 0 96b 44c 96c
962 96b 0 96d
44e 0 98a 113
:3 0 114 :3 0 96e
96f 0 21 :3 0
115 :4 0 cb :3 0
a0 :2 0 450 970
975 :2 0 98a c7
:3 0 35 :2 0 fa
:2 0 457 978 97a
:3 0 104 :3 0 116
:3 0 97c 97d 0
bb :3 0 117 :4 0
55 :3 0 45a 97e
982 :2 0 984 45e
985 97b 984 0
986 460 0 98a
b8 :3 0 bb :3 0
987 988 0 98a
462 98e :3 0 98e
c2 :3 0 47d 98e
98d 98a 98b :6 0
98f 1 0 6c7
71e 98e fd8 :2 0
118 :a 0 9d7 19
:7 0 493 272b 0
491 29 :3 0 b8
:7 0 994 993 :3 0
498 274b 0 495
b9 :3 0 29 :3 0
b7 :6 0 999 998
:3 0 99b :2 0 9d7
991 99c :2 0 119
:3 0 29 :3 0 99f
:7 0 9a2 9a0 0
9d5 0 2a :6 0
5e :3 0 2a :3 0
5d :3 0 119 :3 0
119 :3 0 bc :3 0
b8 :4 0 11a 1
:8 0 9ac 49a 9be
31 :3 0 32 :3 0
33 :3 0 9ae 9af
0 c :3 0 11b
:4 0 91 :3 0 b8
:3 0 49c 9b3 9b5
49e 9b0 9b7 :2 0
9b9 4a2 9bb 4a4
9ba 9b9 :2 0 9bc
4a6 :2 0 9be 0
9be 9bd 9ac 9bc
:6 0 9d2 19 :3 0
2a :3 0 75 :2 0
4a8 9c1 9c2 :3 0
104 :3 0 116 :3 0
9c4 9c5 0 b8
:3 0 117 :4 0 2a
:3 0 4aa 9c6 9ca
:2 0 9cc 4ae 9cd
9c3 9cc 0 9ce
4b0 0 9d2 b7
:3 0 2a :3 0 9cf
9d0 0 9d2 4b2
9d6 :3 0 9d6 118
:3 0 4b6 9d6 9d5
9d2 9d3 :6 0 9d7
1 0 991 99c
9d6 fd8 :2 0 11c
:a 0 a44 1b :7 0
4ba :2 0 4b8 b9
:3 0 10 :3 0 11d
:6 0 9dd 9dc :3 0
9df :2 0 a44 9d9
9e0 :2 0 11d :3 0
6a :3 0 9e2 9e3
0 75 :2 0 4bc
9e5 9e6 :3 0 11d
:3 0 11e :3 0 9e8
9e9 0 75 :2 0
4be 9eb 9ec :3 0
9e7 9ee 9ed :2 0
11d :3 0 11f :3 0
9f0 9f1 0 75
:2 0 4c0 9f3 9f4
:3 0 9ef 9f6 9f5
:2 0 11d :3 0 120
:3 0 9f8 9f9 0
75 :2 0 4c2 9fb
9fc :3 0 9f7 9fe
9fd :2 0 11d :3 0
121 :3 0 a00 a01
0 75 :2 0 4c4
a03 a04 :3 0 9ff
a06 a05 :2 0 11d
:3 0 122 :3 0 a08
a09 0 75 :2 0
4c6 a0b a0c :3 0
a07 a0e a0d :2 0
11d :3 0 123 :3 0
a10 a11 0 75
:2 0 4c8 a13 a14
:3 0 a0f a16 a15
:2 0 11d :3 0 124
:3 0 a18 a19 0
75 :2 0 4ca a1b
a1c :3 0 a17 a1e
a1d :2 0 11d :3 0
125 :3 0 a20 a21
0 75 :2 0 4cc
a23 a24 :3 0 a1f
a26 a25 :2 0 11d
:3 0 126 :3 0 a28
a29 0 75 :2 0
4ce a2b a2c :3 0
a27 a2e a2d :2 0
11d :3 0 127 :3 0
a30 a31 0 128
:4 0 a32 a33 0
a35 4d0 a3c 11d
:3 0 127 :3 0 a36
a37 :2 0 a38 a39
0 a3b 4d2 a3d
a2f a35 0 a3e
0 a3b 0 a3e
4d4 0 a3f 4d7
a43 :3 0 a43 11c
:4 0 a43 a42 a3f
a40 :6 0 a44 1
0 9d9 9e0 a43
fd8 :2 0 129 :a 0
b22 1c :7 0 4db
29d7 0 4d9 6
:3 0 12a :7 0 a49
a48 :3 0 4e0 29f7
0 4dd b9 :3 0
29 :3 0 95 :6 0
a4e a4d :3 0 a50
:2 0 b22 a46 a51
:2 0 4e4 2a2b 0
4e2 12c :3 0 a54
:7 0 a57 a55 0
b20 0 12b :6 0
10 :3 0 a59 :7 0
a5c a5a 0 b20
0 12d :6 0 a0
:2 0 4e6 29 :3 0
a5e :7 0 a61 a5f
0 b20 0 12e
:6 0 29 :3 0 a63
:7 0 a66 a64 0
b20 0 ea :6 0
a1 :3 0 12f :3 0
96 :3 0 12e :3 0
130 :4 0 131 1
:8 0 b1d 130 :3 0
96 :3 0 132 :3 0
133 :3 0 12e :3 0
12a :3 0 ab :4 0
134 1 :8 0 b1d
ea :3 0 a75 a76
0 b1d 135 :3 0
12b :3 0 136 :4 0
a79 a7a 0 a7b
:2 0 b1d f8 :3 0
12b :3 0 12d :3 0
6a :3 0 a7f a80
0 12d :3 0 11e
:3 0 a82 a83 0
12d :3 0 137 :3 0
a85 a86 0 12d
:3 0 138 :3 0 a88
a89 0 12d :3 0
139 :3 0 a8b a8c
0 12d :3 0 13a
:3 0 a8e a8f 0
12d :3 0 11f :3 0
a91 a92 0 12d
:3 0 120 :3 0 a94
a95 0 12d :3 0
121 :3 0 a97 a98
0 12d :3 0 122
:3 0 a9a a9b 0
12d :3 0 123 :3 0
a9d a9e 0 12d
:3 0 124 :3 0 aa0
aa1 0 12d :3 0
125 :3 0 aa3 aa4
0 12d :3 0 126
:3 0 aa6 aa7 0
12d :3 0 13b :3 0
aa9 aaa 0 12d
:3 0 13c :3 0 aac
aad 0 12d :3 0
13d :3 0 aaf ab0
0 12d :3 0 13e
:3 0 ab2 ab3 0
12d :3 0 13f :3 0
ab5 ab6 0 12d
:3 0 140 :3 0 ab8
ab9 :2 0 abc :2 0
b13 a7e abd :3 0
4e8 :3 0 ff :3 0
12b :3 0 141 :3 0
abf ac0 :4 0 ac1
:3 0 b13 11c :3 0
12d :3 0 4fd ac3
ac5 :2 0 b13 ea
:3 0 ea :3 0 100
:2 0 fa :2 0 4ff
ac9 acb :3 0 ac7
acc 0 b13 11
:3 0 96 :3 0 142
:3 0 6a :3 0 11e
:3 0 137 :3 0 138
:3 0 139 :3 0 13a
:3 0 11f :3 0 120
:3 0 121 :3 0 122
:3 0 123 :3 0 124
:3 0 125 :3 0 126
:3 0 13b :3 0 13c
:3 0 13d :3 0 13e
:3 0 13f :3 0 140
:3 0 127 :3 0 12e
:3 0 ea :3 0 12d
:3 0 6a :3 0 12d
:3 0 11e :3 0 12d
:3 0 137 :3 0 12d
:3 0 138 :3 0 12d
:3 0 139 :3 0 12d
:3 0 13a :3 0 12d
:3 0 11f :3 0 12d
:3 0 120 :3 0 12d
:3 0 121 :3 0 12d
:3 0 122 :3 0 12d
:3 0 123 :3 0 12d
:3 0 124 :3 0 12d
:3 0 125 :3 0 12d
:3 0 126 :3 0 12d
:3 0 13b :3 0 12d
:3 0 13c :3 0 12d
:3 0 13d :3 0 12d
:3 0 13e :3 0 12d
:3 0 13f :3 0 12d
:3 0 140 :3 0 12d
:3 0 127 :4 0 143
1 :8 0 b13 502
b15 f8 :4 0 b13
:4 0 b1d 144 :3 0
12b :4 0 b19 :2 0
b1d b17 0 95
:3 0 12e :3 0 b1a
b1b 0 b1d 508
b21 :3 0 b21 129
:3 0 510 b21 b20
b1d b1e :6 0 b22
1 0 a46 a51
b21 fd8 :2 0 145
:a 0 d36 1e :7 0
517 2d80 0 515
b9 :3 0 10 :3 0
11d :6 0 b28 b27
:6 0 519 6 :3 0
c8 :7 0 b2c b2b
:3 0 b2e :2 0 d36
b24 b2f :2 0 147
:2 0 51c 29 :3 0
b32 :7 0 b36 b33
b34 d34 0 2e
:6 0 522 :2 0 520
6 :3 0 51e b38
b3a :6 0 b3d b3b
0 d34 0 146
:6 0 11c :3 0 11d
:3 0 b3e b40 :2 0
d31 148 :3 0 149
:3 0 b42 b43 0
14a :4 0 17 :2 0
11d :3 0 127 :3 0
b47 b48 0 524
b46 b4a :3 0 527
b44 b4c :2 0 d31
11d :3 0 127 :3 0
b4e b4f 0 75
:2 0 529 b51 b52
:3 0 148 :3 0 149
:3 0 b54 b55 0
14b :4 0 52b b56
b58 :2 0 d2e 8c
:3 0 f0 :3 0 11d
:3 0 138 :3 0 14c
:3 0 f0 :3 0 11d
:3 0 139 :3 0 f0
:3 0 11d :3 0 139
:3 0 14c :3 0 f0
:3 0 11d :3 0 13a
:3 0 f0 :3 0 11d
:3 0 13a :3 0 14c
:3 0 f0 :3 0 11d
:3 0 11f :3 0 f0
:3 0 11d :3 0 11f
:3 0 146 :3 0 b4
:4 0 14d 1 :8 0
d2e 113 :3 0 14e
:3 0 b76 b77 0
14f :3 0 2e :3 0
b79 b7a 150 :3 0
d :2 0 b7c b7d
151 :4 0 b7f b80
152 :3 0 8c :3 0
f0 :3 0 11d :3 0
6a :3 0 b85 b86
0 52d b84 b88
fa :2 0 147 :2 0
52f b83 b8c b82
b8d 153 :3 0 8c
:3 0 154 :3 0 f0
:3 0 11d :3 0 6a
:3 0 b93 b94 0
533 b92 b96 535
b91 b98 fa :2 0
147 :2 0 537 b90
b9c b8f b9d 155
:3 0 8c :3 0 f0
:3 0 11d :3 0 6a
:3 0 ba2 ba3 0
53b ba1 ba5 fa
:2 0 156 :2 0 53d
ba0 ba9 b9f baa
157 :3 0 146 :3 0
bac bad 158 :3 0
fb :2 0 baf bb0
159 :3 0 15a :2 0
bb2 bb3 15b :3 0
102 :2 0 bb5 bb6
15c :3 0 fd :2 0
bb8 bb9 15d :3 0
f0 :3 0 11d :3 0
11e :3 0 bbd bbe
0 541 bbc bc0
bbb bc1 15e :3 0
a0 :2 0 bc3 bc4
15f :4 0 bc6 bc7
160 :3 0 161 :3 0
bc9 bca 162 :4 0
bcc bcd 163 :3 0
164 :2 0 fa :2 0
543 bd0 bd2 :3 0
bcf bd3 165 :3 0
164 :2 0 fa :2 0
545 bd6 bd8 :3 0
bd5 bd9 166 :4 0
bdb bdc 167 :4 0
bde bdf 168 :4 0
be1 be2 169 :4 0
be4 be5 16a :4 0
be7 be8 16b :4 0
bea beb 16c :4 0
bed bee 16d :4 0
bf0 bf1 16e :4 0
bf3 bf4 16f :4 0
bf6 bf7 170 :4 0
bf9 bfa 171 :4 0
bfc bfd 172 :4 0
bff c00 173 :4 0
c02 c03 174 :4 0
c05 c06 175 :4 0
c08 c09 176 :4 0
c0b c0c 177 :3 0
178 :2 0 c0e c0f
179 :3 0 a0 :2 0
c11 c12 17a :3 0
c8 :3 0 c14 c15
17b :4 0 c17 c18
547 b78 c1a :2 0
d2e 113 :3 0 17c
:3 0 c1c c1d 0
21 :3 0 2e :3 0
c1f c20 17d :3 0
a1 :3 0 17e :3 0
17f :4 0 56f c24
c26 180 :4 0 571
c23 c29 c22 c2a
181 :3 0 a1 :3 0
17e :3 0 182 :4 0
574 c2e c30 183
:4 0 576 c2d c33
c2c c34 184 :3 0
180 :4 0 c36 c37
185 :3 0 180 :4 0
c39 c3a 186 :3 0
187 :4 0 c3c c3d
188 :3 0 183 :4 0
c3f c40 579 c1e
c42 :2 0 d2e 113
:3 0 114 :3 0 c44
c45 0 14f :3 0
2e :3 0 c47 c48
189 :3 0 18a :4 0
c4a c4b 18b :3 0
f0 :3 0 11d :3 0
137 :3 0 c4f c50
0 581 c4e c52
c4d c53 18c :3 0
a0 :2 0 c55 c56
583 c46 c58 :2 0
d2e 113 :3 0 114
:3 0 c5a c5b 0
14f :3 0 2e :3 0
c5d c5e 189 :3 0
18d :4 0 c60 c61
18b :3 0 f0 :3 0
11d :3 0 138 :3 0
c65 c66 0 588
c64 c68 c63 c69
18c :3 0 a0 :2 0
c6b c6c 58a c5c
c6e :2 0 d2e 113
:3 0 114 :3 0 c70
c71 0 14f :3 0
2e :3 0 c73 c74
189 :3 0 18e :4 0
c76 c77 18b :3 0
f0 :3 0 11d :3 0
139 :3 0 c7b c7c
0 58f c7a c7e
c79 c7f 18c :3 0
a0 :2 0 c81 c82
591 c72 c84 :2 0
d2e 113 :3 0 114
:3 0 c86 c87 0
14f :3 0 2e :3 0
c89 c8a 189 :3 0
18f :4 0 c8c c8d
18b :3 0 f0 :3 0
11d :3 0 13a :3 0
c91 c92 0 596
c90 c94 c8f c95
18c :3 0 a0 :2 0
c97 c98 598 c88
c9a :2 0 d2e 113
:3 0 114 :3 0 c9c
c9d 0 14f :3 0
2e :3 0 c9f ca0
189 :3 0 190 :4 0
ca2 ca3 18b :3 0
f0 :3 0 11d :3 0
11f :3 0 ca7 ca8
0 59d ca6 caa
ca5 cab 18c :3 0
a0 :2 0 cad cae
59f c9e cb0 :2 0
d2e 113 :3 0 191
:3 0 cb2 cb3 0
14f :3 0 2e :3 0
cb5 cb6 192 :3 0
fd :2 0 cb8 cb9
159 :3 0 15a :2 0
cbb cbc 193 :3 0
f0 :3 0 11d :3 0
137 :3 0 cc0 cc1
0 5a4 cbf cc3
cbe cc4 194 :3 0
f0 :3 0 11d :3 0
138 :3 0 cc8 cc9
0 5a6 cc7 ccb
cc6 ccc 195 :3 0
f0 :3 0 11d :3 0
139 :3 0 cd0 cd1
0 5a8 ccf cd3
cce cd4 196 :3 0
f0 :3 0 11d :3 0
13a :3 0 cd8 cd9
0 5aa cd7 cdb
cd6 cdc 197 :3 0
f0 :3 0 11d :3 0
11f :3 0 ce0 ce1
0 5ac cdf ce3
cde ce4 198 :4 0
ce6 ce7 5ae cb4
ce9 :2 0 d2e 113
:3 0 199 :3 0 ceb
cec 0 14f :3 0
2e :3 0 cee cef
19a :3 0 a0 :2 0
cf1 cf2 19b :3 0
fa :2 0 cf4 cf5
19c :3 0 f0 :3 0
11d :3 0 120 :3 0
cf9 cfa 0 5b8
cf8 cfc cf7 cfd
19d :3 0 f0 :3 0
11d :3 0 121 :3 0
d01 d02 0 5ba
d00 d04 cff d05
19e :3 0 f0 :3 0
11d :3 0 123 :3 0
d09 d0a 0 5bc
d08 d0c d07 d0d
19f :3 0 f0 :3 0
11d :3 0 122 :3 0
d11 d12 0 5be
d10 d14 d0f d15
1a0 :3 0 11d :3 0
124 :3 0 d18 d19
0 d17 d1a 1a1
:3 0 11d :3 0 125
:3 0 d1d d1e 0
d1c d1f 1a2 :4 0
d21 d22 1a3 :4 0
d24 d25 5c0 ced
d27 :2 0 d2e 11d
:3 0 23 :3 0 d29
d2a 0 2e :3 0
d2b d2c 0 d2e
5cc d2f b53 d2e
0 d30 5d9 0
d31 5db d35 :3 0
d35 145 :3 0 5df
d35 d34 d31 d32
:6 0 d36 1 0
b24 b2f d35 fd8
:2 0 1a4 :a 0 dca
1f :7 0 5e4 342a
0 5e2 b9 :3 0
10 :3 0 11d :6 0
d3c d3b :3 0 5e8
3450 0 5e6 29
:3 0 ba :7 0 d40
d3f :3 0 6 :3 0
c4 :7 0 d44 d43
:3 0 5ec :2 0 5ea
6 :3 0 c8 :7 0
d48 d47 :3 0 29
:3 0 1a5 :7 0 d4c
d4b :3 0 d4e :2 0
dca d38 d4f :2 0
d6c d6d 0 5f4
6 :3 0 1a7 :2 0
5f2 d52 d54 :6 0
d57 d55 0 dc8
0 1a6 :6 0 8c
:3 0 8c :3 0 f0
:3 0 1a8 :3 0 1a9
:3 0 8a :3 0 1aa
:3 0 f0 :3 0 1a8
:3 0 1a9 :3 0 1aa
:3 0 f0 :3 0 1a8
:3 0 1a9 :3 0 1a6
:3 0 c3 :3 0 23
:3 0 11d :3 0 23
:4 0 1ab 1 :8 0
dc0 3 :3 0 c2
:3 0 21 :3 0 11d
:3 0 23 :3 0 d70
d71 0 d6f d72
ba :3 0 ba :3 0
d74 d75 c4 :3 0
c4 :3 0 d77 d78
97 :3 0 a0 :2 0
d7a d7b c7 :3 0
a0 :2 0 d7d d7e
c8 :3 0 c8 :3 0
d80 d81 ca :3 0
1a6 :3 0 d83 d84
cb :3 0 f0 :3 0
11d :3 0 126 :3 0
d88 d89 0 5f6
d87 d8b d86 d8c
cc :3 0 11d :3 0
13b :3 0 d8f d90
0 d8e d91 cd
:3 0 11d :3 0 13c
:3 0 d94 d95 0
d93 d96 ce :3 0
11d :3 0 13d :3 0
d99 d9a 0 d98
d9b cf :3 0 1ac
:4 0 d9d d9e d0
:3 0 11d :3 0 13e
:3 0 da1 da2 0
da0 da3 d1 :3 0
11d :3 0 13f :3 0
da6 da7 0 da5
da8 d2 :3 0 11d
:3 0 140 :3 0 dab
dac 0 daa dad
b8 :3 0 11d :3 0
bc :3 0 db0 db1
0 daf db2 5f8
d6e db4 :2 0 dc0
22 :3 0 1ad :3 0
1a5 :3 0 2b :3 0
65 :3 0 5d :3 0
bc :3 0 11d :3 0
bc :4 0 1ae 1
:8 0 dc0 609 dc9
31 :4 0 dc3 60d
dc5 60f dc4 dc3
:2 0 dc6 611 :2 0
dc9 1a4 :3 0 613
dc9 dc8 dc0 dc6
:6 0 dca 1 0
d38 d4f dc9 fd8
:2 0 1af :a 0 e3a
20 :7 0 617 366e
0 615 29 :3 0
1b0 :7 0 dcf dce
:3 0 61b 3694 0
619 29 :3 0 ba
:7 0 dd3 dd2 :3 0
6 :3 0 c4 :7 0
dd7 dd6 :3 0 61f
:2 0 61d 6 :3 0
c8 :7 0 ddb dda
:3 0 29 :3 0 1a5
:7 0 ddf dde :3 0
de1 :2 0 e3a dcc
de2 :2 0 de9 df0
0 625 10 :3 0
de5 :7 0 de8 de6
0 e38 0 12d
:6 0 1b1 :3 0 142
:3 0 11 :3 0 96
:3 0 1b0 :3 0 23
:3 0 f8 :4 0 1b2
1 :8 0 df1 12d
:3 0 11 :3 0 96
:3 0 1b0 :3 0 142
:3 0 1b1 :3 0 142
:4 0 1b3 1 :8 0
e26 145 :3 0 12d
:3 0 c8 :3 0 627
dfa dfd :2 0 e26
12d :3 0 23 :3 0
dff e00 0 2f
:2 0 62a e02 e03
:3 0 1a4 :3 0 12d
:3 0 ba :3 0 c4
:3 0 c8 :3 0 1a5
:3 0 62c e05 e0b
:2 0 e0d 632 e0e
e04 e0d 0 e0f
634 0 e26 12d
:3 0 bc :3 0 e10
e11 0 2f :2 0
636 e13 e14 :3 0
11 :3 0 23 :3 0
12d :3 0 23 :3 0
bc :3 0 12d :3 0
bc :3 0 96 :3 0
1b0 :3 0 142 :3 0
1b1 :3 0 142 :4 0
1b4 1 :8 0 e23
638 e24 e15 e23
0 e25 63a 0
e26 63c e28 f8
:3 0 df1 e26 :4 0
e35 130 :3 0 be
:3 0 ba :3 0 1b5
:3 0 c4 :3 0 1b6
:3 0 c8 :3 0 1ad
:3 0 1a5 :3 0 96
:3 0 1b0 :4 0 1b7
1 :8 0 e35 641
e39 :3 0 e39 1af
:3 0 644 e39 e38
e35 e36 :6 0 e3a
1 0 dcc de2
e39 fd8 :2 0 1b8
:a 0 f21 22 :7 0
648 3860 0 646
29 :3 0 b8 :7 0
e3f e3e :3 0 1bb
:2 0 64a b9 :3 0
6 :3 0 1b9 :6 0
e44 e43 :3 0 e46
:2 0 f21 e3c e47
:2 0 651 389d 0
64f 6 :3 0 64d
e4a e4c :6 0 e4f
e4d 0 f1f 0
1ba :6 0 655 38d1
0 653 29 :3 0
e51 :7 0 e54 e52
0 f1f 0 54
:6 0 1bd :3 0 e56
:7 0 e59 e57 0
f1f 0 1bc :6 0
659 3919 0 657
29 :3 0 e5b :7 0
e5e e5c 0 f1f
0 1be :6 0 29
:3 0 e60 :7 0 e63
e61 0 f1f 0
1bf :6 0 1c0 :a 0
e8a 23 :7 0 2f
:2 0 65b 6 :3 0
1c1 :7 0 e67 e66
:3 0 e69 :2 0 e8a
e64 e6a :2 0 1b9
:3 0 65d e6d e6e
:3 0 1b9 :3 0 1b9
:3 0 17 :2 0 19
:3 0 1a :2 0 65f
e73 e75 661 e72
e77 :3 0 17 :2 0
1c1 :3 0 664 e79
e7b :3 0 e70 e7c
0 e7e 667 e83
1b9 :3 0 1c1 :3 0
e7f e80 0 e82
669 e84 e6f e7e
0 e85 0 e82
0 e85 66b 0
e86 66e e89 :3 0
e89 0 e89 e88
e86 e87 :6 0 e8a
22 0 e64 e6a
e89 f1f :2 0 1b1
:3 0 2b :3 0 1c2
:3 0 bc :3 0 b8
:3 0 6a :3 0 f8
:4 0 1c3 1 :8 0
e94 e8c e93 26
:3 0 28 :3 0 1c4
:3 0 1c5 :3 0 1c6
:3 0 1ba :3 0 54
:3 0 1bc :3 0 1be
:3 0 1bf :3 0 22
:3 0 2b :3 0 1b1
:3 0 2b :3 0 1c7
:4 0 1c8 1 :8 0
f00 1bc :3 0 161
:3 0 1c9 :2 0 672
ea7 ea8 :3 0 1c0
:3 0 1ca :4 0 17
:2 0 1ba :3 0 675
eac eae :3 0 17
:2 0 1cb :4 0 678
eb0 eb2 :3 0 17
:2 0 91 :3 0 54
:3 0 67b eb5 eb7
67d eb4 eb9 :3 0
17 :2 0 1cc :4 0
680 ebb ebd :3 0
683 eaa ebf :2 0
ec1 685 ec2 ea9
ec1 0 ec3 687
0 f00 1be :3 0
3c :2 0 a0 :2 0
68b ec5 ec7 :3 0
1bf :3 0 3c :2 0
a0 :2 0 690 eca
ecc :3 0 ec8 ece
ecd :2 0 1c0 :3 0
1ca :4 0 17 :2 0
1ba :3 0 693 ed2
ed4 :3 0 17 :2 0
1cb :4 0 696 ed6
ed8 :3 0 17 :2 0
91 :3 0 54 :3 0
699 edb edd 69b
eda edf :3 0 17
:2 0 1cd :4 0 69e
ee1 ee3 :3 0 17
:2 0 91 :3 0 1be
:3 0 6a1 ee6 ee8
6a3 ee5 eea :3 0
17 :2 0 1ce :4 0
6a6 eec eee :3 0
17 :2 0 91 :3 0
1bf :3 0 6a9 ef1
ef3 6ab ef0 ef5
:3 0 17 :2 0 1cf
:4 0 6ae ef7 ef9
:3 0 6b1 ed0 efb
:2 0 efd 6b3 efe
ecf efd 0 eff
6b5 0 f00 6b7
f08 31 :4 0 f03
6bb f05 6bd f04
f03 :2 0 f06 6bf
:2 0 f08 0 f08
f07 f00 f06 :6 0
f0a 24 :3 0 6c1
f0c f8 :3 0 e94
f0a :4 0 f1c 1b9
:3 0 2f :2 0 6c3
f0e f0f :3 0 1c0
:3 0 1d0 :4 0 6c5
f11 f13 :2 0 f19
1c0 :3 0 1d1 :4 0
6c7 f15 f17 :2 0
f19 6c9 f1a f10
f19 0 f1b 6cc
0 f1c 6ce f20
:3 0 f20 1b8 :3 0
6d1 f20 f1f f1c
f1d :6 0 f21 1
0 e3c e47 f20
fd8 :2 0 1d2 :a 0
fd2 26 :7 0 6da
3be3 0 6d8 29
:3 0 b8 :7 0 f26
f25 :3 0 6df 3c03
0 6dc b9 :3 0
6 :3 0 1b9 :6 0
f2b f2a :3 0 f2d
:2 0 fd2 f23 f2e
:2 0 6e3 :2 0 6e1
29 :3 0 f31 :7 0
f34 f32 0 fd0
0 ea :6 0 1c0
:a 0 f5b 27 :7 0
6 :3 0 1c1 :7 0
f38 f37 :3 0 f3a
:2 0 f5b f35 f3b
:2 0 1b9 :3 0 2f
:2 0 6e5 f3e f3f
:3 0 1b9 :3 0 1b9
:3 0 17 :2 0 19
:3 0 1a :2 0 6e7
f44 f46 6e9 f43
f48 :3 0 17 :2 0
1c1 :3 0 6ec f4a
f4c :3 0 f41 f4d
0 f4f 6ef f54
1b9 :3 0 1c1 :3 0
f50 f51 0 f53
6f1 f55 f40 f4f
0 f56 0 f53
0 f56 6f3 0
f57 6f6 f5a :3 0
f5a 0 f5a f59
f57 f58 :6 0 f5b
26 0 f35 f3b
f5a fd0 :2 0 1b1
:3 0 1d3 :3 0 2b
:3 0 8d :3 0 26
:3 0 8d :3 0 28
:3 0 1c2 :3 0 1d3
:3 0 22 :3 0 8d
:3 0 1d3 :3 0 bc
:3 0 b8 :3 0 1d3
:3 0 6a :3 0 1d3
:3 0 2b :3 0 8d
:3 0 2b :3 0 8d
:3 0 1c7 :3 0 f8
:4 0 1d4 1 :8 0
f75 f5d f74 ea
:3 0 22 :3 0 2b
:3 0 1b1 :3 0 2b
:3 0 1c5 :3 0 1c6
:3 0 1d5 :3 0 1c4
:3 0 1c4 :3 0 161
:3 0 1d6 :3 0 161
:4 0 1d7 1 :8 0
fa6 22 :3 0 1c7
:3 0 161 :3 0 2b
:3 0 1b1 :3 0 2b
:4 0 1d8 1 :8 0
fa6 1c0 :3 0 1ca
:4 0 17 :2 0 1b1
:3 0 26 :3 0 f8e
f8f 0 6f8 f8d
f91 :3 0 17 :2 0
1cb :4 0 6fb f93
f95 :3 0 17 :2 0
91 :3 0 1b1 :3 0
28 :3 0 f99 f9a
0 6fe f98 f9c
700 f97 f9e :3 0
17 :2 0 1d9 :4 0
703 fa0 fa2 :3 0
706 f8b fa4 :2 0
fa6 708 fc8 31
:3 0 1c0 :3 0 1ca
:4 0 17 :2 0 1b1
:3 0 26 :3 0 fab
fac 0 70c faa
fae :3 0 17 :2 0
1cb :4 0 70f fb0
fb2 :3 0 17 :2 0
91 :3 0 1b1 :3 0
28 :3 0 fb6 fb7
0 712 fb5 fb9
714 fb4 fbb :3 0
17 :2 0 1da :4 0
717 fbd fbf :3 0
71a fa8 fc1 :2 0
fc3 71c fc5 71e
fc4 fc3 :2 0 fc6
720 :2 0 fc8 0
fc8 fc7 fa6 fc6
:6 0 fca 28 :3 0
722 fcc f8 :3 0
f75 fca :4 0 fcd
724 fd1 :3 0 fd1
1d2 :3 0 726 fd1
fd0 fcd fce :6 0
fd2 1 0 f23
f2e fd1 fd8 :3 0
fd7 0 fd7 :3 0
fd7 fd8 fd5 fd6
:6 0 fd9 :2 0 729
0 3 fd7 fdc
:3 0 fdb fd9 fdd
:8 0
743
4
:3 0 1 7 1
4 1 10 1
d 1 19 1
16 2 2e 30
1 35 2 32
37 2 39 3b
1 40 2 3d
42 2 44 46
1 49 2 59
5b 1 60 2
5d 62 2 64
66 1 6b 2
68 6d 2 6f
71 1 74 1
7e 1 82 1
8b 1 94 4
81 8a 93 9c
1 a2 1 ac
1 b6 1 c0
1 c4 1 ca
1 db 4 e1
e2 e3 e4 1
e6 1 dd 1
e9 1 f0 2
ee f0 2 f3
f5 3 fd fe
ff 1 101 1
106 2 104 106
1 10b 2 109
10b 3 113 114
115 1 117 1
11d 2 11b 11d
1 122 2 120
122 1 129 2
127 129 3 131
132 133 1 135
1 13b 2 139
13b 2 13e 140
2 145 147 3
14f 150 151 1
153 1 159 2
157 159 2 15c
15e 3 166 167
168 1 16a 1
170 2 16e 170
1 175 2 173
175 3 17d 17e
17f 1 181 1
187 2 185 187
2 18a 18c 3
194 195 196 1
198 7 19b 11a
138 156 16d 184
19a 1 19e 2
19d 19e 5 1a5
1a6 1a7 1a8 1a9
1 1ab 1 1ad
3 ec 19c 1ae
1 1b2 2 1b4
1b5 2 1b6 1b9
3 aa b4 be
1 1c2 1 1cb
1 1d4 1 1dd
1 1e6 1 1ef
1 1f8 1 201
1 20a 9 1ca
1d3 1dc 1e5 1ee
1f7 200 209 212
1 216 1 220
1 22a 1 234
1 23e 1 248
1 252 1 25c
1 266 1 270
4 27e 27f 280
281 4 287 288
289 28a 4 290
291 292 293 4
299 29a 29b 29c
4 2a2 2a3 2a4
2a5 4 2ab 2ac
2ad 2ae 4 2b4
2b5 2b6 2b7 9
27b 284 28d 296
29f 2a8 2b1 2ba
2cc 1 2cf 1
2ce 1 2d2 1
2d5 1 2d8 1
2d9 9 21e 228
232 23c 246 250
25a 264 26e 1
2e2 1 2eb 1
2f4 1 2fd 1
306 1 30f 1
318 7 2ea 2f3
2fc 305 30e 317
320 1 326 1
324 1 32e 1
334 1 337 1
33d 1 341 1
347 1 34b 1
351 1 355 1
35b 1 35f 1
365 1 369 1
36f 7 372 340
34a 354 35e 368
371 1 374 2
37b 37c 1 37e
1 380 3 32d
373 381 1 329
1 38b 1 393
1 399 1 3a0
1 39e 1 3aa
1 3af 1 3ac
1 3b2 1 3b7
2 3be 3bf 1
3c1 1 3c3 3
3b5 3c4 3c7 2
39c 3a3 1 3d0
1 3d9 1 3e2
1 3eb 4 3d8
3e1 3ea 3f3 1
3f7 1 3fc 1
403 1 401 1
40a 1 408 1
411 1 40f 1
418 1 416 1
41f 1 41d 1
43f 2 43e 43f
1 44b 4 445
448 44e 451 1
453 1 456 2
455 456 1 462
1 468 4 45c
45f 465 46b 1
46d 3 43d 454
46e 1 479 4
473 476 47c 47f
1 470 1 482
1 487 5 48e
48f 490 491 492
1 494 1 496
2 485 497 7
3fa 3ff 406 40d
414 41b 422 1
4a0 1 4a9 1
4b2 1 4bb 1
4c4 1 4cd 1
4d6 1 4df 1
4e8 1 4f1 1
4fa b 4a8 4b1
4ba 4c3 4cc 4d5
4de 4e7 4f0 4f9
502 1 506 1
50b 7 511 512
513 514 515 516
517 1 51c 4
521 522 523 524
1 538 1 53e
2 53c 53e 1
54f 1 553 2
555 556 1 571
2 577 578 1
57a 1 573 1
57d 6 519 51f
526 537 557 580
2 509 50e 1
58a 1 592 1
59d 1 5a6 1
5af 1 5b8 1
5c1 1 5ca 1
5d3 1 5dc 1
5e5 1 5ee 1
5f7 1 600 b
5ae 5b7 5c0 5c9
5d2 5db 5e4 5ed
5f6 5ff 608 1
60c 7 612 613
614 615 616 617
618 1 61d 4
622 623 624 625
2 638 652 2
658 659 1 65b
1 654 1 65e
4 61a 620 627
661 1 60f 1
671 2 67a 67d
1 674 1 686
1 68a 1 68f
3 689 68e 692
1 696 2 6a0
6a6 2 6ad 6b5
1 6a8 1 6b8
2 6bb 6bf 1
699 1 6c8 1
6d1 1 6da 1
6e3 1 6e7 1
6eb 1 6f4 1
6f8 1 6fc 1
700 1 704 1
708 1 70c 1
710 1 714 1
718 10 6d0 6d9
6e2 6e6 6ea 6f3
6f7 6fb 6ff 703
707 70b 70f 713
717 71c 1 720
1 72a 1 734
1 73e 1 748
1 752 1 75c
1 766 1 770
1 775 1 77a
1 784 1 78e
1 798 1 7a2
1 7a7 1 7ac
1 7b3 1 7b1
1 7b8 1 800
2 7ff 800 2
807 808 1 80a
1 80c 3 829
82a 82b 2 82e
830 1 836 3
838 839 83a 2
832 83c 1 842
3 844 845 846
2 83e 848 2
82d 84a 1 854
1 858 1 856
1 85b 2 861
863 1 869 2
867 869 1 86d
1 86f 4 84d
85e 866 870 3
821 824 873 1
876 1 875 1
879 1 883 2
881 883 1 888
1 88c 2 88e
88f 19 892 893
894 895 896 897
898 899 89a 89b
89c 89d 89e 89f
8a0 8a1 8a2 8a3
8a4 8a5 8a6 8a7
8a8 8a9 8aa 3
8ae 8af 8b0 2
8b6 8b7 1 8ba
3 8c1 8c2 8c3
1 8c5 1 8c7
1 8c9 3 8d0
8d1 8d2 1 8d4
1 8d6 1 8d8
3 8df 8e0 8e1
1 8e3 1 8e5
1 8e7 3 8ee
8ef 8f0 1 8f2
1 8f4 1 8f6
3 8fd 8fe 8ff
1 901 1 903
1 905 3 90c
90d 90e 1 910
1 912 1 914
3 91b 91c 91d
1 91f 1 921
1 923 3 92a
92b 92c 1 92e
1 930 1 932
3 939 93a 93b
1 93d 1 93f
1 941 3 948
949 94a 1 94c
1 94e 1 950
3 957 958 959
1 95b 1 95d
1 95f 3 966
967 968 1 96a
1 96c 4 971
972 973 974 1
979 2 977 979
3 97f 980 981
1 983 1 985
1a 7c1 7f3 7fe
80d 81a 87c 880
890 8ac 8b2 8b9
8c8 8d7 8e6 8f5
904 913 922 931
940 94f 95e 96d
976 986 989 13
728 732 73c 746
750 75a 764 76e
773 778 782 78c
796 7a0 7a5 7aa
7af 7b6 7bb 1
992 1 996 2
995 99a 1 99e
1 9ab 1 9b4
3 9b1 9b2 9b6
1 9b8 1 9ad
1 9bb 1 9c0
3 9c7 9c8 9c9
1 9cb 1 9cd
3 9be 9ce 9d1
1 9a1 1 9da
1 9de 1 9e4
1 9ea 1 9f2
1 9fa 1 a02
1 a0a 1 a12
1 a1a 1 a22
1 a2a 1 a34
1 a3a 2 a3c
a3d 1 a3e 1
a47 1 a4b 2
a4a a4f 1 a53
1 a58 1 a5d
1 a62 14 a81
a84 a87 a8a a8d
a90 a93 a96 a99
a9c a9f aa2 aa5
aa8 aab aae ab1
ab4 ab7 aba 1
ac4 2 ac8 aca
5 abb ac2 ac6
acd b12 7 a6c
a74 a77 a7c b15
b18 b1c 4 a56
a5b a60 a65 1
b25 1 b2a 2
b29 b2d 1 b31
1 b39 1 b37
1 b3f 2 b45
b49 1 b4b 1
b50 1 b57 1
b87 3 b89 b8a
b8b 1 b95 1
b97 3 b99 b9a
b9b 1 ba4 3
ba6 ba7 ba8 1
bbf 1 bd1 1
bd7 27 b7b b7e
b81 b8e b9e bab
bae bb1 bb4 bb7
bba bc2 bc5 bc8
bcb bce bd4 bda
bdd be0 be3 be6
be9 bec bef bf2
bf5 bf8 bfb bfe
c01 c04 c07 c0a
c0d c10 c13 c16
c19 1 c25 2
c27 c28 1 c2f
2 c31 c32 7
c21 c2b c35 c38
c3b c3e c41 1
c51 4 c49 c4c
c54 c57 1 c67
4 c5f c62 c6a
c6d 1 c7d 4
c75 c78 c80 c83
1 c93 4 c8b
c8e c96 c99 1
ca9 4 ca1 ca4
cac caf 1 cc2
1 cca 1 cd2
1 cda 1 ce2
9 cb7 cba cbd
cc5 ccd cd5 cdd
ce5 ce8 1 cfb
1 d03 1 d0b
1 d13 b cf0
cf3 cf6 cfe d06
d0e d16 d1b d20
d23 d26 c b59
b75 c1b c43 c59
c6f c85 c9b cb1
cea d28 d2d 1
d2f 3 b41 b4d
d30 2 b35 b3c
1 d39 1 d3e
1 d42 1 d46
1 d4a 5 d3d
d41 d45 d49 d4d
1 d53 1 d51
1 d8a 10 d73
d76 d79 d7c d7f
d82 d85 d8d d92
d97 d9c d9f da4
da9 dae db3 3
d6b db5 dbf 1
dc2 1 dc1 1
dc5 1 d56 1
dcd 1 dd1 1
dd5 1 dd9 1
ddd 5 dd0 dd4
dd8 ddc de0 1
de4 2 dfb dfc
1 e01 5 e06
e07 e08 e09 e0a
1 e0c 1 e0e
1 e12 1 e22
1 e24 4 df9
dfe e0f e25 2
e28 e34 1 de7
1 e3d 1 e41
2 e40 e45 1
e4b 1 e49 1
e50 1 e55 1
e5a 1 e5f 1
e65 1 e68 1
e6c 1 e74 2
e71 e76 2 e78
e7a 1 e7d 1
e81 2 e83 e84
1 e85 1 ea6
2 ea5 ea6 2
eab ead 2 eaf
eb1 1 eb6 2
eb3 eb8 2 eba
ebc 1 ebe 1
ec0 1 ec2 1
ec6 2 ec4 ec6
1 ecb 2 ec9
ecb 2 ed1 ed3
2 ed5 ed7 1
edc 2 ed9 ede
2 ee0 ee2 1
ee7 2 ee4 ee9
2 eeb eed 1
ef2 2 eef ef4
2 ef6 ef8 1
efa 1 efc 1
efe 3 ea4 ec3
eff 1 f02 1
f01 1 f05 1
f08 1 f0d 1
f12 1 f16 2
f14 f18 1 f1a
2 f0c f1b 6
e4e e53 e58 e5d
e62 e8a 1 f24
1 f28 2 f27
f2c 1 f30 1
f36 1 f39 1
f3d 1 f45 2
f42 f47 2 f49
f4b 1 f4e 1
f52 2 f54 f55
1 f56 2 f8c
f90 2 f92 f94
1 f9b 2 f96
f9d 2 f9f fa1
1 fa3 3 f83
f8a fa5 2 fa9
fad 2 faf fb1
1 fb8 2 fb3
fba 2 fbc fbe
1 fc0 1 fc2
1 fa7 1 fc5
1 fc8 1 fcc
2 f33 f5b 19
b 14 1d 25
4f 7a 1bf 2df
387 3cd 49d 587
5a3 668 683 6c5
98f 9d7 a44 b22
d36 dca e3a f21
fd2
1
4
0
fdc
0
1
50
29
b6
0 1 1 1 4 1 6 1
1 9 1 b 1 d 1 1
10 1 1 13 1 15 16 17
1 19 1 1 1c 1 1 1
20 1 22 22 24 1 26 26
28 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0

996 19 0
704 15 0
686 13 0
5d3 10 0
506 d 0
4cd d 0
3eb b 0
306 8 0
9d9 1 1b
7b1 15 0
ac 4 0
7a2 15 0
f35 26 27
e64 22 23
75c 15 0
de4 20 0
a58 1c 0
dcc 1 20
a46 1 1c
a53 1c 0
78e 15 0
775 15 0
696 13 0
72a 15 0
234 6 0
1d4 6 0
a5d 1c 0
784 15 0
d 1 0
7e 4 0
dcd 20 0
d39 1f 0
b25 1e 0
9da 1b 0
671 12 0
3 0 1
798 15 0
22a 6 0
1cb 6 0
e49 22 0
700 15 0
1c2 6 0
e50 22 0
720 15 0
3fc b 0
216 6 0
6c7 1 15
5ee 10 0
4e8 d 0
318 8 0
20 1 0
6fc 15 0
770 15 0
dd5 20 0
d42 1f 0
a4b 1c 0
7a7 15 0
6da 15 0
5a6 10 0
58a f 0
4a0 d 0
b31 1e 0
220 6 0
b6 4 0
f36 27 0
e65 23 0
99e 19 0
710 15 0
60c 10 0
5f7 10 0
5b8 10 0
50b d 0
4f1 d 0
4b2 d 0
3f7 b 0
3d0 b 0
399 9 0
38b 9 0
2eb 8 0
a2 4 0
16 1 0
752 15 0
f23 1 26
73e 15 0
52 1 3
766 15 0
70c 15 0
f24 26 0
e3d 22 0
992 19 0
718 15 0
68a 13 0
5ca 10 0
4c4 d 0
2fd 8 0
7d 1 4
7ac 15 0
6e7 15 0
1dd 6 0
3cf 1 b
e5f 22 0
991 1 19
e5a 22 0
b37 1e 0
a47 1c 0
252 6 0
1f8 6 0
5c1 10 0
4bb d 0
3e2 b 0
2f4 8 0
248 6 0
1ef 6 0
94 4 0
266 6 0
20a 6 0
38a 1 9
2e1 1 8
d51 1f 0
401 b 0
589 1 f
714 15 0
600 10 0
4fa d 0
b24 1 1e
40f b 0
416 b 0
e3c 1 22
5e5 10 0
4df d 0
41d b 0
30f 8 0
f30 26 0
a62 1c 0
7b8 15 0
ddd 20 0
d4a 1f 0
734 15 0
dd9 20 0
d46 1f 0
b2a 1e 0
6eb 15 0
23e 6 0
1e6 6 0
6f4 15 0
d38 1 1f
49f 1 d
f28 26 0
e41 22 0
3d9 b 0
5af 10 0
4a9 d 0
2e2 8 0
8b 4 0
708 15 0
1c1 1 6
f5d 28 0
e8c 24 0
de9 21 0
408 b 0
39e 9 0
324 8 0
6f8 15 0
25c 6 0
201 6 0
4 1 0
dd1 20 0
d3e 1f 0
6d1 15 0
68f 13 0
685 1 13
e55 22 0
27 1 2
748 15 0
6e3 15 0
5dc 10 0
4d6 d 0
66b 1 12
77a 15 0
6c8 15 0
82 4 0
5a5 1 10
0
/
 show err;
 
PROMPT *** Create  grants  BARS_BPK ***
grant EXECUTE                                                                on BARS_BPK        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_BPK        to OBPC;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_bpk.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 