

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/RNBU_INDEX_FIX.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  procedure RNBU_INDEX_FIX ***

  CREATE OR REPLACE PROCEDURE BARS.RNBU_INDEX_FIX 
-- �.�.
-- v.1.0 23.04.13
-- ��������� ��� ����������� ����� � ��������� ������� rnbu_trace_arch
-- ��������� ������ �������� RNBU_TRACE_ARCH_I1/I2. ���� �����-�� ��������� 15��
-- ������� � ����������� �� �����
-- ��������� �������� ����� ����������������� size1/2>...
-- ��������� ��� job � ������ ����������
-- ���������:
-- 1. ��� sys-�� ���������
-- GRANT SELECT ANY DICTIONARY TO BARS;
-- 2. ��� bars-�� ��������� ���������
-- 3. �������� ���� � EM � ������ ����������
--
-- v.1.1 24.04.13
-- ��������� �������� ����������� �� ����� ����� bars_mail
-- ��������! bars_mail ������ ���� ��������, ������ ������������ ��� �������� ���������
-- � ������� corp2
-- ���� �� ��������, ���������������� ��� ������� ����� ---bars_mail---

is
size1 number;
size2 number;
begin
-- size index1
select ceil(sum(bytes) / 1024/1024) into size1
from dba_segments
where owner like 'BARS'
and segment_type = 'INDEX'
and segment_name='RNBU_TRACE_ARCH_I1'
group by segment_name;
-- size index2
select ceil(sum(bytes) / 1024/1024) into size2
from dba_segments
where owner like 'BARS'
and segment_type = 'INDEX'
and segment_name='RNBU_TRACE_ARCH_I2'
group by segment_name;
if size1>15000 then
begin
EXECUTE IMMEDIATE 'DROP INDEX BARS.RNBU_TRACE_ARCH_I1';
exception when others then
if sqlcode =-01418 then null;
else raise;
end if;
end;
begin
EXECUTE IMMEDIATE 'CREATE INDEX BARS.RNBU_TRACE_ARCH_I1 ON BARS.RNBU_TRACE_ARCH
                   (KODF, DATF, TOBO, ACC)
                   LOGGING
                   TABLESPACE BRSMDLI
                   PCTFREE    10
                   INITRANS   2
                   MAXTRANS   255
                   STORAGE    (
                   INITIAL          64K
                   NEXT             64K
                   MINEXTENTS       1
                   MAXEXTENTS       UNLIMITED
                   PCTINCREASE      0
                   BUFFER_POOL      DEFAULT
                   )
                   NOPARALLEL';
end;

-- bars_mail -----------------------------------------
begin
bars_mail.put_msg2queue(
p_name        => 'DBA_Zhytomyr',
p_addr        => 'rohmanyukyy@ztobu.in.ua',
p_subject      => 'BARSDB_Index_I1_Recreate',
p_body         => 'RNBU_Index_I1_Recreate');
end;
commit;
------------------------------------------------------

end if;
-----------
if size2>15000 then
begin
EXECUTE IMMEDIATE 'DROP INDEX BARS.RNBU_TRACE_ARCH_I2';
exception when others then
if sqlcode =-01418 then null; else raise; end if;
end;
begin
EXECUTE IMMEDIATE 'CREATE INDEX BARS.RNBU_TRACE_ARCH_I2 ON BARS.RNBU_TRACE_ARCH
                   (KODF, DATF, KODP)
                   LOGGING
                   TABLESPACE BRSMDLI
                   PCTFREE    10
                   INITRANS   2
                   MAXTRANS   255
                   STORAGE    (
                   INITIAL          64K
                   NEXT             64K
                   MINEXTENTS       1
                   MAXEXTENTS       UNLIMITED
                   PCTINCREASE      0
                   BUFFER_POOL      DEFAULT
                   )
                   NOPARALLEL';
end;

-- bars_mail -----------------------------------------
begin
bars_mail.put_msg2queue(
p_name        => 'DBA_Zhytomyr',
p_addr        => 'rohmanyukyy@ztobu.in.ua',
p_subject      => 'BARSDB_Index_I2_Recreate',
p_body         => 'RNBU_Index_I2_Recreate');
end;
commit;
------------------------------------------------------
end if;
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/RNBU_INDEX_FIX.sql =========*** En
PROMPT ===================================================================================== 
