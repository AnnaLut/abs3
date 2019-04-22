set pagesize 100 
set linesize 4000
set trims ON
set serverout ON size 1000000
set feedback on
set pause off
set heading off
set spool on

column mfo new_value mfo 
accept mfo prompt '������� ��� ��� ������ ������ ����������� �������� � ������� �������. �����  - ��� ���'
column rnk new_value rnk 
accept rnk prompt '������� RNK ������� ��� ������ ������������ ��������. ����� - ��� �������'

spool D:\adr_replace.log

select '��������� ��� ������: ��� = '||decode(nvl('&mfo','-'),'-','���',to_char('&mfo'))||', RNK = '||decode(nvl('&rnk','-'),'-','���',to_char('&rnk'))
  from dual;
set termout off
set feedback off

declare 
  v_num integer;
begin
  select count(1) into v_num
    from user_tables 
    where table_name = 'TMP_ADDR_UPDATE';
  if v_num = 0 then
    execute immediate 'create table tmp_addr_update (kf varchar2(6), rnk number, dt_update date,
                               domain_old varchar2(30), domain_new varchar2(30),
                               region_old varchar2(30), region_new varchar2(30),
                               locality_old varchar2(30), locality_new varchar2(30),
                               address_old varchar2(100), address_new varchar2(100),
                               street_old varchar2(100), street_new varchar2(100),
                               home_old varchar2(100), home_new varchar2(100),
                               room_old varchar2(100), room_new varchar2(100),
                               zip_old varchar2(20), zip_new varchar2(20))';
  end if;
end;
/


