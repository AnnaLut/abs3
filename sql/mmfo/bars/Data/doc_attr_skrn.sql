
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/patch_data_DOC_ATTR.sql =========*** Ru
PROMPT ===================================================================================== 

Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_ADRES','Сейфы: адрес арендатора сейфа','','SELECT TO_CHAR(S.ADRES) INTO :sValue FROM SKRYNKA_ND S WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_ADRES_CL2','Сейфы: Адреса клієнта (друга особа)','','select nvl(max(txt),''_____________'') INTO :sValue from nd_txt where nd = :ND and tag = ''SKR_8''');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_AREND_SUM','Сейфы: сумма арендной платы','','SELECT to_char(s_arenda/100) INTO :sValue FROM skrynka_nd WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_AREND_SUM_M','Сейфы: сумма арендной платы в месяц','','SELECT to_char(s_arenda/100/CEIL(MONTHS_BETWEEN(dat_end,dat_begin))) INTO :sValue FROM skrynka_nd WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_AREND_SUM_M_PR','Сейфы: сумма аренды без НДС прописью','','SELECT substr(f_sumpr((s_arenda/CEIL(MONTHS_BETWEEN(dat_end,dat_begin))),''980'',''F''),1,100) INTO :sValue FROM skrynka_nd WHERE nd=:ND and sos <> 15 ');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_AREND_SUM_PR','Сейфы: сумма арендной платы (прописью)','','SELECT substr(f_sumpr(s_arenda,''980'',''F''),1,100) INTO :sValue FROM skrynka_nd WHERE nd=:ND and sos <> 15 ');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_AREND_SUM1','Сейфы: сумма аренды без НДС','','SELECT to_char((round(s_arenda)-round(s_nds))/100) INTO :sValue FROM skrynka_nd WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_AREND_SUM1_PR','Сейфы: сумма аренды без НДС прописью','','SELECT substr(f_sumpr(s_arenda-s_nds,''980'',''F''),1,100) INTO :sValue FROM skrynka_nd WHERE nd=:ND and sos <> 15 ');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_ATRT','Сейфы: кем и когда выдан паспорт','','SELECT ''від ''||TO_CHAR(S.ISSUED) INTO :sValue FROM SKRYNKA_ND S WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_ATTR_CL2','Сейфы: Ким і коли  виданий Паспорт клієнта (друга особа)','','select nvl(max(txt),''_____________'') INTO :sValue from nd_txt where nd = :ND and tag = ''SKR_6''');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_DAT_BEGIN','Сейфы: начало договора','','SELECT SUBSTR(F_DAT_LIT(S.DAT_BEGIN),1,25) INTO :sValue FROM SKRYNKA_ND S WHERE nd=:ND AND sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_DAT_END','Сейфы: окончание договора','','SELECT SUBSTR(F_DAT_LIT(S.DAT_END),1,25) INTO :sValue  FROM SKRYNKA_ND S WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_DATZ','Сейфы: дата заключения договора','','SELECT substr(f_dat_lit(docdate),1,25) INTO :sValue FROM skrynka_nd WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_DNIKAL','Сейфы: количество календарных дней договора','','SELECT to_char(DAT_END-DAT_BEGIN+1) INTO :sValue FROM SKRYNKA_ND S WHERE nd=:ND AND sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_DOVER','Сейфы: доверенное лицо (ФИО)','','SELECT to_char(fio2) INTO :sValue FROM skrynka_nd WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_DOVER_ADRES','Сейфы: доверенное лицо (адрес)','','SELECT TO_CHAR(S.ADRES2) INTO :sValue FROM SKRYNKA_ND S WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_DOVER_ATRT','Сейфы: доверенное лицо (кем и когда выдан паспорт)','','SELECT TO_CHAR(S.ISSUED2) INTO :sValue FROM SKRYNKA_ND S WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_DOVER_DATR','Сейфы: доверенное лицо (дата рождения)','','SELECT SUBSTR(F_DAT_LIT(S.DATR2),1,25) INTO :sValue FROM SKRYNKA_ND S WHERE nd=:ND AND sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_DOVER_DDAT2','Сейфы: дата окончания доверенности','','SELECT SUBSTR(F_DAT_LIT(S.DOV_DAT2),1,25) INTO :sValue FROM SKRYNKA_ND S WHERE nd=:ND AND sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_DOVER_KOD','Сейфы: доверенное лицо (ид код)','','SELECT okpo2 INTO :sValue FROM skrynka_nd WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_DOVER_PASP','Сейфы: доверенное лицо (пасп.данные)','','SELECT to_char(pasp2) INTO :sValue FROM skrynka_nd WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_DOVER_PREDST','Сейфы: Діє на підставі уповноважена особа','','select nvl(max(txt),''_____________'') INTO :sValue from nd_txt where nd = :ND and tag = ''SKR_3''');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_DОVER_MR','Сейфы: доверенное лицо (место рождения)','','SELECT mr2 INTO :sValue FROM skrynka_nd WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_FIO','Сейфы: ФИО арендатора сейфа','','SELECT  case when s.custtype = 3 then TO_CHAR(S.FIO) else TO_CHAR(S.nmk) end INTO :sValue FROM SKRYNKA_ND S WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_FIO_CL2','Сейфы: ПІБ клієнта(друга особа)','','select nvl(max(txt),''_____________'') INTO :sValue from nd_txt where nd = :ND and tag = ''SKR_4''');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_FIO_PREDST','Сейфы: ПІБ уповноваженої особи','','select nvl(max(txt),''_____________'') INTO :sValue from nd_txt where nd = :ND and tag = ''SKR_1'' ');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_KEY','Сейфы: номер ключа','','SELECT to_char(s.keynumber) INTO :sValue FROM skrynka_nd n, skrynka s WHERE n.nd=:ND and n.sos <> 15 and n.n_sk=s.n_sk');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_KOD','Сейфы: идентификационный код ФЛ, ОКПО ЮЛ','','SELECT okpo1 INTO :sValue FROM skrynka_nd WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_KOD_CL2','Сейфы: Код  РНОКПП клієнта (друга особа)','','select nvl(max(txt),''_____________'') INTO :sValue from nd_txt where nd = :ND and tag = ''SKR_7''');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_MFOK','Сейфы: МФО расчетного счета клиента ЮЛ','','SELECT to_char(mfok) INTO :sValue FROM skrynka_nd WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_MR','Сейфы: место рождения арендатора','','SELECT mr INTO :sValue FROM skrynka_nd WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_NAME_SKRN','Сейфы: Назва скриньки(розмір)','','select trim(t.name) INTO :sValue  from  skrynka_nd n, skrynka_tip t  ,  skrynka s where  s.o_sk = t.o_sk and N.n_sk = s.n_sk and  n.nd = :ND');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_ND','Сейфы: номер договора','','SELECT to_char(ndoc) INTO :sValue FROM skrynka_nd WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_NDNI','Сейфы: количество дней аренды','','SELECT to_char(dat_end - dat_begin+1) INTO :sValue FROM skrynka_nd WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_NDS_SUM','Сейфы: сумма НДС','','SELECT to_char(round(s_nds/100,2)) INTO :sValue FROM skrynka_nd WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_NDS_SUM_PR','Сейфы: сумма НДС (прописью)','','SELECT substr(f_sumpr(s_nds,''980'',''F''),1,100) INTO :sValue FROM skrynka_nd WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_NLS','Сейфы: индивидуальный счет 2909 сейфа','','SELECT a.nls INTO :sValue FROM skrynka_nd sn, skrynka_acc sa, accounts a WHERE sn.nd=:ND and sn.sos <> 15 and sn.n_sk = sa.n_sk and sa.acc = a.acc');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_NLSK','Сейфы: расчетный счет клиента ЮЛ','','SELECT to_char(nlsk) INTO :sValue FROM skrynka_nd WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_NMK','Сейфы: наименование клиента ЮЛ','','SELECT to_char(nmk) INTO :sValue FROM skrynka_nd WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_NO','Сейфы: № депозитного сейфа','','SELECT TO_CHAR(S.SNUM) INTO :sValue FROM SKRYNKA S, SKRYNKA_ND N  WHERE N.nd=:ND and n.sos <> 15 and n.n_sk = s.n_sk');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_PASP','Сейфы: № и серия паспорта','','SELECT TO_CHAR(S.DOKUM) INTO :sValue FROM SKRYNKA_ND S WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_PASP_CL2','Сейфы: Паспорт клієнта (друга особа)','','select nvl(max(txt),''_____________'') INTO :sValue from nd_txt where nd = :ND and tag = ''SKR_5''');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_PASP_PREDST','Сейфы: Паспорт уповноваженої особи','','select nvl(max(txt),''_____________'') INTO :sValue from nd_txt where nd = :ND and tag = ''SKR_2''');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_STAF_ADRESS','Сейфы: Адреса відділення','','select NVL(MAX(d.adress),''_______'')  INTO :sValue from  skrynka_staff d where tip = 1 and activ = 1');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_STAF_DOVER','Сейфы: Довіренність менеджера','','select NVL(MAX(d.dover),''_______'')  INTO :sValue from  skrynka_staff d where tip = 1 and activ = 1');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_STAFF_APPROVED','Сейфы: Ким і коли затверджені тарифи','','select NVL(MAX(d.APPROVED),''_______________'')   INTO :sValue from  skrynka_staff d where  tip = 1 and activ = 1');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_STAFF_MODETIME','Сейфы: Режим роботи відділення','','select NVL(MAX(d.mode_time),''__:__-__:__'')   INTO :sValue from  skrynka_staff d where tip = 1 and activ = 1');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_STAFF_TOWN','Сейфы: Менеджер - місто','','select NVL(NVL(MAX(d.TOWN), branch_usr.get_branch_param(''TOWN'')),''_______'')  INTO :sValue from  skrynka_staff d where  tip = 1 and activ = 1');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_STAFF_WEEKEND','Сейфы: Вихіддні дні','','select NVL(MAX(d.WEEKEND),''_______________'')   INTO :sValue from  skrynka_staff d where  tip = 1 and activ = 1');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_STAF_MFO','Сейфы: Адреса відділення','','select NVL(MAX(d.mfo),''_______'')  INTO :sValue from  skrynka_staff d where  tip = 1 and activ = 1');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_STAF_POSADA','Сейфы: Посада менеджера','','select NVL(MAX(d.posada),''_______'')  INTO :sValue from  skrynka_staff d where  tip = 1 and activ = 1');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_STAF_POSADAR','Сейфы: Посада менеджера родовому відмінку','','select NVL(MAX(d.posada_r),''_______'')  INTO :sValue from  skrynka_staff d where  tip = 1 and activ = 1');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_STAF_STAFF','Сейфы: Менеджер','','select NVL(MAX(d.fio),''_______'')  INTO :sValue from  skrynka_staff d where  tip = 1 and activ = 1');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_STAF_STAFFR','Сейфы: Менеджер родовому відмінку','','select NVL(MAX(d.fio_r),''_______'')  INTO :sValue from  skrynka_staff d where  tip = 1 and activ = 1');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_STAF_TELEFON','Сейфы: Адреса відділення','','select NVL(MAX(d.telefon),''_______'')  INTO :sValue from  skrynka_staff d where  tip = 1 and activ = 1');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_#tariff','Сейфы: № позиції тарифа','','select max(nn)
 from (
 select rownum nn, t.name,  daysfrom, daysto, t2.s as sump,t.s  , s.nd, decode(t2.s,S.SD/100,1,0) as t
  from skrynka_tip t, skrynka_tariff tf, skrynka_tariff2 t2 , skrynka_nd s
  where t.o_sk = tf.o_sk
and TF.TARIFF = T2.TARIFF
and (t2.tariff, t2.tariff_date)
in  ( select tariff, max(tariff_date)
from skrynka_tariff2
where tariff_date <= S.DAT_BEGIN and tariff = t2.tariff group by tariff )
and S.ND = :ND
and S.TARIFF = T2.TARIFF
  Order by T.O_SK, daysfrom )
  where t = 1');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_TEL','Сейфы: телефон','','SELECT tel INTO :sValue FROM skrynka_nd WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_TYPE_DOG','Тип угоди 2 - ЮО, 3 - ФО, 4 - ФО+ФО','','SELECT  case s.custtype when 2 then 2 else nvl((select  4 from nd_txt where nd = s.nd and tag = ''SKR_4''),3)  end INTO :sValue FROM SKRYNKA_ND S WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_ZALOG','Сейфы: залоговая сумма','','select to_char(gl.p_icurval(980,t.s,bankdate)) INTO :sValue from  skrynka_nd n, skrynka_tip t  ,  skrynka s where  s.o_sk = t.o_sk and N.n_sk = s.n_sk and  n.nd = :ND');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_ZALOG_DAT','Сейфы: дата документа залога','','select ''від ''||SUBSTR(F_DAT_LIT( r.bdate ),1,25) INTO :sValue from  skrynka_nd n, skrynka_nd_ref r, opldok o, skrynka_acc s where   n.nd = :ND and o.ref = r.ref and s.acc = o.acc and N.n_sk = s.n_sk and s.tip = ''M''');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_ZALOG_PR','Сейфы: залоговая сумма (прописью)','','select substr(f_sumpr(gl.p_icurval(980,t.s,bankdate)*100,''980'',''F''),1,100) INTO :sValue from skrynka_nd n, skrynka_tip t  ,  skrynka s where  s.o_sk = t.o_sk and N.n_sk = s.n_sk and  n.nd = :ND');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_ZALOG_REF','Сейфы: Референс документа залога','','select ''№''||r.ref INTO :sValue from   skrynka_nd n, skrynka_nd_ref r, opldok o, skrynka_acc s where   n.nd = :ND and o.ref = r.ref and s.acc = o.acc and N.n_sk = s.n_sk and s.tip = ''M''');
    exception when dup_val_on_index then null;
end;
/
COMMIT;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/patch_data_DOC_ATTR.sql =========*** En
PROMPT ===================================================================================== 
