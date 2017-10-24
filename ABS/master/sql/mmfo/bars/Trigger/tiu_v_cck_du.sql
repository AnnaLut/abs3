

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_V_CCK_DU.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_V_CCK_DU ***

  CREATE OR REPLACE TRIGGER BARS.TIU_V_CCK_DU INSTEAD OF  UPDATE or delete  on  V_CCK_DU REFERENCING NEW AS NEW OLD AS OLD  FOR EACH ROW
declare
  l_nd  number   ; l_rnk number       ;  JJ arjk%rowtype     ;
  DAT1_old date  ; DAT1_new date      ;  DAT2_old date       ; DAT2_new date ;    dat1_ date    ; dat2_ date    ;
  daos_    date  ; Mode_ int          ;  sErr_ varchar2(55)  := '\      ����������i ����';
  aa     accounts%rowtype ;
  a2701  accounts%rowtype ;   a2708  accounts%rowtype ;
  dd     cc_deal%rowtype  ;
  l_acra number ;
  l_acrb number ;
  l_acc  number  ;
  l_2233 int ;
------------------
BEGIN
  DAT1_old := :old.DAT1 ;  DAT1_new := :new.DAT1 ;
  DAT2_old := :old.DAT2 ;  DAT2_new := :new.DAT2 ;
  l_nd     := :old.ND   ;  l_rnk    := :old.rnk  ;

  if deleting then     delete from nd_txt where nd = l_nd and tag in ( 'DO_DU',  'DINDU','ARJK');
     return;
  end if;

  If :new.arjk is null  then       raise_application_error(-20203,'�� ������ ��� ��������', TRUE);
  end if;

  begin
     select * into JJ from arjk where id = :new.arjk;
  exception when no_data_found then  raise_application_error(-20203,'�� �������� ��� �������� ' || :new.arjk, TRUE);
  end;

  If  DAT1_new < :old.SDATE  OR   DAT2_new > :old.WDATE then     raise_application_error(-20203,
'DIU: ���� ��������� � ��� ='|| to_char(DAT1_new ,'dd.mm.yyyy') || ' �����  ���� ������� ��='|| to_char(:old.SDATE ,'dd.mm.yyyy')|| '
 ��� ���� ���������� � ����='|| to_char(DAT2_new ,'dd.mm.yyyy') || ' �I���� ���� ������. ��='|| to_char(:old.WDATE ,'dd.mm.yyyy'),
TRUE);
  end if;

  If DAT1_new < JJ.dat1 then    raise_application_error(-20203,
'DIU: ���� ��������� � ��� ='|| to_char(DAT1_new ,'dd.mm.yyyy')  || ' �����  ���� �i������� ����='|| to_char(JJ.dat1 ,'dd.mm.yyyy') ||
' ' || JJ.name ,   TRUE);
  end if;

  ---------------------
  cck_app.Set_ND_TXT( p_ND  =>l_nd,   p_TAG =>'ARJK',   p_TXT => to_char(JJ.id) );

  If      DAT2_new is null  -- ���� ���������� �����
     AND (DAT1_new is not null  and DAT1_old is null  -- ���� ��������� �� �����  � �� ����� ����.��������
          or
          DAT1_new <> DAT1_old
          ) then
      -- ��������  ��
      cck_app.Set_ND_TXT( p_ND  =>l_nd,   p_TAG =>'DO_DU',   p_TXT =>to_char(null) );
      cck_app.Set_ND_TXT( p_ND  =>l_nd,   p_TAG =>'DINDU',   p_TXT => to_char(DAT1_new,'dd/mm/yyyy')  );
      mode_ := 1;
  elsIf   DAT1_new = DAT1_old      -- ���� ��������� �� ����������
     and  DAT2_new is not null     -- ���� ���������� ������
     and  DAT2_new >= DAT1_new     -- ���� ����������   >= ���� ���������
   then
     -- ������� �� ��
     cck_app.Set_ND_TXT( p_ND  =>l_nd,   p_TAG =>'DO_DU',   p_TXT =>to_char(DAT2_new,'dd/mm/yyyy') );
     mode_ := 2;

  elsIf  DAT1_new is null and DAT1_old is not null     -- ���� ��������� ����� , ���������� �� �����
   then
     -- �������, ��� ������ �� ��
     delete from nd_txt x where x.nd = l_nd and x.tag in ('DO_DU','DINDU');
     mode_ := 2;
  else

     raise_application_error(-20203,sErr_ ||'
���� ������   �� ='||to_char(:old.SDATE ,'dd.mm.yyyy')|| '
���� �������� �� ='||to_char(:old.WDATE ,'dd.mm.yyyy')|| '
���� ����. � ��� ='||to_char(DAT1_new   ,'dd.mm.yyyy')|| '
���� ����. � ��� ='||to_char(DAT1_old   ,'dd.mm.yyyy')|| '
���� ����.�� ����='||to_char(DAT2_new   ,'dd.mm.yyyy')|| '
���� ������  ����='||to_char(JJ.dat1    ,'dd.mm.yyyy') ,   TRUE);
   end if ;

   -- ���� �������
   begin
      select a.acc into l_2233  from accounts a, nd_acc n where n.nd = l_nd and n.acc= a.acc and a.nbs ='2233' and ostc<0 and rownum =1;

/*
      If mode_ =2  and nvl( :new.r013, '*' ) not in ('1','9') then
         raise_application_error(-20203,'R013 ('||:new.r013||') HE = 1 ��� 9 ', TRUE);
      end if;
*/

   exception when no_data_found then l_2233 :=0;
   end;


   If ( getglobaloption('MFOP') = '300465' or gl.aMfo = '300465' )  then

     -- ������ ��� ��. ����������.
     for k in (select a.acc, a.nbs , a.accc
               from accounts a
               where rnk = l_rnk and tip in ('SS ','SN ','SP ','SK9','SPN','SK0','ZAL')
                 and exists (select 1 from nd_acc n  where n.nd=l_nd and n.acc= a.acc  union all
                             select 1 from nd_acc n, cc_accp z where n.nd=l_nd and n.acc= z.accs and z.acc= a.acc
                             )
              )
     loop
        if    mode_ = 1 then           --�������� � �-�����
           --1) �������� RNK
           begin
             execute immediate   'insert into RNKP_KOD (rnk, kodk) values ( ' || l_rnk || ',' ||  JJ.id || ') ';
           Exception when dup_val_on_index then null;
           end;

           --2) �������� ACC
           Begin
             Insert into accountsw (acc, tag, value) values (k.ACC, 'CORPV', 'Y');
           Exception when dup_val_on_index then
             Update accountsw w set w.value = 'Y' where w.acc = k.ACC and w.tag = 'CORPV';
           End;

           If l_2233 > 0 then
