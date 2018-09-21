begin
update OPERLIST t
set t.funcname = '/barsroot/ndi/referencebook/GetRefBookData/?tableName=E_DEAL_META'||CHR(38)||'accessCode=1'||CHR(38)||'sPar=[NSIFUNCTION][PAR=>:Dat(SEM=Îáåð³òü ì³ñÿöü,TYPE=D)][PROC=>PUL.PUT(''ADAT'',to_char(nvl(:Dat,GL.BD),''mmyyyy''))][EXEC=>BEFORE]'
where t.codeoper = 1695;
end;
/
commit;
/