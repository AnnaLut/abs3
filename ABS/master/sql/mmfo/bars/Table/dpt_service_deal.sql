

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_SERVICE_DEAL.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_SERVICE_DEAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_SERVICE_DEAL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_SERVICE_DEAL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_SERVICE_DEAL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_SERVICE_DEAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_SERVICE_DEAL 
   (	SERV_ID NUMBER(38,0), 
	DEAL_ID NUMBER, 
	COMMENTS VARCHAR2(128)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_SERVICE_DEAL ***
 exec bpa.alter_policies('DPT_SERVICE_DEAL');


COMMENT ON TABLE BARS.DPT_SERVICE_DEAL IS '';
COMMENT ON COLUMN BARS.DPT_SERVICE_DEAL.SERV_ID IS '';
COMMENT ON COLUMN BARS.DPT_SERVICE_DEAL.DEAL_ID IS '';
COMMENT ON COLUMN BARS.DPT_SERVICE_DEAL.COMMENTS IS '';



PROMPT *** Create  grants  DPT_SERVICE_DEAL ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_SERVICE_DEAL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_SERVICE_DEAL to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_SERVICE_DEAL to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_SERVICE_DEAL.sql =========*** End 
PROMPT ===================================================================================== 