/*
�������� �.�. <SchevchenkoSI@oschadnybank.com>
��������  �������
����:    ��������� ������������ �������������� ���������� �.�.
³� ����:    ��������� ����������-��������� ������������ ��������������� ����� �������� �.�.
����    28.08.2013
REF �:    13/1-03/85
����:    ���� ������������� ��� ����� Millennium�

��������� � ������� ������ �� 02.09.2013 � ��� ���� ������������ ��������� ����������� ����������� ���������� ��������� �� ���������, ���������� ����:
- ��������� R013=2 �� S580=6 �� ���������, �� ������������ �� ���.2233 ;
- ��������� R013=5 �� S580=6 �� ���/���  , �� ������������ �� ���.2238  (������, ��������� �������� 30 ���).
  � ����� ������� ������� �� ������� 2238 ������� ����������� �� 2 �������: �������, ��������� �������� 30 ��� � ����������� R013=5 �� S580=6
                                                                         �� �������, ��������� ����� 30 ��� � ����������� R013=6 �� S580=6;
- ��������� S580=6 �� ��� �������� ������� �� ��������� ������� (���. 2233) � ����� ���������� �������, ���������� ���� (��������� ������� 2400, 9500).
*/
              If    k.nbs = '2233'  then  update specparam set r013 = '2', s580 = '6' where acc = k.acc ;
                                          update specparam set r013 = '2', s580 = '6' where acc = k.accc;
              elsIf k.nbs = '2238' then   update specparam set r013 = '5', s580 = '6' where acc = k.acc ;
              else                        update specparam set             s580 = '6' where acc = k.acc ;
              end if;
           end if;

        elsif mode_ = 2 then
           --��������� �� �-������ = ��������� ACC
