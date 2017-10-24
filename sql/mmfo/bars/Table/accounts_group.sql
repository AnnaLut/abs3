

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACCOUNTS_GROUP.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACCOUNTS_GROUP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACCOUNTS_GROUP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ACCOUNTS_GROUP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ACCOUNTS_GROUP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACCOUNTS_GROUP ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACCOUNTS_GROUP 
   (	ID_GRP NUMBER(4,0), 
	NLS CHAR(14), 
	VALUTA CHAR(3)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACCOUNTS_GROUP ***
 exec bpa.alter_policies('ACCOUNTS_GROUP');


COMMENT ON TABLE BARS.ACCOUNTS_GROUP IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_GROUP.ID_GRP IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_GROUP.NLS IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_GROUP.VALUTA IS '';




PROMPT *** Create  constraint SYS_C006782 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_GROUP MODIFY (ID_GRP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACCOUNTS_GROUP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCOUNTS_GROUP  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACCOUNTS_GROUP  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCOUNTS_GROUP  to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACCOUNTS_GROUP.sql =========*** End **
PROMPT ===================================================================================== 
