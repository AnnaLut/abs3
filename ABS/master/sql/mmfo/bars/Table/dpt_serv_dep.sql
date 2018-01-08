

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_SERV_DEP.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_SERV_DEP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_SERV_DEP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_SERV_DEP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_SERV_DEP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_SERV_DEP ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_SERV_DEP 
   (	SERV_ID NUMBER(38,0), 
	DEPOSIT_ID NUMBER(38,0), 
	STATUS NUMBER(1,0) DEFAULT 0, 
	COMMENTS VARCHAR2(128)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_SERV_DEP ***
 exec bpa.alter_policies('DPT_SERV_DEP');


COMMENT ON TABLE BARS.DPT_SERV_DEP IS '';
COMMENT ON COLUMN BARS.DPT_SERV_DEP.SERV_ID IS '';
COMMENT ON COLUMN BARS.DPT_SERV_DEP.DEPOSIT_ID IS '';
COMMENT ON COLUMN BARS.DPT_SERV_DEP.STATUS IS '';
COMMENT ON COLUMN BARS.DPT_SERV_DEP.COMMENTS IS '';



PROMPT *** Create  grants  DPT_SERV_DEP ***
grant SELECT                                                                 on DPT_SERV_DEP    to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_SERV_DEP    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_SERV_DEP    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_SERV_DEP    to START1;
grant SELECT                                                                 on DPT_SERV_DEP    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_SERV_DEP.sql =========*** End *** 
PROMPT ===================================================================================== 
