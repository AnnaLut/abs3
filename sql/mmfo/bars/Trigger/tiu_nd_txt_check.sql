

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_ND_TXT_CHECK.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_ND_TXT_CHECK ***

  CREATE OR REPLACE TRIGGER BARS.TIU_ND_TXT_CHECK 
BEFORE INSERT OR UPDATE ON BARS.ND_TXT REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
   WHEN (
new.txt is not null
      ) DECLARE
 -- ver 01/12/2011
   nTmp_  number;
   sTmp_  nd_txt.txt%type ;


  tmpDat_ date;                -- � ��� ���������� �������� ���������� ����
  sDate_   date;               -- ���� ���������� ��������
  flg_ boolean;                -- ���� � ������� �������������� � ����
  i_ int;                      -- ������ ��� �����
  err_    Varchar2 (500);      -- ����� ������
  err_tag_ varchar2(250);      --  ��� ������ ���� ��������� ������

  TYPE var_date IS TABLE OF VARCHAR(20);  --   ������ ��� ��������� ������ � ����
  v_date_ var_date:=var_date(null,'ddmmyyyy','dd.mm.yyyy','ddmmyy','dd.mm.yy','yyyymmdd','yyyy.mm.dd','yymmdd','yyyyddmm','mmddyyyy','DD MONTH YYYY');
  t_    Varchar2(1);
  type_  char(1);



BEGIN

:new.txt:=trim(:new.txt);
select type into type_ from cc_tag where tag=:new.tag;
-----------------------------------------------------------------------------------------------------------------------
-- ������� ���������� ���� c ��������� �� �������� ��� (���� �������� - ���������� ����)
if type_='D' then
   i_  :=v_date_.first;
   flg_:=false;
   begin
      --select nvl(sdate,gl.BDATE-(365*20)) into sdate_ from cc_deal d where d.nd=:new.nd;
      select nvl(sdate,gl.BDATE) into sdate_ from cc_deal d where d.nd=:new.nd;
   exception when no_data_found then null;
   end;

   begin
      select '��� ���� <'||name|| '>'|| chr(13) || chr(10)
      into err_tag_ from cc_tag where tag=:new.tag;
   exception when no_data_found then err_tag_:=:new.tag;
   end;

   err_:= err_tag_|| ' ������ ����������� ������ ����';
   while flg_=false and i_<=v_date_.last
   loop
      begin
         if v_date_(i_) is null then TmpDat_:=to_date(:new.txt);
         else TmpDat_:=to_date(:new.txt,v_date_(i_),'NLS_DATE_LANGUAGE = Russian');
         end if;
         --if TmpDat_>=(bankdate-100*365) and TmpDat_<(bankdate+30*365) then flg_:=true;
         if TmpDat_>=sdate_ and TmpDat_<(bankdate+50*365) then flg_:=true;
         else
            if TmpDat_<sdate_ then
               err_:= err_tag_ ||' ������� ����� ������ ����.'||to_char(tmpDat_,'dd/mm/yyyy');
            else
               err_:= err_tag_ ||' ������� ������ ���������� ����.'||to_char(tmpDat_,'dd/mm/yyyy');
            end if;
         end if;
      EXCEPTION WHEN OTHERS THEN null;
      end;
      i_:=v_date_.next(i_);
   end loop;

   if flg_=true then  :new.txt:=to_char(tmpDat_,'dd/mm/yyyy');
   else               RAISE_APPLICATION_ERROR(-20002,err_);
   end if;

--------------------------------------------------------------------------------------------------------------------
-- �������� �� ������ �����
elsif type_ = 'N' then

   sTmp_ := Trim(:new.txt) ;

   begin
      select :new.tag || ': ��� ���� <'||name|| '>'|| chr(13) || chr(10)
      into err_tag_ from cc_tag where tag=:new.tag;
   exception when no_data_found then err_tag_:=:new.tag;
   end;

   if length( sTmp_ ) > 19 then
      err_:= substr ( err_tag_|| ' ������ ����� 19 ��������:'|| sTmp_, 1, 250 );
      RAISE_APPLICATION_ERROR(-20002,err_);
   end if;

     if not regexp_like(sTmp_,'^-?\d*(,|\.)?\d*$') then
      err_:= Substr( err_tag_ || ' ������� ���������� ��������:'|| sTmp_, 1,250);
     RAISE_APPLICATION_ERROR(-20002,err_);
     end if;

   :new.txt:= sTmp_ ;

-- �������� �� ������ ��������� PARTN
elsif type_ = 'C' then

	sTmp_ := Trim(:new.txt) ;

   begin
      	select :new.tag || ': ��� ���� <'||name|| '>'|| chr(13) || chr(10)
      	into err_tag_ from cc_tag where tag=:new.tag;
   exception when no_data_found then err_tag_:=:new.tag;
   end;

   if :new.tag = 'PARTN' and sTmp_ not in('Ta�','ͳ') then
      err_:= substr ( err_tag_|| ' �� ���������� �������� ���������'|| sTmp_||', ������� � ��������', 1, 250 );
      RAISE_APPLICATION_ERROR(-20002,err_);
   elsif :new.tag = 'PARTN' and sTmp_ in('Ta�','ͳ') then :new.txt:= sTmp_;
   end if;

end if;

END;


/
ALTER TRIGGER BARS.TIU_ND_TXT_CHECK ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_ND_TXT_CHECK.sql =========*** En
PROMPT ===================================================================================== 
