using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Xml;

public class cardsController : ApiController
{
    // GET api/<controller>
    public HttpResponseMessage Get(string okpo)
    {
        //Острог, вул.Татарська буд.5 кв.104
        String[] responce = new String[] { @"<?xml version='1.0' encoding='UTF-8'?>
 <response>
   <status>OK</status>
   <qualityClients>
      <qualityClient>
         <clientCard>
            <kf>333368</kf>
            <rnk>163184</rnk>
            <dateOn>1999-01-05T00:00:00+02:00</dateOn>
            <nmk>ПОРТНОВА ЛІДІЯ АНТОНІВНА</nmk>
            <snLn>ПОРТНОВА</snLn>
            <snFn>ЛІДІЯ</snFn>
            <snMn>АНТОНІВНА</snMn>
            <nmkv>PORTNOVA LIDIIA ANTONIVNA</nmkv>
            <snGc>ПОРТНОВОЇ ЛІДІЇ АНТОНІВНИ</snGc>
            <codcagent>5</codcagent>
            <k013>5</k013>
            <country>804</country>
            <prinsider>99</prinsider>
            <tgr>1</tgr>
            <okpo>0794205941</okpo>
            <passp>1</passp>
            <ser>СР</ser>
            <numdoc>878522</numdoc>
            <organ>Острозьким РВ УМВС України в Рівненській обл</organ>
            <pdate>2002-02-15T00:00:00+02:00</pdate>
            <datePhoto>2002-02-15T00:00:00+02:00</datePhoto>
            <bday>1921-09-29T00:00:00+02:00</bday>
            <bplace>Рівненська область м.Острог</bplace>
            <sex>2</sex>
            <branch>/333368/000122/060122/</branch>
            <adr></adr>
            <urZip>35800</urZip>
            <urDomain>РІВНЕНСЬКА ОБЛАСТЬ</urDomain>
            <urRegion>Острозький район</urRegion>
            <urLocality>Острог</urLocality>
            <urAddress>вул.Татарська буд.5 кв.104</urAddress>
            <urTerritoryId>28610</urTerritoryId>
            <fgadr>вул.Весняна буд.10 кв.21</fgadr>
            <fgdst>Острозький район</fgdst>
            <fgobl>РІВНЕНСЬКА ОБЛАСТЬ</fgobl>
            <fgtwn>Острог</fgtwn>
            <ise>14410</ise>
            <fs>10</fs>
            <ved>00000</ved>
            <k050>000</k050>
            <publp>Нi</publp>
            <cigpo>6</cigpo>
            <credit>1</credit>
            <deposit>0</deposit>
            <bankCard>1</bankCard>
            <currentAccount>1</currentAccount>
            <other>0</other>
            <lastChangeDt>2014-03-25T00:00:00+02:00</lastChangeDt>
            <maker>testUser</maker>
            <makerDtStamp>2015-06-09T20:20:41.719+03:00</makerDtStamp>
         </clientCard>
      </qualityClient>
      <qualityClient>
         <clientCard>
            <kf>352457</kf>
            <rnk>163184</rnk>
            <dateOn>1999-01-05T00:00:00+02:00</dateOn>
            <nmk>ПОРТНОВА ЛІДІЯ АНТОНІВНА</nmk>
            <snLn>ПОРТНОВА</snLn>
            <snFn>ЛІДІЯ</snFn>
            <snMn>АНТОНІВНА</snMn>
            <nmkv>PORTNOVA LIDIIA ANTONIVNA</nmkv>
            <snGc>ПОРТНОВОЇ ЛІДІЇ АНТОНІВНИ</snGc>
            <codcagent>5</codcagent>
            <k013>5</k013>
            <country>804</country>
            <prinsider>99</prinsider>
            <tgr>1</tgr>
            <okpo>0794205941</okpo>
            <passp>1</passp>
            <ser>СР</ser>
            <numdoc>878522</numdoc>
            <organ>Острозьким РВ УМВС України в Рівненській обл</organ>
            <pdate>2002-02-15T00:00:00+02:00</pdate>
            <datePhoto>2002-02-15T00:00:00+02:00</datePhoto>
            <bday>1921-09-29T00:00:00+02:00</bday>
            <bplace>Рівненська область м.Острог</bplace>
            <sex>2</sex>
            <branch>/352457/000000/000030/</branch>
            <adr></adr>
            <urZip>35800</urZip>
            <urDomain>РІВНЕНСЬКА ОБЛАСТЬ</urDomain>
            <urRegion>Острозький район</urRegion>
            <urLocality>Острог</urLocality>
            <urAddress>вул.Татарська буд.5 кв.104</urAddress>
            <urTerritoryId>28610</urTerritoryId>
            <fgadr>вул.Весняна буд.10 кв.21</fgadr>
            <fgdst>Острозький район</fgdst>
            <fgobl>РІВНЕНСЬКА ОБЛАСТЬ</fgobl>
            <fgtwn>Острог</fgtwn>
            <ise>14410</ise>
            <fs>10</fs>
            <ved>00000</ved>
            <k050>000</k050>
            <publp>Нi</publp>
            <cigpo>6</cigpo>
            <credit>1</credit>
            <deposit>0</deposit>
            <bankCard>1</bankCard>
            <currentAccount>1</currentAccount>
            <other>0</other>
            <lastChangeDt>2014-03-25T00:00:00+02:00</lastChangeDt>
            <maker>testUser</maker>
            <makerDtStamp>2015-06-09T20:20:41.719+03:00</makerDtStamp>
         </clientCard>
         <qualityAttr quality='88.888885' defaultGroupQuality='100.0'/>
      </qualityClient>
   </qualityClients>
</response>",@"<?xml version='1.0' encoding='UTF-8'?>
 <response>
   <status>OK</status>
   <qualityClients>
      <qualityClient>
         <clientCard>
            <kf>352457</kf>
            <rnk>163184</rnk>
            <dateOn>1999-01-05T00:00:00+02:00</dateOn>
            <nmk>Іванов Іван Іванович</nmk>
            <snLn>Іванов</snLn>
            <snFn>Іван</snFn>
            <snMn>Іванович</snMn>
            <nmkv>IVANOV IVAN IVANOVICH</nmkv>
            <snGc>Іванова Івана Івановича</snGc>
            <codcagent>5</codcagent>
            <k013>5</k013>
            <country>804</country>
            <prinsider>99</prinsider>
            <tgr>1</tgr>
            <okpo>3296205941</okpo>
            <passp>1</passp>
            <ser>АА</ser>
            <numdoc>000236</numdoc>
            <organ>Острозьким РВ УМВС України в Рівненській обл</organ>
            <pdate>2002-02-15T00:00:00+02:00</pdate>
            <datePhoto>2002-02-15T00:00:00+02:00</datePhoto>
            <bday>1990-03-31T00:00:00+02:00</bday>
            <bplace>Кіровоградська область м.Олександрія</bplace>
            <sex>2</sex>
            <branch>/352457/000000/000030/</branch>
            <adr></adr>
            <urZip>35800</urZip>
            <urDomain>КІРОВОГРАДСЬКА ОБЛАСТЬ</urDomain>
            <urRegion>Олександрійський район</urRegion>
            <urLocality>Олександрія</urLocality>
            <urAddress>вул.Миру буд.24 кв.104</urAddress>
            <urTerritoryId>28000</urTerritoryId>
            <fgadr>вул.Артема буд.25 кв.21</fgadr>
            <fgdst>Олександрійський район</fgdst>
            <fgobl>КІРОВОГРАДСЬКА ОБЛАСТЬ</fgobl>
            <fgtwn>Олександрія</fgtwn>
            <ise>14410</ise>
            <fs>10</fs>
            <ved>00000</ved>
            <k050>000</k050>
            <publp>Нi</publp>
            <cigpo>6</cigpo>
            <credit>1</credit>
            <deposit>0</deposit>
            <bankCard>1</bankCard>
            <currentAccount>1</currentAccount>
            <other>0</other>
            <lastChangeDt>2014-03-25T00:00:00+02:00</lastChangeDt>
            <maker>testUser</maker>
            <makerDtStamp>2015-06-09T20:20:41.719+03:00</makerDtStamp>
         </clientCard>
         <qualityAttr quality='88.888885' defaultGroupQuality='100.0'/>
      </qualityClient>
   </qualityClients>
</response>",@"<?xml version='1.0' encoding='UTF-8'?>
 <response>
   <status>OK</status>
   <qualityClients>
      <qualityClient>
         <clientCard>
            <kf>352457</kf>
            <rnk>163184</rnk>
            <dateOn>1999-01-05T00:00:00+02:00</dateOn>
            <nmk>Петров Іван Іванович</nmk>
            <snLn>Петров</snLn>
            <snFn>Іван</snFn>
            <snMn>Іванович</snMn>
            <nmkv>PETROV IVAN IVANOVICH</nmkv>
            <snGc>Петров Івана Івановича</snGc>
            <codcagent>5</codcagent>
            <k013>5</k013>
            <country>804</country>
            <prinsider>99</prinsider>
            <tgr>1</tgr>
            <okpo>0000000000</okpo>
            <passp>1</passp>
            <ser>АА</ser>
            <numdoc>000236</numdoc>
            <organ>Острозьким РВ УМВС України в Рівненській обл</organ>
            <pdate>2002-02-15T00:00:00+02:00</pdate>
            <datePhoto>2002-02-15T00:00:00+02:00</datePhoto>
            <bday>1990-03-31T00:00:00+02:00</bday>
            <bplace>Кіровоградська область м.Олександрія</bplace>
            <sex>2</sex>
            <branch>/352457/000000/000030/</branch>
            <adr></adr>
            <urZip>35800</urZip>
            <urDomain>КІРОВОГРАДСЬКА ОБЛАСТЬ</urDomain>
            <urRegion>Олександрійський район</urRegion>
            <urLocality>Олександрія</urLocality>
            <urAddress>вул.Миру буд.24 кв.104</urAddress>
            <urTerritoryId>28000</urTerritoryId>
            <fgadr>вул.Артема буд.25 кв.21</fgadr>
            <fgdst>Олександрійський район</fgdst>
            <fgobl>КІРОВОГРАДСЬКА ОБЛАСТЬ</fgobl>
            <fgtwn>Олександрія</fgtwn>
            <ise>14410</ise>
            <fs>10</fs>
            <ved>00000</ved>
            <k050>000</k050>
            <publp>Нi</publp>
            <cigpo>6</cigpo>
            <credit>1</credit>
            <deposit>0</deposit>
            <bankCard>1</bankCard>
            <currentAccount>1</currentAccount>
            <other>0</other>
            <lastChangeDt>2014-03-25T00:00:00+02:00</lastChangeDt>
            <maker>testUser</maker>
            <makerDtStamp>2015-06-09T20:20:41.719+03:00</makerDtStamp>
         </clientCard>
         <qualityAttr quality='88.888885' defaultGroupQuality='100.0'/>
      </qualityClient>
   </qualityClients>
</response>"};
        XmlDocument doc_iner = new XmlDocument();
        foreach (var item in responce)
        {
            if (item.Contains("<okpo>" + okpo + "</okpo>"))
            {
                doc_iner.LoadXml(item);
            }
        }
        return Request.CreateResponse(HttpStatusCode.OK, doc_iner, Configuration.Formatters.XmlFormatter);
    }
}