declare 
  -- Local variables here
  v_rowids sys.odciridlist;
  v_cnt number;
  v_cnt_upd number;
  v_rnk number := to_number('&rnk');
  v_limit number := null;
  v_flag integer;
  v_rec customer_address%rowtype;
  v_start_time timestamp := systimestamp;
  v_okpo customer.okpo%type;
  v_kf_start_time timestamp := systimestamp;

  function translate_field (p_str in varchar2,
                            p_flag in number default 0) 
    return varchar2
    is 
    v_ret varchar2(2000) := replace(p_str,'''','"');
    v_pos number;
    v_sql varchar2(1000);
    v_num integer;
  begin
--    dbms_output.put(v_ret||' -> ');
    -- �.3 �������� ��������� - #������!
    v_ret := trim(replace(replace(v_ret,'#������!'),'#������!'));

    if v_ret like '%�%' then
      v_ret := replace(v_ret,'�','-');
    end if;


    -- �.5
    -- ���� ��� ���� ����������� ���� � ������ �������, ����� �� �����, ���� ������������ ������� ����, �� �������� ����
    if nvl(p_flag,0) > 0 then
--      v_ret := regexp_replace(upper(v_ret),'^(.)\1+$');
      if regexp_like(upper(v_ret),'^(.)\1+$') then
        return null;
      end if;
    end if;
    if v_ret is null then
      return null;
    end if;
    
    -- �.6
    -- ���� ��� ���� ����������� �������� � ������ �������, ��������� ������ (����� �� ����� ������), �� �������� ����
    if not regexp_like(v_ret,'[[:alnum:]]') then
      return null;
    end if;



    -- �.7
    -- ���� � ���� 4 �� ����� ���������� �������, �������� ������������� ���������� ���� �� ������� ([]{};':",.<>) � ��������, �������� �� QWERTY / ������ ���������. 
    if length(v_ret)-length(regexp_replace(v_ret,'[a-zA-Z]'))>=4 then
      v_ret := initcap(translate(v_ret,'������`QWERTYUIOPASDFGHJKLZXCVBNM{qwertyuiopasdfghjklzxcvbnm[<:,;^��','--''''''''''����������Բ����������������������������������������������'));
    else
    -- �.8
    --���� � ��� 3 ��� ����� ���������� �������, �������� ����� ���������� ���� ��������� �����
    -- ��������� "�" ������� �� ��������� "�"
    --��������� "�" ������� �� ��������� "�"
      v_ret := translate(v_ret,'iIpP','����');
    end if;

    -- �.9
    -- ������� "\" �� "/" (����) 
    v_ret := replace(v_ret,'\','/');
    
    -- �.10
    -- "^" ���������� ��������
    v_ret := rtrim(v_ret,'^');
    
    -- �.11
    -- �������� ������ ������ (.)
    v_ret := ltrim(v_ret,'.');
    
    -- �.12
    -- ������� #��� �� ����, ���� �� ������ ������ �������/����� � ���
    if v_ret like '%#���' then
      v_ret := replace(v_ret,'#���','����');
    end if;

    -- �.13
    -- ������� #��� �� ����, ���� �� ������ ������ �������/����� � ���
    if v_ret like '%#���' then
      v_ret := replace(v_ret,'#���','����');
    end if;

    -- �.14 
    -- ������� #� �� ��, ���� �� ������ ��� �������/����� � ���
    if v_ret like '%#�' then
      v_ret := replace(v_ret,'#�','��');
    end if;
   
-- �.33
--�������� �������� ������� 
--� (���������� �������)
--' (��������)
    if nvl(p_flag,0)>0 then
      v_ret := rtrim(rtrim(rtrim(v_ret,'�'),''''),'*');
    end if;

    -- �.15
    -- "������� �� �������� ������� �������:
    -- ""`""
    -- ""�""
    -- ""�""
    -- ""@"" 
    -- ������ �����                                                                                                     
    v_ret := replace(replace(v_ret,chr(38)||'Quo',''''),chr(38)||'Qu','''');
    v_ret := translate(v_ret,chr(38)||'`��"','''''''''''');
    
    
    -- �.17
    -- "������ ��������� ��������� �������� :
    -- ���� ����� ""*"" ����� ���� � ���� �,�,�,�,�,� �� ��������� ���� ""*"" ����� ���� � ���� �,�,�,� , 
    -- �� ������� ����� ""*"" �� ��������. � ���� ������� ����� �� ����������"
    v_ret := regexp_replace(v_ret,'([������������])(\*)([�ު�����])','\1''\3');
    
    --�.18
    -- "~�" ������� �� "��"
    v_ret := replace(v_ret,'~�','��');
    
    --�.19
    -- ������ "�" ������� �� "�"
    v_ret := translate(v_ret,'��','��');
    
    -- �.21
    -- ����� "�"  ������� �� "�"
    v_ret := replace(v_ret,'��','��');
    
    -- �.20
    -- "������� �� ����� ������� ������� �� ���������:
    --����  (�)
    --""-="" 
    --""=-""
    --""="""
    v_ret := regexp_replace(translate(v_ret,'�=','--'),'([ =])([-])|([-])([ =])','-');
    
    -- �.21
    /*
      "- ��������� ������� ��������� ������� � ""1"" �� �����, �� ������� ������ � ���� �� ""1"" �� � ������� ""�"":
      ""1�"" �� ""��""
      ""�1"", ���� ��������� ������ ����� ��� �� ������ ������� ���� - �������  �� ""��""
      ""�1�"" �� ""��""
      ""�1�"" �� ""��""
      ""�1�"" �� ""��""
      ""�1�"" �� ""��""
      ""�1"", ���� ��������� ������ ����� ��� �� ������ ������� ���� - �������  �� ""��""
      - ������� ""1"" �� ""�"",  �� �����, �� ������ ���� �� ""1""  � ������ ""�"""
    */
    if p_flag = 2 then
      if v_ret like '%i1' then
        v_ret := replace(v_ret,'i1','i�');
      end if;
      v_ret := replace(regexp_replace(v_ret,'([������])([1])','\1�'),'1�','��');
--      v_ret := regexp_replace(v_ret,'([:�-�-�])([1])','\1�');
    end if;
-- ���� ���� ���������� ���� � ����-����� 1 ������� (��������� ����� �� �����, "�����"), �������� ����
    if length(v_ret) = 1 and nvl(p_flag,0) > 0 then -- �.4
      return null; 
    end if;

    -- �.22
    -- ������� !- �� 1- � ��� ������
    if p_flag = 2 and v_ret like '%!-%' then
      v_ret := replace(v_ret,'!-','1-');
    end if;
  
    if p_flag = 1 then 
    -- �.23
    -- ������� �� 1 �� "�", �������, ���� 1 ����� �� ������� �����, �� ������� �� ������ "�". 
    -- � ���� ������ �� �������, �� ������������ �� "�" ����� � ������� ����� �� "�".
      if v_ret not like '%-%1%' and not regexp_like(v_ret,'^[[:digit:]]+$') then
        v_ret := replace(replace(replace(regexp_replace(v_ret,'^1','I'),' 1',' �'),'1','�'),'��','��');
      end if;
    -- �.26
    --"�������  ������� ��������� �������, ���� ���� ������ �� ������� ����:
    -- ""�/""  �� ""�.""
    --""�,"" �� ""�.""
    --""�>"" �� ""�.""
    --""�,""  �� ""�.""
    --""�/""  �� ""�.""
    --""���,""  �� ""���.""
    --""���/""  �� ""���."""
      v_ret := regexp_replace(ltrim(v_ret),'^((�)|(�)|(�)|(���))[/,>?]','\1.');
    end if;
    
    -- �.24
    -- ������� "�", "�" (���������� ������ �������), "�", "�" (���������� ������ �������) �� �������� ������� ���������� �� ���������� ��������
    v_ret := translate(v_ret,'����','����');
    
    -- �.25
    -- "�������  ������� ��������� �������, ���� ���� ������ �� ������� ����:
    -- ""���,"" �� ""���.""
    -- ""���/"" �� ""���.""
    --""����,"" �� ""����.""
    --""����/"" �� ""����.""
    --""���,"" �� ""���.""
    --""���/"" �� ""���."""
    if p_flag = 2 then
      v_ret := regexp_replace(v_ret,'^((���)|(����)|(���))[,/]','\1.');
    end if;
    
    
--�.26
--�������� ������ �� �������� ������� � ������
-- ���� (,) 
--2 ���� (,,)
--���� ����� ���� (, ,)
-- ���� (/)
--���� ����� ()"

    v_ret := ltrim(rtrim(ltrim(rtrim(v_ret,','),','),'/'),'/');
    if v_ret like ',,%' then 
      v_ret := substr(v_ret,3);
    end if;
    if v_ret like '%,,' then
      v_ret:=substr(v_ret,1,length(v_ret)-2);
    end if;
    if v_ret like ', ,%' then
      v_ret := substr(v_ret,4);
    end if;
    if v_ret like '%, ,' then
      v_ret:=substr(v_ret,1,length(v_ret)-3);
    end if;
    if v_ret like '()%' then 
      v_ret := substr(v_ret,3);
    end if;
    if v_ret like '%()' then
      v_ret:=substr(v_ret,1,length(v_ret)-2);
    end if;

    -- �.28
    -- ���� ��������� ". " (������ �����) ����� �� ������� ����� ��� ���� ���� ��� ������� ����� �����, �� �������� ". "
    v_ret := replace(ltrim(v_ret,'. '),'.-','-');
    
    -- �.29
    -- �������� ����� ����-���� ���� ��������� ������� �� ���� ��� ����� ������ (��� ���� �� ����). ��������� �����, ���� ������ ������� �� ����������
    v_ret := regexp_replace(v_ret,'([^[:alnum:]])\1+','\1');

    -- �.30
    -- �������� ������ �� �������� ������
    v_ret := trim(v_ret);
    
-- �.31
-- ������ ��������� ��������� �������� :
-- ���� ����� "@" ����� ���� � ���� �,�,�,�,�,� �� ��������� ���� "@" ����� ���� � ���� �,�,�,� , �� ������� ����� "@" �� ��������. � ���� ������� ������ "@" ��������
    v_ret := regexp_replace(v_ret,'([������������])(@)([�ު�����])','\1''\3');
    v_ret := replace(v_ret,'@','');



/*    if regexp_like(v_ret,'[�-�]') then
      v_ret := initcap(v_ret);
    end if;
*/    
    return v_ret;
  end;

begin

  for b in (select * from mv_kf where kf = nvl('&mfo',kf)) loop
    v_kf_start_time := systimestamp;
    bc.go(b.kf);
    v_okpo := f_ourokpo;
    v_cnt := 0;
    v_cnt_upd := 0;
dbms_output.put_line('mfo = '||b.kf);
    dbms_application_info.set_action('start select kf = '||b.kf);
    for cln in (select ca.rowid, ca.*
                  from customer_address ca, 
                       customer c,
                       codcagent cc
                  where (c.custtype = 3 or (c.custtype=2 and c.sed=91))
                    and c.kf = b.kf 
                    and ca.kf = b.kf
                    and c.rnk = ca.rnk 
                    and c.okpo != v_okpo
                    and c.rnk = nvl(v_rnk,c.rnk)
                    and c.date_off is null
                    and c.codcagent = cc.codcagent
                    and cc.rezid = 1
                    and ((v_limit is not null and rownum< nvl(v_limit,1)) or 
                         (v_limit is null))
)
    loop 
        select * into v_rec from customer_address where rowid = cln.rowid;
        v_cnt := v_cnt +1;
        dbms_application_info.set_action('kf = '||b.kf||'('||v_cnt||')');
         v_rec.locality := translate_field(cln.locality,1);

         v_rec.region   := translate_field(cln.region,3);

--  ���� ���� ������ ���������� �� ���� �� ����� "�" (��������� ��� ���������), �� ������� "�" �� ����� "0"
         if regexp_count(cln.zip,'\d') = 5 and length(cln.zip)>5 then
           v_rec.zip := regexp_replace(cln.zip,'[^[:digit:]]');
         else 
           v_rec.zip := cln.zip;
         end if;
         if v_rec.zip like '%O%' or v_rec.zip like '%�%' then
           v_rec.zip      := regexp_replace(translate(v_rec.zip,'O�','00'),'\D');  -- translate= �.4
         end if;

         if cln.zip like '%O%' or cln.zip like '%�%' then
           if regexp_count(cln.zip,'\d') = 5 then
             v_rec.zip      := regexp_replace(cln.zip,'[^[:digit:]]');
           else 
             v_rec.zip      := regexp_replace(translate(cln.zip,'O�','00'),'\D');  -- translate= �.4
           end if;
         end if;
-- �.6 ��� ������� ��������
         if length(v_rec.zip) = 1 then
           v_rec.zip := null;
         end if;

         v_rec.domain   := translate_field(cln.domain,1);

         v_rec.address  := translate_field(cln.address);

         v_rec.street   := translate_field(cln.street,2);

-- �.34
--"���������� ����� ���������� ���� �� ����� �������� ��������� �����:
--� �� �
--� �� �
--� �� �
--� �� �
--� �� �
--� �� �
--� �� �
--� �� �

         v_rec.home     := translate(cln.home,'AaBbIiTtKkPhHhMm','���ⲳ����������');
    -- �.24
    -- ������� "�", "�" (���������� ������ �������), "�", "�" (���������� ������ �������) �� �������� ������� ���������� �� ���������� ��������
         v_rec.home := translate(v_rec.home,'����','����');

         v_rec.home     := translate_field(v_rec.home);

         v_rec.room     := translate_field(cln.room);
         v_rec.room := translate(v_rec.room,'����','����');



           if   nvl(v_rec.domain,'�') != cln.domain
             or nvl(v_rec.region,'�') != cln.region
             or nvl(v_rec.locality,'�') != cln.locality
             or nvl(v_rec.address,'�') != cln.address
             or nvl(v_rec.street,'�') != cln.street
             or nvl(v_rec.home,'�') != cln.home
             or nvl(v_rec.room,'�') != cln.room
             or nvl(v_rec.zip,'�') != cln.zip then
             
             update customer_address
               set domain = v_rec.domain,
                   region = v_rec.region,
                   locality = v_rec.locality,
                   address = v_rec.address,
                   street = v_rec.street,
                   home = v_rec.home,
                   room = v_rec.room,
                   zip = v_rec.zip
               where rowid = cln.rowid;
             insert into tmp_addr_update 
               select b.kf, cln.rnk, sysdate,
                      case v_rec.domain
                        when cln.domain then null
                        else cln.domain
                      end,
                      case v_rec.domain
                        when cln.domain then null
                        else v_rec.domain
                      end,
                      case v_rec.region
                        when cln.region then null
                        else cln.region
                      end,
                      case v_rec.region
                        when cln.region then null
                        else v_rec.region
                      end,
                      case v_rec.locality
                        when cln.locality then null
                        else cln.locality
                      end,
                      case v_rec.locality
                        when cln.locality then null
                        else v_rec.locality
                      end,
                      case v_rec.address
                        when cln.address then null
                        else cln.address
                      end,
                      case v_rec.address
                        when cln.address then null
                        else v_rec.address
                      end,
                      case v_rec.street
                        when cln.street then null
                        else cln.street
                      end,
                      case v_rec.street
                        when cln.street then null
                        else v_rec.street
                      end,
                      case v_rec.home
                        when cln.home then null
                        else cln.home
                      end,
                      case v_rec.home
                        when cln.home then null
                        else v_rec.home
                      end,
                      case v_rec.room
                        when cln.room then null
                        else cln.room
                      end,
                      case v_rec.room
                        when cln.room then null
                        else v_rec.room
                      end,
                      case v_rec.zip
                        when cln.zip then null
                        else cln.zip
                      end,
                      case v_rec.zip
                        when cln.zip then null
                        else v_rec.zip
                      end
                 from dual;
                 v_cnt_upd := v_cnt_upd + 1;
                 if v_cnt_upd - round(v_cnt_upd,-3) = 0 then
--                   rollback;
                   commit;
                   null;
                 end if;
           end if;
          commit;    
--        rollback;
      end loop;
      dbms_output.put_line('KF = '||b.kf||': time - '||to_char(systimestamp - v_kf_start_time)||'(start '||to_char(v_kf_start_time,'hh24:mi:ssx')||', end '||to_char(systimestamp,'hh24:mi:ss')||'), count = '||v_cnt||', upd = '||v_cnt_upd);
    bars.bc.home;
  end loop;
  
  dbms_output.put_line('Total time = '||to_char(systimestamp - v_start_time)||'(start '||to_char(v_start_time,'hh24:mi:ssx')||', end '||to_char(systimestamp,'hh24:mi:ss')||', upd = '||v_cnt_upd);

end;
/

spool off
