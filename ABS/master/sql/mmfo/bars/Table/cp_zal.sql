

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_ZAL.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_ZAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_ZAL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_ZAL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_ZAL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Alter Table CP_ZAL ***

PROMPT *** ALTER_POLICIES to CP_ZAL ***
 exec bpa.alter_policies('CP_ZAL');


/*
PROMPT *** Create  constraint XPK_CPZAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_ZAL ADD CONSTRAINT XPK_CPZAL PRIMARY KEY (REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CPZAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CPZAL ON BARS.CP_ZAL (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/
*/

begin   
 execute immediate 'alter table CP_ZAL drop constraint XPK_CPZAL cascade';
exception when others then
  if  sqlcode=-2443  then null; else raise; end if;
 end;
/

begin   
 execute immediate 'alter table CP_ZAL add rnk number';
exception when others then
  if  sqlcode=-1430  then null; else raise; end if;
 end;
/

begin   
 execute immediate 'alter table CP_ZAL add id_cp_zal number';
exception when others then
  if  sqlcode=-1430  then null; else raise; end if;
 end;
/

-- Add comments to the columns 
COMMENT ON COLUMN CP_ZAL.RNK       is 'Код Контрагента';
COMMENT ON COLUMN CP_ZAL.ID_CP_ZAL is 'Код CP_ZAL';

begin   
 execute immediate 'create index IND_U_CP_ZAL on CP_ZAL (ref, rnk) tablespace BRSMDLI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

begin   
 execute immediate 'create unique index IND_U_ID_CP_ZAL on CP_ZAL (id_cp_zal)tablespace BRSMDLI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

begin   
 execute immediate 'alter table CP_ZAL modify id_cp_zal not null';
exception when others then
  if  sqlcode=-1442  then null; else raise; end if;
 end;
/


PROMPT *** Create  grants  CP_ZAL ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_ZAL          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_ZAL          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_ZAL          to CP_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_ZAL          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_ZAL.sql =========*** End *** ======
PROMPT ===================================================================================== 
