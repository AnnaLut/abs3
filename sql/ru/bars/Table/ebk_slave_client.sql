

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EBK_SLAVE_CLIENT.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EBK_SLAVE_CLIENT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EBK_SLAVE_CLIENT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EBK_SLAVE_CLIENT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EBK_SLAVE_CLIENT ***
begin 
  execute immediate '
  CREATE TABLE BARS.EBK_SLAVE_CLIENT 
   (	GCIF VARCHAR2(30), 
	SLAVE_KF VARCHAR2(6), 
	SLAVE_RNK NUMBER(38,0), 
	 CONSTRAINT PK_EBK_SLAVE_CLIENT PRIMARY KEY (GCIF, SLAVE_KF, SLAVE_RNK) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSDYND 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EBK_SLAVE_CLIENT ***
 exec bpa.alter_policies('EBK_SLAVE_CLIENT');


COMMENT ON TABLE BARS.EBK_SLAVE_CLIENT IS 'Таблица привязанных карточек к gcif';
COMMENT ON COLUMN BARS.EBK_SLAVE_CLIENT.GCIF IS '';
COMMENT ON COLUMN BARS.EBK_SLAVE_CLIENT.SLAVE_KF IS '';
COMMENT ON COLUMN BARS.EBK_SLAVE_CLIENT.SLAVE_RNK IS '';




PROMPT *** Create  constraint PK_EBK_SLAVE_CLIENT ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBK_SLAVE_CLIENT ADD CONSTRAINT PK_EBK_SLAVE_CLIENT PRIMARY KEY (GCIF, SLAVE_KF, SLAVE_RNK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_EBK_SLAVE_CLIENT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_EBK_SLAVE_CLIENT ON BARS.EBK_SLAVE_CLIENT (GCIF, SLAVE_KF, SLAVE_RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EBK_SLAVE_CLIENT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on EBK_SLAVE_CLIENT to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EBK_SLAVE_CLIENT.sql =========*** End 
PROMPT ===================================================================================== 
