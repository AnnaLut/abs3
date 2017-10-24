

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TGR_ND_TXT.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TGR_ND_TXT ***

  CREATE OR REPLACE TRIGGER BARS.TGR_ND_TXT 
BEFORE INSERT OR UPDATE OR DELETE ON BARS.ND_TXT
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
/******************************************************************************
   NAME:       tgr_nd_txt

   PURPOSE:
 24-11-2015 DAV ������� ���������� ������� ��� ����������� ������ ������ �������� �������� �������� � ���� �� �������


 28-02-2013 ��� ���������������� ��������� ����� ������� ����������� ����� ���������� ��� �� ����
            :NEW.TAG = 'DAYSS' ��� ������ ���� �� ������� � � ������ ��_tag �� ��������.

 26-02-2013 �� ������� ��� ������ ����������� ������ ���� �������� ����� ���. ��������,
            TAG - NPROD ��� ������ ���� �� ������� � � ������ ��_tag �� ��������.

 14-08-2012 OLGA �������� ����� ��� FREQP - ������������� ��������� %%

 26-10-2011 Sta+Olga
            ��������� LIM �� ����.�����, �.�. ����������� ���������
 23-03-2011  Nov �������� �������� �� ���������� FLAGS
                �������� ����� ��� FREQ - ������������� ��������� �����


           ��� ���� ������ � ����� ����.

               1. �������� ������������ ����� ��������� ���. ����������
                   'ZAYxx' - �������� �� ������ ����� �� ������ �� �� �� ����
                   'FLAGS' - ��� � ��� ��������� ��. ������������� v_cc_flags
                   'FREQ'  - ��������� �������������� ��������� ��������� �����
                   'S_SDI' - ����� ��������
                   'R_CR9' - ���������� ������ �� ���������������� �����
                   'SN8_R' - ���������� ������ ���� (����� ������������ ������� ��
                              ��. ��������� SPN_BRI)
                             + ������ ����. ������ ���� �� ��� �������
                               ������  c ������� ���������� ����
                             � �����������  ������� ������� � ��������  �� ���� (id=2)
                   'DAYSN' - ���� ��������� %
                   'DATSN' - ������ ���� ��������� %
                   'S260'  - ����������� ������������� �� ���� ������ ��������


               2. ������� ������� TIU_ND_TXT_NBU
                                  TIU_ND_TXT_SLV
                  ��� ����������� ������

******************************************************************************/

DECLARE


 tmpVar NUMBER(20,4);

 l_new_SN8_R number(20,4):=null;
 l_old_SN8_R number(20,4):=null;
 nTemp int;
 dTemp date;
 SPN_BRI_ int;
 err_ Varchar2(150);
 flg_ boolean;
 i_ int:=0;                      -- ���������� ��� �����
 l_vidd  number;

 TYPE var_date IS TABLE OF VARCHAR(20);  --   ������ ��� ��������� �������������� � ����
 v_date_ var_date:=var_date(null,'ddmmyyyy','dd.mm.yyyy','ddmmyy','dd.mm.yy','yyyymmdd','yyyy.mm.dd','yymmdd','yyyyddmm','mmddyyyy','DD MONTH YYYY');


 /******************************************************************************/
 --   PRAGMA AUTONOMOUS_TRANSACTION;
 --  ���������� ��� ����������� ���������� ������ �������� ������ ����� ��������
 --  � �������� ����� ����������

  function  get_nd_txt( p_nd number, -- ����� ��������
                        p_tag1 varchar2, -- ���, �������� �������� ����� �������� ��� ��������, ��� ����������� �������������
                        p_tag2 varchar2, -- ��� ��� �������� ����� �������� (���� ��� �� �� ��������� ��� �� ����)
                        p_txt varchar2   -- �������� ���� ��� �������� ����� �������� (���� ��� �� �� ��������� ��� �� ����)
                      ) return varchar2
  IS
    pragma autonomous_transaction;
  begin
    if p_tag1<> p_tag2 then
    return (cck_app.Get_ND_TXT(p_nd,p_tag1));
    else
    return p_txt;
    end if;
  end;


BEGIN
  tmpVar := 0;
  flg_:=false;

