PROMPT ===================================================================================== 
PROMPT *** Run *** ======= Scripts /Sql/BARS/Sequence/S_XOZ_REF_UPDATE.sql ======*** Run *** 
PROMPT ===================================================================================== 
-- version 1.0 06/12/2017 V.Kharin
PROMPT *** Create  sequence S_XOZ_REF_UPDATE ***
begin    execute immediate
   'CREATE SEQUENCE  BARS.S_XOZ_REF_UPDATE  MINVALUE 0 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 5 ORDER NOCYCLE';
 exception
    when others then null;
end;
/
PROMPT *** Create  grants  S_XOZ_REF_UPDATE ***
grant SELECT  on S_XOZ_REF_UPDATE  to BARS_ACCESS_DEFROLE;
grant SELECT  on S_XOZ_REF_UPDATE  to BARS;
grant SELECT  on S_XOZ_REF_UPDATE  to START1;

PROMPT ===================================================================================== 
PROMPT *** End *** ======= Scripts /Sql/BARS/Sequence/S_XOZ_REF_UPDATE.sql ======*** End *** 
PROMPT ===================================================================================== 
/
commit;