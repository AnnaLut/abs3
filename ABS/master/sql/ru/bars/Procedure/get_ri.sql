

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/GET_RI.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure GET_RI ***

  CREATE OR REPLACE PROCEDURE BARS.GET_RI 
IS

begin

-- ��� ���.��� � ����� (�� ���� � ���������) � ����������� �������, ���� �� ������� ��������� � ���
for m in (
select
c.rnk, c.branch,c.custtype,c.okpo,p.passp,p.ser,p.numdoc, r.k060 as prinsider, r.insform as insfo, c.prinsider as prinsider_before, to_number(w.value) as insfo_before
from
    customer c
    left join person p on c.rnk=p.rnk
    left join customerw w on c.rnk=w.rnk and w.tag='INSFO'
    left join customer_ri r on c.okpo=r.idcode and nvl(p.passp,r.doct)=r.doct and nvl(p.ser,r.docs)=r.docs and nvl(p.numdoc,r.docn)=r.docn
where
    c.date_off is null and
    c.custtype=3   and
    c.codcagent in (3,5) and
    r.idcode <>'0000000000' and
    length(r.idcode)=10 and
    r.doct is not null and r.docs is not null and r.docn is not null
union all
-- ��� ���.��� � ����� (�� ���� � ���������) ��� �������,���� ��� � ��� ������� '0000000000' ��� '000000000'
select
c.rnk, c.branch,c.custtype,c.okpo,p.passp,p.ser,p.numdoc, r.k060 as prinsider, r.insform as insfo, c.prinsider as prinsider_before, to_number(w.value) as insfo_before
from
    customer c
    left join person p on c.rnk=p.rnk
    left join customerw w on c.rnk=w.rnk and w.tag='INSFO'
    left join customer_ri r on p.passp=r.doct and p.ser=r.docs and p.numdoc=r.docn
where
    c.date_off is null and
    c.custtype=3   and
    c.codcagent in (3,5) and
    c.OKPO in ('0000000000','000000000') and
    r.idcode <>'0000000000' and
    length(r.idcode)=10 and
    r.doct is not null and r.docs is not null and r.docn is not null
union all
-- ��� ���.��� ��� ���� (�� ���������)
select
c.rnk, c.branch,c.custtype,c.okpo,p.passp,p.ser,p.numdoc, r.k060 as prinsider, r.insform as insfo, c.prinsider as prinsider_before, to_number(w.value) as insfo_before
from
    customer c
    left join person p on c.rnk=p.rnk
    left join customerw w on c.rnk=w.rnk and w.tag='INSFO'
    left join customer_ri r on p.passp=r.doct and p.ser=r.docs and p.numdoc=r.docn
where
    c.date_off is null and
    c.custtype=3   and
    c.codcagent in (3,5) and
    r.idcode ='0000000000' and
    r.doct is not null and r.docs is not null and r.docn is not null
union all
-- ��� ���.��� � ����� (������ �� ����)
select
c.rnk, c.branch,c.custtype,c.okpo,p.passp,p.ser,p.numdoc, r.k060 as prinsider, r.insform as insfo, c.prinsider as prinsider_before, to_number(w.value) as insfo_before
from
    customer c
    left join person p on c.rnk=p.rnk
    left join customerw w on c.rnk=w.rnk and w.tag='INSFO'
    left join customer_ri r on c.okpo=r.idcode
where
    c.date_off is null and
    c.custtype=3       and
    c.codcagent in (3,5) and
    r.idcode <>'0000000000' and length(r.idcode)=10 and
    r.doct is null and r.docs is null and r.docn is null
union all
-- ��� ��.���
select
c.rnk, c.branch,c.custtype,c.okpo,p.passp,p.ser,p.numdoc, r.k060 as prinsider, r.insform as insfo, c.prinsider as prinsider_before, to_number(w.value) as insfo_before
from
    customer c
    left join person p on c.rnk=p.rnk
    left join customerw w on c.rnk=w.rnk and w.tag='INSFO'
    left join customer_ri r on c.okpo=r.idcode
where
    c.date_off is null and
    c.custtype=2       and
    c.codcagent in (3,5) and
    length(r.idcode)=8
)
loop
    insert into TMP_RI_CUST(rnk, branch, custtype, okpo, passp, ser, numdoc, prinsider, insfo, prinsider_before, insfo_before)
    values (m.rnk, m.branch, m.custtype, m.okpo, m.passp, m.ser, m.numdoc, m.prinsider, m.insfo, m.prinsider_before, m.insfo_before);
end loop;

--������ �볺���, �� �������� ������ ���"�������(�� � �����������)
for m in (
select c.rnk, c.branch,c.custtype,c.okpo,p.passp,p.ser,p.numdoc,99 as prinsider, null as insfo,c.prinsider as prinsider_before,w.value as insfo_before
from
    customer c
    left join person p on c.rnk=p.rnk
    left join customerw w on c.rnk=w.rnk and w.tag='INSFO'
where
    C.RNK not in (select rnk from TMP_RI_CUST) and
    c.date_off is null and
    c.custtype in (2,3) and
    c.codcagent in (3,5) and
    c.prinsider<>99
)
loop
    insert into TMP_RI_CUST(rnk, branch, custtype, okpo, passp, ser, numdoc, prinsider, insfo, prinsider_before, insfo_before)
    values (m.rnk, m.branch, m.custtype, m.okpo, m.passp, m.ser, m.numdoc, m.prinsider, m.insfo, m.prinsider_before, m.insfo_before);
end loop;

--��������� � ������ � ��������� �������, �� �� ��������
delete from TMP_RI_CUST where prinsider=prinsider_before and nvl(insfo,-1)=nvl(insfo_before,-1);


--������� ���� � ������� customer
for m in (select rnk,prinsider from TMP_RI_CUST where prinsider<>prinsider_before)
loop
  update customer set prinsider=m.prinsider where rnk=m.rnk;
end loop;

--������� ���� � ������� customerw
update customerw cw
set value=(select to_char(tc.insfo) from TMP_RI_CUST tc where cw.rnk=tc.rnk)
where  cw.rnk in (select tc.rnk from TMP_RI_CUST tc where tc.insfo is not null and tc.insfo_before is not null and tc.insfo<>tc.insfo_before) and cw.tag='INSFO';

insert into customerw (rnk, tag, value, isp)
select distinct tc.rnk,'INSFO',tc.insfo,user_id
from TMP_RI_CUST tc
where tc.insfo_before is null and tc.insfo is not null;

delete from customerw cw
where cw.rnk in (select tc.rnk from TMP_RI_CUST tc where tc.insfo_before is not null and tc.insfo is null) and cw.tag='INSFO';

end GET_RI;
/
show err;

PROMPT *** Create  grants  GET_RI ***
grant EXECUTE                                                                on GET_RI          to TECH005;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/GET_RI.sql =========*** End *** ==
PROMPT ===================================================================================== 
