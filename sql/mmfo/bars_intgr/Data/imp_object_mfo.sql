prompt bars_intgr/Data/imp_object_mfo.sql

prompt CLIENTFO2
insert /*+ ignore_row_on_dupkey_index(IMP_OBJECT_MFO, XPK_IMP_OBJECT_MFO) */ into imp_object_mfo(kf, object_name, changenumber)
select kf, 'CLIENTFO2', 0 from bars.mv_kf;
commit;

prompt CLIENT_ADDRESS
insert /*+ ignore_row_on_dupkey_index(IMP_OBJECT_MFO, XPK_IMP_OBJECT_MFO) */ into imp_object_mfo(kf, object_name, changenumber)
select kf, 'CLIENT_ADDRESS', 0 from bars.mv_kf;
commit;

prompt ACCOUNTS
insert /*+ ignore_row_on_dupkey_index(IMP_OBJECT_MFO, XPK_IMP_OBJECT_MFO) */ into imp_object_mfo(kf, object_name, changenumber)
select kf, 'ACCOUNTS', 0 from bars.mv_kf;
commit;

prompt BPK2
insert /*+ ignore_row_on_dupkey_index(IMP_OBJECT_MFO, XPK_IMP_OBJECT_MFO) */ into imp_object_mfo(kf, object_name, changenumber)
select kf, 'BPK2', 0 from bars.mv_kf;
commit;

prompt DEPOSITS2
insert /*+ ignore_row_on_dupkey_index(IMP_OBJECT_MFO, XPK_IMP_OBJECT_MFO) */ into imp_object_mfo(kf, object_name, changenumber)
select kf, 'DEPOSITS2', 0 from bars.mv_kf;
commit;

prompt ACCOUNTS_CASH
insert /*+ ignore_row_on_dupkey_index(IMP_OBJECT_MFO, XPK_IMP_OBJECT_MFO) */ into imp_object_mfo(kf, object_name, changenumber)
select kf, 'ACCOUNTS_CASH', 0 from bars.mv_kf;
commit;
