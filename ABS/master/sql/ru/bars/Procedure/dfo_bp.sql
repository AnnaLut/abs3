

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/DFO_BP.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure DFO_BP ***

  CREATE OR REPLACE PROCEDURE BARS.DFO_BP (ww varchar2:='2')
is

begin
for k in (select branch, 'PDFONAM' as TAG, PDFONAM as VAL from dfo union all
select branch, 'PDFONLS' as TAG, PDFONLS as VAL from dfo union all
select branch, 'PDFOID' as TAG, PDFOID as VAL from dfo union all
select branch, 'PDFOMFO' as TAG, PDFOMFO as VAL from dfo union all
select branch, 'PDFOVZB' as TAG, PDFOVZB as VAL from dfo )

loop
begin
    insert into branch_parameters (branch,tag,val) values
                                    (k.branch, k.tag,k.val);
    exception when dup_val_on_index then
    update  branch_parameters set val=k.val where branch=k.branch and tag=k.tag;
end;
end loop;



end DFO_BP;
/
show err;

PROMPT *** Create  grants  DFO_BP ***
grant EXECUTE                                                                on DFO_BP          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/DFO_BP.sql =========*** End *** ==
PROMPT ===================================================================================== 
