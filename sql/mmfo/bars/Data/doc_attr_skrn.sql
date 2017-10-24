
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/patch_data_DOC_ATTR.sql =========*** Ru
PROMPT ===================================================================================== 

Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_ADRES','�����: ����� ���������� �����','','SELECT TO_CHAR(S.ADRES) INTO :sValue FROM SKRYNKA_ND S WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_ADRES_CL2','�����: ������ �볺��� (����� �����)','','select nvl(max(txt),''_____________'') INTO :sValue from nd_txt where nd = :ND and tag = ''SKR_8''');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_AREND_SUM','�����: ����� �������� �����','','SELECT to_char(s_arenda/100) INTO :sValue FROM skrynka_nd WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_AREND_SUM_M','�����: ����� �������� ����� � �����','','SELECT to_char(s_arenda/100/CEIL(MONTHS_BETWEEN(dat_end,dat_begin))) INTO :sValue FROM skrynka_nd WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_AREND_SUM_M_PR','�����: ����� ������ ��� ��� ��������','','SELECT substr(f_sumpr((s_arenda/CEIL(MONTHS_BETWEEN(dat_end,dat_begin))),''980'',''F''),1,100) INTO :sValue FROM skrynka_nd WHERE nd=:ND and sos <> 15 ');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_AREND_SUM_PR','�����: ����� �������� ����� (��������)','','SELECT substr(f_sumpr(s_arenda,''980'',''F''),1,100) INTO :sValue FROM skrynka_nd WHERE nd=:ND and sos <> 15 ');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_AREND_SUM1','�����: ����� ������ ��� ���','','SELECT to_char((round(s_arenda)-round(s_nds))/100) INTO :sValue FROM skrynka_nd WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_AREND_SUM1_PR','�����: ����� ������ ��� ��� ��������','','SELECT substr(f_sumpr(s_arenda-s_nds,''980'',''F''),1,100) INTO :sValue FROM skrynka_nd WHERE nd=:ND and sos <> 15 ');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_ATRT','�����: ��� � ����� ����� �������','','SELECT ''�� ''||TO_CHAR(S.ISSUED) INTO :sValue FROM SKRYNKA_ND S WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_ATTR_CL2','�����: ��� � ����  ������� ������� �볺��� (����� �����)','','select nvl(max(txt),''_____________'') INTO :sValue from nd_txt where nd = :ND and tag = ''SKR_6''');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_DAT_BEGIN','�����: ������ ��������','','SELECT SUBSTR(F_DAT_LIT(S.DAT_BEGIN),1,25) INTO :sValue FROM SKRYNKA_ND S WHERE nd=:ND AND sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_DAT_END','�����: ��������� ��������','','SELECT SUBSTR(F_DAT_LIT(S.DAT_END),1,25) INTO :sValue  FROM SKRYNKA_ND S WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_DATZ','�����: ���� ���������� ��������','','SELECT substr(f_dat_lit(docdate),1,25) INTO :sValue FROM skrynka_nd WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_DNIKAL','�����: ���������� ����������� ���� ��������','','SELECT to_char(DAT_END-DAT_BEGIN+1) INTO :sValue FROM SKRYNKA_ND S WHERE nd=:ND AND sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_DOVER','�����: ���������� ���� (���)','','SELECT to_char(fio2) INTO :sValue FROM skrynka_nd WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_DOVER_ADRES','�����: ���������� ���� (�����)','','SELECT TO_CHAR(S.ADRES2) INTO :sValue FROM SKRYNKA_ND S WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_DOVER_ATRT','�����: ���������� ���� (��� � ����� ����� �������)','','SELECT TO_CHAR(S.ISSUED2) INTO :sValue FROM SKRYNKA_ND S WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_DOVER_DATR','�����: ���������� ���� (���� ��������)','','SELECT SUBSTR(F_DAT_LIT(S.DATR2),1,25) INTO :sValue FROM SKRYNKA_ND S WHERE nd=:ND AND sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_DOVER_DDAT2','�����: ���� ��������� ������������','','SELECT SUBSTR(F_DAT_LIT(S.DOV_DAT2),1,25) INTO :sValue FROM SKRYNKA_ND S WHERE nd=:ND AND sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_DOVER_KOD','�����: ���������� ���� (�� ���)','','SELECT okpo2 INTO :sValue FROM skrynka_nd WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_DOVER_PASP','�����: ���������� ���� (����.������)','','SELECT to_char(pasp2) INTO :sValue FROM skrynka_nd WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_DOVER_PREDST','�����: ĳ� �� ������ ������������ �����','','select nvl(max(txt),''_____________'') INTO :sValue from nd_txt where nd = :ND and tag = ''SKR_3''');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_D�VER_MR','�����: ���������� ���� (����� ��������)','','SELECT mr2 INTO :sValue FROM skrynka_nd WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_FIO','�����: ��� ���������� �����','','SELECT  case when s.custtype = 3 then TO_CHAR(S.FIO) else TO_CHAR(S.nmk) end INTO :sValue FROM SKRYNKA_ND S WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_FIO_CL2','�����: ϲ� �볺���(����� �����)','','select nvl(max(txt),''_____________'') INTO :sValue from nd_txt where nd = :ND and tag = ''SKR_4''');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_FIO_PREDST','�����: ϲ� ������������ �����','','select nvl(max(txt),''_____________'') INTO :sValue from nd_txt where nd = :ND and tag = ''SKR_1'' ');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_KEY','�����: ����� �����','','SELECT to_char(s.keynumber) INTO :sValue FROM skrynka_nd n, skrynka s WHERE n.nd=:ND and n.sos <> 15 and n.n_sk=s.n_sk');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_KOD','�����: ����������������� ��� ��, ���� ��','','SELECT okpo1 INTO :sValue FROM skrynka_nd WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_KOD_CL2','�����: ���  ������ �볺��� (����� �����)','','select nvl(max(txt),''_____________'') INTO :sValue from nd_txt where nd = :ND and tag = ''SKR_7''');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_MFOK','�����: ��� ���������� ����� ������� ��','','SELECT to_char(mfok) INTO :sValue FROM skrynka_nd WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_MR','�����: ����� �������� ����������','','SELECT mr INTO :sValue FROM skrynka_nd WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_NAME_SKRN','�����: ����� ��������(�����)','','select trim(t.name) INTO :sValue  from  skrynka_nd n, skrynka_tip t  ,  skrynka s where  s.o_sk = t.o_sk and N.n_sk = s.n_sk and  n.nd = :ND');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_ND','�����: ����� ��������','','SELECT to_char(ndoc) INTO :sValue FROM skrynka_nd WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_NDNI','�����: ���������� ���� ������','','SELECT to_char(dat_end - dat_begin+1) INTO :sValue FROM skrynka_nd WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_NDS_SUM','�����: ����� ���','','SELECT to_char(round(s_nds/100,2)) INTO :sValue FROM skrynka_nd WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_NDS_SUM_PR','�����: ����� ��� (��������)','','SELECT substr(f_sumpr(s_nds,''980'',''F''),1,100) INTO :sValue FROM skrynka_nd WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_NLS','�����: �������������� ���� 2909 �����','','SELECT a.nls INTO :sValue FROM skrynka_nd sn, skrynka_acc sa, accounts a WHERE sn.nd=:ND and sn.sos <> 15 and sn.n_sk = sa.n_sk and sa.acc = a.acc');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_NLSK','�����: ��������� ���� ������� ��','','SELECT to_char(nlsk) INTO :sValue FROM skrynka_nd WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_NMK','�����: ������������ ������� ��','','SELECT to_char(nmk) INTO :sValue FROM skrynka_nd WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_NO','�����: � ����������� �����','','SELECT TO_CHAR(S.SNUM) INTO :sValue FROM SKRYNKA S, SKRYNKA_ND N  WHERE N.nd=:ND and n.sos <> 15 and n.n_sk = s.n_sk');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_PASP','�����: � � ����� ��������','','SELECT TO_CHAR(S.DOKUM) INTO :sValue FROM SKRYNKA_ND S WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_PASP_CL2','�����: ������� �볺��� (����� �����)','','select nvl(max(txt),''_____________'') INTO :sValue from nd_txt where nd = :ND and tag = ''SKR_5''');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_PASP_PREDST','�����: ������� ������������ �����','','select nvl(max(txt),''_____________'') INTO :sValue from nd_txt where nd = :ND and tag = ''SKR_2''');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_STAF_ADRESS','�����: ������ ��������','','select NVL(MAX(d.adress),''_______'')  INTO :sValue from  skrynka_staff d where tip = 1 and activ = 1');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_STAF_DOVER','�����: ���������� ���������','','select NVL(MAX(d.dover),''_______'')  INTO :sValue from  skrynka_staff d where tip = 1 and activ = 1');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_STAFF_APPROVED','�����: ��� � ���� ���������� ������','','select NVL(MAX(d.APPROVED),''_______________'')   INTO :sValue from  skrynka_staff d where  tip = 1 and activ = 1');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_STAFF_MODETIME','�����: ����� ������ ��������','','select NVL(MAX(d.mode_time),''__:__-__:__'')   INTO :sValue from  skrynka_staff d where tip = 1 and activ = 1');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_STAFF_TOWN','�����: �������� - ����','','select NVL(NVL(MAX(d.TOWN), branch_usr.get_branch_param(''TOWN'')),''_______'')  INTO :sValue from  skrynka_staff d where  tip = 1 and activ = 1');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_STAFF_WEEKEND','�����: ������� ��','','select NVL(MAX(d.WEEKEND),''_______________'')   INTO :sValue from  skrynka_staff d where  tip = 1 and activ = 1');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_STAF_MFO','�����: ������ ��������','','select NVL(MAX(d.mfo),''_______'')  INTO :sValue from  skrynka_staff d where  tip = 1 and activ = 1');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_STAF_POSADA','�����: ������ ���������','','select NVL(MAX(d.posada),''_______'')  INTO :sValue from  skrynka_staff d where  tip = 1 and activ = 1');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_STAF_POSADAR','�����: ������ ��������� �������� ������','','select NVL(MAX(d.posada_r),''_______'')  INTO :sValue from  skrynka_staff d where  tip = 1 and activ = 1');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_STAF_STAFF','�����: ��������','','select NVL(MAX(d.fio),''_______'')  INTO :sValue from  skrynka_staff d where  tip = 1 and activ = 1');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_STAF_STAFFR','�����: �������� �������� ������','','select NVL(MAX(d.fio_r),''_______'')  INTO :sValue from  skrynka_staff d where  tip = 1 and activ = 1');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_STAF_TELEFON','�����: ������ ��������','','select NVL(MAX(d.telefon),''_______'')  INTO :sValue from  skrynka_staff d where  tip = 1 and activ = 1');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_#tariff','�����: � ������� ������','','select max(nn)
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
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_TEL','�����: �������','','SELECT tel INTO :sValue FROM skrynka_nd WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_TYPE_DOG','��� ����� 2 - ��, 3 - ��, 4 - ��+��','','SELECT  case s.custtype when 2 then 2 else nvl((select  4 from nd_txt where nd = s.nd and tag = ''SKR_4''),3)  end INTO :sValue FROM SKRYNKA_ND S WHERE nd=:ND and sos <> 15');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_ZALOG','�����: ��������� �����','','select to_char(gl.p_icurval(980,t.s,bankdate)) INTO :sValue from  skrynka_nd n, skrynka_tip t  ,  skrynka s where  s.o_sk = t.o_sk and N.n_sk = s.n_sk and  n.nd = :ND');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_ZALOG_DAT','�����: ���� ��������� ������','','select ''�� ''||SUBSTR(F_DAT_LIT( r.bdate ),1,25) INTO :sValue from  skrynka_nd n, skrynka_nd_ref r, opldok o, skrynka_acc s where   n.nd = :ND and o.ref = r.ref and s.acc = o.acc and N.n_sk = s.n_sk and s.tip = ''M''');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_ZALOG_PR','�����: ��������� ����� (��������)','','select substr(f_sumpr(gl.p_icurval(980,t.s,bankdate)*100,''980'',''F''),1,100) INTO :sValue from skrynka_nd n, skrynka_tip t  ,  skrynka s where  s.o_sk = t.o_sk and N.n_sk = s.n_sk and  n.nd = :ND');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL) VALUES ('SKRN_ZALOG_REF','�����: �������� ��������� ������','','select ''�''||r.ref INTO :sValue from   skrynka_nd n, skrynka_nd_ref r, opldok o, skrynka_acc s where   n.nd = :ND and o.ref = r.ref and s.acc = o.acc and N.n_sk = s.n_sk and s.tip = ''M''');
    exception when dup_val_on_index then null;
end;
/
COMMIT;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/patch_data_DOC_ATTR.sql =========*** En
PROMPT ===================================================================================== 