/*

��� �������� ������� �� ���� �������������� �������� R013 "1" ��� "9" ���������� ��.

R020  R013
2233  1    ��������.������.������� �i�.������ � ��,�� ���������� �������� �����.����� ����.�����������,�� �������� ������������ �� � ������ �� ��������
2233  2    ������������ ������� �������, ����� �������� ������ �� ������� �� ������ ���������� �������� �� ���������� ����������, ���������� ���������� ���������, ����� �� 50% ������������� ���� ��� �������� ������ ��/��� ��������� ������
2233  9    ���� ������������ ������� �������, �� ����� �i������ ������
*/

           delete from accountsw w where w.acc = k.ACC and w.tag = 'CORPV';
           If l_2233 > 0 then

              If    k.nbs = '2233'  then  update specparam set r013 = :new.r013, s580=4       where acc = k.acc ;
                                          update specparam set r013 = :new.r013, s580=4       where acc = k.accc;

              elsIf k.nbs = '2238' then   update specparam set r013 = '3' , s580=4    where acc = k.acc ;
--            else                        update specparam set                        where acc = k.acc ;
              end if;

           end if;
        end if;
     end loop;
  end if;

  If JJ.NLS_2809  is not null and mode_ = 1 then

     --������������ ���� � ���
     select  a.* into aa from accounts a where tip='SS ' and acc in (select acc from nd_acc where nd = l_ND);
     a2701.nls := vkrzn( substr(gl.amfo,1,5),  '27010' || l_nd );

     -- ��������� �������� � ������������� ������ � �� �� ���� ������� 2701
     cck.CC_OP_NLS ( ND_  => l_nd,     KV_  => 980 , NLS_ => a2701.nls  , TIP_PRT => 'DIU' ,  ISP_  => aa.isp,
                     GRP_ => aa.grp,  P080_ => null, MDA_ => aa.mdate, ACC_    => l_acc );
     update accounts set rnk = JJ.rnk where acc = l_acc;


     a2708.nls := vkrzn( substr(gl.amfo,1,5),  '27080' || l_nd );

     -- ��������� �������� � ������������� ������ � �� �� ��������� ��� 2708
     cck.CC_OP_NLS ( ND_  => l_nd,     KV_  => 980 , NLS_ => a2708.nls  , TIP_PRT => 'DIU' ,  ISP_  => aa.isp,
                     GRP_ => aa.grp,  P080_ => null, MDA_ => aa.mdate, ACC_    => l_acra );

     update accounts set rnk = JJ.rnk where acc = l_acra;

     begin
       select acc  into l_acrb from accounts where JJ.nls_7061 = nls and kv=980;
     exception when no_data_found then  raise_application_error(-20203,'�� �������� ���.7061 ��� ��������=' || JJ.id, TRUE);
     end;

     Insert into INT_ACCN (ACC,ID,METR,BASEM,BASEY,FREQ, ACR_DAT, ACRA,ACRB) Values (l_acc,1,0,0,0,1,gl.bdate-1, l_acra, l_acrb );
     Insert into INT_RATN (ACC,ID,BDAT,IR) Values (l_acc,1 ,gl.bdate, JJ.ir);

  END IF;

end TIU_v_cck_du ;


/
ALTER TRIGGER BARS.TIU_V_CCK_DU ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_V_CCK_DU.sql =========*** End **
PROMPT ===================================================================================== 