------------------------------ �������� �� ������ ����� �� ������ �� �� �� ����-----------------
------------------------------��. cck_dop.cc_open ----------------------------

  if INSERTING OR UPDATING then
   if trim(:NEW.TXT) is not null then

     if :NEW.TAG in ('ZAY0P','ZAY2P','ZAY4P','ZAY6P','ZAY8P') then
       begin
         select pawn into tmpVar from cc_pawn where pawn=:NEW.TXT and pawn not in (select pawn from cc_pawn where nbsz=9031);
       exception when others then raise_application_error(-20100,'������� �� i������ �������� ���� �������!');
       end;
     end if;

     if :NEW.TAG in ('ZAY1P','ZAY3P','ZAY5P','ZAY7P','ZAY9P') then
       begin
         select pawn into tmpVar from cc_pawn where pawn=:NEW.TXT and pawn  in (select pawn from cc_pawn where nbsz=9031);
       exception when others then raise_application_error(-20100,'������� �� i������ �������� ���� ������!');
       end;
     end if;

     if :NEW.TAG like 'ZAY_S' then
       begin
         select to_number(translate(:NEW.TXT,'.',','),'99999999999D99', ' NLS_NUMERIC_CHARACTERS = '',.''')
           into tmpVar from dual;
       exception when others then raise_application_error(-20100,'������� �� �i��� ���� ������� = '||:NEW.TXT);
       end;
     end if;

     if :NEW.TAG like 'ZAY_R' then
       begin
         select rnk into tmpVar from customer  where rnk=:NEW.TXT;
       exception when others then raise_application_error(-20100,'�������� �� �i���� ��� ���������� = '||:NEW.TXT);
       end;
     end if;

   end if;

  end if;

--------------------------- ������������� ��������� ��������� ����� -----------------------------------------

  if :new.TAG='FREQ' then
     begin
       select freq into tmpVar from freq where freq=to_number(:NEW.TXT);
     EXCEPTION  WHEN OTHERS THEN RAISE_APPLICATION_ERROR (-20000,'���������� �� ����� ��� ����������� ��������� ��������� ����� FREQ='||:NEW.TXT);
     end;
     update cc_add set freq=to_number(:new.TXT) where nd=:NEW.ND and adds=0;
  end if;

--------------------------- ������������� ��������� %% -----------------------------------------

  if :new.TAG='FREQP' then
     begin
       select freq into tmpVar from freq where freq=to_number(:NEW.TXT);
     EXCEPTION  WHEN OTHERS THEN RAISE_APPLICATION_ERROR (-20000,'���������� �� ����� ��� ����������� ��������� %% FREQP='||:NEW.TXT);
     end;
     update int_accn set freq = to_number(:new.TXT)
      where id = 0 and acc = (select a.acc
                                from nd_acc n, accounts a
                               where n.nd = :NEW.ND and n.acc = a.acc and a.tip = 'LIM' and a.nls like '8999%');
  end if;

-------------------------- ����� ------------------------------------

  if :new.TAG='FLAGS' then
     begin
      select kod into tmpVar from v_cc_flags where kod=:NEW.TXT;
     EXCEPTION  WHEN OTHERS THEN  RAISE_APPLICATION_ERROR (-20000,'������ �������� ��� ������ ��������  FLAGS='||:NEW.TXT);
     end;
  end if;

-------------------------- ������� ------------------------------------

  if :NEW.TAG like 'S_SDI' then
     begin
       select cck_app.to_number2(:NEW.TXT) into tmpVar from dual;
     exception when others then  raise_application_error(-20100,'������� �� �i��� ���� ���i�i�(��������) = '||:NEW.TXT);
     end;
  end if;

