

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_SERVICE.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_SERVICE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_SERVICE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_SERVICE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_SERVICE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_SERVICE ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_SERVICE 
   (	SERV_ID NUMBER(38,0), 
	SERV_NAME VARCHAR2(4), 
	COMMENTS VARCHAR2(128)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_SERVICE ***
 exec bpa.alter_policies('DPT_SERVICE');


COMMENT ON TABLE BARS.DPT_SERVICE IS '';
COMMENT ON COLUMN BARS.DPT_SERVICE.SERV_ID IS '';
COMMENT ON COLUMN BARS.DPT_SERVICE.SERV_NAME IS '';
COMMENT ON COLUMN BARS.DPT_SERVICE.COMMENTS IS '';



PROMPT *** Create  grants  DPT_SERVICE ***
grant SELECT                                                                 on DPT_SERVICE     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_SERVICE     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_SERVICE     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_SERVICE     to START1;
grant SELECT                                                                 on DPT_SERVICE     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_SERVICE.sql =========*** End *** =
PROMPT ===================================================================================== 
