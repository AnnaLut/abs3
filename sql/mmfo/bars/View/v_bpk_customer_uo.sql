

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BPK_CUSTOMER_UO.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BPK_CUSTOMER_UO ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BPK_CUSTOMER_UO ("RNK", "TGR", "CUSTTYPE", "COUNTRY", "NMK", "NMKV", "NMKK", "CODCAGENT", "PRINSIDER", "OKPO", "ADR", "SAB", "C_REG", "C_DST", "RGTAX", "DATET", "ADM", "DATEA", "STMT", "DATE_ON", "DATE_OFF", "NOTES", "NOTESEC", "CRISK", "PINCODE", "ND", "RNKP", "ISE", "FS", "OE", "VED", "SED", "LIM", "MB", "RGADM", "BC", "BRANCH", "TOBO", "ISP", "TAXF", "NOMPDV", "K050", "NREZID_CODE", "CTYPE", "DOC", "ISSUER", "BDAYPLACE", "PK_NAME", "NMKV_FIRST", "NMKV_LAST", "LAST_NAME_CONTACT") AS 
  select v."RNK",v."TGR",v."CUSTTYPE",v."COUNTRY",v."NMK",v."NMKV",v."NMKK",v."CODCAGENT",v."PRINSIDER",v."OKPO",v."ADR",v."SAB",v."C_REG",v."C_DST",v."RGTAX",v."DATET",v."ADM",v."DATEA",v."STMT",v."DATE_ON",v."DATE_OFF",v."NOTES",v."NOTESEC",v."CRISK",v."PINCODE",v."ND",v."RNKP",v."ISE",v."FS",v."OE",v."VED",v."SED",v."LIM",v."MB",v."RGADM",v."BC",v."BRANCH",v."TOBO",v."ISP",v."TAXF",v."NOMPDV",v."K050",v."NREZID_CODE",
       decode(nvl(trim(v.sed),'00'),'91','тн-яод','тн') ctype,
       trim(s.name || ' ' || p.ser || ' ' || p.numdoc) doc,
       trim(to_char(p.pdate,'dd.MM.yyyy') || ' ' || p.organ) issuer,
       trim(to_char(p.bday,'dd.MM.yyyy') || ' ' || p.bplace) bdayplace,
       fio(trim(replace(nvl(v.nmkv,substr(f_translate_kmu(v.nmk),1,70)), '  ', ' ')),2) || ' ' ||
       fio(trim(replace(nvl(v.nmkv,substr(f_translate_kmu(v.nmk),1,70)), '  ', ' ')),1) pk_name,
       substr(fio(nmkv,2),1,30) nmkv_first,
       substr(fio(nmkv,1),1,30) nmkv_last,
       (select min(t.last_name) keep(dense_rank first order by t.sign_privs, t.type_id)
          from customer_rel t
         where t.rnk = v.rnk and t.rel_id = 20 ) last_name_contact
  from customer v, person p, passp s
 where v.custtype = 3
   and v.rnk = p.rnk
   and p.passp = s.passp
   and v.sed = '91  '
   and v.date_off is null
union all
select v."RNK",v."TGR",v."CUSTTYPE",v."COUNTRY",v."NMK",v."NMKV",v."NMKK",v."CODCAGENT",v."PRINSIDER",v."OKPO",v."ADR",v."SAB",v."C_REG",v."C_DST",v."RGTAX",v."DATET",v."ADM",v."DATEA",v."STMT",v."DATE_ON",v."DATE_OFF",v."NOTES",v."NOTESEC",v."CRISK",v."PINCODE",v."ND",v."RNKP",v."ISE",v."FS",v."OE",v."VED",v."SED",v."LIM",v."MB",v."RGADM",v."BC",v."BRANCH",v."TOBO",v."ISP",v."TAXF",v."NOMPDV",v."K050",v."NREZID_CODE",
       'чн' ctype,
       null doc,
       null issuer,
       null bdayplace,
       fio(trim(replace(nvl(v.nmkv,substr(f_translate_kmu(v.nmk),1,70)), '  ', ' ')),2) || ' ' ||
       fio(trim(replace(nvl(v.nmkv,substr(f_translate_kmu(v.nmk),1,70)), '  ', ' ')),1) pk_name,
       nmkv nmkv_first,
       null nmkv_last,
       (select min(t.last_name) keep(dense_rank first order by t.sign_privs, t.type_id)
          from customer_rel t
         where t.rnk = v.rnk and t.rel_id = 20 ) last_name_contact
  from customer v
 where v.custtype = 2
   and v.date_off is null;

PROMPT *** Create  grants  V_BPK_CUSTOMER_UO ***
grant SELECT                                                                 on V_BPK_CUSTOMER_UO to BARSREADER_ROLE;
grant SELECT                                                                 on V_BPK_CUSTOMER_UO to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BPK_CUSTOMER_UO to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BPK_CUSTOMER_UO.sql =========*** End 
PROMPT ===================================================================================== 
