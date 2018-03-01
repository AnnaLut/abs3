PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REZ_XOZ_TIP.sql =========*** Run *** =====
PROMPT ===================================================================================== 

PROMPT *** ALTER_POLICY_INFO to REZ_XOZ_TIP ***

BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REZ_XOZ_TIP'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''REZ_XOZ_TIP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REZ_XOZ_TIP ***
begin 
  execute immediate '
  CREATE TABLE BARS.REZ_XOZ_TIP 
   (  FDAT   DATE,
      ACC    NUMBER(38), 
      TIP    CHAR (3) 
   )  tablespace BRSMDLD';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** ALTER_POLICIES to REZ_XOZ_TIP ***
 exec bpa.alter_policies('REZ_XOZ_TIP');


COMMENT ON TABLE  BARS.REZ_XOZ_TIP         IS 'Госп.дебіторка, якої немає в картотеці';
COMMENT ON COLUMN BARS.REZ_XOZ_TIP.FDAT    IS 'Звітна дата';
COMMENT ON COLUMN BARS.REZ_XOZ_TIP.ACC     IS 'ACC рахунку';
COMMENT ON COLUMN BARS.REZ_XOZ_TIP.TIP     IS 'Тип рахунку';

PROMPT *** Create  constraint PK_REZ_XOZ_TIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_XOZ_TIP ADD CONSTRAINT PK_REZ_XOZ_TIP PRIMARY KEY (fdat,acc)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  index PK_REZ_XOZ_TIP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_REZ_XOZ_TIP ON BARS.REZ_XOZ_TIP (fdat,acc) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

BEGIN 
     execute immediate  
       'begin  
            bpa.alter_policy_info(''REZ_XOZ_TIP'', ''FILIAL'' ,null, null, null, null);
            bpa.alter_policy_info(''REZ_XOZ_TIP'', ''WHOLE'' , null, null, null, null);
            null;
        end; 
       '; 
END; 
/
PROMPT *** ALTER_POLICIES to REZ_XOZ_TIP ***
exec bpa.alter_policies('REZ_XOZ_TIP');
BEGIN bars_policy_adm.add_column_kf(p_table_name => 'REZ_XOZ_TIP');
exception when others then
  if  sqlcode=-01430  then null; else raise; end if;
end;
/
exec bars_policy_adm.alter_policy_info(p_table_name => 'REZ_XOZ_TIP', p_policy_group => 'WHOLE', p_select_policy => null, p_insert_policy => 'E', p_update_policy => 'E', p_delete_policy => 'E');
exec bars_policy_adm.alter_policy_info(p_table_name => 'REZ_XOZ_TIP', p_policy_group => 'FILIAL', p_select_policy => 'M', p_insert_policy => 'M', p_update_policy => 'M', p_delete_policy => 'M');
exec bars_policy_adm.alter_policies(p_table_name => 'REZ_XOZ_TIP');

PROMPT *** Create  grants  REZ_XOZ_TIP ***
grant SELECT  on REZ_XOZ_TIP         to BARS_ACCESS_DEFROLE;
grant SELECT  on REZ_XOZ_TIP         to RCC_DEAL;
grant SELECT  on REZ_XOZ_TIP         to START1;
grant SELECT  on REZ_XOZ_TIP         to UPLD;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REZ_XOZ_TIP.sql =========*** End *** =====
PROMPT ===================================================================================== 
