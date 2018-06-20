PROMPT *** DROP   constraint FK_STOLST_STOGRP ***
begin
 execute immediate '
   ALTER TABLE BARS.STO_LST DROP CONSTRAINT FK_STOLST_STOGRP
   ';
exception when others then 
  if  sqlcode=-02443 then null; else raise; end if;
end ;
/
begin
 bc.go('/300465/');
 update STO_grp set idg=12 where idg like '12__';
end;
/
commit;

begin
 for rec in (SELECT * FROM  mv_kf) 
   loop
     bc.go('/'||rec.kf||'/');
     update STO_lst set idg=12 where idg like '12__';
   end loop;
end ;
/
commit;

begin
  bc.home;
end;
/

PROMPT *** DROP   constraint PK_STOGRP ***
begin
 execute immediate '
   ALTER TABLE BARS.STO_GRP DROP CONSTRAINT PK_STOGRP
   ';
exception when others then 
  if  sqlcode=-02443 then null; else raise; end if;
end ;
/

PROMPT *** DROP  index PK_STOGRP ***
begin
 execute immediate '
    DROP INDEX PK_STOGRP
   ';
exception when others then 
  if  sqlcode=-02443 or sqlcode=-01418 then null; else raise; end if;
end ;
/

PROMPT *** Create  constraint PK_STOGRP ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_GRP ADD CONSTRAINT PK_STOGRP PRIMARY KEY (KF,IDG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
end;
/


