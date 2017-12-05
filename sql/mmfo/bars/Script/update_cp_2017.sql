prompt ##############################################
prompt 1. ���� � �������� ������� �� �� ���
prompt ##############################################
----------------------------------------
begin EXECUTE IMMEDIATE 'alter table bars.CP_ACCC add ( D_Close date) ';
exception when others then   if SQLCODE = -01430 then null;   else raise; end if;   -- ORA-01430: column being added already exists in table
end;
/
COMMENT ON COLUMN BARS.CP_ACCC.D_Close IS '���� ���� ���.�����';
------------------------------------------------
begin EXECUTE IMMEDIATE 'alter table bars.CP_RYN add ( D_Close date) ';
exception when others then   if SQLCODE = -01430 then null;   else raise; end if;   -- ORA-01430: column being added already exists in table
end;
/

COMMENT ON COLUMN BARS.CP_RYN.D_Close IS '���� ���� ���.�����';
------------------------
declare l_tabid number; l_colid number;
begin   SUDA; 
  l_tabid := bars_metabase.get_tabid('CP_ACCC');
  select max(colid) + 1 into l_colid from META_COLUMNS where tabid = l_tabid ;
  bars_metabase.add_column(l_tabid, l_colid, 'D_CLOSE', 'D', '���� ���� �/�', 1.5, null, 13, 0, 0, 0, 0, '', '', 1, 0, '', 0, 0, 0, '', '', 0);
  l_tabid := bars_metabase.get_tabid('CP_RYN');
  select max(colid) + 1 into l_colid from META_COLUMNS where tabid = l_tabid ;
  bars_metabase.add_column(l_tabid, l_colid, 'D_CLOSE', 'D', '���� ���� �/�', 1.5, null, 13, 0, 0, 0, 0, '', '', 1, 0, '', 0, 0, 0, '', '', 0);
exception when others then  null ;
end;
/
commit ;


prompt ##############################################
prompt 2. ����������� ���� �������� �/�
prompt ##############################################
----------------------------------------
begin bc.go('300465');
  for X in (select d.ryn, max(k.DATP) DATP    from cp_deal d, cp_kod k  where d.id = k.id group by d.ryn having max(k.DATP) < gl.BDATE)
  loop 
    FOR R in (select * from cp_accc c where  c.ryn = X.RYN )
    loop  
       for A in (select acc from accounts where nls in ( R.NLSA, nvl( R.NLSD,'*'),  nvl( R.NLSP,'*'), nvl( R.NLSR   ,'*'), nvl( R.NLSS   ,'*'), nvl( R.NLSR2,'*'), 
                                                                 nvl( R.S2VD,'*'),  nvl( R.S2VP,'*'), nvl( R.NLSEXPN,'*'), nvl( R.NLSEXPR,'*'), nvl( R.NLSR3,'*')
                                                       ) and ostc =0  and dazs is null
                )
--NLSA	C	���-�~�������
--NLSD	C	���-�~��������
--NLSP	C	���-� ���쳿
--NLSR	C	���-�~�����. %
--NLSS	C	���-�~����������
--NLSR2	C	���-�~�������. %
--S2VD	C	����.���.~�����������~��������
--S2VP	C	����.���.~���������~���쳿
--NLSEXPN	C	���-�~����������~�������
--NLSEXPR	C	���-�~����������~������
--NLSR3	C	���-�~�������~������
      loop update accounts set dazs = gl.Bdate where acc  = A.acc ;
           for AA in (select acc from accounts where accc = A.ACC )
           loop update accounts set dazs = gl.Bdate where acc  = A.acc ; end loop ; -- AAA
      end loop ; -- A; 

      update CP_ACCC set d_close = X.DATP + 1 where ryn = X.RYN;
      update CP_RYN  set d_close = X.DATP + 1 where ryn = X.RYN;
      Update CP_deal set dazs    = gl.Bdate   where ryn = X.RYN;

    end loop ; --R
  end loop ; -- X
  commit;
  SUDA; 
end ;
/
commit ;
----------------------------------

