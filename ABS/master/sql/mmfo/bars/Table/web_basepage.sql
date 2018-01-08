

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WEB_BASEPAGE.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WEB_BASEPAGE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WEB_BASEPAGE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WEB_BASEPAGE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WEB_BASEPAGE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WEB_BASEPAGE ***
begin 
  execute immediate '
  CREATE TABLE BARS.WEB_BASEPAGE 
   (	URL_MASK VARCHAR2(100)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WEB_BASEPAGE ***
 exec bpa.alter_policies('WEB_BASEPAGE');


COMMENT ON TABLE BARS.WEB_BASEPAGE IS '';
COMMENT ON COLUMN BARS.WEB_BASEPAGE.URL_MASK IS '';



PROMPT *** Create  grants  WEB_BASEPAGE ***
grant SELECT                                                                 on WEB_BASEPAGE    to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on WEB_BASEPAGE    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on WEB_BASEPAGE    to START1;
grant SELECT                                                                 on WEB_BASEPAGE    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WEB_BASEPAGE.sql =========*** End *** 
PROMPT ===================================================================================== 
