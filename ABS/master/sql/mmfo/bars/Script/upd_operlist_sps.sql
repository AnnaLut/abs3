begin
bc.home;
for k in (select * from operlist where funcname like '%SPS.PAY_SOME_PEREKR%')
loop
update operlist 
set funcname = funcname||'[QST=>Ви дійсно бажаєте виконати техн. списання?]'
where codeoper = k.codeoper;
commit; 
end loop;
end;

/