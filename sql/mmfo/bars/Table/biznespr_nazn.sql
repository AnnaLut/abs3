

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BIZNESPR_NAZN.sql =========*** Run ***
PROMPT ===================================================================================== 



PROMPT *** Create  table BIZNESPR_NAZN ***
begin 
  execute immediate '
  CREATE TABLE BARS.BIZNESPR_NAZN 
   (	SLOVO VARCHAR2(29), 
	    COMM VARCHAR2(48),
		KF   VARCHAR2(6 )    DEFAULT sys_context(''bars_context'',''user_mfo'') CONSTRAINT CC_BIZNESPRNAZN_KF_NN NOT NULL
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


begin 
    execute immediate 'alter table BIZNESPR_NAZN add kf  VARCHAR2(6 )    DEFAULT sys_context(''bars_context'',''user_mfo'')';
exception when others then 
  if sqlcode = -01430 then null;
  else raise;
  end if; 
end;
/  

update BIZNESPR_NAZN set KF = '300465' where kf is null;
commit;



begin execute immediate 'ALTER TABLE BIZNESPR_NAZN MODIFY (KF VARCHAR2(6 ) CONSTRAINT CC_BIZNESPRNAZN_KF_NN NOT NULL)';
exception when others then 
  if sqlcode = -01442 then null;
  else raise;
  end if; 
end;
/  







PROMPT *** ALTER_POLICIES to BIZNESPR_NAZN ***
 exec bpa.alter_policies('BIZNESPR_NAZN');


COMMENT ON TABLE BARS.BIZNESPR_NAZN IS '';
COMMENT ON COLUMN BARS.BIZNESPR_NAZN.SLOVO IS '';
COMMENT ON COLUMN BARS.BIZNESPR_NAZN.COMM IS '';




PROMPT *** Create  constraint PK_BIZNESPRNAZN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BIZNESPR_NAZN ADD CONSTRAINT PK_BIZNESPRNAZN PRIMARY KEY (SLOVO)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BIZNESPRNAZN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BIZNESPRNAZN ON BARS.BIZNESPR_NAZN (SLOVO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BIZNESPR_NAZN ***
grant DELETE,INSERT,SELECT,UPDATE                                            on BIZNESPR_NAZN   to ABS_ADMIN;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on BIZNESPR_NAZN   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BIZNESPR_NAZN   to BARS_DM;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on BIZNESPR_NAZN   to START1;
grant FLASHBACK,SELECT                                                       on BIZNESPR_NAZN   to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BIZNESPR_NAZN.sql =========*** End ***
PROMPT ===================================================================================== 


exec BARS_POLICY_ADM.REMOVE_POLICIES('BIZNESPR_NAZN');
BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BIZNESPR_NAZN'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BIZNESPR_NAZN'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''BIZNESPR_NAZN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/
exec bars_policy_adm.add_policies('BIZNESPR_NAZN');
exec bars_policy_adm.enable_policies('BIZNESPR_NAZN');