-------------------------- ������� ����������� ------------------------------------

  if :NEW.TAG = 'PR_TR' and :NEW.TXT is not null then
     -- �������� �������� ������������ � ��������� (������!, ������� - �����)
     if :OLD.TXT = 0 and :NEW.TXT = 1 then raise_application_error(-20100,'��������� ����������� ����������� �� � ��������!');   end if;
     if :OLD.TXT = 1 and nvl(:NEW.txt,0) = 0 then
         delete from cc_trans where acc in (select acc from nd_acc where nd = :NEW.ND);
     end if;
     select vidd into l_vidd from cc_deal where nd = :NEW.ND;
     begin
     -- �������� ������������ �����
       select cck_app.to_number2(:NEW.TXT) into tmpVar from dual;
     exception when others then  raise_application_error(-20100,'������� ���������� ������ ���������� '||:NEW.TXT);
     end;
     -- �������� ������������ ��������
     if tmpVar not in (0,1) then  raise_application_error(-20100,'������� ���i��� ������ ���������� '||:NEW.TXT); end if;
     -- ������������� ��������� ����������� ��� ������������ ��
     if (tmpVar = 1 and l_vidd = 1) then raise_application_error(-20100,'��������� ���������� ������ ������� ��� ������������ �� ��!'); end if;
     -- �������� ����������������
     if (tmpVar = 1 and nvl(get_nd_txt(:NEW.ND,'I_CR9',:NEW.TAG, :NEW.TXT),0) = 1) then raise_application_error(-20100,'��������� ���������� ������ ������� ��� ������������� ��!'); end if;
  end if;

------------------------- �������������� ���------------------------------

  if :NEW.TAG like 'R_CR9' and :NEW.TXT is not null then
     begin
       select cck_app.to_number2(:NEW.TXT) into tmpVar from dual;
     exception when others then raise_application_error(-20100,'������� �� �i��� % ������ ��������������� ���� !'||:NEW.TXT);
     end;
  end if;

------------------------- ���� ---------------------------------------------

  if :NEW.TAG = 'SN8_R' or :OLD.TAG = 'SN8_R' then
     begin
       if :NEW.TXT is not null then
            :NEW.TXT:=translate(:NEW.TXT,',-','.');
            select cck_app.to_number2(:NEW.TXT) into l_new_SN8_R from dual;
       end if;
     exception when others then raise_application_error(-20100,'�� ���� ������ ������� ��� = '||:NEW.TXT);
     end;
     begin
       select abs(cck_app.to_number2(:OLD.TXT)) into l_old_SN8_R from dual;
     exception when others then l_old_SN8_R:=null;
     end;
     if nvl(l_new_SN8_R,-1)!=nvl(l_old_SN8_R,-1) then
         SPN_BRI_ := to_number(GetGlobalOption('SPN_BRI')) ; -- ������� ������ ����;
         if SPN_BRI_ is not null then
            delete from int_ratn i where i.id=2 and i.bdat=gl.bdate and i.acc in
                       (select a.acc from nd_acc n,accounts a,int_accn ia where n.nd=nvl(:OLD.ND,:NEW.ND)
                           and ia.acc=a.acc and ia.id=2 and ia.acra is not null and ia.acrb is not null
                           and n.acc=a.acc and a.tip in ('SP ','SL ','SPN','SLN','SK9'));
            -- ���� l_new_SN8_R=null ����� ������ ������� ������
            INSERT INTO INT_RATN (ACC,ID,BDAT,IR,op,br)
                           select a.acc,2,gl.bdate, nvl(l_new_SN8_R,2), decode(l_new_SN8_R,null,3,null),decode(l_new_SN8_R,null,SPN_BRI_,null)
                             from nd_acc n,accounts a,int_accn ia
                             where n.nd=nvl(:OLD.ND,:NEW.ND) and ia.acc=a.acc and ia.id=2
                               and ia.acra is not null and ia.acrb is not null
                               and n.acc=a.acc and a.tip in ('SP ','SL ','SPN','SLN','SK9');
         end if;
     end if;
  end if;


----------------- �������� ����� � �����  ���  ��������� ����  ------------


    if :NEW.TAG = 'DAYSS' and :NEW.TXT is not null  then
     begin
         :NEW.TXT:=translate(:NEW.TXT,',-','.');
         select cck_app.to_number2(:NEW.TXT)
           into nTemp
           from dual;
      if nTemp>31 or nTemp<1 then
         err_:='�� ���� ������� ���� ��������� ��������� ����� = ';
      else
         :NEW.TXT:=to_char(nTemp);
         update int_accn set s=nTemp where id=0 and acc in ( select a.acc from accounts a, nd_acc na where a.tip='LIM' and a.acc=na.acc and na.nd=:NEW.ND);
      end if;
     exception when others then
      err_:='�� ���� ������� ���� ��������� ��������� ����� = ';
     end;
    end if;



