

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_CL_INFO_DATA_ERROR.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_CL_INFO_DATA_ERROR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_CL_INFO_DATA_ERROR'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OW_CL_INFO_DATA_ERROR'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OW_CL_INFO_DATA_ERROR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_CL_INFO_DATA_ERROR ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_CL_INFO_DATA_ERROR 
   (	FILE_NAME VARCHAR2(100), 
	RNK NUMBER(38,0), 
	MPHONE VARCHAR2(12), 
	ERR_TEXT VARCHAR2(1000), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OW_CL_INFO_DATA_ERROR ***
 exec bpa.alter_policies('OW_CL_INFO_DATA_ERROR');


COMMENT ON TABLE BARS.OW_CL_INFO_DATA_ERROR IS '';
COMMENT ON COLUMN BARS.OW_CL_INFO_DATA_ERROR.KF IS '';
COMMENT ON COLUMN BARS.OW_CL_INFO_DATA_ERROR.FILE_NAME IS 'Ім'я файлу';
COMMENT ON COLUMN BARS.OW_CL_INFO_DATA_ERROR.RNK IS 'Реєстраційний номер клієнта';
COMMENT ON COLUMN BARS.OW_CL_INFO_DATA_ERROR.MPHONE IS 'Номер мобільного';
COMMENT ON COLUMN BARS.OW_CL_INFO_DATA_ERROR.ERR_TEXT IS 'Повідомлення';




PROMPT *** Create  constraint FK_OWCLINFODATAERROR_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_CL_INFO_DATA_ERROR ADD CONSTRAINT FK_OWCLINFODATAERROR_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWCLINFODATAERROR_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_CL_INFO_DATA_ERROR MODIFY (KF CONSTRAINT CC_OWCLINFODATAERROR_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OW_CL_INFO_DATA_ERROR ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OW_CL_INFO_DATA_ERROR to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OW_CL_INFO_DATA_ERROR to BARS_DM;
grant FLASHBACK,SELECT                                                       on OW_CL_INFO_DATA_ERROR to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_CL_INFO_DATA_ERROR.sql =========***
PROMPT ===================================================================================== 
