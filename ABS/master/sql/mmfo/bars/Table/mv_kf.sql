

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MV_KF.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MV_KF ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MV_KF ***
begin 
  execute immediate '
  CREATE TABLE BARS.MV_KF 
   (	KF VARCHAR2(6), 
	 CONSTRAINT PK_MVKF PRIMARY KEY (KF) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLD 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MV_KF ***
 exec bpa.alter_policies('MV_KF');


COMMENT ON COLUMN BARS.MV_KF.KF IS 'Код филиала';




PROMPT *** Create  constraint PK_MVKF ***
begin   
 execute immediate '
  ALTER TABLE BARS.MV_KF ADD CONSTRAINT PK_MVKF PRIMARY KEY (KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_MVKF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_MVKF ON BARS.MV_KF (KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MV_KF ***
grant SELECT                                                                 on MV_KF           to BARSAQ with grant option;
grant SELECT                                                                 on MV_KF           to BARSREADER_ROLE;
grant SELECT                                                                 on MV_KF           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MV_KF           to BARS_DM;
grant SELECT                                                                 on MV_KF           to PFU;
grant SELECT                                                                 on MV_KF           to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MV_KF.sql =========*** End *** =======
PROMPT ===================================================================================== 
