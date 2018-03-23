-- замена параметра K072 на новые значения которые будут действовать 
-- c 01.01.2018
-- параметр K072 на 01.01.2018 2-х значный 


exec bc.home;  

begin
    execute immediate 'ALTER TABLE specparam MODIFY k072 VARCHAR2(2)';
exception
    when others then null;
end;
/    

begin
    execute immediate 'ALTER TABLE specparam_update MODIFY k072 VARCHAR2(2)';
exception
    when others then null;
end;
/    

update meta_columns set showmaxchar = 2
where tabid = ( select tabid 
                from meta_tables 
                where trim(tabname) = 'SPECPARAM'
              )
  and colname like 'K072%';

commit;

declare 
k072_   varchar2(2);

begin
   for z in (select kf from mv_kf)
    loop

       bc.subst_mfo(z.kf);

       dbms_output.put_line(' UPDATE_SPECPARAM K072 '); 

       for k in ( select acc, k072 
                  from specparam  
                  where trim(k072) is not null
                )

       loop

          if k.k072 = '1' then
             k072_ := '11';
          elsif k.k072 = '2' then
             k072_ := '12';
          elsif k.k072 = '3' then
             k072_ := '13';
          elsif k.k072 = '4' then
             k072_ := '20';
          elsif k.k072 = '5' then
             k072_ := '21';
          elsif k.k072 = '6' then
             k072_ := '22';
          elsif k.k072 = '7' then
             k072_ := '23';
          elsif k.k072 = '8' then
             k072_ := '24';
          elsif k.k072 = '9' then
             k072_ := '25';
          elsif k.k072 = 'A' then
             k072_ := '26';
          elsif k.k072 = 'B' then
             k072_ := '2D';
          elsif k.k072 = 'C' then
             k072_ := '2E';
          elsif k.k072 = 'D' then
             k072_ := '2F';
          elsif k.k072 = 'E' then
             k072_ := '2J';
          elsif k.k072 = 'F' then
             k072_ := '2K';
          elsif k.k072 = 'G' then
             k072_ := '2L';
          elsif k.k072 = 'H' then
             k072_ := '30';
          elsif k.k072 = 'I' then
             k072_ := '31';
          elsif k.k072 = 'J' then
             k072_ := '31';
          elsif k.k072 = 'K' then
             k072_ := '32';
          elsif k.k072 = 'L' then
             k072_ := '41';
          elsif k.k072 = 'N' then
             k072_ := '41';
          elsif k.k072 = 'R' then
             k072_ := '51';
          elsif k.k072 = 'Z' then
             k072_ := '1X';
          elsif k.k072 = 'Y' then
             k072_ := '2X';
          else
             null;
          end if;

          update specparam set k072 = k072_ 
          where acc = k.acc;

          commit;

       end loop;

   end loop;

   commit;

end;
/