------------------ �������� ����� ��� � ���� ������� ��������� % ------------

  if :NEW.TAG = 'DAYSN' and :NEW.TXT is not null  then
       begin
         :NEW.TXT:=translate(:NEW.TXT,',-','.');
         select cck_app.to_number2(:NEW.TXT) into nTemp from dual;
         if nTemp>31 or nTemp<1 then err_:='�� ���� ������� ���� ��������� ������� = ';
         else :NEW.TXT:=to_char(nTemp);
         end if;
       exception when others then err_:='�� ���� ������� ���� ��������� ������� = ';
       end;
  end if;

  if :NEW.TAG = 'DATSN' and :NEW.TXT is not null  then
       i_:=v_date_.first;
       while flg_=false and i_<=v_date_.last
         loop
            begin
               if v_date_(i_) is null then dTemp:=to_date(:NEW.TXT);
               else dTemp:=to_date(:NEW.TXT,v_date_(i_),'NLS_DATE_LANGUAGE = Russian');
               end if;

               if dTemp>=(nvl(bankdate,sysdate)-100*365) and dTemp<(nvl(bankdate,sysdate)+30*365) then
                  flg_:=true;
                    :NEW.TXT:=to_char(dTemp,'dd/mm/yyyy') ;
               else  select (case when dTemp<=a.bdate then '���� ��������� �� ���� ���� ������ ���� ������! '||:NEW.TXT
                                  when dTemp>=d.wdate then '���� ��������� �� ���� ���� ����� ���� ��������� ��������!'||:NEW.TXT
                                  else null
                             end)
                       into err_
                       from cc_deal d,cc_add a
                      where d.nd=a.nd and d.nd=:NEW.ND;
               end if;
            EXCEPTION WHEN OTHERS THEN null;
            end;
         i_:=v_date_.next(i_);
         end loop;
       if flg_=false then  err_:='�� ���� ������� ������ ���� ������� ��������� �������. ';
       end if;
  end if;

------------------------- �������� �������������� -------------------------

--------------------------- S260 -----------------------------------------

  if :new.TAG='S260' then
     if :new.TXT is not null then
        :new.TXT:=lpad (:new.TXT,2,'00');
        begin
           select s260 into tmpVar from kl_s260 where s260=:NEW.TXT;
           EXCEPTION  WHEN OTHERS THEN RAISE_APPLICATION_ERROR (-20000,'������ �������� ��� ����������� S260');
        end;
     end if;
     update specparam set S260=:new.TXT  where acc in (select a.acc from accounts a,nd_acc n
                                                        where n.nd=:NEW.ND and n.acc=a.acc and  a.dazs is null
                                                          and a.tip in ('SS ','SP ','SL ','SN ','SPN','SK0','SK9','CR9','LIM'));
  end if;

--------------------------- ������� ����������� �������������  ����� � ������� �� �� -----------------------------------------

  if :new.TAG='SPOK'  then
     Insert into BARS.CC_SOB (     ND,    FDAT,   ID,  ISP,                                                                                  TXT, OTM, FREQ)
                      Values (:new.ND, sysdate, null,  gl.aUID, '������ ���������� �������,  ������������ ������ � '||:OLD.TXT ||' �� '||:NEW.TXT,   6,    2);
  end if;


------------------------- ����� �������� ��� ��� ------------------------------

  if :NEW.TAG = 'NPROD' and :NEW.TAG is not null then
    update cc_deal set prod=:NEW.TXT where nd=:NEW.ND;
     Insert into BARS.CC_SOB (     ND,    FDAT,   ID,  ISP,                                                                                  TXT, OTM, FREQ)
                      Values (:new.ND, sysdate, null,user_id, '������ ��� �������� �� '||:NEW.TXT,   6,    2);
  end if;

if err_ is not null then
     raise_application_error(-20100,err_||:NEW.TXT);
end if;

END tgr_nd_txt;


/
ALTER TRIGGER BARS.TGR_ND_TXT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TGR_ND_TXT.sql =========*** End *** 
PROMPT ===================================================================================== 
